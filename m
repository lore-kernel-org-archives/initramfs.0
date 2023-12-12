Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA36rkum"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A23AB8
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702414169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfnxhZxyIHFXKkhkymlF8tIHxP4YeFysm7D+JCtRC28=;
	b=RA36rkumB3aP5CkkyRxJ9NiR7R7Xn16SRSsFY8NjinWSEUjZLQ41auNXSo7FkV6kKaMTc3
	MoRFQpkk3ZPJlvc/em4AaC3ARgJ5Ddy3ayR2lYssJI57QWqav54VDXhfOgkcd94h/QpfaQ
	SThh7cMZdpTc+F/hpsTc0CpY8HzXz/k=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-crlcJTBhP728ZWkke4-8Fg-1; Tue, 12 Dec 2023 15:49:27 -0500
X-MC-Unique: crlcJTBhP728ZWkke4-8Fg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7cade8197e7so614574241.1
        for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 12:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414166; x=1703018966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfnxhZxyIHFXKkhkymlF8tIHxP4YeFysm7D+JCtRC28=;
        b=DEvMs0SQKQfVVXkQ7L2xpGvLiBTVSuWPnPzB5tvFYE3oMBXnREDLoGGpJe5O1GK8zT
         06/n3O96EpPyoXCNiaLQhPJjU3MIjPKtzIhv7PCBPSYzHu6Na2z5mLEVFEL0CJ2193/l
         w0QK4M9Lg6F/nkRtJBf5OxXtIH829TXbViHyvLdDJql4R0ZO92/srcIWoQvwYLthsKs3
         9OTMfyDp5Bt5gzLlfKeO+UJcVCP3dDCfU5BHJqvZOydbWfjNUv8CmAHHKFAbXp6X4uW/
         5JODprNVeui+KVIWo6Sax9CzRRUrqnmC56D7NIoAIDbAMVlyNRJ3YTCn6WctjiMFHqqT
         r1Mg==
X-Gm-Message-State: AOJu0Yx4FaBEolVGPucSwtTa06ycHw9kyXvCNd/HCeHREtb+fq53/uNR
	rsTDlG7tBTxaFW1MF4ZxFSOkzp+4Zjmfs+Vrrd/r4I18llwMkni+c1NSqIqHZY3qO6/eDyvg1tU
	6636ijydiYlOaHrIwgvRA1scflI3HfpKigbtF
X-Received: by 2002:a05:6102:4744:b0:464:6214:8e1a with SMTP id ej4-20020a056102474400b0046462148e1amr4596854vsb.22.1702414166580;
        Tue, 12 Dec 2023 12:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkM/fWRvBhWIXQcbdYRr/ExvnWVrYBMRQmFlDEKggrb7YkMtSPX9wWqtf1n2e5DhS6kBzhnECXbKF8llkyls4=
X-Received: by 2002:a05:6102:4744:b0:464:6214:8e1a with SMTP id
 ej4-20020a056102474400b0046462148e1amr4596847vsb.22.1702414166314; Tue, 12
 Dec 2023 12:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
 <ZXifwMan02j9M3n2@gardel-login> <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
In-Reply-To: <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 12 Dec 2023 20:48:49 +0000
Message-ID: <CAOgh=FwY-8duUD1Tx3g6wQA8GLnQBNj-cx5d9mhPvT4EmjiQGA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Nils Kattenbeck <nilskemail@gmail.com>
Cc: Lennart Poettering <lennart@poettering.net>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 20:35, Nils Kattenbeck <nilskemail@gmail.com> wrote:
>
> Hi, while I have been following this thread passively for now I also
> wanted to chime in.
>
> > (The main reason why sd-stub doesn't actually support erofs-initrds,
> > is that sd-stub also generates initrd cpios on the fly, to pass
> > credentials and system extension images to the kernel, and you can't
> > really mix erofs and cpio initrds into one)
>
> What prevents one from mixing the two (especially given that the
> hypothetical erofs initrd support does not yet exist)?
> Or are you talking about mixing this with your memmap+root=/dev/pmem suggestion?
>
> > The try to optimize the initrd a bit by making it an erofs/memmap
> > thing and so on. And make sure the initrd only contains stuff you
> > always need, so that reading it all into memory is necessary anyway,
> > and hence any approach that tries to run even the initrd off a disk
> > image won't be necessary becuase you need to read everything anyway.
>
> Having to ensure that the initrd is as small as possible is definitely
> no easy task.
> Furthermore unless one has total control over the devices, or even if
> there are only a few hardware revisions, parts of the initrd might not
> be used.
> Even if everything is the same there are codes paths which might not
> be taken during usual operation. An example would be services similar
> to the new systemd-bsod which are only triggered in emergencies.
> Having these in the cpio means that they will always be read and
> decompressed.
> Using sysexts also has the drawback that each and every one of them
> has to be decompressed. I might be mistaken but I expect that this
> will be the case even if the extension-release in the sysext results
> in it being discarded which is obviously another big drawback.
>
> Regardless, even if every single file within the cpio archive (and
> potential sysexts) is used, erofs still has a distinct advantage over
> cpio!
> With cpio everything has to be decompressed and read up front. With
> erofs this is not the case.
> Only the fs header has to be read at first as files are decompressed on demand.
> This means that critical stuff can be started earlier as it does not
> have to wait for decompression of stuff only needed later on.
> For example an initrd-only (i.e. not pivolint root), graphical system
> could start all background services long before the UI starts and
> accesses large asset files.
>
> I agree that this splitting up into another micro-initrd just for some
> storage stuff etc (which I still have not groked completely) does not
> seem to offer any advantages to what we have today. *However*, I
> certainly think that standardizing and supporting some kind of erofs
> based initrd would gain some advantages.

Are we sure? A bunch of stuff in modern initrd's today have nothing to
do with mounting storage. I've proved there's benefit to that with the
data on the initoverlayfs page, you save ~300ms on systemd start time
on a Raspberry Pi 4 with an sd card, if you use an NVMe drive over USB
on a Raspberry Pi 4 it's even more... ~500ms. I wouldn't say that's
insignificant. You still get all the functionality of the fully
fledged initramfs when systemd starts but you save between 300ms and
500ms.

>
> On the other hand this feels like going back to an old ramdisk again.
> This goes beyond my knowledge but based on the kernel docs most
> drawbacks of ramdisks would not apply to an approach with erofs. Also
> maybe the more flexible loopback devices could be used(?) which might
> alleviate some problems.

For the record, this is what we are doing for initoverlayfs at the
moment, mounting "/boot" partition and then loopback. There are
significant advantages as there are few bytes read until you start
using initoverlayfs.

/boot/initramfs-6.5.12-200.fc38.x86_64.img
/boot/initoverlayfs-6.5.12-200.fc38.x86_64.img

>
> -- This block device was of fixed size, so the filesystem mounted on
> it was of fixed size.
>    -> Should not be of concern as it is readonly anyhow.
> -- Using a ram disk also required unnecessarily copying memory from
> the fake block device into the page cache (and copying changes back
> out), as well as creating and destroying dentries.
>    -> (?) This one I am actually not too sure about and supersedes my
> knowledge on tmpfs, vfs (and its cache layers), erofs caching, and
> loopback devices).
> -- Plus it needed a filesystem driver (such as ext2) to format and
> interpret this data.
>    -> erofs is already included in most initrds (and is not too big if
> it is not)
>
> Regards, Nils
>

