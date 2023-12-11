Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E229BD
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 13:46:00 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so4851758276.0
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 13:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702331159; x=1702935959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuCibC/ypMCcCAHwOG4Uyq/OaTwTn9YFr2uOb7Y24CA=;
        b=oFy0CohLNcnrp+dF69LoiLjMAU5uDHOji0WMXNpo714BV0TfeLFWcxWyPLwpVSuX8N
         irjBBBX3SMRlj2F1D+qpe+mUHO/3F2KOOBDVPT9Yzza9WSfptiMpgbm63YdyZDkXQ90U
         2/+nhPN53yOZ8/Kz6O25sxebPVMhhdP66XNyo/YQMHUiOow7duJXzC2Bei3KdFoKRK8h
         ymGR1Y4cqvrYUIGyxZaC5jIsbIJKd9OKkpV94f3hXaSjCXpdYQBmrozDtj1umuNHc5fx
         XY0cUw4dkt1xHqKs2YyUrEfBjoKtgIwXLlUvMEBbn5j7/dfFbnvHvtREaGNXIngEaBC3
         H0ww==
X-Gm-Message-State: AOJu0YydAGN5IKz9tgqgbdx6MOnRJC3QbUTdMbyl3zS92+N2WkLTTO9g
	DlH+YHlB7CPhvHJOO2HQLzseB+4P+L20Kg==
X-Google-Smtp-Source: AGHT+IFPsL8tTVblZRK6IfcTmGqb04BTSlnxYoDajR3fwhBCTBjScVxlcEQI4T98GDegpsPfaBq0rA==
X-Received: by 2002:a25:8a11:0:b0:db5:9004:cf5b with SMTP id g17-20020a258a11000000b00db59004cf5bmr2812457ybl.64.1702331158777;
        Mon, 11 Dec 2023 13:45:58 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v187-20020a2548c4000000b00db3fa34142bsm2816511yba.49.2023.12.11.13.45.57
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:45:58 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbcb0f0212aso629639276.3
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 13:45:57 -0800 (PST)
X-Received: by 2002:a05:6902:1b13:b0:db5:4e4a:4345 with SMTP id
 eh19-20020a0569021b1300b00db54e4a4345mr3725377ybb.6.1702331157369; Mon, 11
 Dec 2023 13:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
 <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
 <ZXd0bNQRgJO-Wgeb@itl-email> <CAMw=ZnT20EB3Cn=6PHsZJUJku=b5As+OBBFXgU+ZK2Tsy7o8Qg@mail.gmail.com>
 <ZXd9EVT494r0tuC_@itl-email>
