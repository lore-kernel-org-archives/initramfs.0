Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE523D7DC
	for <initramfs@vger.kernel.org>; Mon, 23 Mar 2026 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237700; cv=pass; b=my34yibOkTB4HExih9+Ow+5/NL187BvLMnP/fO2Tox3HPrKE329+y/Egl8OJTZoqiCxmxhCZO4KIvpiXUnn61ewJl+r/SWP6Yq8lBny6/MS9D5VRfF6lLK/gDlfbzB5CdpEGaTcrKe3QuCHFvDo7kqBuKd8I3BlAzCZIFtKLoqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237700; c=relaxed/simple;
	bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTM3QRj4iX+Ygktz5QpBskvDLrJoTZFZl5jo/6Gg76lnM/MOnF5a5DMG5g7bWfkslUfQ6VaEJVLWz5xmkIQJlTY7sH4fzpEVM5w3n+kKxDE4KeDzonmTHJgonq8g5YPGOQSJuFFF3djH8uY6LNFXMed9KvrokQBObMFYYwfkxNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRKnIKUq; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRKnIKUq"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad8435f46so2615560d50.1
        for <initramfs@vger.kernel.org>; Sun, 22 Mar 2026 20:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774237698; cv=none;
        d=google.com; s=arc-20240605;
        b=c1BJ8X0z+jEX8Ud/cOK5ewRFwn2fWahL2wqifHkPEsg0/dspjmo+f8k6jSqGEj3lx6
         nn6J/GzA3X/9rBGZR22qJ2XbZsIqPCfWCD3FYDf37XfSsF9U7r8C0w8RQKYqFFa35vPP
         x6Rz2hERRFWgatoRa+p+QWYn+pgi+7sT17vFp8l4aIV6x+NRPcEvE4Z4B8ipDjkaHwfr
         UxHUEoNIEOWELwbU06QbAOABs+WlO5HS/SluWH0M6LZqVWIasZe/XTm/V7mnZjKd1wmL
         m0UF9wLTDZM3mZ8bLvq5IbD2En9t6BKsFpseXndlPXkQCFYDUeBn8gxLdOWgax3WaQdh
         WPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        fh=ST8/muAFFBtED0P+nZtnC7t3uMEYP/hY3ehbS4LEwnU=;
        b=TbwmUj2DTw2Cz9NAcg/RgsRUF9vA3Qc9xgCB9SBX0WtqmBhLuuKNDus7dV1FQfnYpK
         oLEA4wShc4aI2hXxGjN11Srrv5QsHB3plaTDy8BSDHqQmXr185vNPX14MLAfmloXysbg
         ydtT6QMMy4f5T2s9ZsYTdIKZCba9hUd7ymZzUBeAkD4Mafc+MkNhDrVQucHhA+5p9sIR
         LL5fe+c9mRT0SsfQLoyDOAYEUNZRhIVe4xlDtMdm2LJM1Xmyh4gqt3rGKIfvvxeMu4en
         dw8iU2ObMqLuFQJx8gm+z2GVLcZW4m6aTDyOmAbN5/3nrgZll12yiYZ00rYl3s4Fiiuy
         QWNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774237698; x=1774842498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        b=ZRKnIKUqHlbu9S4/u3j72jUfqdIoL18PVg5Gmli8BuuuKRm2xQKLnConJjZ1oFlk3Y
         xGs1kNsepaYHj5wv7m0TsRAyRPGrVz9SGMLsB+Lj5tYpR4yjT2LdeJNcNOhJlMmyR1Kj
         Po0s5IilZHVTbFvR0vgnUUDHbbDcEK6I7yZPXW1kpSe313JkD34rhMbCgTSCrACZbzSp
         eIjNLhNUsvr8vNQ6JVbOJoBuymfDGbIOT0W26KE1nbWwwVwvH8L0X8/dZvbpsNqI10A2
         tgJESBzL5i5r/iwAyvU5VlDcNlu16pshZV4YgDeSfA8KGNv3Pn3OY8q+Mw2OYX+9WDac
         YNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774237698; x=1774842498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        b=rwGfmbufJ+Xp9ODz//9rdvHmlLTaVzr/wGICM0Ftfub1SL64bMCNbMxOyH01BKSjxA
         t/A6QZ2pzBPKQ+eZrf5rxJ6WE5w8v2+Kd6MV8gJ7oHJUW/bGFvWVzOgGXg5/jNKYMSS/
         u1DAwMl/DA7I3mrJGfYkU75CBqD6HNzTj0TcrRSw0El99Ro6enkR21Stfr4FKa7HL4zf
         u8pRvX7cqNW9SnRapmyg0D+N5QU4ONeFj4STdCCjYgf21MZF6Mku8jSXTYTeOKzxKuhu
         ooeoudGZveK2/RtgxOy9DhJptJqhStPF2Pj6OLoEHdpNZNanprmemPMckiJ66RPaEu/U
         RDrA==
