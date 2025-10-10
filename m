Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B512F6168
	for <initramfs@vger.kernel.org>; Fri, 10 Oct 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108562; cv=none; b=J2BUvSn+MLFkHQS0GZyU0Z06R94I7mE53xS6JNbVH8nnl4S1W+Xg6VR38o4hJ2tvgIZFp5++Svyw32/xBxqFh2IIfP5Kjjprx92KzAEuFUZXLBnKJ/KT73ELx7XJJcc2S4wff5KU98lIPzvD1aTGGwbPC0CWJFZ+LfjbLVZL2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108562; c=relaxed/simple;
	bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StXXeTwxPXTFKEoeU3MWiXWp3/HsoHG8QyfmccWMfyfWA7PoMhLwjffYWfjzUAyQVuugpWPLqBI7d4DW02sxSikTB0Bq1xgFdxfxkDFZ9IO/aNUPLOJUNgqoq/a2YG0zrEPNnhFrf/MfKVubb90tgKqk6tUXgK6yOX0P7r8COuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLDqTBw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLDqTBw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3d50882cc2so414409666b.2
        for <initramfs@vger.kernel.org>; Fri, 10 Oct 2025 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108558; x=1760713358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=aFLDqTBwDW9/tslHGMMpz/fDXm/8YFeWeEqOIcghoh/WbHIq4K/0SzxFSFr2C8rGcg
         FzfA6mauz29MwswTSj8YO3mq3cxhh5u7GFdf5ExSSfl6BXbILBg23XGuvlNp3mANuW6S
         eel9qNFJhrnpSPxNuvU8zfBQImKbaXpPm7yI2z/z99IQuraI1weEKXaWKAoKN2dn1Fia
         VeA9V8C1Loi2AzEhqtTtkmVxXU3/XSg2XO66Oqk58zTi4gP34AT/wGmHBqeZyuMiW54A
         2nUtDEww8Cwcun3qpGWQvCqHEXtidVmA+q8Oy3lJypcr/DIo7Im2rac59BUjorWx/gNF
         KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108558; x=1760713358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=wEex59YF9vsrWtTfyCN0FA3LLJffZV8xEiEnNRzU0/K9dbBOfTGfyL+/oV61ivveN7
         BpVXsOkROqP2PVD92ZVeaKJ3Nj5b2HkrrN5icUe56zXVR4GXkdhQdkS60F/8pGR+HaJj
         bETbXcyvlOPL6u16qcZZ+5ayuefOkZqBapo0LTPGNmgNAKJ6NDX0EfeZTmoqGJ6QIlBz
         QlXGLU5sDLlzCxxYsuoGlzinjYXDveFSUt1e1YBo5WjQOjU/qUm7pdKIZw7uUN8Pf8Yg
         Fr15gnmPP46WlBJhdm7Xv8npTG4PprKNW8JKJTa5cc/tF82SycG5+f3TXsXuabhvtGIl
         vdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ43rJoTnvcVTgZHOLN35o87kzwRX9Y93KyBqubK5QqdztL5ng2nMNpIcMV+xe37K76F+jAkh2mpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRA1NEfO/xwg/XmVjZ7+Vtk9Foj0+aoEGrUCXqfRG9ezR6u5w
	FsNiC1briWTCPfEcviffPhdt5eQietWIoa48cxaTc7+jQn/9wWG1Cn4lY/tVosq4b7nQetA38+J
	l4y4pLyqTYSL7U8f1OTgOVkIOD0JXI7I=
X-Gm-Gg: ASbGncun0oAvFHNeBp/TY6XnxqyBWWUtSKFmowayiBXNv4LmmoNdchU7ZNq2uuGbXxA
	csIk+EGWNazQRhY8SHlCzhGmF6CR7i/y07VW/YO3DFQabyBhiFs7kMy8jab/MlxmRmxvebF3JgM
	ZTLJ/mgU2KcBzLXokTJoyVmfmKGmHBDCnRFrq2DZ2kk20dV4qIXo0B9vLugN9QfqNfLxh2TtpHp
	T+YiOqrjwLOr6dZVeuEbkq03g==
X-Google-Smtp-Source: AGHT+IGa/polL6/8Ynsft44cUD0O1NPKwafCC8Smc6nmBnm4TDK7NhR64Y4hIQgBMI+z098vLRzD8f+sU8sdugojvoo=
X-Received: by 2002:a17:906:c104:b0:b04:9ad9:5b29 with SMTP id
 a640c23a62f3a-b50ac5d1e3bmr1407180966b.54.1760108556823; Fri, 10 Oct 2025
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-2-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-2-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:02:00 +0300
X-Gm-Features: AS18NWAoVP5WYC_07QqSXrvsFY0nBG5PiGs9ESaeN2ZfR7dfSMsKUbHhpVYPARc
Message-ID: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:42=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
> for multiple floppies")

With all the respect to the work and the series I have noted this:
1) often the last period is missing in the commit messages;
2) in this change it's unclear for how long (years) the feature was
deprecated, i.e. the other patch states that 2020 for something else.
I wonder if this one has the similar order of oldness.

--=20
With Best Regards,
Andy Shevchenko
