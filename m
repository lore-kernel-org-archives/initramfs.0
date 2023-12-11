Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Nm5c8okg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0ZgUft+/"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129598E
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 08:28:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1493232009FC;
	Mon, 11 Dec 2023 11:28:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 11:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702312121; x=1702398521; bh=r1IzU+fNLieOD4YLNhUxG8kYn+JwEmyGaGh
	cM4KljN8=; b=Nm5c8okgZfkrDNGwyp1hUodtXxhERTpmJ7vsuMCcKfrn5gOkXo4
	0UrU3gVuBsHtYVLHBUVqFHTmAe8EDGqtLLxjKosUz82RF0tLKENGqPXq3ePF2Lgx
	wSu8UdmfDH0Bw3UmR5AKmLKpPolD45iuF34Ex6oD71fdYViMuXheDZs3sGvzZeat
	FOzcW9cPpFJYYVXJUIi5UBpJX5QyMfnRl1cCOu9IplyaN5z9WZPbz4tAbnXk9Xap
	3Tn3PK/W6yQzGSBEek7NA3vGP2BYYFKl/QZ5tzpmem7tO+L89FtMaRp9lySi8sTG
	pFsV2h8thLWsoACSDNCPjj9pfc7lGQ/+YGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702312121; x=1702398521; bh=r1IzU+fNLieOD
	4YLNhUxG8kYn+JwEmyGaGhcM4KljN8=; b=0ZgUft+/RqL44rd+9Prx3r6aI+vlX
	i1vxPsxHyd02gTBiIbnOOWHmWmic7524XfUOVCR8/iF96GFv1ZHDwe9jOuj94YED
	c9+qnDkDOLfiBNAv1T75x+3d4tdDbb0Ji3QUkV01YPk8fHvJUdMaG2jO7lAfN42q
	0JZ05cBxYz5/NFdQT7OGkJUNqVedvTjlkqfJtBYm1G+TL5c1h4RstWZsWYVwcVD8
	wiufRAHdVsNxlgomDTRL/ULNJCTEwfFxD1GSrHZkvosJU9ls/34sjl04w/kuQz2v
	iZf4zFE1l4KD5qPqPmXWl5BxJZMezOLHPwEeD6qTl/a1FrJpWmVYl047w==
X-ME-Sender: <xms:uTh3ZTo4aajhZFQQdbdxFlfdk_uHKK9n2_GIbphA9wk7vv6OcLk-3A>
    <xme:uTh3Zdoov6YBHh-V5bpi6txs9YZYOB3A-JstmaAPn4pFr9GPC1CIinGnO_cBQ7daJ
    2_78pLJd1kxjZk>
X-ME-Received: <xmr:uTh3ZQOZcGrKa4QsAwja2bo0-Cpu9xswJK2JrahEPK70yhJm5weDHBpFRtexYvj2-i-JvV-479YaAAWOyUR7WkCQXRCbtl9h39HApgaRcV6WLXtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:uTh3ZW5EEWnspywZpNqMF5UwdjgjTsMHTcxEuJ37aqcsBNAntd5dQA>
    <xmx:uTh3ZS67gPU0T5xVlBN5LjXQFm467EBZJIyL6DU13PB9fmm14N_5OQ>
    <xmx:uTh3ZeiiSSNBLrk_MvWiHC_3BlFlOCFmZTXU8mB237yV4fuhYKYiFw>
    <xmx:uTh3ZUTqjiWjWODVk-kywsruwyakRwNjYG48YVlWMurqu6UOxa18Ew>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 11:28:40 -0500 (EST)
Date: Mon, 11 Dec 2023 11:28:24 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Lennart Poettering <mzerqung@0pointer.de>,
	Eric Curtin <ecurtin@redhat.com>
Cc: Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXc4t8ayumo-dhul@itl-email>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQwDxQIy+7yCND6V"
Content-Disposition: inline
In-Reply-To: <ZXbdJp1Vz8M8c1MS@gardel-login>


--fQwDxQIy+7yCND6V
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 11:28:24 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Lennart Poettering <mzerqung@0pointer.de>,
	Eric Curtin <ecurtin@redhat.com>
Cc: Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem

