Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="lMSFPQrM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDnO4qlQ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5446D6
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 12:43:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8651B3202788;
	Mon, 11 Dec 2023 15:43:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 15:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702327407; x=1702413807; bh=PpBbFh95GEnlFdMosTwtIHlvAEUnVm5JBmR
	0WK0Bo4A=; b=lMSFPQrMckvf36bNWUrDVZuQQyU78G43SGR8/IcTBJL/w+h8zbR
	99kGj0u1bqWD+HY3lrMex+XY3qIxausfj2e/aV4uqwcKflXpeOgZtI2qJrf59QX3
	w7qtnqJEctoLYAjXM30+dp3MEujR0crXap+utjNL/Ti+gqACQ1G9MMFFi6U+tFpT
	W56ChKxdA/v5TRV7CBS1dyn/wK/IniuPruRq2irt9jvkxOy74opDgn/FQNvscb3w
	v3vMeDe76S9l1GMxDK8oC8jmzliDmKvgzFnLKzj0wml2AdRgoWRu0DmU+Zc7VCJ9
	ewKFhZ92TrIJaRu0g2m1QK9zufDh6pWEXuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702327407; x=1702413807; bh=PpBbFh95GEnlF
	dMosTwtIHlvAEUnVm5JBmR0WK0Bo4A=; b=qDnO4qlQJ/G6x+JaXshY20BUoEUFW
	nRsnrAdsLXNtLdHf69ts+2MT1DQ2MBBkSmyxTyUv36u+78bpZaUVF2pPPO7rqjTD
	Z3JCH4GesqknqjUsycCPzGB1xS+GIf20lBV6nzHatsLaRGcT9EBqqM+ZtLs//NBi
	aqPd4QuQBNn9Yim50fdfWYa3OC0mTntuySEcdLtaCOd9I/KOXEBExRrufWM3A7GJ
	ZwnkgWnmig6zGBqEJAw2wckK4gO+KVPUw1WEvSAcpDzofZf+Y4iycjRFFus8Q170
	F4aHlWlntREEpQNqL5p+ns7RAh7Cl0jHEx/p/aVSXlpW5+zyrCXqeFwTg==
X-ME-Sender: <xms:bnR3Zf7qqdNt52Bcvh5MpY_41qj73SZYB1S2G9aEmw4VB-ZrFq1yRw>
    <xme:bnR3ZU5el_YvMOrclxnkWLkdagpvlEopG5PkukGSn3wN1jzvvnhtfT_y0_lSu8CV2
    K_sE3d2WQD5FdU>
X-ME-Received: <xmr:bnR3ZWeTdYihrEdSfVhrqZ7eVJX9gE8ElXoCpTjdtL1tCAgr81TKaVoBZX8Uz9RzSeOKUNSB_DKZhQoFXZOA-PZtiL4QwpXzUb6-9z8ma6HJbRzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtjgesthdtredttddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgeekgfekvddtueefgeeigfelleeh
    hfevteeivedvgfegtdeuledvhfegjedvudehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:bnR3ZQK5VTZIB6IXtPnxCkz9V9DJoyeOnopKamC8hsl3hzm6_lJcgA>
    <xmx:bnR3ZTJW06x0UqTeposw-jGk8sReZHKSQdHCpOyTtcxw9S-QsY74iQ>
    <xmx:bnR3ZZw7a8gfm_KiKSF8kj8B_ymJKND4R973HYskB4rpH_Cbx9AVLw>
    <xmx:b3R3ZZh6we5m5HMHq_HBYeknUZ4DAPUj9baK-0OrW_-4DwPLf6wVQA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:43:25 -0500 (EST)
Date: Mon, 11 Dec 2023 15:43:24 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Luca Boccassi <bluca@debian.org>
Cc: Lennart Poettering <mzerqung@0pointer.de>,
	Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXd0bNQRgJO-Wgeb@itl-email>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Dec 11, 2023 at 08:15:27PM +0000, Luca Boccassi wrote:
