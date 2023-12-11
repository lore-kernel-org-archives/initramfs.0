Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="RmZVkJZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIgVzmRF"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB66093
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 09:46:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id BCBFC320253D;
	Mon, 11 Dec 2023 12:46:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 12:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702316773; x=1702403173; bh=21egeb6VpS3BqZkntDJLpZ1RytowT7yWew/
	wWa9A3Ko=; b=RmZVkJZ1ecgL83qq+hF4jXLVaVpH8vUS218zCP3L3VBq6iPswMm
	vbM6u+biHSoxDdj4xg/6NKeL5wq0t9j8x+42UMZ5WRqPp3xn3zs2DPBXuLNgcCmv
	A8egRZEecT/RmMVbFY+xL5P4QqpECv8vV2cAvXUA/d7c9mtaMDn4FQeCalaw4mZo
	0kF2Xs49dYl33IgDdOPy9KPqSutOeMACKqGOv3Uc/Zy2rICnEmclgePbxX+GqKTu
	eTEfFdeDX2buGNh0Y+mlECyMuSOBDRQ05MQWKSHX2vzU+8Fv65a0jaaWElk7UP4m
	zIztmJNn3YKCOJnkP3Wc3BoegIYoOp99tBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702316773; x=1702403173; bh=21egeb6VpS3Bq
	ZkntDJLpZ1RytowT7yWew/wWa9A3Ko=; b=GIgVzmRF0nYhcYiLie+vUkSkZD3c8
	MpIRConxUEYbEyg0m1YCsjnENCn7q8Q3FbZaMos+udROMz3b648gobXSNmQtN3Uf
	8WX0jsyz+CbGmM813hF2Q9KfItQAAzCR0GM5nePZ1tsAN61q+wOS05zfeMBkBg6c
	/QAb92SzynTYbK3dznoSa3kvh6BZzRXYThSTLXFxBheVkSK4QNXHPWwpcMea0Gnx
	kFrWSoYxl53uR1y8STXHJGBt60Fpq/PMJZRXsUjkMVACO1Sy9DInDYjbEPp3lKXR
	agd3dQj/UKfgN3iXagrFTSR7KVgD/lWCcujQ3lyxAYsvq61CqPR0vBfsQ==
X-ME-Sender: <xms:5Ep3ZUDTXLlj1uhWO3WSby1mkN9uWlH8VUixftfsqxNiL8i8wm2FDw>
    <xme:5Ep3ZWiOR9mpWuANAx0hJ__4JlBAuAZlr74dHuxNViCMUA5fF88cEhcOkL-JLyXG_
    7ByufuSzDXiroY>
X-ME-Received: <xmr:5Ep3ZXlqqTzBzUJSMWr1zTndNVlhSvnzg67oL8y6q_C-zDacsXBl7OsbhXMArZnV5dHhPhmqhdkU8_9vNAOXnDRWtemvzOnpjsYNdvMl2KonQh9i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtjgesthdtredttddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgeekgfekvddtueefgeeigfelleeh
    hfevteeivedvgfegtdeuledvhfegjedvudehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:5Ep3Zax3OmSmh80fV69ywt1Is1yeqeXEhpjBXAHNHy9bvm1x54tXKA>
    <xmx:5Ep3ZZRAPesJsPTnZh0Fg15GTWngz_8rRORj-KsIGBTuGHZnH6Q67w>
    <xmx:5Ep3ZVYTcJJv6EjdceLrRau52NI5ikiLlyj47eybuU4hID-TePo_rg>
    <xmx:5Up3ZSIZpHeooufPQXNCLKEH_YPuwfrVSmIL-2OfwWtFhYp_VLSXvg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 12:46:12 -0500 (EST)
Date: Mon, 11 Dec 2023 12:46:11 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Eric Curtin <ecurtin@redhat.com>
Cc: Lennart Poettering <mzerqung@0pointer.de>,
	Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXdK40yg1VjjmB3q@itl-email>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Dec 11, 2023 at 05:03:13PM +0000, Eric Curtin wrote:
