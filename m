Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46695377560
	for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880375; cv=pass; b=ULCWBK9ScEyKG+cpgJ5iysxFINr6rl7UEscWXM7FjryCqjynGTe243qnxxb1f5YNScw/Rf8NFeJEaw1rDyituXtWnUJgWe5E1BQCPiG7syR8pmAzxTHt/2k3RRAigDKFXFWnKfUXlPcAsDdADcCyv6ghsayJWYSqpRuyDBdRyOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880375; c=relaxed/simple;
	bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4hhF/3RfhdNWQyAN9EzFyIDyf5UgSCy4/VyMHxIwFmIvH2Y2xRoz3jaiDGDCKAnUDLWzvE1ZDPA8HRGedSF7Rlv+CaewQes216KNu3RmdXn5mkUGz6sWyjTn6zTXrTMGrBeINppsJ8aYbpUt7cz2AVEDdLjISnoy8P+VIg2HH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV+1GIg6; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+1GIg6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649df393c04so4141076d50.1
        for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 12:59:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771880373; cv=none;
        d=google.com; s=arc-20240605;
        b=UmF3F4ZJH9zyl0A3Y5QFBb7qCVp1wnO8VQXlKgzefkoProKCB99vRQLIz2QMIR/Pss
         n9svVLLV04jquCBKecOG5hLJGtYEtL9titLPXerRWSIFRLMTahtm1CxBrKnbP6SVC5vf
         Xk5asE9ohYZ8rNKCSmvx3IYK33zzfFV/lZTHhmXw7V0BzkhJOc30jexwk6Hv+6uT2MTU
         JRu6FEoEnNB6Dqij0XPQdcKr4BHh1bzuNguyskgzqjKoYBOPEIA8dZ2ygoY64wtJ43tv
         bJoQ/0WKJCtt00LOA9VuUpB5dJY24DycFgVUQlJqvQQE+zPdTe6cx1wuotNKYZPdChif
         8LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        fh=fwD++k0aKLS/heC5tcca+12k7fzt/Wp81/rAJZsriKU=;
        b=O/Mj/JRBD18qCABmI+Eh/xPKO7QWUgxAA3bWKehwCDmnUiUXmlIujpO45Ya86lf6ib
         Nz522NGkkNFtpLpGTPvZb1op66ASwQ5k8jUyoyGqkS4hvvuSVcMIjXhj6T03V+01PT2v
         26S8b5S1asvkqhZSvEh7q0LNUGLXpIwyY2ha+yc1iWO2JNcZAFoj2INwe4Mf2m9sBUQu
         Zmepl0FSr1PtHOjYactb7LpqpDSrIJc9AJCxnNYLKwkAY57dyE6lEoicPNVol9kp9Lhx
         33TNLyOodARhZm6Yija1GEDgockQm552CBqZxbZEfnAm4oviJUGrj40U6u7/tJAMqRgL
         fhRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771880373; x=1772485173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        b=eV+1GIg6+1Ij6dfRAkcvpGR/q8GlRjkqQCIlV+t1NLWRdwYCLtLMNWZecHBdU91rFh
         w/iD6Gfhxx7S3i8FVR6Z2rWoctuQVejqEYLaSbEdMcWr4Hy8N78bLgttQlrTwneVi+EL
         dwHq1GNVqnsk+cOcbRlbpbY3Rm5LouK9CxnIkF4f/1F+orR93pNmz7wh9uDscIxyNIHV
         yAc+34cNpXTa7UlpTfxBGHiuAXn34ZbbV+NS1WuwXItiSzeDY8gSg5wU7db0gTGrIXYD
         U11fCL+vdnRqQHTZXkz2jsI+TwoWcvzg3ZHapdMrMxjL0xwbJ61gDPS5FArIUhAzQQeJ
         G3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771880373; x=1772485173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGWxl/dhdATLUFkTP4bDg4Eh/JPLgT7DDIEuEfXiY7U=;
        b=qEL1WL75kxxHNs4/f8Pc1ZLI8MZRFRUSo8e1ytfKz5NI/zoI+5BAMgJwIJruqwYT69
         bctmMTkMtH5ljruDAcQwqLlWj5EzxCuqu/zTJxmDByv6r/x0GHqLexwpvOdVuqcSIijN
         jri6aUx1MwTw947Nm8EcDtyYxM/66XTtKu0QkFX8cCX9CUIQUJ6fprGlB58IIIWptDWO
         acZWo27PiidEaoRee6WjXtcSqI/0xbIfi4n840Ekpe5YaRP7pmJFOl7yOr/VKo4yw2jn
         gg+ZbdSMnEQDXhwcGI+3tfGWneTM/np7RLWCrGWQe1xeF4nyrmNiKW0uggkvKQG1Z2F3
         8o5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5Xe1aMsdKaKuAtkrcYOdWUDUgCE7sG9X6BaaFmyaVgLt4FZlziaKFWiCf9RZ2poHLnXyiBNXSYrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYLfNp5W5dbCb4EaPjJIHhOWNGH3EOu34UfAv5WMbjvjfOZd+
	/ypO8/d/Xzx7bO5b8ndwl6bZtd3pzB0DTd53m4C6CvqReN51ZVy/vWPGnnSV1+W4jv15m5r3bBW
	FGvb+O32mb+fyfZknD3ZnA623iKlh49o=
X-Gm-Gg: ATEYQzwOylWQvRpfFLvjeam1gKwoN0+FJX0GWHVqcdguo8KYEoqIw/yM726woGWkyOU
	iA/wtllJUHOB7gjPXV3/OhDpLrb9R8cDD4l6oFeMHTr7yYf3nh9vAJZ1uBVpHQWF4OWejfx7ggN
	FGoWmil0cuHqXH+ZLinWXlrrFbrB12snWjIv0CEbgcJrq9GD8w251T04AsCRA4ij2oDLShrOVir
	0kZ4k7plnqNftlAcLbLJ7YqUmEE5hY5W28mOU680K8tJ6pYi2GGsGWRrvjxQkpEsUVM6wf7VFlv
	pbk0gNI=
X-Received: by 2002:a05:690e:d47:b0:64a:e799:1d84 with SMTP id
 956f58d0204a3-64c78e3ed37mr10186762d50.49.1771880373230; Mon, 23 Feb 2026
 12:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com> <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
In-Reply-To: <a7cb199d-928d-4158-8f16-db7ae5309082@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 23 Feb 2026 23:58:57 +0300
X-Gm-Features: AaiRm52qRcNRr0w0juOjbrF6MNkTC6Cm6dik1IbLPWbMt5sbBgSggwUmnjLgJPQ
Message-ID: <CAPnZJGAw9o8BetWs_wO2B6YD7mYuOopP0CwD=KCfOJXw2QU4Gg@mail.gmail.com>
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Rob Landley <rob@landley.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:17=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
> FYI I've been using (and occasionally posting) variants of
> https://landley.net/bin/mkroot/0.8.13/linux-patches/0003-Wire-up-CONFIG_D=
EVTMPFS_MOUNT-to-initramfs.patch
> since 2017.

drivers/base/Kconfig says on CONFIG_DEVTMPFS_MOUNT:
> This option does not affect initramfs based booting

So CONFIG_DEVTMPFS_MOUNT works as documented.

(But I am not against your CONFIG_DEVTMPFS_MOUNT approach
if it helps you fix your problem.)

--
Askar Safin