> On Mon, 11 Dec 2023 at 17:30, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
> > > On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
> > >
> > > > Here is the boot sequence with initoverlayfs integrated, the
> > > > mini-initramfs contains just enough to get storage drivers loaded and
> > > > storage devices initialized. storage-init is a process that is not
> > > > designed to replace init, it does just enough to initialize storage
> > > > (performs a targeted udev trigger on storage), switches to
> > > > initoverlayfs as root and then executes init.
> > > >
> > > > ```
> > > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
> > > >
> > > > fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> > > > ```
> > >
> > > I am not sure I follow what these chains are supposed to mean? Why are
> > > there two lines?
> > >
> > > So, I generally would agree that the current initrd scheme is not
> > > ideal, and we have been discussing better approaches. But I am not
> > > sure your approach really is useful on generic systems for two
> > > reasons:
> > >
> > > 1. no security model? you need to authenticate your initrd in
> > >    2023. There's no execuse to not doing that anymore these days. Not
> > >    in automotive, and not anywhere else really.
> > >
> > > 2. no way to deal with complex storage? i.e. people use FDE, want to
> > >    unlock their root disks with TPM2 and similar things. People use
> > >    RAID, LVM, and all that mess.
> > >
> > > Actually the above are kinda the same problem in a way: you need
> > > complex storage, but if you need that you kinda need udev, and
> > > services, and then also systemd and all that other stuff, and that's
> > > why the system works like the system works right now.
> > >
> > > Whenever you devise a system like yours by cutting corners, and
> > > declaring that you don't want TPM, you don't want signed initrds, you
> > > don't want to support weird storage, you just solve your problem in a
> > > very specific way, ignoring the big picture. Which is OK, *if* you can
> > > actually really work without all that and are willing to maintain the
> > > solution for your specific problem only.
> > >
> > > As I understand you are trying to solve multiple problems at once
> > > here, and I think one should start with figuring out clearly what
> > > those are before trying to address them, maybe without compromising on
> > > security. So my guess is you want to address the following:
> > >
> > > 1. You don't want the whole big initrd to be read off disk on every
> > >    boot, but only the parts of it that are actually needed.
> > >
> > > 2. You don't want the whole big initrd to be fully decompressed on every
> > >    boot, but only the parts of it that are actually needed.
> > >
> > > 3. You want to share data between root fs and initrd
> > >
> > > 4. You want to save some boot time by not bringing up an init system
> > >    in the initrd once, then tearing it down again, and starting it
> > >    again from the root fs.
> > >
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
> > >
> > > 3. Simply never transition to the root fs, don't marke the initrds in
> > >    systemd's eyes as an initrd (specifically: don't add an
> > >    /etc/initrd-release file to it). Instead, just merge resources of
> > >    the root fs into your initrd fs via overlayfs. systemd has
> > >    infrastructure for this: "systemd-sysext". It takes immutable,
> > >    authenticated erofs images (with verity, we call them "DDIs",
> > >    i.e. "discoverable disk images") that it overlays into /usr/. [You
> > >    could also very nicely combine this approach with systemd's
> > >    portable services, and npsawn containers, which operate on the same
> > >    authenticated images]. At MSFT we have a major product that works
> > >    exactly like this: the OS runs off a rootfs that is loaded as an
> > >    initrd, and everything that runs on top of this are just these
> > >    verity disk images, using overlayfs and portable services.
> > >
> > > 4. The proposal in 3 also addresses goal 4.
> > >
> > > Which leaves item 1, which is a bit harder to address. We have been
> > > discussing this off an on internally too. A generic solution to this
> > > is hard. My current thinking for this could be something like this,
> > > covering the UEFI world: support sticking a DDI for the main initrd in
> > > the ESP. The ESP is per definition unencrypted and unauthenticated,
> > > but otherwise relatively well defined, i.e. known to be vfat and
> > > discoverable via UUID on a GPT disk. So: build a minimal
> > > single-process initrd into the kernel (i.e. UKI) that has exactly the
> > > storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> > > drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> > > jump into the rootfs stored in the ESP. That latter then has proper
> > > file system drivers, storage drivers, crypto stack, and can unlock the
> > > real root. This would still be a pretty specific solution to one set
> > > of devices though, as it could not cover network boots (i.e. where
> > > there is just no ESP to boot from), but I think this could be kept
> > > relatively close, as the logic in that case could just fall back into
> > > loading the DDI that normally would still in the ESP fully into
> > > memory.
> >
> > I don't think this is "a pretty specific solution to one set of devices"
> > _at all_.  To the contrary, it is _exactly_ what I want to see desktop
> > systems moving to in the future.
> >
> > It solves the problem of large firmware images.  It solves the problem
> > of device-specific configuration, because one can use a file on the EFI
> > system partition that is read by userspace and either treated as
> > untrusted or TPM-signed.
> 
> All those problems are already solved, without inventing a new shell
> scripting solution - we have DDIs and credentials. This is the exact
> opposite of the direction we are pursuing: we want to _kill_ all these
> initrd-specific infrastructure, tools, build systems, dependency
> management and so on, because they are difficult to maintain, they
> create a completely different environment that what is "normally" ran,
> and they end up reinventing everything the 'normal' image does. We
> want to build initrds from packages - as in normal distribution
> packages, not special sauce initrd-only packages, so that the same
> code and the same configuration is used everywhere, in different
> runtime modes. Because that's what distributions are good to do:
> creating package-based ecosystems, with good tooling, infrastructure
> and so on.
> 
> The end goal is to build images without initramfs-tools/dracut and
> just using packages, not to stick yet another glue script in front of
> them, that needs yet more special initrd-only arcane magic to put
> together, in order to save a handful of KBs.