> On Mon, 11 Dec 2023 at 16:36, Demi Marie Obenour
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
> > untrusted or TPM-signed.  It means that one have a complete set of
> > recovery tools in the event of a problem, rather than being limited to
> > whatever one can squeese into an initramfs.  One can even include a full
> > GUI stack (with accessibility support!), rather than just Plymouth.  For
> 
> plymouth is very interesting in that it has it's own graphics stack, event loop
> implementations, etc. A lot of the initrd software is like this.
> plymouth is one of
> the examples I think of in my head of something that could benefit from being
> able to use more generic things. At least it's an easy example to explain to
> people.

Indeed so.  There is still the concern of startup time, which
GPU-accelerated programs in particular are often not great at.

> > Qubes OS, one can include enough of the Xen and Qubes toolstack to even
> > launch virtual machines, allowing the use of USB devices and networking
> > for recovery purposes.  It even means that one can use a FIDO2 token to
> > unlock the hard drive without a USB stack on the host.  And because the
> > initramfs _only_ needs to load the boot extension volume, it can be
> > very, _very_ small, which works great with using Linux as a coreboot
> > payload.
> >
> > The only problem I can see that this does not solve is network boot, but
> > that is very much a niche use case when compared to the millions of
> > Fedora or Debian desktop installs, or even the tens of thousands of
> > Qubes OS installs.  Furthermore, I would _much_ rather network boot be
> > handled by userspace and kexec, rather than the closed source UEFI network
> > stack.
> 
> A generic approach is hard, I think it's worth discussing which type of boots
> you should actually care about milliseconds of performance for. It would be nice
> if we had an init system that contained the binary data to do the minimum for
> standard Fedora, Debian installs and everything else was an extension whether
> that's sysexts, dlopen, a new binary to execute etc.
> 
> If the network is ingrained in your boot stack like this, I'm guessing
> you probably
> don't care about boot performance. Should we come up with a new technique?
> 
> Automotive has an expectation for really fast boots, like 2 seconds, in standard
> desktops installs there's some expectation as you interface directly
> with a human,
> but for other installs how much expectation is there?
> 
> Or can we just fall back to existing techniques for installs like network boot?

I wouldn't say that people doing network boot don't care about boot
performance, mostly because I have been on the other side of similar
arguments before [1].  However, I don't think this technique needs to
support network boot.
- -- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

[1]: Qubes OS doesn't expose GPU acceleration to VMs.  This is not
     because the developers don't care about graphics performance, but
     because GPUs and especially their driver stacks have a very large
     attack surface.  Work is being done to address this, but even once
     Qubes OS does support GPU acceleration, it will need to be off by
     default, at least initially.
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmV3SuMACgkQsoi1X/+c
IsHH6RAAhMQl/nw2jdZ4tlwxX/zqib3Tfzdo1p9a5VOkSobrvV7qbG0DWVrqe+vH
NKU1xy6FGqPexKjLoGlxWXgPN5rQKvkFXSgRaRefcqGn190WRjqexF0euu26GYTx
AfOEWC1hywoyXUR2LMygEMpodA0ZvZffIZcovmjjr4OeXiSc5aAUrHQ2PabHZaET
BL4jfeNikjw6sA2UdpviMRzb1OVEGZDD96XDSbVz/8tOBcZZNePz+FQXnHqTpcLk
DrBtx4l5noeUYingzxmw4MQZYYPr3kC4+DQtQr7zxv8D0UE9g8lIcpektqMvgoON
88FwVOa4TgTij7vG2f4BGCrZjE7PiPPo5BRb+MtjlZMtrhwdI4IwXY8q4EANWUnw
8nM+952nffVVQjpBtKRsXPZ3glAjvUuqHT8GzfWYYu8y8Dar9c3U4aQSTCJspkz3
jBsPAatFSjdBvlE6OtmyYco92K3A9g6WXzkw5t+/yaljBOddEkxEAw8+Lo1dCqrn
zK+vSFhcGpYodsHFQY0w9kAZ2+6HBX2nZaEmD6ka3furRussm7D4Z36lx1D/pi68
BL4aAFFLaEQ0jD8jqtjVZ2JYpUQufzwrnsNPTZ97WTEKd2F/zM/S09WjFsaOfVIO
F95Eqk0YMHP+krDEcXvm34EZ3PeRGlVm1fz4ttjw8XEekwwB5QU=
=HR07
-----END PGP SIGNATURE-----
