Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70346378802
	for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881566; cv=pass; b=jIinO0bMck/8Xd6zBKOmLFtnJzuk96shiC1AwEjC/p1iKKa/YTWEpZv0Ccpaj7mXT23NpZVdvpyT+mOGwe/Rq3ZrygwSk3qMa9nYBQEmCvJwGZFpu79HooHNhj3o6gxOBshG4vD7uGZOVj1H+rRp82xLvDP43BnVkQRPMslylfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881566; c=relaxed/simple;
	bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f116bjfutsJTMCQTTo50+LcnPO1kSIpjiF9fDgH2kLbypqBVJwnqJxzgGuczP0LH7AQS8sh24LCL7vJK2CNWoD9WstbwbMlTcS/Q7+d47ASyeyjGD+ICPw2HyVtIWE6BUg5MnwvZ+4U3n2t7IKtOkRfL+mM/UN5l1t6X8bqf2tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feZ35/6C; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feZ35/6C"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7964fb9ae3dso42048427b3.0
        for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 13:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771881564; cv=none;
        d=google.com; s=arc-20240605;
        b=Oxm9YFAfSRXxQZ/kPybc13Pf9nTdsFEuIJZ7sHp9fRe2O7VqQZ/K1xD0D9F3KA39AH
         SbLd1tDSfbsS1pYv9FrgLw+9erKA1l2NCXR6jnbK4zYbHcU+Z+TNu/FM+Oyv4DIn9dzY
         o3EIzcYALyaXLZNs3tsa8iv5TqkwXU44iN0ZpknI6LqhUt38El6JtL6aXWPA2YS8vDr4
         e7Hunxd2cpKRCYbxAC+Vk9A0VjPog4XEh39+p0ciFR9FbAWEcAGlc6rRWVBRmZOaKnOq
         7t59xxNxGdAHglPdXQ++1bMAkrKrCpzHVjOlzEae+25M5VuBeVGRl2FWX2/nyQpmvBpp
         fNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        fh=lKmuJ9HFhnYigC2+LhBQ6hmKuhhcVrOzxSHBXRp53NY=;
        b=CToSetxdxuaJ+Qy4Ww8Y4RTs2sRnAV4ohtU7I4KjACoHOrnH0DDkS/sXCC2VMdA47G
         d5KxbWpDwtdiyXxAHk6pYMn1ZGcWOhXhcenBmrzpPP4nCyKV+mxe4z+TE5MBVdJIYZAt
         Xv8EdfWuFNtTMisMIGUXBwizE+lUhXbRDsSQDUgRk4vi+3prYzZ97dUkV8kNxSRmeBKQ
         9Z5Vp4/CqSZvpN/r0AxhRNqVIUWV9emzOfHLa34nVA9JtWPqXZxzib1AWKQfQsoxw06W
         GSq/cZG9dXszDCKEZsDbj55YhSeDYEK68EVxsohsmP35cDmgbdyHk0AzQJSRt9PWBT+N
         GozQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771881564; x=1772486364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        b=feZ35/6CpLG18uFRD53yp54tfgbDQPSVpZKLlLIKJQL/7/Qb5cLP70jz8fUNFaGZeO
         XWlKM+VTx1EH8i5Klk0lEDjCr0xS4+o7patwo4c9uWXEk7HK6Yd+doLhe9DkMah8DhNY
         7616VXQL5mSRF1ss/milvO1prJ9dRSqPXAU1zbQvf9Z0gzJpcEx3uY89jN2hCX4IV64P
         UiYutixwkuYyCHCYO4EHuKuVSu7VGTmWqVMU2PbyFST1UzBU7as/KSye2MxwuMCVnCoY
         /iYzL41TlC1wlMsGr1lDemrC05094hsKbShHNnpUe376F5uPwjNFG5y5ThslNDTXQC2b
         Hoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881564; x=1772486364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        b=H0VsHs2qOmKQUQMUrcloC/1tgA2qeUKgCBNhMI9HUkG6iP4od5fxnY8AjGgTbAQDvS
         TDhqSe82D7WfxAtKrksTXFQ9TTEODiHZKFbjZihYUg/A7gn/38DHSIJMqPa+DIzOQGAo
         tq8qDXmvRtG+iewpPoNAcdHoiYgRlgGIsHaRb3INS3/I+L+hWNJ9gulOKxkQJBq531Or
         M58oBo0X5RmZvMlWbkau+P4yeY5MesTsqzDH91fNxftBhERVRZPF9NYEgVMimTnBflIO
         2jHmThnQij1VmrBQy+JFJxy+HerzsPfJ1D8mqdawcwmUHp4qs0pq5LrOOjKzrQEzoaYb
         kPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjCO5ctj0XPHnKcTg0RjOXok/kohO9bxVfELwOjeQ852DtXL/eK2RyvV1H6nIA71IM8ONlsbekZpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KlZDb6419nWYXQexJN3KD0NqzXiIbypI/NO3IwgW0gGy4ANh
	/GyVg321osnSH42+Qu2CCFp3VNU8/nTbLbOZrnuzaM/RSGAvEKIHnd8pLhxetxaMKVZZniDWrER
	giA7p1K7bD6rskiKopvEOvEkIcDb1Bek=
X-Gm-Gg: ATEYQzyTm3aHVmv4rB6g/hozbhG8vz+MjFqJnXjCDCIYRgnzsgvwTUp3tBREQ6WNNk+
	kFUho5UCgQjdRXrm/9QayvdFXm98ied6PaaS5hizhwQYyFemg4sDkN5Y+w1A5Ciyi1j5lfWUyLl
	4EPLwZx5w5HDJLlbWjTRGDjO5TpDJoyVUXGL4yukgd8CrgvMjRULwzhCa7gFf7Ir01kYh5xH9D3
	+1TeZ23hefwPwYlLfGX7GWhwwUESeu7Lr1EjuhLBkFiUeZwtBuz+CcRoS/7YFyEQCbUIivZu9LA
	v+cwSGE=
X-Received: by 2002:a05:690c:298:b0:798:3be8:b724 with SMTP id
 00721157ae682-7983be8c0bdmr55059167b3.65.1771881564464; Mon, 23 Feb 2026
 13:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-3-safinaskar@gmail.com> <e67898f6-4e33-428b-8498-b8b28f817bd9@landley.net>
In-Reply-To: <e67898f6-4e33-428b-8498-b8b28f817bd9@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 00:18:48 +0300
X-Gm-Features: AaiRm50sLaC9UJuN7QdRgNE3QNOZiS7DWDKIfXjMKeU4af4U1Sw57WjY7CysLU8
Message-ID: <CAPnZJGDDFrOObdxa70nSS0bqXQ0zqRPnKWLRFUBCj-FtnkpPtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always
 available in initramfs
To: Rob Landley <rob@landley.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:15=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
> Are you saying it's reoccurred, or that you plan to run a 5 year old
> userspace with a current kernel?

I was not aware about this. Okay, I agree that /dev/null is not needed.

> (Although I can't say I've regression tested an init task statically
> linked against bionic launching itself in an empty chroot recently
> either.

I tested current Android NDK LTS. I found that if stdin/stdout/stderr
already opened, then bionic binary will not crash if /dev/null is absent.
It will not crash even if PID is not 1 (so chroot should work).
But I didn't test what happens if stdin/stdout/stderr are closed.
So, assuming you already somehow got /dev/console, then
/dev/null is not needed.

According to code, bionic binary should work even if stdin/stdout/stderr ar=
e
closed, assuming that PID is 1.

--
Askar Safin