The initramfs being a RAM filesystem is exactly why keeping it small is
so critical.  Lennart's suggestion solves this problem by eagerly
loading an image from disk, which is much less size-constrained.  One
would use distribution packages to build this on-disk image.

> And for ancient, legacy platforms that do not support modern APIs, the
> old ways will still be there, and can be used. Nobody is going to take
> away grub and dracut from the internet, if you got some special corner
> case where you want to use it it will still be there, but the fact
> that such corner cases exist cannot stop the rest of the ecosystem
> that is targeted to modern hardware from evolving into something
> better, more maintainable and more straightforward.

The problem is not that UEFI is not usable in automotive systems.  The
problem is that U-Boot (or any other UEFI implementation) is an extra
stage in the boot process, slows things down, and has more attack
surface.
- -- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmV3dGwACgkQsoi1X/+c
IsGAxg//SME2795YgGWdruCwKs3D3s78MChJ18zx7DKAkIl24bETMHr7fBF0kOf/
nGKgl5VFEFNL+nEKVXNstLPTqP50BdGUShJqz7A7JVXYkpoc7+3WGmd7ZkjUXpXJ
l+37aJEo+U11Vew84LBvpckR63oshoeCr/cJrcnDaNK5NyqN9vhDXHSgJ6lu+8bh
gC7LnAhmvyB0g+vL0QpzNijNyM7nDg9zCzlP3cOYiyLj5cb4MoLL9TAZPsK0oy2q
UagW+5keJxJfY5ffdAWFpqg2UeY/7cPU5H/rkdkUFbaE9Dk8VLVsTFq6Zk5arUGw
8/CJptX2rD3DsFM+yWgizKC7Tnb9DGNZPB5ORZFem26nrNYmBz58NupDWW5HCNo9
OuPO3ASREb6z1XGmrnD1Dc8ExyTczn/zwp+x/qEDtmn8fmhDGuknwQ9D0mZ6XgO4
DuA9q4aKldgOT5wjflTaSSLkjvzaV81m1wGtxvMDdJlrmturU0GsRTeL/RpK9Dsj
BtgfvSfy+FC0uUxXSJQo/dvJmfnFHQFKss/HDf6nJJMvT20fzT+XbNljzVWLRsr3
f3suT56nIQ7oorRlgnpaCN7uQeyMKkMY7CWQtgqLGkp6c27ObfuUREFDl9KZWoF6
pI61gAVGzKmwSwJlFYHohkqMJlcqln27UX2aspQ52PMeGNwOPVM=
=mLxX
-----END PGP SIGNATURE-----
