Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="bBPGqt4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yXgYz4l6"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6CCE
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 13:20:21 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 592F63200A08;
	Mon, 11 Dec 2023 16:20:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 16:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702329619; x=1702416019; bh=fIX/1Wp1SH+ZJI2UNwfXTkGm9yeMxAnso+U
	N5TGTqXo=; b=bBPGqt4Yt/fZfbbHK/82nz65TicrqXjmKAr+lwqS2Bov01NvxqF
	yL7HmBB77i8gODBgsCR7eK6Dq8eqYKSDeRm/bSt1vsqUF+QlwrlCLSrGqkZliTxU
	OIAlZq0VWmBBeUs/oiByOc8+f67akEiTOpt7Xy1XrLkekjwB7g+woRCcHTYaVd/5
	rTKTMGTckA1mxcmmUdRQqNtt8bZoQ3mY4mIbFN4AbtDCexzajR4AEIz83LefSQuP
	1lOviv3jp5E+G594bt9WhIPqqzLlBNAOK75g1639fTB1HOM7x6L5+lLnoA2yZCSl
	NNynulm0lgZioOUMXy2uiJVZRCtEaYATr0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702329619; x=1702416019; bh=fIX/1Wp1SH+ZJ
	I2UNwfXTkGm9yeMxAnso+UN5TGTqXo=; b=yXgYz4l6x97N50njIEjkg20jghMip
	E28bZh4CKR1buRX0TfXYMsi3NhH1vxSe4t76TGzul82MTjDEa6iJO7mwSZA3o34a
	6nGTRVb0Baux6xvQzj3sbG0gOwqG3RauEy5hKQ/UE2lSchM34PWhyDTaeeeWRIYc
	C9peVJsdXmK9JC8XBPOFqfjGQGkgsIxROBdRJrqLzR0ncVjvDm/VIqMOnz1UG6XM
	SkhQm4S0iKdlDcLeLcHrL1l6e08ZYFdfMwWwrZr9J0tH1G0bJ+mM7Cp4tgwWNFUC
	KVxzO1q6gM84oOM1/93EEjyNWfB6v1nc7LPE+JFu0k/R00ZVF+fPtq5AA==
X-ME-Sender: <xms:E313ZYcMm65b3fooFSWQ6AushWw253gIYw6bpPOoNG6Zit-LP7Lezw>
    <xme:E313ZaO7r4vpJEnKL1y7En2gvHDuSOwmIFXiApuqeCL09k1z8dIxS72gPbU0Gy-7F
    Snvw919-SqBl38>
X-ME-Received: <xmr:E313ZZiuC6hDUINKmOiRiNjp34PQAh-6jOhCACzFEuTPr2kB5XcrAH9xzWZGXiHH1VXEul-RnDqxtQtmti1_lQP5KSGG0r60Sb9OTcd9Sc4h-0qT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:E313Zd9S2RS4HXDajm7kgE-VOJ_EfIH-xGyNXnk0MNLP_5ZIVAC-ZQ>
    <xmx:E313ZUtn1CSzsfEG1ZamqrE3gWVWZXMWbYr5qeu8Zl9xrPHpL4sYkQ>
    <xmx:E313ZUH5R0d5Ng2afLst5Rb3sysD5zejuRUmOAtY4ptYnYP0UhKpDg>
    <xmx:E313ZeV9TXNiPTk08xPNnOB66gN0nxWNkhINpWon3hOsuvIGBxXheA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 16:20:19 -0500 (EST)
Date: Mon, 11 Dec 2023 16:20:15 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Luca Boccassi <bluca@debian.org>
Cc: Lennart Poettering <mzerqung@0pointer.de>,
	Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXd9EVT494r0tuC_@itl-email>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
 <ZXd0bNQRgJO-Wgeb@itl-email>
 <CAMw=ZnT20EB3Cn=6PHsZJUJku=b5As+OBBFXgU+ZK2Tsy7o8Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otbj28gad3x0Hl5a"
