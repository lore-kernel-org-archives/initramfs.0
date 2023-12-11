Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDFD6
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:51:37 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id D5005E80203;
	Mon, 11 Dec 2023 12:51:34 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 3053B160253; Mon, 11 Dec 2023 12:51:34 +0100 (CET)
Date: Mon, 11 Dec 2023 12:51:34 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXb3xhSswgjQAwlL@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>

On Mo, 11.12.23 11:28, Eric Curtin (ecurtin@redhat.com) wrote:

> > > For the items listed above I think you can find different solutions
> > > which do not necessarily compromise security as much.
> > >
> > > So, in the list above you could address the latter three like this:
> > >
> > > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> > >    loader load the erofs into contigous memory, then use memmap=X!Y on
> > >    the kernel cmdline to synthesize a block device from that, which
> > >    you then mount directly (without any initrd) via
> > >    root=/dev/pmem0. This means yout boot loader will still load the
> > >    whole image into memory, but only decompress the bits actually
> > >    neeed. (It also has some other nice benefits I like, such as an
> > >    immutable rootfs, which tmpfs-based initrds don't have.)
>
> What I am unsure about here, is the "make the bootloader load the
> erofs into contiguous memory" part. I wonder could we try and use the
> existing initramfs data as is.

Today's initrds are packed cpio archives of an OS file system
hierarchy. What I proposed means you'd have to put the OS file system
hiearchy into an erofs image instead. Which is a trivial operation,
just unpack and repack.

Note that there are two concepts of "initrd" out there.

a) from the kernel perspective an initrd/initramfs (which both are
   badly named, because its a tmpfs these days) is that packed cpio
   archive that is unpacked into a tmpfs, and then jumped into.

b) from systemd's perspective an initrd is an OS image that carries an
   /etc/initrd-release file. If that file exists then systemd will not
   boot up the system regularly, but instead just prepare everything
   that it can transition into some other root fs.

While most often in real life the initrds currently qualify under both
definitions. But there's no reason to always do this. You can also
have images the kernel would consider an initrd, but systemd does not,
which is something we use in the "USI" concept, i.e. "unified system
images", which are basically UKIs (large UKIs) with a complete rootfs
that is the main system of the OS. And you can also do it the other
way round, which is potentially what I am suggesting to you here: use
an erofs image that would not be considered an initrd by the kernel,
but that systemd would consider one, and transition out of.

> I dunno if
> bootloaders make much assumptions about the format of that data, worst
> case scenario we could encapsulate erofs in the initramfs, cpio looking
> data.

boot loaders generally don't bother with the cpio, it's just "data"
for them. Compression algorithms have changed in the past, and it only
mattered that the kernel could decompress it, the boot loader doesn't care.

> Teach the kernel not to decompress and process the whole
> thing and mount it like an erofs alternatively. Does this sound crazy
> or reasonable?

You are re-inventing the traditional "initrd" logic of the kernel
which was a ramdisk (i.e. a block device /dev/ram0), that was filled
with some fs of your choice loaded by the boot loader.

Lennart

--
Lennart Poettering, Berlin
