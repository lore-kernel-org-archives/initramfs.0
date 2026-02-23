Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C338378D8F
	for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882905; cv=pass; b=R170xiwUDnsiPDKkMh+Y9OO8HlZTjmAf8y2Olhf6yunSZV5bK5JSLpnhM4AAUGe5RSUvFxjSLSk3dPxXqVY9VVWT8y6NY2nPb8a53tQdEbOHhX5s4WUp2I6V9Xhe11NjTMGrkxSFs/R4BJfEbE9g74T9vYdYIF0Wp59/gkp1/Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882905; c=relaxed/simple;
	bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvMRExQ7KYze5/4Ou55IWKlWVBaqSvBfZ6zsedACaPLaIPoHzfZMtBrfwXPPpdaY2cJ62QINcgOjKiQK/JA22jxr059uTMnfj7XoEfyos7mD28x/918tYqKl0cX6oxmSO3NKN0/iUNXK/tVP3mhBq7BBOrBjdOJt7sQo3ikj2Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR/KjGM2; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR/KjGM2"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649b1ca87ddso4225161d50.3
        for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 13:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771882903; cv=none;
        d=google.com; s=arc-20240605;
        b=c90j2Lvw6bTKinJgFUSTcP2fBE+b05z0SFTD/Fi5+pd5FRHNpT3zgywvpQtHirMr5M
         +1JcUsyk8hmmwA0Sl1bFw4NEMHdjOhHWPrpW2HB49Wu2jud6E56xRa6yOXGZBuM7Ghx4
         pca/dBf+IbQPNAG//eSt6z1NVlYelZbihvtUFilph75tPYGKlu8X7remNUbK+in/J1Id
         cZ1RvN/eK4egESo6O9jEaH3MiECK/E3lVR8cB3jfCnasld3IGB9iCKX99kUg+rXLoWWM
         L6v7Nh5IteCbwr+XOYNZGSGHbzQctABBYRcidEoSkcRu15wT7BkKgUOJqZKmxT06jthz
         4zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        fh=ZKvreST1CNvP5HzsLfZ2sUGTRn05M25C9anxDRiGH2g=;
        b=Q8XcRGVORKkWq4luBadMsywlQH/fHQX80W1ayDlxFW3JD3VfDBdDfz1h4jdCa+3vsQ
         Di7YaiZnyu7/zAWGKP5YO7Dw0doaQnaJYcQlSTjiZawvmD/SbrJkIfquwmJfYIkVGPIo
         osW54YE12Uw3d7GzM31vOfJJDlHQr2+zd9JVG1/H7n5Jvsioua28fuaRvhiZMDAar86W
         uebLbcBy9QxGUkTOixIM1IiwTn3WVucVrke6gNjhhsiFpDmvcnhCs6idkAOWFx9L/k46
         ZjzpTFlhu4EQ0Nm+Q6FQyNS7XkwfOr88MFtBjm8GR7f8dXCz+dSfUPDfC50DRMq2Rv7B
         s8eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771882903; x=1772487703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        b=mR/KjGM2e1PoabVLs/GloteJgAksAVkDI8QYaZN3u/WSycdLe1qJsALkq8LIuz6X1a
         rRM/Xr4WKXvciPRlqCxUf99PgvoZ9LBE7Deik3xsE3MVoGz10lPjpyHrKodJL60XT5ss
         4z2i+JAP5z830gB/43N2hP8op3xluX8BUsilz9oKrA1qDE+5ooIIa639vIX9Af6KccUq
         kmfftViRVrRcZdDMTcSEfeYgGtWl3Q/4+7Ft8mfVPkJ5d97RKsHpGwoROshuap45Jm//
         dIeB5C+/It5H8vESVY10A5vvW6t2AMoWtVE3Yadcjyc8eciah27PTSgk6CZoXjzJ4Ynp
         bBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882903; x=1772487703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        b=bQ5xybPs1g2qjaOx5IZcokn7T/m8an9FBaDNmdE1q6wld4JpGO5FFdAXEqqhVU4f2G
         TzpCdkfXMtCymc89OzvUUBf8M+HF8Ix953YZhx8IsNwo0OehgpTdwWsPWaqFpS9eiM81
         MEYOjdPpN9VtAvnhfnu+vOTdhi+ERFCwNvm03zK1+2tEfrzBoXIHzeJmBu3LiEBiNw8l
         1UExDQO9L/lTtJhkiu7YDllqPciAvDiVPfOwELQ/e3YwyOAsyGWpJT3cITuasF9b8CVZ
         lcYEE8eGfaU0z5VuZrVCJ1Jz26rx6MiQc/3fI4gj66pHUOb1DOcA4V3boxZ3WZSpYKlW
         FTkA==
