Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762226CE2D
	for <initramfs@vger.kernel.org>; Sun, 14 Sep 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822233; cv=none; b=JVluGYeY7Mmdp+xZXEnw42guu043HVw4iUTz4kPfeyW37xFNZyzEPtdwdkzlw0o0y+j/YuJgead3gUX2R0sQQ0VcdRiE6jwLWUeEH2zvSvGJ924JJ79XdRx4lpkUfaMz6myHoTMTqJHii3C4al05zALXNC2xrP1yUlZDAqH+X1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822233; c=relaxed/simple;
	bh=6pXJgBOVmgKyryw3LURicaeyD0WS1HvzY8WG0GWatOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE+nDsnkON6jMLHfyQjn/rpBERVhRWW+tih9ujiOvUBuoG0CTKSz+i8x4cFZdNaXPsGUJJ8XzQ0HtxJUY2F9w2+Okn+/TyRq3R35T/sKrcHC+XmxATzCCK5h+4cjSFtBtIs2Kp5nWUAjWL2nK1Hifw6RWg1zROqxkGQ5MgYbQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRPnFhfi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRPnFhfi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07e081d852so184010766b.2
        for <initramfs@vger.kernel.org>; Sat, 13 Sep 2025 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822228; x=1758427028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=kRPnFhfit7+R6UzkS4cF3DKL1S7JHip+IAyQf6T2UGYDd+vYI9IC8v9G51KVb5WDAk
         RN/gPz1lGKSMFe9Oe7MIowDwv3N0e4/KFS91xhYm0G+VoSkSei8WkHktPa2wEMB4pNUj
         WzAE/ebYcnJlcUWXpTXxg7oBxbqGV3WM9sIv1WyWWMlOmd/DBHQ0UO8HJ8wtmu7F5pSQ
         pAM88kkn9raeM/jhalMJUOdMS5VqW/+AUemoRwnUmW0/oDdl4OSBi4zM++ZdXBaXmYLj
         VGYSY1r8rSsi6oTo3enO0OXT4w2WPUK9VtsKTo5k8z5kW918njUd5UMO2sKFBB8AaeWA
         2SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822228; x=1758427028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=Tw+GP5+bIGVcIP2U1XAKKpXPZ6DpyoqR3j8xaoQdX6bf7Iefxh2CrSeW/iUfag7HCV
         lryP+f1gipE/J7UZkLS3rFmkxoVG6WZPuXLd6GUQAaRaaPn5riwAccvSyfOTu2zHqrSN
         pTpCAXIWHS9ZN3YEzKERS98wTpwIMrLVfpxeQGrttYn4Qr4Tis5vyy5o9a+MHmHU+nQZ
         Oz/0lOADe0Thbg0lI3vbL+Ul9D24HDPv1fDh9qxdBvqIuvipsoR/mCQmSKd02Dd5otc8
         s2S4slhFNepWPWluANfq4DBRdfyTRb/Iw8WNiAvz12BhjKgb/+RmFRNH+Jz+TWVLBTxh
         RG1g==
X-Forwarded-Encrypted: i=1; AJvYcCX9CNPeoGH/bYrxteiPAc2kcyrfjhNyiDZrhTa0eThj+GQ1ja/2SGkc3yp0TqiQc7rX2GJ4UM+Fc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjyOqfNwuv4Iq69llFMN2oNqQqaQQqsbhDhmndmT3E9liDc8Qw
	qE7bz3ET6bF6aw0X+URyYyIrobQ+7abI820OuSz1Q+hjQqn3btWRrWCn
X-Gm-Gg: ASbGncurqvpuog+cmL0GlHT+WKjXy2P8oHk+lKagc+3YmQZUZ9FDRBA2gC7P4ClmHqM
	8nOU3jLARC/lX/ieSFaKQm57ZIKB2LlU0MnHOdhuNjzdzAnL9izL8N2ZNkxsS8EYVkQQ8cYZETe
	6iJ17YOwaxyb+p6QJmrELlQpgZuptMeWk7rswwUwFUvHhDeNcqH0GXl/DlmA1mMYLHZ/iDtmfK3
	usS9IK6ixlz9aRDL48s/abz4dKAdSh09/HPO/RJ28h33sY0QYmTswyKVW79eYryPdInhoa7F9g6
	r6x3PDuxUYvvZxCRO5qpIkBKogGeCuTDkEXofm7D5WaKVi6n8O8ONXB4gFED9tB1pT5t0CvwpcU
	/V17fzN4nC1GsVdBl84U6nns5O0aYxw==
X-Google-Smtp-Source: AGHT+IHHnPU+sOVT053l7deT3P8z3LJVFAOiksWjmZKd0Ub2gBIDgZK1/4gCPHfUrNaBqPQVOEAIKA==
X-Received: by 2002:a17:907:d16:b0:b04:6338:c936 with SMTP id a640c23a62f3a-b07c35b8e53mr876582466b.17.1757822228258;
        Sat, 13 Sep 2025 20:57:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f1e54sm673986866b.75.2025.09.13.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:07 -0700 (PDT)
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
Subject: [PATCH RESEND 49/62] init: rename ramdisk_execute_command to initramfs_execute_command
Date: Sun, 14 Sep 2025 06:57:03 +0300
Message-ID: <20250914035703.3729713-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/init/main.c b/init/main.c
index 5186233c64fd..cbebd64f523c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -160,7 +160,7 @@ static size_t initargs_offs;
 #endif
 
 static char *execute_command;
-static char *ramdisk_execute_command = "/init";
+static char *initramfs_execute_command = "/init";
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -609,7 +609,7 @@ static int __init rdinit_setup(char *str)
 {
 	unsigned int i;
 
-	ramdisk_execute_command = str;
+	initramfs_execute_command = str;
 	/* See "auto" comment in init_setup */
 	for (i = 1; i < MAX_INIT_ARGS; i++)
 		argv_init[i] = NULL;
@@ -1491,12 +1491,12 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
-	if (ramdisk_execute_command) {
-		ret = run_init_process(ramdisk_execute_command);
+	if (initramfs_execute_command) {
+		ret = run_init_process(initramfs_execute_command);
 		if (!ret)
 			return 0;
 		pr_err("Failed to execute %s (error %d)\n",
-		       ramdisk_execute_command, ret);
+		       initramfs_execute_command, ret);
 	}
 
 	/*
@@ -1588,11 +1588,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * the work
 	 */
 	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(ramdisk_execute_command);
+	ramdisk_command_access = init_eaccess(initramfs_execute_command);
 	if (ramdisk_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			ramdisk_execute_command, ramdisk_command_access);
-		ramdisk_execute_command = NULL;
+			initramfs_execute_command, ramdisk_command_access);
+		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
 
-- 
2.47.2