X-Forwarded-Encrypted: i=1; AJvYcCVlW7mWbrhXTRA38fbO7DS8Hh1v+oSyfILjB4/eCEbaWolU9JZIXy35oY1zFCdPE0apz0zHQs/FipU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75nnVzVbfT20LzMPRugTls7q8MPAv6iPNpHmDwjrf4C7A06Nh
	ul4MDkzUvWSJGUMzZMLK3Lap2CUpidwvnBTBNk6w4NaI0AmlGFHUDdJYaL/cZJ/MCB1A3X5MU27
	ilv6YVK/HXjV2D/UZnw1aifFGkCJcDLI=
X-Gm-Gg: ATEYQzygXgd1kWjI9/1FJ7xlQVmjQq0zo+HnGa2/zN0ExaR8c+E8/IPwfHX9stemASz
	jCGzOv8HbYJsC91EiQ+f7oPxEJOzv2qJBhtdykul/j9lcO97AdO1pvBnZmZDVQ9X9+UIeysBttt
	Jli/QrpuwI07dXopLWD3KFP4U9zP0INbSZS1DRReH32/pgpgqGi8aTaMKWH4JAdIH6otucppomL
	ta4hRSW6mEcnBcgn+AOz7MIb4zUODasdfVn99AyR90PWRmImNTJM7F9c/W79rLaliZB6Ug47ABc
	4RkdDpM=
X-Received: by 2002:a05:690e:429b:10b0:64a:ec39:dd4b with SMTP id
 956f58d0204a3-64eaa7deab5mr8770494d50.43.1774237698447; Sun, 22 Mar 2026
 20:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd45c86c-e1ea-4995-bb00-df83cc873105@landley.net>
 <20260307032258.2857157-1-safinaskar@gmail.com> <54f06055-c5ca-4b8f-9aed-065755e7c1b2@landley.net>
In-Reply-To: <54f06055-c5ca-4b8f-9aed-065755e7c1b2@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 23 Mar 2026 06:47:42 +0300
X-Gm-Features: AQROBzB-PQlqF6OH6A_aRUOwM_KQYLR0utQ15-12H2PLD6u8em4oEuDUzIPNaAM
Message-ID: <CAPnZJGAOPV26Owic+MoMUFaJVoofhLOjfmtVi2fi2GwtrVssYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Rob Landley <rob@landley.net>
Cc: brauner@kernel.org, ddiss@suse.de, initramfs@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, 
	patches@lists.linux.dev, rdunlap@infradead.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:51=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
>
> On 3/6/26 21:22, Askar Safin wrote:
> > Rob, I kindly ask you to test this solution to your problems:
> >
> > https://lore.kernel.org/all/CAPnZJGDDonspVK1WxDac2omkLJVX=3D_1Tybn4ne+s=
f3KyaAuofA@mail.gmail.com/
>
> Your earlier suggestion that at some point they fixed the kernel build
> so I can go "/path/to/dir /path/to/file.txt" (which didn't _used_ to
> work, I tested it way back when) would presumably solve my problem
> without kernel patches.

Cool! Please, write me when you actually test this.

--=20
Askar Safin
