Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhRIiXUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9CD8E
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702314232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bVkuZnnkHDBd0/0RnaRvHJaaK4EPoe4mDrduK+fFCE=;
	b=PhRIiXUythhkwgIVxSDa2ggnFlT/NIyS0vLDEm5QVtn1vRv6ixkyAdz1xDJH8lFWu4m6y2
	DUe/Q4wsu/mJj73hIYlCR38bMatTx7mlMiD/mBwFngsCo5e8/klY8xiVZC52tWkrPkcxIH
	zFChQU41wRE2PNwhZYr0Y4ZdahXjI4Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-iy8Y0-tMP-qg14psUYzWPA-1; Mon, 11 Dec 2023 12:03:51 -0500
X-MC-Unique: iy8Y0-tMP-qg14psUYzWPA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28674705fddso2791266a91.2
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 09:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314230; x=1702919030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bVkuZnnkHDBd0/0RnaRvHJaaK4EPoe4mDrduK+fFCE=;
        b=Ru0o7UXG1EDHxnJyR/x8xe5PyJRwvA9HZkIDHFWsJzDtigARgYrMd7m3ORPtjkzCmC
         5NUABWqybs9GyTr3cj1J7TyebZslullEt1w0xPmxq5LUcJWkEF6vX6YYGtXjd/jSNrR5
         VAx/lSYHrLlryoyeWAWxtzde1m2mB8WexsKZ2CIGRu+W+sWVgfDseW5yOrz5ursJTR7f
         qJceYj3KVj1P6yy2qSX32OHj0bd2QNxRl30nfn5k/6OAtKTBUQ857Kib7D+bWAmCWwqE
         XkY6CX593yUV7SeL+w7SzIbWB5V+dBmrGWWDd6mvOhZjrUZm61Qf91hL6LAxwnqgVBUE
         0lwA==
X-Gm-Message-State: AOJu0Yw6S3/5BoXA5w9Cydb9eYy0y8GhVqTN2qSxEiw/E+XRf0ehM96f
	CfKGUTPnsKpXpC8Zcxrz4q2w/NXP+yH6+xJPVbklX3Hvxo1bAAJ3IVU5bnCp68Et+oPaqC7bOWh
	N9UY4P7oGQWctfEXOA2Of6N/3ibS4yp92mKGR
X-Received: by 2002:a17:90a:51e5:b0:286:c318:42ca with SMTP id u92-20020a17090a51e500b00286c31842camr2064002pjh.58.1702314230060;
        Mon, 11 Dec 2023 09:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHBphZPUo/qowi9FAmzIlGdvMgcGNzVgTC5v6bk1FH9uuyhNMI1saK/4jYv0tgJho/lUV7Iu4i4PolYKV3FWI=
X-Received: by 2002:a17:90a:51e5:b0:286:c318:42ca with SMTP id
 u92-20020a17090a51e500b00286c31842camr2063984pjh.58.1702314229652; Mon, 11
 Dec 2023 09:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