Content-Disposition: inline
In-Reply-To: <CAMw=ZnT20EB3Cn=6PHsZJUJku=b5As+OBBFXgU+ZK2Tsy7o8Qg@mail.gmail.com>


--otbj28gad3x0Hl5a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 16:20:15 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Luca Boccassi <bluca@debian.org>
Cc: Lennart Poettering <mzerqung@0pointer.de>,
	Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem

On Mon, Dec 11, 2023 at 08:58:58PM +0000, Luca Boccassi wrote:
> On Mon, 11 Dec 2023 at 20:43, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> >
> > On Mon, Dec 11, 2023 at 08:15:27PM +0000, Luca Boccassi wrote:
> > > On Mon, 11 Dec 2023 at 17:30, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
> > > > > On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
> > > > >
> > > > > > Here is the boot sequence with initoverlayfs integrated, the
> > > > > > mini-initramfs contains just enough to get storage drivers load=
ed and
> > > > > > storage devices initialized. storage-init is a process that is =
not
> > > > > > designed to replace init, it does just enough to initialize sto=
rage
> > > > > > (performs a targeted udev trigger on storage), switches to
> > > > > > initoverlayfs as root and then executes init.
> > > > > >
> > > > > > ```
> > > > > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -=
> rootfs
> > > > > >
> > > > > > fw -> bootloader -> kernel -> storage-init   -> init ----------=
------->
> > > > > > ```
> > > > >
> > > > > I am not sure I follow what these chains are supposed to mean? Wh=
y are
> > > > > there two lines?
> > > > >
> > > > > So, I generally would agree that the current initrd scheme is not
> > > > > ideal, and we have been discussing better approaches. But I am not
> > > > > sure your approach really is useful on generic systems for two
> > > > > reasons:
> > > > >
> > > > > 1. no security model? you need to authenticate your initrd in
> > > > >    2023. There's no execuse to not doing that anymore these days.=
 Not
> > > > >    in automotive, and not anywhere else really.
> > > > >
> > > > > 2. no way to deal with complex storage? i.e. people use FDE, want=
 to
> > > > >    unlock their root disks with TPM2 and similar things. People u=
se
> > > > >    RAID, LVM, and all that mess.
> > > > >
> > > > > Actually the above are kinda the same problem in a way: you need
> > > > > complex storage, but if you need that you kinda need udev, and
> > > > > services, and then also systemd and all that other stuff, and tha=
t's
> > > > > why the system works like the system works right now.
> > > > >
> > > > > Whenever you devise a system like yours by cutting corners, and
> > > > > declaring that you don't want TPM, you don't want signed initrds,=
 you
> > > > > don't want to support weird storage, you just solve your problem =
in a
> > > > > very specific way, ignoring the big picture. Which is OK, *if* yo=
u can
> > > > > actually really work without all that and are willing to maintain=
 the
> > > > > solution for your specific problem only.
> > > > >
> > > > > As I understand you are trying to solve multiple problems at once
> > > > > here, and I think one should start with figuring out clearly what
> > > > > those are before trying to address them, maybe without compromisi=
ng on
> > > > > security. So my guess is you want to address the following:
> > > > >
> > > > > 1. You don't want the whole big initrd to be read off disk on eve=
ry
> > > > >    boot, but only the parts of it that are actually needed.
> > > > >
> > > > > 2. You don't want the whole big initrd to be fully decompressed o=
n every
> > > > >    boot, but only the parts of it that are actually needed.
> > > > >
> > > > > 3. You want to share data between root fs and initrd
> > > > >
> > > > > 4. You want to save some boot time by not bringing up an init sys=
tem
> > > > >    in the initrd once, then tearing it down again, and starting it
> > > > >    again from the root fs.
> > > > >
> > > > > For the items listed above I think you can find different solutio=
ns
> > > > > which do not necessarily compromise security as much.
> > > > >
> > > > > So, in the list above you could address the latter three like thi=
s:
> > > > >
> > > > > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> > > > >    loader load the erofs into contigous memory, then use memmap=
=3DX!Y on
> > > > >    the kernel cmdline to synthesize a block device from that, whi=
ch
> > > > >    you then mount directly (without any initrd) via
> > > > >    root=3D/dev/pmem0. This means yout boot loader will still load=
 the
