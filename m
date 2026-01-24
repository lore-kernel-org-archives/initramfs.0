Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926A22173D
	for <initramfs@vger.kernel.org>; Sat, 24 Jan 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769249672; cv=pass; b=LYN9oqgo8ihrnFuvuHyOC7Og1uO3qkVkT3FPrNC3C5yfcbZra6I5cvLUAnFo9cSIadbM44mc0Nc/PywUM0kEQReNOA6QleGuFf4muwEYjSxUIrNZIe3aMMfAefPABzHzMYCmj9RMzeQeMB6MLPpTv5nCod+nZiG9xHogcGaagVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769249672; c=relaxed/simple;
	bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHhlgKwdG76c4awXmWwUeW75SpUP/m04SsS6WLvqeX4lbccDjg7CtZHvtbhOz1vLc5NF69XOd8cYIII1BF3FZ4dtr5eC5rEmx/OZWE1fP/Fn7qnUut23+/5tZekh0FIXleGUCPsjEw4BH5LDux/eUs8W3FjYtiwjI9ttbMwulEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYKPH+/w; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYKPH+/w"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso2398182d50.3
        for <initramfs@vger.kernel.org>; Sat, 24 Jan 2026 02:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769249670; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd2fDuYHIGuwQ45L2KySJUKzE+u0x6QgZbq84aj6hLwom190fZGsSr4708291LsmlV
         GoQOj+tw4n6UsRELixsw309T8SsJWU8bFPqXxX4d7U/a614WTuJq665CiEfqAyh8OmkB
         P1cHLpym+UrUyrISXlaNcyGpfNuCv6jgu9YHxBqp50Sd944HWauLan+KvpH4GYYL3ocd
         2fUFiJO+cdZYA/kqcFQNlTkGw6PSlVxmmNctP3UoKCnYW2N6ja6SqSHjbc15y6YrW2tR
         htM9Q5ZtiJeWCaQ1Kg9welwxDmUPJ9VXcwn5aiXnP6WivCZFTNb4hv1+UGi8wWFzopwL
         TQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        fh=0+H9bY7lGnsuv5wakIylrsjNxpCZLsemB74lXKeMEWQ=;
        b=IXmjMJUT2s3jRObAFrQ6n3UcQ/Yc8K3cudRDDHAWghCX+fINqnSVfrA1TesGwaFSrQ
         SQvxZvQLvEpEhLiyI9XvgD5m06nXsLPs7fvrHaTmcm5mlnH/RieP0zJpBeGY0L+yQAC8
         ES972+D3ooPh3tyxyZFxxMg2vUm2cy1zfuUKJff2ygcPlnZUB8zrqUYdrpQrtkyKAmK3
         h4QyC/q9UEYPpmzzgfZCSDTFxpVIw3mXbwSFp4uxWTCOBR4zqL1wNqC2ZHFZwrN//kN/
         zKAHFogl2XwUMI5t2EDkJMfyWa3B/bB6l1Hy+sAJVNEDk6fYL0cbGCLufQdA3OZ3X/8T
         WVZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769249670; x=1769854470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=EYKPH+/wt5Eddu1G8cutJCykY64wRsqS81cGNPuweZHYzmMt3HGx5LAEVmTLb/FYeM
         dYrJFBz2dnknohxDH2VbhCx4XTlD5Arfp8NeUV8TiDn5lNE0MB8qslWf0JVJ3jRzCdBZ
         MPU9YE1SUPcVvr/LyhzsfVJFVdYTX/aSWP+HHIE4pLRpn1YmBLaVoF2RTwXvURZyqBGk
         efG2VKqIRU/wLhEqRDjMVIai61v9RuDYTqC7REDNPzCQeeJFjfBWh5QuWn417dtyu1ct
         vC77iCxMpwZcgxhBIKy5uBHQko/VZ//urF+UA9hb1csVkBI2REguxoZ9/M1WP0hwnViB
         3aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769249670; x=1769854470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=pCilaRTNn1gXEUfYGbwsws3lSAd5flSHZXQQpDgryk7w0K3WIhxAnNZdD9S1ZxCVCg
         AvmU852riwddRlnCqb/yRH/OhHAPjS1iPtfXGKtNPwSU9xNHPZi74TXyiLrWm5Lt+LFN
         QxnZGDPsNZIPVMOTZ3vpRTCNeg7L2AzbzAB/Ixloz3FI31/C4XgbnTfyVYozyr6RYT0F
         lSYWmwv75K/ugJ8tR51JtoXmEfEDsao2lHu8jdRtoUBq4S5DA8zzPZcl4EbfKG8DrN6K
         E54xI0wobm9NYyZcWfPvjlGBdT4mF6FzWcWU9o7YA4vwV544WMu8dEHYDuwZVDlkE3Cn
         VZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyeegQptA8VbYnb5cDpll9O8DDpC5vpoK0wcQhc+2ffhR0Rojl1vMJG8EEuHco9HPoN8Ixto8rGuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9qVp+URN16sshaijybxL3+TQxuYeoHz3DxX5TLRMx/XsIac2
	3UMy92Eg34GMIZXckHg7NZq/wH0KnIBNSwLeP/um0HlDHTyenDvEYo0mNfOmBR6dKvjFx6CS/+t
	4G7deYnUVFkpl/DBm1nMh5BDSrhpIMLY=
X-Gm-Gg: AZuq6aKUOc8ZSSMwb6SzrdmINm8ldbehXtwgCrv3YCvNnwGxguMLqIklvohzvCG9la4
	1+ZqnM0SYUmCbao7Rt11gjhvThy66MaKpetM60iSFNYguNy8XJ04l+HcvOKwaiU42TLYar0ZTyy
	41BpZDQLQq4v8MaRPvKIpWq8VW0huj9W968p66wZSKECJTUHRLK8q7TemB8JtY9fOTDGb+tQM2g
	JErY2mhZWU36LlTTl5szoCEUfIRD0ysovmCtCfeJ3h+0U0+IrlwU3miG7InThBZhfcikX4=
X-Received: by 2002:a53:ac82:0:b0:649:3970:fa88 with SMTP id
 956f58d0204a3-6495bece06cmr4745338d50.37.1769249670198; Sat, 24 Jan 2026
 02:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com> <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
 <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com> <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
In-Reply-To: <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 24 Jan 2026 13:13:53 +0300
X-Gm-Features: AZwV_QgI2djWv53heJq45UjjcmWS5t43scQ8_DAQPG3PfhZnXr_aF6xvpALbmMM
Message-ID: <CAPnZJGA7jbQAAV09Lr+NKNwRvKmegZFC=LzOZybWG7skF4rpQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jeff Layton <jlayton@kernel.org>, amir73il@gmail.com, 
	cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 1:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> The current patchset makes nullfs unconditional. As each mount

Oops, I missed that "fs: use nullfs unconditionally as the real
rootfs" is present in vfs.all.

--=20
Askar Safin