On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
> On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
>=20
> > Here is the boot sequence with initoverlayfs integrated, the
> > mini-initramfs contains just enough to get storage drivers loaded and
> > storage devices initialized. storage-init is a process that is not
> > designed to replace init, it does just enough to initialize storage
> > (performs a targeted udev trigger on storage), switches to
> > initoverlayfs as root and then executes init.
> >
> > ```
> > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
> >
> > fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> > ```
>=20
> I am not sure I follow what these chains are supposed to mean? Why are
> there two lines?
>=20
> So, I generally would agree that the current initrd scheme is not
> ideal, and we have been discussing better approaches. But I am not
> sure your approach really is useful on generic systems for two
> reasons:
>=20
> 1. no security model? you need to authenticate your initrd in
>    2023. There's no execuse to not doing that anymore these days. Not
>    in automotive, and not anywhere else really.
>=20
> 2. no way to deal with complex storage? i.e. people use FDE, want to
>    unlock their root disks with TPM2 and similar things. People use
>    RAID, LVM, and all that mess.
>=20
> Actually the above are kinda the same problem in a way: you need
> complex storage, but if you need that you kinda need udev, and
> services, and then also systemd and all that other stuff, and that's
> why the system works like the system works right now.
>=20
> Whenever you devise a system like yours by cutting corners, and
> declaring that you don't want TPM, you don't want signed initrds, you
> don't want to support weird storage, you just solve your problem in a
> very specific way, ignoring the big picture. Which is OK, *if* you can
> actually really work without all that and are willing to maintain the
> solution for your specific problem only.
>=20
> As I understand you are trying to solve multiple problems at once
> here, and I think one should start with figuring out clearly what
> those are before trying to address them, maybe without compromising on
> security. So my guess is you want to address the following:
>=20
> 1. You don't want the whole big initrd to be read off disk on every
>    boot, but only the parts of it that are actually needed.
>=20
> 2. You don't want the whole big initrd to be fully decompressed on every
>    boot, but only the parts of it that are actually needed.
>=20
> 3. You want to share data between root fs and initrd
>=20
> 4. You want to save some boot time by not bringing up an init system
>    in the initrd once, then tearing it down again, and starting it
>    again from the root fs.
>=20
> For the items listed above I think you can find different solutions
> which do not necessarily compromise security as much.
>=20
> So, in the list above you could address the latter three like this:
>=20
> 2. Use an erofs rather than a packed cpio as initrd. Make the boot
>    loader load the erofs into contigous memory, then use memmap=3DX!Y on
>    the kernel cmdline to synthesize a block device from that, which
>    you then mount directly (without any initrd) via
>    root=3D/dev/pmem0. This means yout boot loader will still load the
>    whole image into memory, but only decompress the bits actually
>    neeed. (It also has some other nice benefits I like, such as an
>    immutable rootfs, which tmpfs-based initrds don't have.)
>=20
> 3. Simply never transition to the root fs, don't marke the initrds in
>    systemd's eyes as an initrd (specifically: don't add an
>    /etc/initrd-release file to it). Instead, just merge resources of
>    the root fs into your initrd fs via overlayfs. systemd has
>    infrastructure for this: "systemd-sysext". It takes immutable,
>    authenticated erofs images (with verity, we call them "DDIs",
>    i.e. "discoverable disk images") that it overlays into /usr/. [You
>    could also very nicely combine this approach with systemd's
>    portable services, and npsawn containers, which operate on the same
>    authenticated images]. At MSFT we have a major product that works
>    exactly like this: the OS runs off a rootfs that is loaded as an
>    initrd, and everything that runs on top of this are just these
>    verity disk images, using overlayfs and portable services.
>=20
> 4. The proposal in 3 also addresses goal 4.
>=20
> Which leaves item 1, which is a bit harder to address. We have been
> discussing this off an on internally too. A generic solution to this
> is hard. My current thinking for this could be something like this,
> covering the UEFI world: support sticking a DDI for the main initrd in
> the ESP. The ESP is per definition unencrypted and unauthenticated,
> but otherwise relatively well defined, i.e. known to be vfat and
> discoverable via UUID on a GPT disk. So: build a minimal
> single-process initrd into the kernel (i.e. UKI) that has exactly the
> storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> jump into the rootfs stored in the ESP. That latter then has proper
> file system drivers, storage drivers, crypto stack, and can unlock the
> real root. This would still be a pretty specific solution to one set
> of devices though, as it could not cover network boots (i.e. where
> there is just no ESP to boot from), but I think this could be kept
> relatively close, as the logic in that case could just fall back into
> loading the DDI that normally would still in the ESP fully into
> memory.