> > > > >    whole image into memory, but only decompress the bits actually
> > > > >    neeed. (It also has some other nice benefits I like, such as an
> > > > >    immutable rootfs, which tmpfs-based initrds don't have.)
> > > > >
> > > > > 3. Simply never transition to the root fs, don't marke the initrd=
s in
> > > > >    systemd's eyes as an initrd (specifically: don't add an
> > > > >    /etc/initrd-release file to it). Instead, just merge resources=
 of
> > > > >    the root fs into your initrd fs via overlayfs. systemd has
> > > > >    infrastructure for this: "systemd-sysext". It takes immutable,
> > > > >    authenticated erofs images (with verity, we call them "DDIs",
> > > > >    i.e. "discoverable disk images") that it overlays into /usr/. =
[You
> > > > >    could also very nicely combine this approach with systemd's
> > > > >    portable services, and npsawn containers, which operate on the=
 same
> > > > >    authenticated images]. At MSFT we have a major product that wo=
rks
> > > > >    exactly like this: the OS runs off a rootfs that is loaded as =
an
> > > > >    initrd, and everything that runs on top of this are just these
> > > > >    verity disk images, using overlayfs and portable services.
> > > > >
> > > > > 4. The proposal in 3 also addresses goal 4.
> > > > >
> > > > > Which leaves item 1, which is a bit harder to address. We have be=
en
> > > > > discussing this off an on internally too. A generic solution to t=
his
> > > > > is hard. My current thinking for this could be something like thi=
s,
> > > > > covering the UEFI world: support sticking a DDI for the main init=
rd in
> > > > > the ESP. The ESP is per definition unencrypted and unauthenticate=
d,
> > > > > but otherwise relatively well defined, i.e. known to be vfat and
> > > > > discoverable via UUID on a GPT disk. So: build a minimal
> > > > > single-process initrd into the kernel (i.e. UKI) that has exactly=
 the
> > > > > storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs =
fs
> > > > > drivers, and dm-verity. Then have a PID 1 that does exactly enoug=
h to
> > > > > jump into the rootfs stored in the ESP. That latter then has prop=
er
> > > > > file system drivers, storage drivers, crypto stack, and can unloc=
k the
> > > > > real root. This would still be a pretty specific solution to one =
set
> > > > > of devices though, as it could not cover network boots (i.e. where
> > > > > there is just no ESP to boot from), but I think this could be kept
> > > > > relatively close, as the logic in that case could just fall back =
into
> > > > > loading the DDI that normally would still in the ESP fully into
> > > > > memory.
> > > >
> > > > I don't think this is "a pretty specific solution to one set of dev=
ices"
> > > > _at all_.  To the contrary, it is _exactly_ what I want to see desk=
top
> > > > systems moving to in the future.
> > > >
> > > > It solves the problem of large firmware images.  It solves the prob=
lem
> > > > of device-specific configuration, because one can use a file on the=
 EFI
> > > > system partition that is read by userspace and either treated as
> > > > untrusted or TPM-signed.
> > >
> > > All those problems are already solved, without inventing a new shell
> > > scripting solution - we have DDIs and credentials. This is the exact
> > > opposite of the direction we are pursuing: we want to _kill_ all these
> > > initrd-specific infrastructure, tools, build systems, dependency
> > > management and so on, because they are difficult to maintain, they
> > > create a completely different environment that what is "normally" ran,
> > > and they end up reinventing everything the 'normal' image does. We
> > > want to build initrds from packages - as in normal distribution
> > > packages, not special sauce initrd-only packages, so that the same
> > > code and the same configuration is used everywhere, in different
> > > runtime modes. Because that's what distributions are good to do:
> > > creating package-based ecosystems, with good tooling, infrastructure
> > > and so on.
> > >
> > > The end goal is to build images without initramfs-tools/dracut and
> > > just using packages, not to stick yet another glue script in front of
> > > them, that needs yet more special initrd-only arcane magic to put
> > > together, in order to save a handful of KBs.
> >
> > The initramfs being a RAM filesystem is exactly why keeping it small is
> > so critical.  Lennart's suggestion solves this problem by eagerly
> > loading an image from disk, which is much less size-constrained.  One
> > would use distribution packages to build this on-disk image.
>=20
> This is already solved by using extension DDIs for optional packages.

