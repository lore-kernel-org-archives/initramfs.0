Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9F239E76
	for <initramfs@vger.kernel.org>; Fri, 10 Oct 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072282; cv=none; b=tMsx/MN8IDokRS66XWDLHWTd5oJ3RaTqmZfOYqhBycjCapBnGHMUe2sFspvj6fZTDx4SVOpD/F71umPOFxvMpRPQcjNUKmLRMpOwXh6bpkbVS4kVh+XgD75E8TDPMau3uNbmt4PCQQ/jFi2lqWxCyQgntDYD2/Hfz2xWZ3bZWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072282; c=relaxed/simple;
	bh=20zVq/I1A85ImSdUuzZ7bh9Qs7dqD4eEIEsQzzw5Ci4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqX4TBrHJxPLRLmQaGHu29WCXsOVJppzidDal/wGIUAs9f+tr5LBK7Bgx3hemMVzNYRvsTyyA8T+fPrgGUhQVcqDP/WJGrJCNs1v15XEPvWVmiYU8kAiulSy9Mh/ivpEV7ErlbHJOfp4FGB7Rpban8OnJ5TXMWSjHtc8SP0KCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrdiTzbT; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdiTzbT"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63bcfcb800aso1879311d50.0
        for <initramfs@vger.kernel.org>; Thu, 09 Oct 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072278; x=1760677078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=GrdiTzbTpmXrgj0/PjkohCZ6LgFNbxV45gb5L/ZVbzaWKAHJgA12/mfFqFdtOpY72m
         bZZCyt4k8jRvQo4unsWw4ZeaFcU/eOYR2U/wcLgsvZR/RYdUoV9fmyuViF8Of5PYj/l4
         634Gm0JHXypxB9ycdlhLckuOP80mjqw4wIO9HLiTQ6purdE8gu3SXgXaNMsYndjRbf75
         1dPvVv1bpLUsn7UsoLTsiGPIZ2KQmnwtMFB4nrm8RHlzLeSFwrO7OIHtu7G4t0f6Q3Az
         maevl8wn3jZRwLsUqzTevJOM0Q45hnxhlAkendZd7mXKlZsyaRmG6ugJRYjmZ1sxfyiy
         qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072278; x=1760677078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=lDh/eoJNLhMnP9q2ouTnUigT0/pNsjb5qufSrNwA6KYxmN6hanjdVT4sIiSbLsmeDP
         EfWzwbYz9cBVWdf4SF2T0v7yNsbzX/QXi0VzRK2VoOHgivTugZlkDjolXhCjBuyDccbb
         KTIkAYIc+OHrXxb3o6IzpiwcZ7kvQKtLIMqmJL/IG+2Uw3/CyaLpCzMLBO1Vjf+nFlZp
         CdXXVoyPmuNhWboDgelfGv4zqlqttekTacuwKlJvyEBZaF8cZGHn75b4rfY3/XUFDaWX
         L6I8ntZHZfnxVz/3wmEzopBFB5XKqm8wjCNTu+yEq8i1BRd5AQHYDBX/OyM+vk9ZFQ77
         JBMA==
X-Forwarded-Encrypted: i=1; AJvYcCWw1auH4eQgzO7QNfRk1QSJDHQWKmW6FGGGV4Dy05JV5aA5KWx0sgCb8aZBi1gO0n+FSod7qpDuBNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKq9XxccEfPgw0KBMmU3J4wMuS7ZQuqbzZfVecXK2UbQ2KNqp
	w3FO7Am9UVinMoHF6HFlBXb/tFnmU7bsirUG46HJshL0TV6arR90q6nQLTnSvVEKw6giK10Jzmk
	ke8CZfiGANhYwMe8nnB1A6Et5IM5AVoA=
X-Gm-Gg: ASbGncs41JHl4v/AvPd5DZ9FCJ/BE8AsQugsan8/8X9BxLc0ubxo+l8UHi5V4bI1PrB
	MkEa+iXrF4899GrIZgdLnm7nBytxaYIIg6JSQcrMcmESpiATHi4qP5qD6eUSOsx8Oc68LA30hZe
	ubEkPUoL/Iv65xwyFfxrMcZEWlq55upg6mMoZfTnRlwUmznJLg3g3T3VFcqYPTzBAllSdsS+lFl
	pnnHLNxdJIk8Re785ePRoz9iA==
X-Google-Smtp-Source: AGHT+IHqDciv7GAPYfMGdKr9Fwuo5GT168N8GcrpsJ5KozP5HqYqg/LDALxuogvzJXgNCm6zrA+DoCqu7lr8uhQrVc0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr7466309d50.51.1760072277565; Thu, 09 Oct 2025
 21:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
 <20250925131055.3933381-1-nschichan@freebox.fr>
In-Reply-To: <20250925131055.3933381-1-nschichan@freebox.fr>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:57:21 +0300
X-Gm-Features: AS18NWAQwCKadWHXCZjVUBNaD3TaKIilJiJAQzSbvGFaYuFuE8UDpW1_H3riB-k
Message-ID: <CAPnZJGBPyONjJoM6cskxysDnN4pxWuWJCK5A6TgikR2xHsrN5Q@mail.gmail.com>
Subject: Re: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND
 00/62] initrd: remove classic initrd support).
To: nschichan@freebox.fr
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

On Thu, Sep 25, 2025 at 4:12=E2=80=AFPM <nschichan@freebox.fr> wrote:
> - drop prompt_ramdisk and ramdisk_start kernel parameters
> - drop compression support
> - drop image autodetection, the whole /initrd.image content is now
>   copied into /dev/ram0
> - remove rd_load_disk() which doesn't seem to be used anywhere.

I welcome any initrd simplification!

> Hopefully my email config is now better and reaches gmail users
> correctly.

Yes, I got this email.

--
Askar Safin
