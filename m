Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFB306B0C
	for <initramfs@vger.kernel.org>; Thu, 18 Sep 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225501; cv=none; b=TECjGKViz7LzuuWq4AU1Gy9PhUoV1M71KFHGyZX4CLGIzo6C43xMvGIXAxZrrH2vbyHVKkPwCAGs6d0wsJm406Y9qZZURx2OyxPAhXA2eGrxHAKPMbldAFCJu4UvCs2a47+sAdXqrIk6tz4t+7X8L+G1KE3vMPFq5vrN0z7Kzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225501; c=relaxed/simple;
	bh=hrTKVKMuOKbLilzSA+VEl+XSSF0VIocT2KvCzkuRjcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOuqnDzSzpuJaC2/tq+y/FVG5rKb8WjzIN7s8k88xlpScA+wM1je5TtdYOY4AuOLC3ckdBwc2YsTrIZzjCCzDtgBCrLnz9bA4sWYvwoCUfPxAVZx+VBynuY8+SXJO83FCAmd7tB8gxpxztlxZvROovMR53HusW/fkMh9wId1MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNlT1dRM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNlT1dRM"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b211ccfda1dso182202366b.3
        for <initramfs@vger.kernel.org>; Thu, 18 Sep 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225496; x=1758830296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=hNlT1dRMFhV3nNEO8OCPXfEiZjy7HadMXu4vRgp3Ipj8QW/pTjkxFRxYZEa69pe80J
         R5WZR6uBlmeIbF+VQhBUi3wnRJuDxh3ZSYPm2HtEzHdmYgYFzaLOTkBNZpxqwUsXFCi5
         xh48TC/I8mOWxP2I4D6qthvi1wAkVJadHw9+Q6aETqCdcS+tzshGNcO1qODnTVXpUxR3
         DzGuLf7FRf7YNLECrqzb9ayMBLdTqRvBk0ivmzKueGmRkmu1GRq1Uqn5Uc0kg8EqXgPJ
         5wCj9Urjk2M3jfgX+oYXsBuDx3I+zNM2GW5fMn6rB/kk6qlx/ZV55XBxceRxo80pIEfP
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225496; x=1758830296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=b0QxhnukzCzJnHuTMk45fj/BI/8NuJ8i+oBLj/MHDzRZv7wfZNdZ+8Gel28JFdCzfh
         5n5cgt2ssONlZmP3D3dL5eVVu0j1Pl6moBjtMKbCT0HU14XrfB6mL+Gm85VG4Y1I+zHv
         ptJs6yVzjKxlZB/MPhqp4ELG6Eaj6CCKQNqq7H88nRmO9/m9BdZqUWmU7aVLWKA8djdT
         ek0Fl+2PyLHK8fwOJd1uoZaFlEEYUklkCRPWorXwpYzt6iD0NtxRdhQZNCAI2v3j38R8
         eq9P7QZLLozY/Q40xg07usmYtEwUg3WTfSjHvImtScKBiI3MtuD1LVrq7Af247PjRbNx
         rQDw==
X-Forwarded-Encrypted: i=1; AJvYcCWB6Ic4+DWkkH3sTZtygDVcxclqBY4SNRKrP/krH6CXFYEEbeLUX6+6v5vfeVmeLalHNtOc7ylUdJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKsiZ06pZMvL237qsOg73GJqWtJb1L4zAz9ibPPufXZDj2uE0
	MCF+A08Y0+QYTNZB4vfqgTtTTBVAKkLGXojDSM6miZNu8uVKP/5YJTDn
X-Gm-Gg: ASbGncuTaLWog4mFC4CccddXDoTK+kvZdIUSZd4DinJvLGeDr9X/DB0d131R91kZ8Un
	1hlq+lzAl5FuxSL9F95LreF6n+hp2rioioiQPoIFEeTfvAEaVtTJc4rqWZ0JiLpVitVM8IZO879
	81kbeHWwCnF5moqRVayL47Ozbfq4ltxnojSyaIeb/IvoaDHTvnD5pq2uW6OHzvBuNZfi0zgGwl5
	lrqIj2BQHitvmiaen3ofqq8769VSNhK95P3WovmVQ7fF07teTjOTnpUi7MFOUFAGUVkHsZYHW/M
	Ep9bFoYk4Zyta8XppvH/2uJp2/9eTM+/KKGTPRQeuwkkSoc55dcR+LO/z+NfH+Rc/iw0zk+zcBZ
	PtTQHjlj0CrKx1wIFOYpOz0sYWC+28sM9pGiv4Q==
X-Google-Smtp-Source: AGHT+IH2NBu6L+bASXNqg9sJUcZ42MFCB2aqzEFiqoDEW6um54A4CtHcJnO37auTgFbi6nwycKDm8A==
X-Received: by 2002:a17:907:a089:b0:b19:969a:86 with SMTP id a640c23a62f3a-b24f35aa177mr45885966b.37.1758225496090;
        Thu, 18 Sep 2025 12:58:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd1101c44sm264530466b.82.2025.09.18.12.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:58:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 22:58:06 +0300
Message-ID: <20250918195806.6337-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918152830.438554-1-nschichan@freebox.fr>
References: <20250918152830.438554-1-nschichan@freebox.fr>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When booting with root=/dev/ram0 in the kernel commandline,
> handle_initrd() where the deprecation message resides is never called,
> which is rather unfortunate (init/do_mounts_initrd.c):

Yes, this is unfortunate.

I personally still think that initrd should be removed.

I suggest using workaround I described in cover letter.

Also, for unknown reasons I didn't get your letter in my inbox.
(Not even in spam folder.) I ocasionally found it on lore.kernel.org .

-- 
Askar Safin