What about non-optional packages?  The goal is to _require_ the on-disk
image to boot, so that full-featured UI toolkits can be used to e.g.
prompt for LUKS passphrases.  Ideally, the initramfs would be as minimal
as possible.

> > > And for ancient, legacy platforms that do not support modern APIs, the
> > > old ways will still be there, and can be used. Nobody is going to take
> > > away grub and dracut from the internet, if you got some special corner
> > > case where you want to use it it will still be there, but the fact
> > > that such corner cases exist cannot stop the rest of the ecosystem
> > > that is targeted to modern hardware from evolving into something
> > > better, more maintainable and more straightforward.
> >
> > The problem is not that UEFI is not usable in automotive systems.  The
> > problem is that U-Boot (or any other UEFI implementation) is an extra
> > stage in the boot process, slows things down, and has more attack
> > surface.
>=20
> Whatever firmware you use will have an attack surface, the interface
> it provides - whether legacy bios or uefi-based - is irrelevant for
> that. Skipping or reimplementing all the verity, tpm, etc logic also
> increases the attack surface, as does adding initrd-only code that is
> never tested and exercised outside of that limited context. If you are
> running with legacy bios on ancient hardware you also will likely lack
> tpm, secure boot, and so on, so it's all moot, any security argument
> goes out of the window. If anybody cares about platform security, then
> a tpm-capable and secureboot-capable firmware with a modern, usable
> interface like uefi, running the same code in initrd and full system,
> using dm-verity everywhere, is pretty much the best one can do.

Neither Chrome OS devices nor Macs with Apple silicon use UEFI, and both
have better platform security than any UEFI-based device on the market I
am aware of.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--otbj28gad3x0Hl5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmV3fREACgkQsoi1X/+c
IsFeQw//XouD1U/KglVdbfnAJocQdby9l2mF04ooZ7eFcDncn2NHiorXloNDCWeA
UY5tAnjZ1N8bLH1KbvEk62niVxazbZF4FQUPiJtL4QcVX+GXOmfKbSRo/aSsaZJ5
wRoNDUT1OxpwgLOUwecM4OtWNTRGKdBXx93Pu+s8CJmZ7zDq5HGOtCkm4lIHlYaL
mGcI8kHaiwg1Pklw08FxlOgFtUOLgN5cCKGEkaiy20K//0FIHve9mtdW3RVdcKOw
22vDQExJrSXZVDVAG1eNCkvV1sK9Jmt9mXn/W22DqOQHPyGKy1J6QdmtvLBfu1Rp
yXt3XmRolCLdHAUXtHsWFGkzURyDRRGbgUJ3GcsCO20QzJrjKH2QcBFxy0GgOEvS
ZhQ1jSvJMvh6OQWMin2paVC6jb3w9ibhFFTMdNLC+axE2xFm+6Gd++wxn9cQJ4T+
VLa7Sw4DvrU1wKr8Q0P49eurIR7umGfYRHeEXoCO2xL2hE4b71JbBMzZN9vzj4sm
oveIIVQLhfHqz750NyAvLCjPu4JA3usqTXuIBpOOE1TLY6rTlWvymfVH7pBrYL4W
EoNDlMvayVLfKK+qk92YD1f2XKYcEZWdeh+OlS7xTyzBr2X8ocZwbVMoENu3K+dz
w2GJSMWG8rrpGfKBhrQqIhqAu5cxLHoLsCV3YvKpAVXqSaCvIpU=
=q3ei
-----END PGP SIGNATURE-----

--otbj28gad3x0Hl5a--
