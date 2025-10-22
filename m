Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CD34BA3A
	for <initramfs@vger.kernel.org>; Wed, 22 Oct 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151316; cv=none; b=Uo/7JbNQcwqOIEOqqB9W/7WIi57y/MvI7FgipfgYtBFXx2zjg4HtShsMYuplnV6OZ8uKOlnpBEViq06QQ7B782TDm67yeR/xI2ttC2lE8/Kx0Am0pFNpVcPxBR+Wy6P56bLx4ONg2rsIiLKqMp/ISdRyIAJaZBCAjljge5zg8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151316; c=relaxed/simple;
	bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae6JgjoxnKqFr/wIOFYVmQ6ql7JD7icBZhvD9FpGZ+xyvZZbSV+5KRywlSQM30tH/swL0/GiwbAIC+Vw53CXlhZWHO+qeJ1CiY7AwRKcd0ZqgqDIeAg6Kwb/Tn8sXQFvnhlT4+4mWcc1B2PWEF8R9yMhe6psKv2BCrQjXh4jt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcCo87Yq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcCo87Yq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1388902066b.1
        for <initramfs@vger.kernel.org>; Wed, 22 Oct 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151312; x=1761756112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=TcCo87Yq/iqTvWnBnXr1s/sb405+ysTLf/84TAuBDnKBBDUXPhVcnrRzwWKSmvJPHM
         sHvLDJy4H+au5p0MkDVRxE9dBRvvR5TXtEajr8oGykSgG9bDfoNc0SlJdAn0+tOvZfUF
         nDkYKnfeNYvxMDaPVIu7RTFhe+JFog3XitWtISUFtnLJq8yv/Ie79MJmif4ot1haGFCd
         eahrAgwlG3DgFuB8g1YM9qlrtpgocKryspGEc8RduAwwVtt+k5wKIBMXCj03ujxrfucx
         vvNSnbdMyBfFKGJkyK/ZXqMenwgzukXmQnWfk2h2YtnVuv+LJSuNRCoU/aN8C5Nys+E1
         YxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151312; x=1761756112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=BvtyTq7a9qFyRyS7I6u1BGvjk5SATVMMSRE7m/DbF5wgp7rQJM1M4HcTZVDgG4jSSW
         9a8gZ62HP1Wfayrw7ix8eD7sdy1aMIsYQLtRRlizWQFVIUp1k2c7I+3VPIapAVBL2+E6
         S/UxfF1t2Fi1DlkUlsZcYtOqpyjHtWZ9tO6q2eZ2DpBfF4xOC0K/uYaq68HXL6INQAgw
         rBGEuI1ZC29NhWM7j0grkmgNkkZUDLjL9OIxUSfZOFpZxNbJY65upuurXTQ9u8eBZg/u
         NtN5imGLw2jf6/dCx4CDdF9XJJkeJwsOhGhgHf3MDDE3JxZl9SGD6lVOR6vai4nd0nNy
         osow==
X-Forwarded-Encrypted: i=1; AJvYcCUW4jBxy2TPM7HoDNx4jfq2u+drc/ZGrtOSNkSQqSJJEan+psLOFNiGaM49wftccx5kEWh1yoBSKo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIy4RuDONX0WMjFwWw+d1ZtSme1+K9wrIQW3yi4lGQ8aUq1s1D
	D+TYWa6B+Vm9LjfentEAPUBgjpujGix23mPP1tVqy1diRhRdiJ08ivIe3/QsgyHnmrrY1KfXBZz
	2DI+QVaYjkfNv8w/2gXZiEQQf+Ji/k4Y=
X-Gm-Gg: ASbGncvN6s13euXU8U67g0sKqvNavBtydu/tYZRGkx+HsmKAyMTwPfDITdeKHCPKP18
	ccaQDIAZiYthyJwAkG8EN/wvp7BEMslNbmW9gPDrJwpFrRtJkteLe8IBv25qDPm6YEJnjYzsqu6
	mPlbXuyvGBfjrjWzbEjkURpXKvCq5ahbUeeeSWEZeABsr7kTTh94BAkwttVVbr8OWHLcfWiVQzU
	UG2PC3uY5j6KuSHtUd490DRNW69egiwFmYscHDmMzjDEM//6hf6n4yKBM6NNLhRB+Sp4D1C
X-Google-Smtp-Source: AGHT+IHkWGnG06JOtYFwx6WKEecUCCr1fs/y3xfoAi4lziINz4JBVkxPbzc5Y9qrcmqbPId7dzqQXzuYY7OGWY5xDrg=
X-Received: by 2002:a17:907:c11:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b647500ee9amr2300275766b.45.1761151311555; Wed, 22 Oct 2025
 09:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPg-YF2pcyI-HusN@archie.me> <20251022080626.24446-1-safinaskar@gmail.com>
In-Reply-To: <20251022080626.24446-1-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 19:41:15 +0300
X-Gm-Features: AS18NWAouNqJg7toJrl3zFJYl4AxgHZN6-E0xEGlNVrmOGgNKVxnzpVBWI-jPi8
Message-ID: <CAHp75Vfb5J9P1vhSWkGy_j+ter_774ThBJHZuSp=r583xGP8Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: bagasdotme@gmail.com, akpm@linux-foundation.org, arnd@arndb.de, 
	axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	christophe.leroy@csgroup.eu, cyphar@cyphar.com, ddiss@suse.de, 
	dyoung@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	jrtc27@jrtc27.com, julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	krzk@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, monstr@monstr.eu, mzxreary@0pointer.de, 
	nschichan@freebox.fr, patches@lists.linux.dev, rob@landley.net, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
> Bagas Sanjaya <bagasdotme@gmail.com>:

...

> > Do you mean that initrd support will be removed in LTS kernel release o=
f 2026?
>
> I meant September 2026. But okay, if there is v4, then I will change this=
 to
> "after LTS release in the end of 2026".

No need to mention "ater LTS release", we all know that this is the
last release that made the year in question.

--=20
With Best Regards,
Andy Shevchenko