In-Reply-To: <ZXd9EVT494r0tuC_@itl-email>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 11 Dec 2023 21:45:45 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnTTaMK1S6HCm3FL8YkgbYFuvZNQmbPjSC=kfc98=j7MJw@mail.gmail.com>
Message-ID: <CAMw=ZnTTaMK1S6HCm3FL8YkgbYFuvZNQmbPjSC=kfc98=j7MJw@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Lennart Poettering <mzerqung@0pointer.de>, Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Yariv Rachmani <yrachman@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 21:20, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Mon, Dec 11, 2023 at 08:58:58PM +0000, Luca Boccassi wrote:
> > On Mon, 11 Dec 2023 at 20:43, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA512
> > >
> > > On Mon, Dec 11, 2023 at 08:15:27PM +0000, Luca Boccassi wrote:
> > > > On Mon, 11 Dec 2023 at 17:30, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
> > > > > > On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
> > > > > >
> > > > > > > Here is the boot sequence with initoverlayfs integrated, the
> > > > > > > mini-initramfs contains just enough to get storage drivers loaded and
> > > > > > > storage devices initialized. storage-init is a process that is not
> > > > > > > designed to replace init, it does just enough to initialize storage
> > > > > > > (performs a targeted udev trigger on storage), switches to
> > > > > > > initoverlayfs as root and then executes init.
> > > > > > >
> > > > > > > ```
> > > > > > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
> > > > > > >
> > > > > > > fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> > > > > > > ```
> > > > > >
> > > > > > I am not sure I follow what these chains are supposed to mean? Why are
> > > > > > there two lines?
> > > > > >
> > > > > > So, I generally would agree that the current initrd scheme is not
> > > > > > ideal, and we have been discussing better approaches. But I am not
> > > > > > sure your approach really is useful on generic systems for two
> > > > > > reasons:
> > > > > >
> > > > > > 1. no security model? you need to authenticate your initrd in
> > > > > >    2023. There's no execuse to not doing that anymore these days. Not
> > > > > >    in automotive, and not anywhere else really.
> > > > > >
> > > > > > 2. no way to deal with complex storage? i.e. people use FDE, want to
> > > > > >    unlock their root disks with TPM2 and similar things. People use
> > > > > >    RAID, LVM, and all that mess.
> > > > > >
> > > > > > Actually the above are kinda the same problem in a way: you need
> > > > > > complex storage, but if you need that you kinda need udev, and
> > > > > > services, and then also systemd and all that other stuff, and that's
> > > > > > why the system works like the system works right now.
> > > > > >
> > > > > > Whenever you devise a system like yours by cutting corners, and
> > > > > > declaring that you don't want TPM, you don't want signed initrds, you
> > > > > > don't want to support weird storage, you just solve your problem in a
> > > > > > very specific way, ignoring the big picture. Which is OK, *if* you can
> > > > > > actually really work without all that and are willing to maintain the
> > > > > > solution for your specific problem only.
> > > > > >
> > > > > > As I understand you are trying to solve multiple problems at once
> > > > > > here, and I think one should start with figuring out clearly what
> > > > > > those are before trying to address them, maybe without compromising on
> > > > > > security. So my guess is you want to address the following:
> > > > > >
> > > > > > 1. You don't want the whole big initrd to be read off disk on every
> > > > > >    boot, but only the parts of it that are actually needed.
> > > > > >
> > > > > > 2. You don't want the whole big initrd to be fully decompressed on every
> > > > > >    boot, but only the parts of it that are actually needed.
> > > > > >
> > > > > > 3. You want to share data between root fs and initrd
> > > > > >
> > > > > > 4. You want to save some boot time by not bringing up an init system
> > > > > >    in the initrd once, then tearing it down again, and starting it
> > > > > >    again from the root fs.
> > > > > >
> > > > > > For the items listed above I think you can find different solutions
> > > > > > which do not necessarily compromise security as much.
> > > > > >
> > > > > > So, in the list above you could address the latter three like this:
> > > > > >
> > > > > > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> > > > > >    loader load the erofs into contigous memory, then use memmap=X!Y on
> > > > > >    the kernel cmdline to synthesize a block device from that, which
> > > > > >    you then mount directly (without any initrd) via
> > > > > >    root=/dev/pmem0. This means yout boot loader will still load the
> > > > > >    whole image into memory, but only decompress the bits actually
> > > > > >    neeed. (It also has some other nice benefits I like, such as an
> > > > > >    immutable rootfs, which tmpfs-based initrds don't have.)
> > > > > >
> > > > > > 3. Simply never transition to the root fs, don't marke the initrds in
> > > > > >    systemd's eyes as an initrd (specifically: don't add an
> > > > > >    /etc/initrd-release file to it). Instead, just merge resources of
> > > > > >    the root fs into your initrd fs via overlayfs. systemd has
> > > > > >    infrastructure for this: "systemd-sysext". It takes immutable,
> > > > > >    authenticated erofs images (with verity, we call them "DDIs",
> > > > > >    i.e. "discoverable disk images") that it overlays into /usr/. [You
> > > > > >    could also very nicely combine this approach with systemd's
> > > > > >    portable services, and npsawn containers, which operate on the same
> > > > > >    authenticated images]. At MSFT we have a major product that works
> > > > > >    exactly like this: the OS runs off a rootfs that is loaded as an
> > > > > >    initrd, and everything that runs on top of this are just these
> > > > > >    verity disk images, using overlayfs and portable services.
> > > > > >
> > > > > > 4. The proposal in 3 also addresses goal 4.
> > > > > >
> > > > > > Which leaves item 1, which is a bit harder to address. We have been
> > > > > > discussing this off an on internally too. A generic solution to this
> > > > > > is hard. My current thinking for this could be something like this,
> > > > > > covering the UEFI world: support sticking a DDI for the main initrd in
> > > > > > the ESP. The ESP is per definition unencrypted and unauthenticated,
> > > > > > but otherwise relatively well defined, i.e. known to be vfat and
> > > > > > discoverable via UUID on a GPT disk. So: build a minimal
> > > > > > single-process initrd into the kernel (i.e. UKI) that has exactly the
> > > > > > storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> > > > > > drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> > > > > > jump into the rootfs stored in the ESP. That latter then has proper
> > > > > > file system drivers, storage drivers, crypto stack, and can unlock the
> > > > > > real root. This would still be a pretty specific solution to one set
> > > > > > of devices though, as it could not cover network boots (i.e. where
> > > > > > there is just no ESP to boot from), but I think this could be kept
> > > > > > relatively close, as the logic in that case could just fall back into
> > > > > > loading the DDI that normally would still in the ESP fully into
> > > > > > memory.
> > > > >
> > > > > I don't think this is "a pretty specific solution to one set of devices"
> > > > > _at all_.  To the contrary, it is _exactly_ what I want to see desktop
> > > > > systems moving to in the future.
> > > > >
> > > > > It solves the problem of large firmware images.  It solves the problem
> > > > > of device-specific configuration, because one can use a file on the EFI
> > > > > system partition that is read by userspace and either treated as
> > > > > untrusted or TPM-signed.
> > > >
> > > > All those problems are already solved, without inventing a new shell
> > > > scripting solution - we have DDIs and credentials. This is the exact
> > > > opposite of the direction we are pursuing: we want to _kill_ all these
> > > > initrd-specific infrastructure, tools, build systems, dependency
> > > > management and so on, because they are difficult to maintain, they
> > > > create a completely different environment that what is "normally" ran,
> > > > and they end up reinventing everything the 'normal' image does. We
> > > > want to build initrds from packages - as in normal distribution
> > > > packages, not special sauce initrd-only packages, so that the same
> > > > code and the same configuration is used everywhere, in different
> > > > runtime modes. Because that's what distributions are good to do:
> > > > creating package-based ecosystems, with good tooling, infrastructure
> > > > and so on.
> > > >
> > > > The end goal is to build images without initramfs-tools/dracut and
> > > > just using packages, not to stick yet another glue script in front of
> > > > them, that needs yet more special initrd-only arcane magic to put
> > > > together, in order to save a handful of KBs.
> > >
> > > The initramfs being a RAM filesystem is exactly why keeping it small is
> > > so critical.  Lennart's suggestion solves this problem by eagerly
> > > loading an image from disk, which is much less size-constrained.  One
> > > would use distribution packages to build this on-disk image.
> >
> > This is already solved by using extension DDIs for optional packages.
>
> What about non-optional packages?  The goal is to _require_ the on-disk
> image to boot, so that full-featured UI toolkits can be used to e.g.
> prompt for LUKS passphrases.  Ideally, the initramfs would be as minimal
> as possible.