In-Reply-To: <ZXc4t8ayumo-dhul@itl-email>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 11 Dec 2023 17:03:13 +0000
Message-ID: <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Lennart Poettering <mzerqung@0pointer.de>, Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 16:36, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
> > On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
> >
> > > Here is the boot sequence with initoverlayfs integrated, the
> > > mini-initramfs contains just enough to get storage drivers loaded and
> > > storage devices initialized. storage-init is a process that is not
> > > designed to replace init, it does just enough to initialize storage
> > > (performs a targeted udev trigger on storage), switches to
> > > initoverlayfs as root and then executes init.
> > >
> > > ```
> > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
> > >
> > > fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> > > ```
> >
> > I am not sure I follow what these chains are supposed to mean? Why are
> > there two lines?
> >
> > So, I generally would agree that the current initrd scheme is not
> > ideal, and we have been discussing better approaches. But I am not
> > sure your approach really is useful on generic systems for two
> > reasons:
> >
> > 1. no security model? you need to authenticate your initrd in
> >    2023. There's no execuse to not doing that anymore these days. Not
> >    in automotive, and not anywhere else really.
> >
> > 2. no way to deal with complex storage? i.e. people use FDE, want to
> >    unlock their root disks with TPM2 and similar things. People use
> >    RAID, LVM, and all that mess.
> >
> > Actually the above are kinda the same problem in a way: you need
> > complex storage, but if you need that you kinda need udev, and
> > services, and then also systemd and all that other stuff, and that's
> > why the system works like the system works right now.
> >
> > Whenever you devise a system like yours by cutting corners, and
> > declaring that you don't want TPM, you don't want signed initrds, you
> > don't want to support weird storage, you just solve your problem in a
> > very specific way, ignoring the big picture. Which is OK, *if* you can
> > actually really work without all that and are willing to maintain the
> > solution for your specific problem only.
> >
> > As I understand you are trying to solve multiple problems at once
> > here, and I think one should start with figuring out clearly what
> > those are before trying to address them, maybe without compromising on
> > security. So my guess is you want to address the following:
> >
> > 1. You don't want the whole big initrd to be read off disk on every
> >    boot, but only the parts of it that are actually needed.
> >
> > 2. You don't want the whole big initrd to be fully decompressed on every
> >    boot, but only the parts of it that are actually needed.
> >
> > 3. You want to share data between root fs and initrd
> >
> > 4. You want to save some boot time by not bringing up an init system
> >    in the initrd once, then tearing it down again, and starting it
> >    again from the root fs.
> >
> > For the items listed above I think you can find different solutions
> > which do not necessarily compromise security as much.
> >
> > So, in the list above you could address the latter three like this:
> >
> > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> >    loader load the erofs into contigous memory, then use memmap=X!Y on
> >    the kernel cmdline to synthesize a block device from that, which
> >    you then mount directly (without any initrd) via
> >    root=/dev/pmem0. This means yout boot loader will still load the
> >    whole image into memory, but only decompress the bits actually
> >    neeed. (It also has some other nice benefits I like, such as an
> >    immutable rootfs, which tmpfs-based initrds don't have.)
> >
> > 3. Simply never transition to the root fs, don't marke the initrds in
> >    systemd's eyes as an initrd (specifically: don't add an
> >    /etc/initrd-release file to it). Instead, just merge resources of
> >    the root fs into your initrd fs via overlayfs. systemd has
> >    infrastructure for this: "systemd-sysext". It takes immutable,
> >    authenticated erofs images (with verity, we call them "DDIs",
> >    i.e. "discoverable disk images") that it overlays into /usr/. [You
> >    could also very nicely combine this approach with systemd's
> >    portable services, and npsawn containers, which operate on the same
> >    authenticated images]. At MSFT we have a major product that works
> >    exactly like this: the OS runs off a rootfs that is loaded as an
> >    initrd, and everything that runs on top of this are just these
> >    verity disk images, using overlayfs and portable services.
> >
> > 4. The proposal in 3 also addresses goal 4.
> >
> > Which leaves item 1, which is a bit harder to address. We have been
> > discussing this off an on internally too. A generic solution to this
> > is hard. My current thinking for this could be something like this,
> > covering the UEFI world: support sticking a DDI for the main initrd in
> > the ESP. The ESP is per definition unencrypted and unauthenticated,
> > but otherwise relatively well defined, i.e. known to be vfat and
> > discoverable via UUID on a GPT disk. So: build a minimal
> > single-process initrd into the kernel (i.e. UKI) that has exactly the
> > storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> > drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> > jump into the rootfs stored in the ESP. That latter then has proper
> > file system drivers, storage drivers, crypto stack, and can unlock the
> > real root. This would still be a pretty specific solution to one set
> > of devices though, as it could not cover network boots (i.e. where
> > there is just no ESP to boot from), but I think this could be kept
> > relatively close, as the logic in that case could just fall back into
> > loading the DDI that normally would still in the ESP fully into
> > memory.
>
> I don't think this is "a pretty specific solution to one set of devices"
> _at all_.  To the contrary, it is _exactly_ what I want to see desktop
> systems moving to in the future.
>
> It solves the problem of large firmware images.  It solves the problem
> of device-specific configuration, because one can use a file on the EFI
> system partition that is read by userspace and either treated as
> untrusted or TPM-signed.  It means that one have a complete set of
> recovery tools in the event of a problem, rather than being limited to
> whatever one can squeese into an initramfs.  One can even include a full
> GUI stack (with accessibility support!), rather than just Plymouth.  For

plymouth is very interesting in that it has it's own graphics stack, event loop
implementations, etc. A lot of the initrd software is like this.
plymouth is one of
the examples I think of in my head of something that could benefit from being
able to use more generic things. At least it's an easy example to explain to
people.

> Qubes OS, one can include enough of the Xen and Qubes toolstack to even
> launch virtual machines, allowing the use of USB devices and networking
> for recovery purposes.  It even means that one can use a FIDO2 token to
> unlock the hard drive without a USB stack on the host.  And because the
> initramfs _only_ needs to load the boot extension volume, it can be
> very, _very_ small, which works great with using Linux as a coreboot
> payload.
>
> The only problem I can see that this does not solve is network boot, but
> that is very much a niche use case when compared to the millions of
> Fedora or Debian desktop installs, or even the tens of thousands of
> Qubes OS installs.  Furthermore, I would _much_ rather network boot be
> handled by userspace and kexec, rather than the closed source UEFI network
> stack.

A generic approach is hard, I think it's worth discussing which type of boots
you should actually care about milliseconds of performance for. It would be nice
if we had an init system that contained the binary data to do the minimum for
standard Fedora, Debian installs and everything else was an extension whether
that's sysexts, dlopen, a new binary to execute etc.

If the network is ingrained in your boot stack like this, I'm guessing
you probably
don't care about boot performance. Should we come up with a new technique?

Automotive has an expectation for really fast boots, like 2 seconds, in standard
desktops installs there's some expectation as you interface directly
with a human,
but for other installs how much expectation is there?

Or can we just fall back to existing techniques for installs like network boot?

Is mise le meas/Regards,

Eric Curtin

>
> It does require some care when upgrading, as the dm-verity image and the
> UKI cannot both be updated atomically, but one can solve that by first
> writing the new dm-verity image to a separate location.  The UKI will
> try both both the old and new locations for the dm-verity image and
> rename the new image over the old one on success.  The wrong image will
> simply fail to mount as its root hash will be wrong.
>
> This even allows Apple-esque boot policies to be implemented on
> commodity hardware, provided that the system firmware is sufficiently
> hardened.  It won't be as good as what Apple does, but it will be a huge
> win from what is possible today.
>
> > (If you are focussing on systems lacking UEFI, then replace the word
> > "ESP" in the above with a similar concept, i.e. a well discoverable,
> > unauthenticated relatively simple file system, such as vfat).
> >
> > Anyway, I can't tell you how to solve your specific problems, but if
> > there's one thing I'd suggest you to keep in mind then it's the
> > security angle, i.e. keep in mind from the beginning how
> > authentication of every component of your process shall work, how
> > unatteneded disk encryption shall operate and how measurement shall
> > work. Security must be built into things from the beginning, not be
> > added as an afterthought.
>
> As a Qubes OS developer and a security researcher, thank you.
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab

