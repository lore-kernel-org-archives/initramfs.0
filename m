Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DD303C80
	for <initramfs@vger.kernel.org>; Wed, 22 Oct 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120398; cv=none; b=I2jwh+PgRKKgb+tBN6TYTRIsIXkT7ejaWpuIkvIxKH/ZptSdmyMAsdQGH95p9Nev4KOY8GROVAldOtv5ghHUcqZVWegZVX3ufyIoh4mi+coRPN+/zpwWvv6Oif3SKBjgwgf8EK6lPWNBSQpX+0UgkcwCXTj+s7F8jcVLj3bsrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120398; c=relaxed/simple;
	bh=eyBdO2wWOgqsPzs2lpBJ9/L31r8e4dCSgvgCYmxIx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF+eOX2Te49NTbhe+bUrxh15xCcrcw9zz0TBaOpYtLc0We1fbTwgyZMMzbtK6XysROmX3TQb2h77OuMx1irwc0Q+V1gINak2RkyVgELGfpMr/8min4OlvPdc6siiFMTdfFEgWY6fSSIFThBTeoH8p33iZFcNEBThl+KNRZ2jTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUx/AVC/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUx/AVC/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso2195725a12.2
        for <initramfs@vger.kernel.org>; Wed, 22 Oct 2025 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=aUx/AVC/VZbpE2oN97dtsPHXthi3yMi5uzy00pyB+I/2aKpB1pOF2pRPdY6cZntp6p
         +DxMKa9u/iHSxDOYlybze4ivOTbEBXwIlPobhtH9vR+ofclCSVUnFdLZ2x75oKao2T6F
         BzGLltxDdG1BTWxSKuNX4gqbmqd/hSjjIIFVs0n0Ch4mlkoUiC6dBoLKKuDIBPDKTFUi
         kFk5uj7UUBrRa5xQZqggiEu3sdLoHgwuGvH/67ISB2+jrRmwVgOB6jqYyuXpupwhrpaf
         63/jcsA3jGWujqwOZrdyACWvjfRvauXk4GbFXeQNuFeYqpEhKr8/+iUckaeissAGe+rY
         jSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=j6jfUVfwCugUQr+JUHVxbSb4uUurGO5NuN+5usND1OS8PRlzR/mxDoxazWohLvoSiv
         Yh3GN5mLU3kXIsL1mZtnBeidEQMFADUiEtgLo+mjIGcF+t70s6WiMs8fMSeHv4Fr479J
         kkkpedKQgVgaVLpwmvZsnz2F62JroMGUsXGQw/KqgNPYGGtuqAj/WwISJAqSmUCPLfvP
         b8+MeIzruipPgoqilDD9jx77wGn19ac29U2a6FuFVkokqJJPFaQriH5bWvBMiZ/FuNuF
         C12rWXj0XNNGW1/+3H8IintaZl9K+2Euz/VcL6CczmZVkdwg+jINp0KW0qVn4+7wKcAO
         Na+A==
X-Forwarded-Encrypted: i=1; AJvYcCULZDvGeZ38tiLVTFk/tsMHD453bFO2qAtepZ+wgSuGFgdeUmy0vkRNFluSide6kSgTiPuBbZOtWuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2F5Y8dHQ/+dZhSPe1UCg5pByzNhoqbXVfZiWP4+RNlx+Vbe2
	fUCmWS3IyF4jIfdmzgFcfp+evQTpIqgV68GD66KxkJteAGYWafUnDzIA
X-Gm-Gg: ASbGncuoK7Bwiyo8Vb8rAi7wSpjI7vpOFG1Brxof/pFNmsdQglCwBcbwl3b/KKnVVsa
	b47jyME6ukJKiKN77zsdkVrorWVYTw/qH3F2uVwyIjqD0RBUmIsgjs5MX7cKgRI+D8jmp9vJL9n
	R8OD7WsMtoHI1QUzGec1vmNTlCfj0P/N7OokyW/I26XlEjfEdsRQxHrb9Oz+QBD5mOfTCcJyQnt
	mOPmhle5X3ePQaWk+uEwEApVS/KC/7TzxoyiHL6qt27xrnQiBqJqJTnbGGv0iXoRa/zCavq7lN0
	5zEHDpgk1HRZ8axoEO+hWvJB3/mJZx3sHWxVTLlMjuX5XbdRwwZ+zRSN3aEbCSjY4oSq/+t6NdQ
	9VHazktxXWBU1+Dhffx/Vhney9EHAu+rjH3k26cIb7k/RgeyM/y0+DB9UQPSJ8oF9EXujQGkGwT
	8F
X-Google-Smtp-Source: AGHT+IFKMamBOdEkXZztW4+a96FX3cVQPwKK7mU8xvsOl5ZRh1X2aHXQdNoBVmqwPChAhbEjv7M9Xg==
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id 4fb4d7f45d1cf-63e23c0c43amr1116868a12.27.1761120394218;
        Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c4945ef49sm11192106a12.29.2025.10.22.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: bagasdotme@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	arnd@arndb.de,
	axboe@kernel.dk,
	bp@alien8.de,
	brauner@kernel.org,
	christophe.leroy@csgroup.eu,
	cyphar@cyphar.com,
	ddiss@suse.de,
	dyoung@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	jrtc27@jrtc27.com,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	krzk@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	nschichan@freebox.fr,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
Date: Wed, 22 Oct 2025 11:06:25 +0300
Message-ID: <20251022080626.24446-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPg-YF2pcyI-HusN@archie.me>
References: <aPg-YF2pcyI-HusN@archie.me>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bagas Sanjaya <bagasdotme@gmail.com>:
> Do you mean that initrd support will be removed in LTS kernel release of 2026?

I meant September 2026. But okay, if there is v4, then I will change this to
"after LTS release in the end of 2026".

-- 
Askar Safin