You can use DDIs for anything you want, outside of systemd itself

> > > > And for ancient, legacy platforms that do not support modern APIs, the
> > > > old ways will still be there, and can be used. Nobody is going to take
> > > > away grub and dracut from the internet, if you got some special corner
> > > > case where you want to use it it will still be there, but the fact
> > > > that such corner cases exist cannot stop the rest of the ecosystem
> > > > that is targeted to modern hardware from evolving into something
> > > > better, more maintainable and more straightforward.
> > >
> > > The problem is not that UEFI is not usable in automotive systems.  The
> > > problem is that U-Boot (or any other UEFI implementation) is an extra
> > > stage in the boot process, slows things down, and has more attack
> > > surface.
> >
> > Whatever firmware you use will have an attack surface, the interface
> > it provides - whether legacy bios or uefi-based - is irrelevant for
> > that. Skipping or reimplementing all the verity, tpm, etc logic also
> > increases the attack surface, as does adding initrd-only code that is
> > never tested and exercised outside of that limited context. If you are
> > running with legacy bios on ancient hardware you also will likely lack
> > tpm, secure boot, and so on, so it's all moot, any security argument
> > goes out of the window. If anybody cares about platform security, then
> > a tpm-capable and secureboot-capable firmware with a modern, usable
> > interface like uefi, running the same code in initrd and full system,
> > using dm-verity everywhere, is pretty much the best one can do.
>
> Neither Chrome OS devices nor Macs with Apple silicon use UEFI, and both
> have better platform security than any UEFI-based device on the market I
> am aware of.

We are talking about Linux distributions here. If one wants to use
proprietary systems, sure, there are better things out there, but
that's off topic.
