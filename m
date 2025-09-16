Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F62F5A15
	for <initramfs@vger.kernel.org>; Tue, 16 Sep 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042516; cv=none; b=oqEE3KCbJlVOkVWWpMgcvcHyJ5aeUC1xPk/BlzDY4Y4Agpwipj1hrwDKYncmasH9PWzfYvkxlj17/afA1lIW87Nvn0wimxuX16+m8/PvdeUaSWFYIC+TtO7/tY6VMHwNdtN5ayNgRe4zP51bMa6oZ0SP6ARopD3rBwvntXvrYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042516; c=relaxed/simple;
	bh=PgWcajlgRtwCN1aidp/F0FGsvN0V9p5zYN3VYaOBF0E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OK4xqeSIoO1wxEqUFADVM5pDWjR+PEnvg72jwWImTRCeQOus5KIILJBf/U07SD1bcxHfn/eEXMdmg2d8k6xjaJw3prDAAVk2rLbovQj8RxMvs3nL3Ob7+FC//ifku0IPAgpc0xgrnVsVl/X+MmCTXX+RpBIs1iYdFmlR1Z29n+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=D5eLwBoj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="D5eLwBoj"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1644914f8f.1
        for <initramfs@vger.kernel.org>; Tue, 16 Sep 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1758042511; x=1758647311; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=D5eLwBojfdlh7Q0cfd/t8ODFkczYAE4ccdja3rz4S2mZAneyp4d5nkKj2+q5ACqPOi
         /yjKRgjGDtlthxxMjKg+S4dh4NoTe7TQtaOGt7C2xJuzHcDvWXbiFQeZFEXRTYRGEndM
         SX9Sw6J/VXNagS+CitUGczdEzmFWRDpey8ygRCmBQMHIQu7GPnjJmsiuzxJ439/U8JmR
         298j/N4p67b/yaMJKJJ+VWXOpv1hUZ105IAdTcUXwsdDkApa+SUIZ/41vDVTSl2x9Wl3
         IQdtpGO7ZGksW/E0kcCSXvs8GiZJOFfXHXP3NBDLRPnYeH08tG9upiLt0dMHZhfnli7C
         h58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042511; x=1758647311;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=vHF/TeJ+SKiGh6ZmrOIh+a6H8OXyvY0m0CFk/2xRO69qNXm2Blsc8W20tX40btUID0
         yxz/a68fSr9laP9xcVtRMJQ3qQbCtNIPcb41IgdFBshcFlaobUhp0QOdzx62H4emDavl
         93D9sXtuOKfuwbsp1SrM4YVpMs4mKh1vbGc7FnGBdPvbfYX3GbfeA3CrlIwaKRFA8ewo
         17tr6+n3eDhWjAIpqOm4gSJBhyuJOB5D8bEsk+HajIlsCp6avwkD6slVycBlahVURD3x
         +eafou//pmYcind9WIFp/X07Zlb5dwkQc0mvb4GyIhdH/xWubc32HH3FbiEsK7Jf8Fo5
         1H1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQcjWlSZRXAiPSCbsiVTFpUinr6eKXac2PP3Ma0IAe/YRQHRN/8SXghV3FQhD7t+s/Gvrh1QoVMeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdSdWL1E/V0LrEZkGnEuaz4oSmwpeSLgDGAiotpAf9kgNt59D
	IShFeOnlgz+wvFEpqXJLlrJ0dy2QjNJw/rfoi1Mj3D0PqwmS6zTrL9Gxy3YldiHvfyE=
X-Gm-Gg: ASbGncuUbYwGVRLB3JMk3kFj+Ifhi1gqht94mmk/ZYaOAPMK35ts5WKOKhPcfqSvA2i
	ZutLEgHMlwTvBJjDYhxuRbJ/PeWzQDuMYiCsLUrp2iYzs+isJ+aypCrp9tYIsYBJMC+oJeF+6tR
	yF5Bi8FkYXMYNDEXLvheR0eRDojmc2kqHlihdqxwd5tjACWdeT6G+EoS/U/NK4p62xQZ5BOqOaJ
	aTnxc/7tr5eFqquyKTg8ipH5rH+PdSamidQ3M1x+YVIPr92yuZaMveRYzWkkS2t9cFH9PVm0y0A
	WR8ZKaIFbrpLxAKmAdfhMVTV1329AVKF0nOj9m8FAHC2jsqCBoaUreFAFAu6KHaHTK96WyZgRTV
	OykzT6n9MYFUtIr5/68Hx67bLKHmDV5FRVVMbgx2d2yPTaAUZ4N7n+6w5Ng==
X-Google-Smtp-Source: AGHT+IGdFovreVsG0VTuKKVTgWJJEqEKFnO21Mo+tI9uoQq7jJrFi/9vVCfXuUmfB6QhCbWUaAaAkg==
X-Received: by 2002:a05:6000:2dca:b0:3eb:2437:97c5 with SMTP id ffacd0b85a97d-3eb24379a13mr7083124f8f.22.1758042510664;
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Received: from smtpclient.apple (nat-184-7.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm22520843f8f.39.2025.09.16.10.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
Date: Tue, 16 Sep 2025 18:08:18 +0100
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Rob Landley <rob@landley.net>,
 Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org,
 x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org,
 initramfs@vger.kernel.org,
 linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-acpi@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>,
 devicetree@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

On 13 Sep 2025, at 01:37, Askar Safin <safinaskar@gmail.com> wrote:
> [...]
> For example, I renamed the following global variables:
> 
> __initramfs_start
> __initramfs_size
> [...]
> 
> to:
> 
> __builtin_initramfs_start
> __builtin_initramfs_size

I strongly suggest picking different names given __builtin_foo is the
naming scheme used for GNU C builtins/intrinsics. I leave you and
others to bikeshed that one.

Jessica

