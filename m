Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FC1E7C38
	for <initramfs@vger.kernel.org>; Fri, 10 Oct 2025 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069383; cv=none; b=ZC6dQ1c80J4jZI6XGFt0n2rqg9Ieq1mEe2LpQAcFQd0BuNK/9xFzkEZpzyRQlVcEr+p4WsMf3LgPdX7YnIGCFfblr5BZYfizCh62xaqRhmwRS7R/ZzCITTtFhvuzIcToqtVltOodjdK9SzZmuV2gSlyIHIkRfhwJCFfLCjM9Tts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069383; c=relaxed/simple;
	bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAzb1aUX5x1pklch6k0egCX9K+higcPLyBu9M3v6ERGUAfM6ui/NBLi1o034Yxu8OMDTyyeKUG4tk5J0nYavs+rM0v2lXxbAIKByWAUcugqJ/sL1EyAuW9qSMNG8zWLa2bEkN4k8Jc/6hAMlUuq1Sl2boRnHTlotbmXyEPtMH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDuL5tqL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDuL5tqL"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-72e565bf2f0so17392137b3.3
        for <initramfs@vger.kernel.org>; Thu, 09 Oct 2025 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760069379; x=1760674179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=nDuL5tqLs6F/bqWcdATCSw3q6sR4xH9PojO9qOD+5CVFhCKnIdXYLqb6N9qP3a90AK
         XcWKwh2rGBNpBKIw4DXxov8U2qs0Dzy6gXk8vFfvDusYiZmPGdnri/OyTQj/4/Q9hjBA
         AP9cRpfxElOVTqf47iRfDxq23HPr72skNOU/r2V/uYwO0u5rdlLaDJlfE0FHTHhwxXRY
         CxV+l2MjGbd2BdsN32iKqGDmRkhB4tNQBtMagkevAiwpNidXH4OagDZ/3oHz+Ju9tDVq
         V/7yZAk0s3YGeHhlLGi653f8C0CT7tXpjc3Ab8zbhGaCEogKGwXedDHs/+NW7Be9ThrK
         SjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069379; x=1760674179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=Nr7FB9lDHfm9bZzo5azbfcHbLC5GD78gFFmhZkUjogDqwEjH3I33r49AG4FIC3Hb7G
         OAJyVOcTSdmn4rXJEj3OU38XUQDmP3tdO6Pq79lMJhKR2tUDhGYqccTJLCoxcalXAoqt
         8DXhnAMPzs+/BqCC8dppTxTYXuSmXpUg5FEGtDQE1uog2wkHVa/aYFAiTNJ8Wt3eM7rQ
         YgqZXEzu2qiDROzPUg0VsWYkiyW2JonabgeJkBuTHHbsM0x3yBJR2wXjfPqMWMbM1q0Y
         je+1GHMJchOhKNNbVUJfiUBw23QdygyNDtwva/Lh5hL50hgOS/IRy3WeBW+ApZ/KSokn
         6Asw==
X-Forwarded-Encrypted: i=1; AJvYcCVOo2JIDiskqUEOUEorm8LwdNYjXvc7mjOyQnitnBevjaOvVOKfSuWWBVzLVqGmuJFcrsBpLtllZgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsuMvt9uo3wKOtid02l/0Hexqn8FGd0tyMjJY/vNqXcoBGxpP
	tgQWvHl4YhrHzt4JlDtdr9fTfu5b7PW2nbxb+GFpZnLbLWVr3O4xCAemE4DLXQJA87vlwUoH3k0
	VFCow26wIfgKinlPU9AYDn12s5Vdmy40=
X-Gm-Gg: ASbGncsrnFUSYLcrI0BGLYrQOD6ihlF+kbvNevvIRTacmExLGHOQfBsHOzpxcCmLQb8
	6VtKcpI/nOp0s3xu+29Xo/hWimqoFBz2VgWrjMGGf+vl2ss/INe7cKQgFQ3RxK+1qgvJ7G4iK2K
	GDnZD4Qlo+jZmdLPmB7QFwzwP1uHIst+TfrK7ZbLnikD5Cgg2oaQ+CNr0Gn2HpKWnIwpxbNZu8p
	4Yd1iIiWLf6Ms57fEwmZgi55C5Kp44aHm5H
X-Google-Smtp-Source: AGHT+IEKzDZJ3mg1FFWOqowFJqWLj/+dmJPdM199pmmtVcavFH/YLuoH0hEdsvn7dHSOiTNw/3Aomiv0DcOjJivXzrY=
X-Received: by 2002:a53:e946:0:b0:636:17d6:a30 with SMTP id
 956f58d0204a3-63ccb82410bmr7618496d50.15.1760069378763; Thu, 09 Oct 2025
 21:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
In-Reply-To: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:09:02 +0300
X-Gm-Features: AS18NWDxe32nrD4BfQQFhIe3tEEfxrwgJsYQo_BWhSUPsy5CceSv7QOcZ20roI0
Message-ID: <CAPnZJGAKmgySY_RK0kmGTgwUh9hw4FSrVR+LoJCbD_RmJZe6RA@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
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

On Tue, Sep 16, 2025 at 8:08=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
> I strongly suggest picking different names given __builtin_foo is the
> naming scheme used for GNU C builtins/intrinsics. I leave you and
> others to bikeshed that one.

Thank you! I will fix this.

--=20
Askar Safin
