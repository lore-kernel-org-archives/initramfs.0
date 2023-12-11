Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mny7xVgU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAEE12C
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702294975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYAeNOzmfe+7lHyYHnYw8Dn6KEKiRkFZDUxcOP5fUXo=;
	b=Mny7xVgUDbNLGRxsHXVYJ6SV4gwCx23jqnftABB14/dTg2wbtbnfF+BlrCMNUxyUM4YT9u
	1cH55ZICHJkrJvbARCQOt1g9KKet/PPKIriD2gbFJU1eb3oUs7Uphe4WhsVcUCoKNFuFHm
	TwtRVmobS7oexB8tG2AV9Dvo2DQ2LL4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-_npun1vYP0q4j8MJ_BOJuA-1; Mon, 11 Dec 2023 06:42:54 -0500
X-MC-Unique: _npun1vYP0q4j8MJ_BOJuA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cecc9a3519so1797466b3a.0
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294973; x=1702899773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYAeNOzmfe+7lHyYHnYw8Dn6KEKiRkFZDUxcOP5fUXo=;
        b=Flszfi2Sls71FdU+d5IPqA0VlF9wKzSL6YSRm7ylK9C78SuYEwmDG4bb0i4Doyo1Hr
         KZZAfkmwV0L95xV2Xx6prIY35pYkb+HIjiDGB9zPKC6C9c8LtwS9LWgeSK9zE9ZNBl4t
         rFdC5NqUVrYgSCzzzRc9pafyy91I+N7ebH3CQSwwMpRebf1B3X2y/LZsuMikDg/iZhET
         ZFm3a7RpfdgKmBAElK4sziDhyBJxwUThn9XMmeAiStXfOj1f3PIxTGCHoRUC7TjIBgnS
         4dL7UgdRKNE3En7+ma+wIwgtQR3ZfsuUGer/Az4qoI04y6DrnRNsUvde2EEH0cjqPUh2
         GWqw==
X-Gm-Message-State: AOJu0YzTHjiLKk7p3STAqnuwz+tUWsJ0Sl6zhzoNfqQkd+GoW8cI9JXh
	BkbJWId73VjQd4n36+qrg7Md29apcH6idUPtr94seaSJJeTdHR8Qi21LtALYAvbep8/Nf5mP1Af
	dM8dE+LNAL6SBcdlYS/q3TI/2/5YKPpNfFIigeuq6p7inAENl0A==
X-Received: by 2002:a05:6a00:7002:b0:6ce:2731:d5ce with SMTP id lf2-20020a056a00700200b006ce2731d5cemr1327964pfb.63.1702294972891;
        Mon, 11 Dec 2023 03:42:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHREw2ZjAcOB52BHgxW+e5ruVQOEzQFtXn90C34YslO3wiJ8NC3ZcUBSG2yo2U6r1hx3cFC/wFjW0udFDAiIEk=
X-Received: by 2002:a05:6a00:7002:b0:6ce:2731:d5ce with SMTP id
 lf2-20020a056a00700200b006ce2731d5cemr1327958pfb.63.1702294972503; Mon, 11
 Dec 2023 03:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
In-Reply-To: <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 11 Dec 2023 11:42:15 +0000
Message-ID: <CAOgh=FwacNaw0MqAtK=wjRt5TyM369-4+22eNvowFR_yoet-Xw@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <mzerqung@0pointer.de>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, 
	Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I am also thinking, what is the difference between "make the
bootloader load the erofs into contiguous memory" part and doing
something like storage-init.

They are similar approaches, introduce something in the middle to
handle the erofs.

Is mise le meas/Regards,

Eric Curtin

