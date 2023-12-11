Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA0C4
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 12:15:40 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db548da6e3bso5029366276.0
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 12:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325740; x=1702930540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFyvopXSGdhaHGBgnsQ7IIVg2NfcVoxsNjHV8R0ePIk=;
        b=f/ZeWorC1736Pso5yc36W/PDSUDz/Vgn8h1HW96Rpoyl9v2SSQJErnBMCMsauIVTZE
         sjcw8vWPsYeM3aUL+Lp5Pdq8YEgIRTJr0fwHkYwIE2RL1YbxQcu+eaDUBj3x6Xbb5tFe
         Ii2OxGrrBttzxO3WCD9KebuxOJ3jlzKSmn8mMTwFTC3CBHTSXgnXGJO9HGI+H9GAHxAe
         ERZf0K9TaycrCWjngiIyAjMpfvBZghGJsIqs6rFbUrsAqR8JjyN8ENX3DYd0cldyKN6u
         LpYeKbNk/9hjUQKRImK6M2r0hUSfV2zu5VKnt7o07575x9sRkIO8VN5sS4AU8igzhBfQ
         5+Bw==
X-Gm-Message-State: AOJu0Yz+ZLpO4oJ0lWDKvqA2cuTJtvgfjuZbJDz2uNbFMGAp7IwnEQGf
	MhL90eQmEm0EdamXzsdz6rOkQAjHwfuAxw==
X-Google-Smtp-Source: AGHT+IGKZrMWhz5soePFlsUdOeWMljzeKJqXTX4uszQn7mGcr/iMI24XhuIEUXPQPWEIuuL/2FL/uQ==
X-Received: by 2002:a5b:70b:0:b0:db3:fa4e:5b80 with SMTP id g11-20020a5b070b000000b00db3fa4e5b80mr3521833ybq.20.1702325739654;
        Mon, 11 Dec 2023 12:15:39 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o12-20020a258d8c000000b00dbcb622b2e9sm55408ybl.53.2023.12.11.12.15.39
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 12:15:39 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db5e5647c24so5008867276.1
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 12:15:39 -0800 (PST)
X-Received: by 2002:a25:2350:0:b0:dbc:b24c:d4d2 with SMTP id
 j77-20020a252350000000b00dbcb24cd4d2mr558577ybj.42.1702325738862; Mon, 11 Dec
 2023 12:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
In-Reply-To: <ZXc4t8ayumo-dhul@itl-email>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 11 Dec 2023 20:15:27 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
Message-ID: <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Lennart Poettering <mzerqung@0pointer.de>, Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 17:30, Demi Marie Obenour
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
> untrusted or TPM-signed.

All those problems are already solved, without inventing a new shell
scripting solution - we have DDIs and credentials. This is the exact
opposite of the direction we are pursuing: we want to _kill_ all these
initrd-specific infrastructure, tools, build systems, dependency
management and so on, because they are difficult to maintain, they
create a completely different environment that what is "normally" ran,
and they end up reinventing everything the 'normal' image does. We
want to build initrds from packages - as in normal distribution
packages, not special sauce initrd-only packages, so that the same
code and the same configuration is used everywhere, in different
runtime modes. Because that's what distributions are good to do:
creating package-based ecosystems, with good tooling, infrastructure
and so on.

The end goal is to build images without initramfs-tools/dracut and
just using packages, not to stick yet another glue script in front of
them, that needs yet more special initrd-only arcane magic to put
together, in order to save a handful of KBs.

And for ancient, legacy platforms that do not support modern APIs, the
old ways will still be there, and can be used. Nobody is going to take
away grub and dracut from the internet, if you got some special corner
case where you want to use it it will still be there, but the fact
that such corner cases exist cannot stop the rest of the ecosystem
that is targeted to modern hardware from evolving into something
better, more maintainable and more straightforward.
