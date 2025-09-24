Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11331353C
	for <initramfs@vger.kernel.org>; Wed, 24 Sep 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730691; cv=none; b=NtUubxordjO6KukY1SMIguqFv1OQsGPOS80Wd/MQeFEi57lqQ1HdaZ70ja3yMTuisiKQJYm4TOVICFlPFO9jpbxLZbd3ndVTCCUbl5Mnpj76PQiEF7Fb13Jf70BAAr7ncrzu1JwkVWLslSTp5oraoaV4f3ZL4/gjUdRR4beJSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730691; c=relaxed/simple;
	bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8m2ou13+c99qNmI0i2wW6baPPqJDiE4e4IVbiWsqVvPDt9UBtVZ8NcN8BzNjHy1iBeQD85BXCb6XYuC79IwOG/n1D7NjkoGIBrguQlohgzgYKWRmCYH4a4E0ox3bEP3ufZhtOItk7+zrfKVND4HMOZJCbH0cHlhiOJvM1T1+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESV2gQou; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESV2gQou"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b61161dd37so57641cf.3
        for <initramfs@vger.kernel.org>; Wed, 24 Sep 2025 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758730686; x=1759335486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=ESV2gQouzsHw0Ghx+847Tf5wuj2Cvz8JvGZVBbqgTLUShUks6t/g8niF6xTKMp+gjd
         BZRoElC6veBwWw/WK+y1zmK1BrCwHSt9xkHt6EjdNtIPb/6flUxTn8RLQIJdl0QtVEoU
         w/FHxbFWPifK3QFnSjivOb6QY8+GXlo4jvE3/+M6MyT4wns5fOh5dIzlxD0L42M0K80e
         blWWeSwn/ic89n7yOwd0f54hSw9NlpaEtjyPcLSNn0Jbh3vbsWRBy9OdDOLpmCyPNk7U
         XLARA68Wsy5S1DH2bkn6yhU3L99Cn9NfnrxL/30lfrIs32+LFdFwT83yeTryJJB7vpw3
         fRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730686; x=1759335486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=MCi2qLysjGxG/cfoU26nJDD2ptAzVdlsc+DQRBi53hvU4rxA4sRYwnxY5gNM9KntCG
         8Nw+TX9F5G/6ArNIyzHn7+MnAb/8jtL3N8HTXd1cvYVgHu/YU1ijrIHn6mkn9QCE9pJB
         Ia3daku9nu0Vi/82rz4SBAEA2pEzgOMVmzVJiL/TzEnkorY5O1tGENWCqOCaNq16ZyFC
         A/jxCX2bcPIuqr93CeYIVEVVEmhx9zhNVkEZJABVCNN3WKP3Zu20bRPxGSJTY+3OKHvR
         Op5hY7ifcxNPvEboCae79EHhXqqJq4pEdWjb6UD/FbhoH9silKzvCRSlMkxwF1JqtQfR
         8l9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbALg7+OoyPYwPF7m4V7q1Inw4PsaQnYNdgmFrdmL4zBZbul5JPTuB5tx5DC3dXGoV87iXK00QFyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadGC2uPQuIkIFH+pzmYlDMVGDZ843RbIwjYR9Ptcbh4f/Ewvu
	fUXwqeogP4/v9cm215ovVQ6ymPwuTRwkz83PS+44jloUS1wK8UKzo/xsKn//oWI7yXOZ18InYyE
	J6a7G7yFXlNaNDV//1R+7dxuj3Ycg6Dk=
X-Gm-Gg: ASbGncuZMw6aumIZ6iDa68XKhYbX9HiNHigOegwW1b3K/erD9S49FgSuoxipaus00ab
	+JGudW8CFPfGA5E0nZw9HJ55UaaWp/s7X6TFDkTw/qzNsn4IjbMEHHSNb8Wr/eZo13Pom0NJlL2
	9TQwgg6XtgXd69NY6Cp5uKlQRNXaYSfsVojz6cgRAoyM7mhMlRfnjX63Rid9CrIAOzGyvSQq7Ml
	YWEo1Jvh2gZ/ZNKS9aSPRQsEx5RJlHFxAIUEg/U
X-Google-Smtp-Source: AGHT+IHrjx0XfB3NQHdqBt66Ox1dwY4oj3I0wMxztSwqqFAAkQnhEkK0QBLdnresO+RuCvDJitimjmBRn2YZHsgZxpk=
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id
 d75a77b69052e-4da473535b8mr6186491cf.16.1758730685377; Wed, 24 Sep 2025
 09:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
In-Reply-To: <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
From: Alexander Patrakov <patrakov@gmail.com>
Date: Thu, 25 Sep 2025 00:17:39 +0800
X-Gm-Features: AS18NWB-xeGoRDKYPj3kUYXUnKXLhFMFvvc0QyoLpOeKcP1DsD-enKeBhlulfsI
Message-ID: <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:22=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 13/09/2025 =C3=A0 02:37, Askar Safin a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > Intro
> > =3D=3D=3D=3D
> > This patchset removes classic initrd (initial RAM disk) support,
> > which was deprecated in 2020.
> > Initramfs still stays, and RAM disk itself (brd) still stays, too.
> > init/do_mounts* and init/*initramfs* are listed in VFS entry in
> > MAINTAINERS, so I think this patchset should go through VFS tree.
> > This patchset touchs every subdirectory in arch/, so I tested it
> > on 8 (!!!) archs in Qemu (see details below).
> > Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_IN=
ITRAMFS
> > and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
> > CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
> > If you still use initrd, see below for workaround.
>
> Apologise if my question looks stupid, but I'm using QEMU for various
> tests, and the way QEMU is started is something like:
>
> qemu-system-ppc -kernel ./vmlinux -cpu g4 -M mac99 -initrd
> ./qemu/rootfs.cpio.gz
>
> I was therefore expecting (and fearing) it to fail with your series
> applied, but surprisingly it still works.
>
> Therefore is it really initrd you are removing or just some corner case
> ? If it is really initrd, then how does QEMU still work with that
> -initrd parameter ?

The QEMU -initrd parameter is a misnomer. It can be used to pass an
initrd or an initramfs, and the kernel automatically figures out what
it is. What you are passing is an initramfs (a gzipped cpio archive
with all the files), which is a modern and supported use case.

--=20
Alexander Patrakov