X-Forwarded-Encrypted: i=1; AJvYcCWNLihDwH1j/aBCAaY9NU503KtE9zlOfA84/UTxPD8Fgrk/yJdF0qQLAkKytjpkaVWk5Mpu5E9Lxu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypy3FnIPEThW1IugEdvtxKi7xjj8kpQ4NSTY0HcDQaD5hZXEyT
	w7kPvQgZsh8WGZWBdzJ3CGTvG7oK11B1EgluYwwdBymeNEqHwsCsY2cOYyNfNWVCGVPSBQmtfoY
	/VfnEVnUB+6joeb03vRzjKpLHUu9K6BE=
X-Gm-Gg: ATEYQzyKQn4AnLzK2ddRy5MKOyskQ87VUiur1qJO+sqGSm4Qn30pC25+7qwo0p3Sh8X
	qcdmf7f9BsGJIsAliIRmPRIn8YT11h2EiL1lWRlCBYeNJJ73mqd05KMaTCuZKcNA70nWo70RSk8
	M7WfFf5Vdk431EiEPYz+cSgY7E6OnXQGmwJQnhjvMyixbSIZp1V8z8MDEaoy2QJJDCrpUTE+vlU
	5W+gvbqMaFD8sFiKnn5biynDqoBqyuzzA+2YwJy8drOwRmBN91apIO5eeTPlxKEkcdDUVQv9Qwk
	vWEhBcQ=
X-Received: by 2002:a05:690e:134b:b0:64a:d67a:1fdc with SMTP id
 956f58d0204a3-64c785dc781mr9063433d50.13.1771882903527; Mon, 23 Feb 2026
 13:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220105913.4b62e124.ddiss@suse.de> <20260220191150.244006-1-safinaskar@gmail.com>
 <20260223121946.45b3c5b1.ddiss@suse.de>
In-Reply-To: <20260223121946.45b3c5b1.ddiss@suse.de>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 00:41:07 +0300
X-Gm-Features: AaiRm53G7mBkRTZxrmFx_UAZ2LIC8h6oVUqyUREBRtA1_T72X2Ms5uG-DS2L9PQ
Message-ID: <CAPnZJGC0kHEmAqHeTXwbcmuA0GqEOhDmCfjLRPRKff5DsEgW6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: David Disseldorp <ddiss@suse.de>
Cc: brauner@kernel.org, initramfs@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, 
	patches@lists.linux.dev, rdunlap@infradead.org, rob@landley.net, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:20=E2=80=AFAM David Disseldorp <ddiss@suse.de> wr=
ote:
> There are still other options:
> - use a different initramfs archiving tool

I'm trying to solve Rob's use case. He tries to write a tool for building
kernel and rootfs called "mkroot". The tool is written in pure shell
without any C. It should not have any external dependencies.
So it cannot depend on a custom cpio tool. The only cpio tools
allowed are gen_init_cpio and whatever cpio is present on the system.

> - point GNU cpio at an existing /dev/console

This will not work if we are inside some container, such as docker.
Container engines usually replace /dev/console with something else.

> or call mknod as root

mkroot should work as normal user

> I remain unconvinced

I still believe in my approach.

According to current kernel logic, /dev/console
magically works if you use external initramfs and doesn't work
if you use internal initramfs. I simply propose to make internal
initramfs work, too.

> To me it still feels like a workaround for GNU
> cpio's poor archive-contents-must-exist-locally interface.

I will repeat: mkroot should work not only with GNU cpio,
but with whatever cpio is present on the system.

So we should either fix *all* cpio implementations, or
fix the kernel. Obviously the second option is easier.

--=20
Askar Safin
