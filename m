X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 02:06:30 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DE5B6
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 02:06:30 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 3E6F8E80203;
	Mon, 11 Dec 2023 10:57:59 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CB830160253; Mon, 11 Dec 2023 10:57:58 +0100 (CET)
Date: Mon, 11 Dec 2023 10:57:58 +0100
From: Lennart Poettering <mzerqung@0pointer.de>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXbdJp1Vz8M8c1MS@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>

On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:

> Here is the boot sequence with initoverlayfs integrated, the
> mini-initramfs contains just enough to get storage drivers loaded and
> storage devices initialized. storage-init is a process that is not
> designed to replace init, it does just enough to initialize storage
> (performs a targeted udev trigger on storage), switches to
> initoverlayfs as root and then executes init.
>
> ```
> fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
>
> fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> ```

I am not sure I follow what these chains are supposed to mean? Why are
there two lines?

So, I generally would agree that the current initrd scheme is not
ideal, and we have been discussing better approaches. But I am not
sure your approach really is useful on generic systems for two
reasons:

1. no security model? you need to authenticate your initrd in
   2023. There's no execuse to not doing that anymore these days. Not
   in automotive, and not anywhere else really.

2. no way to deal with complex storage? i.e. people use FDE, want to
   unlock their root disks with TPM2 and similar things. People use
   RAID, LVM, and all that mess.

Actually the above are kinda the same problem in a way: you need
complex storage, but if you need that you kinda need udev, and
services, and then also systemd and all that other stuff, and that's
why the system works like the system works right now.

Whenever you devise a system like yours by cutting corners, and
declaring that you don't want TPM, you don't want signed initrds, you
don't want to support weird storage, you just solve your problem in a
very specific way, ignoring the big picture. Which is OK, *if* you can
actually really work without all that and are willing to maintain the
solution for your specific problem only.

As I understand you are trying to solve multiple problems at once
here, and I think one should start with figuring out clearly what
those are before trying to address them, maybe without compromising on
security. So my guess is you want to address the following:

1. You don't want the whole big initrd to be read off disk on every
   boot, but only the parts of it that are actually needed.

2. You don't want the whole big initrd to be fully decompressed on every
   boot, but only the parts of it that are actually needed.

3. You want to share data between root fs and initrd

4. You want to save some boot time by not bringing up an init system
   in the initrd once, then tearing it down again, and starting it
   again from the root fs.

For the items listed above I think you can find different solutions
which do not necessarily compromise security as much.

So, in the list above you could address the latter three like this:

2. Use an erofs rather than a packed cpio as initrd. Make the boot
   loader load the erofs into contigous memory, then use memmap=X!Y on
   the kernel cmdline to synthesize a block device from that, which
   you then mount directly (without any initrd) via
   root=/dev/pmem0. This means yout boot loader will still load the
   whole image into memory, but only decompress the bits actually
   neeed. (It also has some other nice benefits I like, such as an
   immutable rootfs, which tmpfs-based initrds don't have.)

3. Simply never transition to the root fs, don't marke the initrds in
   systemd's eyes as an initrd (specifically: don't add an
   /etc/initrd-release file to it). Instead, just merge resources of
   the root fs into your initrd fs via overlayfs. systemd has
   infrastructure for this: "systemd-sysext". It takes immutable,
   authenticated erofs images (with verity, we call them "DDIs",
   i.e. "discoverable disk images") that it overlays into /usr/. [You
   could also very nicely combine this approach with systemd's
   portable services, and npsawn containers, which operate on the same
   authenticated images]. At MSFT we have a major product that works
   exactly like this: the OS runs off a rootfs that is loaded as an
   initrd, and everything that runs on top of this are just these
   verity disk images, using overlayfs and portable services.

4. The proposal in 3 also addresses goal 4.

Which leaves item 1, which is a bit harder to address. We have been
discussing this off an on internally too. A generic solution to this
is hard. My current thinking for this could be something like this,
covering the UEFI world: support sticking a DDI for the main initrd in
the ESP. The ESP is per definition unencrypted and unauthenticated,
but otherwise relatively well defined, i.e. known to be vfat and
discoverable via UUID on a GPT disk. So: build a minimal
single-process initrd into the kernel (i.e. UKI) that has exactly the
storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
drivers, and dm-verity. Then have a PID 1 that does exactly enough to
jump into the rootfs stored in the ESP. That latter then has proper
file system drivers, storage drivers, crypto stack, and can unlock the
real root. This would still be a pretty specific solution to one set
of devices though, as it could not cover network boots (i.e. where
there is just no ESP to boot from), but I think this could be kept
relatively close, as the logic in that case could just fall back into
loading the DDI that normally would still in the ESP fully into
memory.

(If you are focussing on systems lacking UEFI, then replace the word
"ESP" in the above with a similar concept, i.e. a well discoverable,
unauthenticated relatively simple file system, such as vfat).

Anyway, I can't tell you how to solve your specific problems, but if
there's one thing I'd suggest you to keep in mind then it's the
security angle, i.e. keep in mind from the beginning how
authentication of every component of your process shall work, how
unatteneded disk encryption shall operate and how measurement shall
work. Security must be built into things from the beginning, not be
added as an afterthought.

Lennart

--
Lennart Poettering, Berlin