I don't think this is "a pretty specific solution to one set of devices"
_at all_.  To the contrary, it is _exactly_ what I want to see desktop
systems moving to in the future.

It solves the problem of large firmware images.  It solves the problem
of device-specific configuration, because one can use a file on the EFI
system partition that is read by userspace and either treated as
untrusted or TPM-signed.  It means that one have a complete set of
recovery tools in the event of a problem, rather than being limited to
whatever one can squeese into an initramfs.  One can even include a full
GUI stack (with accessibility support!), rather than just Plymouth.  For
Qubes OS, one can include enough of the Xen and Qubes toolstack to even
launch virtual machines, allowing the use of USB devices and networking
for recovery purposes.  It even means that one can use a FIDO2 token to
unlock the hard drive without a USB stack on the host.  And because the
initramfs _only_ needs to load the boot extension volume, it can be
very, _very_ small, which works great with using Linux as a coreboot
payload.

The only problem I can see that this does not solve is network boot, but
that is very much a niche use case when compared to the millions of
Fedora or Debian desktop installs, or even the tens of thousands of
Qubes OS installs.  Furthermore, I would _much_ rather network boot be
handled by userspace and kexec, rather than the closed source UEFI network
stack.

It does require some care when upgrading, as the dm-verity image and the
UKI cannot both be updated atomically, but one can solve that by first
writing the new dm-verity image to a separate location.  The UKI will
try both both the old and new locations for the dm-verity image and
rename the new image over the old one on success.  The wrong image will
simply fail to mount as its root hash will be wrong.

This even allows Apple-esque boot policies to be implemented on
commodity hardware, provided that the system firmware is sufficiently
hardened.  It won't be as good as what Apple does, but it will be a huge
win from what is possible today.

> (If you are focussing on systems lacking UEFI, then replace the word
> "ESP" in the above with a similar concept, i.e. a well discoverable,
> unauthenticated relatively simple file system, such as vfat).
>=20
> Anyway, I can't tell you how to solve your specific problems, but if
> there's one thing I'd suggest you to keep in mind then it's the
> security angle, i.e. keep in mind from the beginning how
> authentication of every component of your process shall work, how
> unatteneded disk encryption shall operate and how measurement shall
> work. Security must be built into things from the beginning, not be
> added as an afterthought.

As a Qubes OS developer and a security researcher, thank you.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--fQwDxQIy+7yCND6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmV3OLYACgkQsoi1X/+c
IsFyNxAArx72Adj1gD+G9UHxAYeoRVTiUT0VPIvvBVQ1HI3uKhFGafNIdhAKkS6Y
ii15FD0yjOrXXvGUW6cPOHRnDkWT9kvBNBHRT2IDn1UwARV5fFhLS06x4CuFAaik
czEejiQqzAaomb4F48NbCyQkh4ZNzhpN85jLixuU9PpnoW0HazZW6cXkRhRVmDtH
GC6lxARSlqkjynh+ZUMYbnUH+MBfHKzh/Jbo/QUwJMq7cf6ekrip+kuBMWbQ58EZ
QO1LowdvietGsubyObFZIdVilPvh32qJ6/ul2Gl2SAZvUWdGPNFk5MFKyPwDWD1S
O0PsFY1NqWLPKewFXeTFUyQHwvApYkHlZ8TmAJrTZUbOnlLN19zBCHfEw3GFoDC+
LFsQkeojgF7tGQ78pNO18m4sjF6hafzsM61DoZJjSZaM0IbF/+IbP0y0yDUHOuun
An59fmWSoO98Gv2Hco118bacYfXNA/Mbmvvkf7jEi2JIWDd6hMEfP5X8akYhmJ2b
VVDMGanN4Ro8hf49yntvr0asbJMdMpQEhe+dJVBAEMU/UeMEsd7y5BcRj/tN3D9p
fHuBP6sSkiMeRdU9fv8m7v/SFhWeNrU6ndHXsOTuqezR3Wsn9vgGboZOu7ADymBZ
wWlRTENALgDRh2G6XliC2eFDNAXJ9WNFWlMLbpbt49NKJtzlbMA=
=7lcP
-----END PGP SIGNATURE-----

--fQwDxQIy+7yCND6V--
