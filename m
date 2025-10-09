Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52242D2391
	for <initramfs@vger.kernel.org>; Thu,  9 Oct 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999420; cv=none; b=VZOy6Wfya26ms9hMJyzGaT7Ded/p1EaxmB2XnSKFlbc1kMWGtVLSTtA8C/I4Y4GK4tqH60RT9YrtLkiorpxLaQFyrSjjnwNmn/nVViofXzqmQLbT1dudizPnXIH8HYbQxIu9b7Dyp6oAVWnIlCBcyxtXJB+zQGKVj5rDWjg1EzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999420; c=relaxed/simple;
	bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLTaoTkW4snS3CaUcizGXNuq5eLstR+bMUlvQgi39ue4uckhM1Nj6XuH1HUo/QMcbjWQmiQKVgXnI/nsnTpoaaERCsDLyaHoGE1JUlcm23x++v3edYzEyxg9tolwaVVSopebQkp2tQTM8IkFqbH89XMrX7JkUxOctaFKx9LhWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd1CQWr6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd1CQWr6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603a269cso7057097b3.1
        for <initramfs@vger.kernel.org>; Thu, 09 Oct 2025 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999416; x=1760604216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=Sd1CQWr65JLYzY9EVKrEmyokZCi5vMbs6EjxpG+7QH6YGT3tDWbcej0s4cZgoeqQuS
         JarC6ZTWUL+kjcHPGBPAUN8Ppb1QBAPtlSxQfjpNRglhJxMMypRIPnB6rYYKLQvZjKiN
         y72xO5wzZc7AAEZk+IBKqraBb7+6wC4+Imv7nbjEtku9PO6PAKcYEb1vRHgafdvgR9U2
         dCS1DB4VwniCeBOnc8XLvNltoejI4ecSgvo1PpGG1tSl6PrUxnfallIONRoeLTNOEzbX
         FvDKAaN4VsNHkaBPKCCqR4S+rBMFmJJlJYY4H+OBfaZXGyq7o1ppfnH/vgJ3jgRm0T4d
         tz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999416; x=1760604216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=StGtJ8onz28d+t9YxRwFTyBGQ5OT0EcWkAwEobC9bupH++BUxjX0R3mqZYC2QdYI83
         UL1hZbens6eh5WiMjGC9Lap0AP2DnSVTR0oivAowUAPbYvyEw+N/maudc2T+duKkeZwg
         en7G1XWjlerOuJ1gwu/+FLZLyfJrbRBYiENytGfxJZqHaLMcq/O2AV0UbYi3IV/+MVly
         TLZuSoj0cCzCvfoMSzadxls2yhEhuCPS3niQs55+OnuMgBeeVP3N8O+rk0tJAHM+BPqP
         LV9kjEf1zW+aUz04VL9fIZc8FRLWRSG+988vfhn8aprNTKS3RZaB09qdbbFb2DErjUp3
         y03Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAizzR68RcRwBlg9svzQRVhS9S3Dxp24WVCg9fP0Yaxfl6DkvJZvta/eH577wTrnSG0a3f1d73WK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkevyH7iAHp+G7IZBNPC3nUsntqAhRORNSqAn1T4mx5hDhZjri
	MoaaJYv9QMlQAn/0FbALXIvzLmPcKz2wdNrV45RmgNZV0LO5IPuYXvDbY3IXZb7zcGa16iyf3DH
	7p1FcjoL259DzLdNg2itaQ1H19DL5+b8=
X-Gm-Gg: ASbGncvTp8AAvMzSmLqwmEcyasRuQp4Ea+HWyksUnOJXJBKGpMj5dtiEz/Sn3TXLtq4
	HgpGXRxT4WdIEXloQwRnHYz3MboMlQDuI0L+/fc5LwUVw8yRQTPgrZaj/JsYx+VaaPQmEPkM15/
	PuNQcw5Jrccje6PCJOUxdUhokvPd53P7DkHsPN79XaLHeD/NWhQ/HwzQqt8RjcpwBAtfmN5LXon
	fHG7a3jiKxPAHFVN3MmyhhTuU7RTJaRU7+CaNdVRQ==
X-Google-Smtp-Source: AGHT+IHqqt7JHMFlL5DEMxX8/4fuWke6o7x715NV65SuEycRYAp5q8y3uA9SPr+Cccah/gPAgRpT2LfWBS7AmxUm0/4=
X-Received: by 2002:a05:690e:146:b0:635:4ece:20a9 with SMTP id
 956f58d0204a3-63ccb91d5e0mr4410660d50.46.1759999415603; Thu, 09 Oct 2025
 01:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
 <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com> <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
In-Reply-To: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 11:42:59 +0300
X-Gm-Features: AS18NWA7xuLtf9pobQHoPGHI9uL9SjsnEaZg-EuuD52zBO81KbUszIYBPPZ5wRY
Message-ID: <CAPnZJGAp-wG+9wDmmisfpxvFbRtXkG-RipAuZe=fi1BWy-3G-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 5:29=E2=80=AFPM Nicolas Schichan <nschichan@freebox=
.fr> wrote:
> > Then in September 2026 I will fully remove initrd.
>
> Is there a way to find some kind of middle ground here ?

I still plan to fully remove initrd in September 2026.
Maintainers will decide whether they will merge my patchset.
You may try to convince them.

> I can send a patch for that but first I need to sort out my SMTP
> issues from the other day.

If you still have mail issues, consider applying for @linux.dev email,
they are free for Linux devs ( https://linux.dev/ ).

Also, I just tried to test whether your use case is still supported in
mainline (i. e. uncompressed initrd with root=3D/dev/ram0).
It turned out that on modern kernels you need to enable
recently introduced CONFIG_BLK_DEV_WRITE_MOUNTED to
make this work.
So, make sure to enable this when upgrading kernel.

--=20
Askar Safin