On Mon, 11 Dec 2023 at 11:28, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Mon, 11 Dec 2023 at 11:20, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > On Mon, 11 Dec 2023 at 10:06, Lennart Poettering <mzerqung@0pointer.de> wrote:
> > >
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
> >
> > The top line is the filesystem transition, the bottom is more like a
> > process perspective. Will make this clearer in future.
> >
> > >
> > > So, I generally would agree that the current initrd scheme is not
> > > ideal, and we have been discussing better approaches. But I am not
> > > sure your approach really is useful on generic systems for two
> > > reasons:
> > >
> > > 1. no security model? you need to authenticate your initrd in
> > >    2023. There's no execuse to not doing that anymore these days. Not
> > >    in automotive, and not anywhere else really.
> >
> > Yes you are right, there is no excuse, the plan was to mount using
> > dm-verity most likely with the details from the initramfs, but
> > admittedly we had not looked into that into great detail.
> >
> > >
> > > 2. no way to deal with complex storage? i.e. people use FDE, want to
> > >    unlock their root disks with TPM2 and similar things. People use
> > >    RAID, LVM, and all that mess.
> >
> > We had 3 thoughts on this:
> >
> > 1. Just worry about the common use-cases and leave everyone else
> > fallback to the approaches we use today.
> > 2. Try and split up systemd to make it even smaller. We do use
> > systemd-udev in the small initramfs storage-init process so far.
> > 3. Reimplement some things? But as little as possible, on a case by
> > case basis, we certainly don't want to fall into the trap of rewriting
> > systemd that's for sure, systemd does these things very well.
> >
> > Tbh, if we try and implement this in kernelspace a lot of these
> > questions go away. You just teach the kernel to deal with the
> > filesystem image early (say erofs or whatever other filesystem) and
> > have that data where initramfs data currently is. You still pay for
> > the initial read, but you still save a bunch of kernel time.
> >
> > >
> > > Actually the above are kinda the same problem in a way: you need
> > > complex storage, but if you need that you kinda need udev, and
> > > services, and then also systemd and all that other stuff, and that's
> > > why the system works like the system works right now.
> >
> > True, but there is also a bunch of stuff in current initrd's today
> > that aren't required to mount basic storage, but are designed around
> > the whole idea of having an early throwaway filesystem.
> >
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
> >
> > It's mainly the top 3 that were the goals. And that people have the
> > freedom to consider using heavier weight generic libraries, tools,
> > etc. if they want. You want to use Rust (or languages X, Y, Z) to
> > write something early boot, go ahead! You'll only pay the cost for the
> > larger binary if you actually use it. The week I started tinkering at
> > this, there was a mini-debate on whether we should include glib or not
> > in the initrd. And we are regularly under pressure to reduce boot time
> > at the moment.
> >
> > Number 4 was a convenient way to do an early version of this, stick a
> > process in between systemd and the kernel. But it turns out, it works
> > very well, the only problem is the reimplementation problem really.
> >
> > Theoretically this could be systemd-storage-init -> systemd also. Or
> > systemd and dlopen more libraries as they become available later down
> > the line.
> >
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
>
> What I am unsure about here, is the "make the bootloader load the
> erofs into contiguous memory" part. I wonder could we try and use the
> existing initramfs data as is. I dunno if
> bootloaders make much assumptions about the format of that data, worst
> case scenario we could encapsulate erofs in the initramfs, cpio looking
> data. Teach the kernel not to decompress and process the whole
> thing and mount it like an erofs alternatively. Does this sound crazy
> or reasonable?
> Sometimes you cannot change the code in a bootloader and it would be
> nice if we could avoid introducing another layer of bootloader.
>
>
> >
> > Yes, lets explore this approach with the kernel community to gather
> > their thoughts. I'm still happy I did the userspace version first,
> > even if we end up doing it in kernelspace because it allowed me to
> > test on various pieces of hardware to see if the benefits are genuine
> > and they are....
> >
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
> >
> > I'm hoping we can benefit both use cases, the case where you want to
> > transition to a rootfs and the case where you never want to transition
> > to a rootfs.
> >
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
> > >
> >
> > I'm certainly a little biased here because I work with ARM, I would
> > like it to be UEFI world, but it's not and convincing every SoC vendor
> > you must use UEFI is hard. I know a UEFI covering solution only would
> > not have much value for my team at least.
> >
> > > (If you are focussing on systems lacking UEFI, then replace the word
> > > "ESP" in the above with a similar concept, i.e. a well discoverable,
> > > unauthenticated relatively simple file system, such as vfat).
> >
> > Yeah, agree, this baseline, I think, is common enough to assume. Like
> > Android Boot Images as an example are basically a UKI binary stuff in
> > a boot partition.
> >
> > >
> > > Anyway, I can't tell you how to solve your specific problems, but if
> > > there's one thing I'd suggest you to keep in mind then it's the
> > > security angle, i.e. keep in mind from the beginning how
> > > authentication of every component of your process shall work, how
> > > unatteneded disk encryption shall operate and how measurement shall
> > > work. Security must be built into things from the beginning, not be
> > > added as an afterthought.
> >
> > Yes and we certainly want something that fits with the UKI models and
> > the other commonplace models around.
> >
> > >
> > > Lennart
> > >
> > > --
> > > Lennart Poettering, Berlin
> > >

