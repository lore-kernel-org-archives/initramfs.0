Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD323AC39
	for <initramfs@vger.kernel.org>; Sat, 13 Sep 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724335; cv=none; b=LhyhoueNQ0tGqDb+e71knM7WYQoVVINBhILtp3DSaDv1Z/HLpHyv25em4malLUzkR4FPXXYuFkXgiig1a9aGiGIftsptuVqXdqSA5xZyy3CrYLYFLi5GWiUJ3zG0rRBqBXCAc0YIC0gYszrfX50uSLZMhG2l1xSi/Iou4AYu7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724335; c=relaxed/simple;
	bh=kibOCauDCBkqzoIIQtVCNE2P0zxtFVdI1DUZ/kvaArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTh7xIfxWtTUqEDXTQ/5IeUoX8kan+9gJy4CAu4NclSMwj6DZWeja+7W00BOiAJT9uJJ8B/G9XCjOgq2SOxlDC8xO5x0mdVEMIugVdh8rQIlaJ51bs0+UNdFyDGmuGnfHmDzLSAGVPhdBRDcOWsq3LOjzebRKfTxgg2/oYEkV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOStwEqH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOStwEqH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fdb137so377172566b.0
        for <initramfs@vger.kernel.org>; Fri, 12 Sep 2025 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724329; x=1758329129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi1FJKwP9nWnSjptSGh11GRsqwR1G48l7l6Ou3g4XAs=;
        b=HOStwEqHw8VoYhk7VlxxKOyJSgS3oHdg9X+fH9tPx8w3h+SQEBbgO6RjhW40LGfh7U
         7bxuSSZ2f0QLvSJJrCAbrfcXm6EhsCN+XJ1lIzoOPCQOiLb7LqDSXQQYP85D5gX0T6+P
         5jaIBw0hoLHPtpGJ3pWXXPg3JAdrjiLpKOHlOvGYo45xN0DLGaejUxVIxRQI3oZIpRud
         hvko6/1Vpn1tmc/uXidMtUD0wPWKYEVLP0V5MxpbQDXGGQJF2b6NB0mbAzuvb8tbGKZa
         R+mcO//zHtUaf0W7Fc3IPPmoFcBAZCBNm7+Oa1SPvpA5yHNZZM9b7qS1xXWTaim6mZiS
         9M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724329; x=1758329129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi1FJKwP9nWnSjptSGh11GRsqwR1G48l7l6Ou3g4XAs=;
        b=P0TlhoWQz7TASKQKWkfow2Ze3DBmdquYJfKLDgI5oV6lFFH0sUtdiVF+UQ2YRJxdah
         u6MsbBC9NwthxedPPNDwKRhfcJ9bIl9X72CEQ6XKkN67RBftQJmyO0q/aJAE7aOQhGNd
         wfQyP1yVcwMYapQQ5vou2cZk19pAI7ah2bdtOW0t3Jn8TY+1JekZ7zDR64MuRkgumDc2
         QV7rmbXwvGHmOJk6aLVOd5di2ddSX6aBRzp5vNUc9CwltM6AQ88fBr2dsBqUkFCet6iQ
         65UJj18z0xCbwWr7Sb/Kh/0ehrDlZUL9x1t8qqsb/UjRFiD1HyXUcHSU8o215ivDjN5L
         2QGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tNHMyEHkWCy4UCTMFIqeNip2APC76suSrdlGuh20uQWN70clCPEK4cPyEhaVwbUIaxNUxUhk7dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWgdlYsZkAqtDDsOsExJZgLcWzrS6RDWKZIzY30v+veRL2FVX
	0QOGM9YST6Ppe+zLyKgtqYM5+P5GkRwwYDNcmKubwUlLiJYctV7uMiGH
X-Gm-Gg: ASbGncsF1+0FtbPY/HO7bUdLk0mZO/PyCa4K3T3HL/NJ9lSiOcjOoKcm1eOLpugcTo9
	ydFcflmNpwy7oJDBbChuT4Gx3T76dnmFmC6sq/27WU1gGABXqHivNiqrGc3aaHIdrQ8+azSrvKv
	dAnW4548OVWFYvveYLnC7kg33ysgqnfCQQQBJvJFX9EjcpBVnhjm3WAjPvLSSBdJnv5ZIpByoMl
	+DG45GJV1M4R/zyUMCryIaa2klJ2hBGK+NRwSCri9+epieHG6J2VQ2jH41VeCkDuBP+TS8VaGfO
	VycCLyTG12YUaOtkAmARfeTPflP/78Fto/J17BpGPr4nCd4N+6nwr7uz7iJyK657lael2RDWZjt
	/B030JQeB44wCji4KbYk=
X-Google-Smtp-Source: AGHT+IEY39yKNpHOwhu+b8E85JfZO5GXoHp0A73FES6zZeZtQwPXvLC0BV0HcFzY55ZLXxqy2VO9oA==
X-Received: by 2002:a17:907:9405:b0:b07:c9b2:dbd with SMTP id a640c23a62f3a-b07c9b20f2cmr456963866b.4.1757724328684;
        Fri, 12 Sep 2025 17:45:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5casm460965366b.68.2025.09.12.17.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:45:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
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
Subject: [PATCH RESEND 05/62] init: remove "ramdisk_start" command line parameter, which controls starting block number of initrd
Date: Sat, 13 Sep 2025 00:37:44 +0000
Message-ID: <20250913003842.41944-6-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is preparation for initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/blockdev/ramdisk.rst  | 3 +--
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 init/do_mounts_rd.c                             | 7 -------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/ramdisk.rst b/Documentation/admin-guide/blockdev/ramdisk.rst
index 9ce6101e8dd9..e57c61108dbc 100644
--- a/Documentation/admin-guide/blockdev/ramdisk.rst
+++ b/Documentation/admin-guide/blockdev/ramdisk.rst
@@ -74,12 +74,11 @@ arch/x86/boot/Makefile.
 
 Some of the kernel command line boot options that may apply here are::
 
-  ramdisk_start=N
   ramdisk_size=M
 
 If you make a boot disk that has LILO, then for the above, you would use::
 
-	append = "ramdisk_start=N ramdisk_size=M"
+	append = "ramdisk_size=M"
 
 4) An Example of Creating a Compressed RAM Disk
 -----------------------------------------------
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f940c1184912..07e8878f1e13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5285,8 +5285,6 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
-	ramdisk_start=	[RAM] RAM disk image start address
-
 	random.trust_cpu=off
 			[KNL,EARLY] Disable trusting the use of the CPU's
 			random number generator (if available) to
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 8e0a774a9c6f..864fa88d9f89 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -17,13 +17,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init ramdisk_start_setup(char *str)
-{
-	/* will be removed in next commit */
-	return 1;
-}
-__setup("ramdisk_start=", ramdisk_start_setup);
-
 static int __init crd_load(decompress_fn deco);
 
 /*
-- 
2.47.2

