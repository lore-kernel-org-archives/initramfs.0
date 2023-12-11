Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKa6NjaG"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A25C3
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 09:34:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2cb20c82a79so44762101fa.3
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702316049; x=1702920849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krwHvhUfT7SKb764Y11yTLd2kd5mGB/7YkyIpqc4J5M=;
        b=CKa6NjaGdBZYyCjIUHhANi50BYoeGPR2d04ECffbxW44hERGeOfN5Np/DaxO9F29dj
         q8RIfH8okUYSET1OVglbKYqFUxTGQ+OuPCcNC4a9bkLQJkOylO+ImevRsQB4Cv/MiKgB
         8LYwcCYlbjwVGaX7T+0hXaae1SjmfgwsoAU5TAwkdPhi94HCjrprd/cKZKXMj5qcVdts
         Sim+i+eQVBe+MlfmSo2mGHBQ0E8WEVtFzp9liQpbDKTIY1le5kA4NlxZ58NrprJnWx0q
         9dk1MHWdmqwnWN670nPnU5ug8cPTWuKGRi4BXE5G3m43qvkWyAUn9O60MyuHiVEAwL2E
         OAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316049; x=1702920849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krwHvhUfT7SKb764Y11yTLd2kd5mGB/7YkyIpqc4J5M=;
        b=PBCg2y1wabOGtbrsXlV7SoHTyO+QdURYl4Uz8z4FNd237qfF6uMiWTfFUjfX3i66sr
         bzf10ncEdyNWKI+JTF+Ndq1mc5lXxLE2sFsWSAS38XVW9GNHqA/QSNJEUllCZH8zPULy
         OB7VsdH/cFWqlZjvkizTvapUEYrRnpcGXFJTNW//CinK6N+UJd4KTnG/6DGQ+hcKp5vJ
         RUBzw5FVngUEVUkyIeMvDiE1h/sjqaIMRLZ/kRi9pPEZhgvzLTAqf+zi+6mg89clgbEO
         m4MX5N2VZeR02ha7O5g/AzEgCJnH7W2EeeU3G7YgibITNyRz7qXJsr8hRkooXjcfLqLF
         oU9g==
X-Gm-Message-State: AOJu0YzosRDC2jCmBSiwOD/9ClJAc29ErdRo8MBOnAizDIjy51c8ZgsG
	/5fvxjYOmt29NVwW1AO3VcyLWXqXsXhby7ZNyh8=
X-Google-Smtp-Source: AGHT+IFSKYh1oeIXwjFm+mLFJV9gM4DFm66Xt47wKUr4oe2AHkpaLPSiSHN+gIftD2wPdZJG8rhlL1jp1weitWRfWEY=
X-Received: by 2002:a2e:a80d:0:b0:2cc:1ec1:90f4 with SMTP id
 l13-20020a2ea80d000000b002cc1ec190f4mr1914600ljq.69.1702316048828; Mon, 11
 Dec 2023 09:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
In-Reply-To: <ZXc4t8ayumo-dhul@itl-email>
From: Neal Gompa <ngompa13@gmail.com>
Date: Mon, 11 Dec 2023 12:33:31 -0500
Message-ID: <CAEg-Je8FPJ1rTrGwQRQotF_g=f_b7J7Wy7NK_vJWPFNw4RuCdg@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Lennart Poettering <mzerqung@0pointer.de>, Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:30=E2=80=AFPM Demi Marie Obenour
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
> > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> root=
fs
> > >
> > > fw -> bootloader -> kernel -> storage-init   -> init ----------------=
->
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
> > 2. You don't want the whole big initrd to be fully decompressed on ever=
y
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
> >    loader load the erofs into contigous memory, then use memmap=3DX!Y o=
n
> >    the kernel cmdline to synthesize a block device from that, which
> >    you then mount directly (without any initrd) via
> >    root=3D/dev/pmem0. This means yout boot loader will still load the
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
> handled by userspace and kexec, rather than the closed source UEFI networ=
k
> stack.
>

Network boot is fairly common in some industries for workstations. In
particular, the film industry does this a fair bit to leverage
switching between workstation and renderfarm modes for workstation
hardware.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
