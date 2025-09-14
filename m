Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83426E6E1
	for <initramfs@vger.kernel.org>; Sun, 14 Sep 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822339; cv=none; b=la7XS3nzxNip0SrQQagOoV1UjB/Ya9lxrw9ss0ARYoj5yCHumK81M39lqBv2tyYLHNXYs09Lu977QdwCDUWFSRVCqgMntVyyzN8ajiowNCKaa2azlMEMu5NN6C0wmL0z+AgGGDneUIv7MUcafPPbz3Uu8wgtwY7n3+9eZqq+gwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822339; c=relaxed/simple;
	bh=wnloEZCAdLMdrfx5MH3Z2R6wkZPYS7ZaUTzWldA8TL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9mDAlob0hG1Aek3KVjFNpS3ooH0s00vfAdghJAHmA1SS0FMd8xy09zD/6dMqwDYI2/QYOAW/BPVGWJ7b7CZ2A3MJIveLq10I/1qckf2KdOvQTagcinjpo5oTWE6sr/1OlnnSC5dftWGgWOrGEYgDrNiWTwy97Z0Y7GQOXzxdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5pg8XJn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5pg8XJn"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a16441so465872966b.2
        for <initramfs@vger.kernel.org>; Sat, 13 Sep 2025 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822336; x=1758427136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LDuJwsx1JnhEieEawhozXv7eEPm7AwX4v3UgIhLgCc=;
        b=X5pg8XJn16li9nWBcEbx3x1guhEtT7Dd40HZ4Qzs/URlek7w4R7LXZmrzfItUvNPsj
         hhIFE1jSywXm5WVgAprCDNMLupH2ctNl2lJAMNYy4iyGfrljLsrD6PgmEBJNWfZRPCkz
         EWfFGVb7ZoErrmRwtTtqjdHyrri+IaBznTfZHczIUVaM0XTwvykHg/vAB/SFXXGPEk3H
         X4X8LT8iuXIBPc4Qu2mcOwFlknqC0YSGe0MXHWTSrdHpeheK1A6lFH2vmXoU5nvdLhjn
         18bODQKz4DDOwrCzdiA58D+CmSEddDkqzbU0FA4VxgbXZ539oukEXtUJhakHaKjaWIsJ
         1qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822336; x=1758427136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LDuJwsx1JnhEieEawhozXv7eEPm7AwX4v3UgIhLgCc=;
        b=KC7Ns/s+vEoesCArHSe29QGhIYrTQotGUUDKoa0GHIuoAmP9o9bvkotQxwBwKTRGFn
         VXwkeyI2td4YAcju4I+6b4RAcWRKoLjs4eEbB4rQe4s7TvTpnHwKZseFdKBy2ldrchpk
         YBLnokiSI/T11/O0w9aFF/0HIWydvhm+Anrx5HmQLycX7SnhqQtzpjjDe7FjUVrDR5GS
         PBxFAZ5Y+ZXU88RtGtMbMzxZg7b9iaAqkk3veliAukCSqebcXFIhM2wkJ7o+ZXHFxRDH
         iWOzDJPBZ27eobzoigANJZ7pDhOkPqZE+7k+rsBS1GURm+/CWc7u+kM2YN/eHV23bhP/
         oTsw==
X-Forwarded-Encrypted: i=1; AJvYcCXCwYORrQKJ2Akwb6MLUSAvTw3bSum+rJEruh9WiyMkiWQcbK5eRS9ZiWakIcD0+3GdZ5tqqOCUFMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5yTmBs6ALpTucktjY/cbTIJclrMsjO+mhM5pX8XgPGWBHhf+
	1Lh7OUVXSXtFedq/Q6hM+UtKT/ZlBcyGGNR5xjQUuybWRD1A+ijQv2jT
X-Gm-Gg: ASbGnct/5iwMi8DDc380I/l7XNVqWO7fqyf2FxhiKVY409Zs61bq+xpBl/dlvUEPuNY
	mvv1dagHlHJxE8cLv9cU8bHx6sbdFAPk5wDnDreeGyBGwSZQAxLtqxXfx1CRoQClylX5yzK7LEB
	BsyZM46qYQSt1QYu0UfWg2TmhZyTj8g7OrjP0aUgEiIDky0z0sPcnQ1H8zT1MF+gFbsnInwF+T9
	3Dw14e9cMQT726nQAnelaLFooBDNKYCSV2j5ShjfhqIUXSzkjdt6ipG5ERVISVsDrT9Wu38d03t
	ElmBCCivVHXt82jFGImHiQARxVITuqS2llCkRtT6SQu2Ytt6WbJL9l2I+k9H+D7HF5oHXOdF9AH
	cH9DmUeU6LylosF7h+Euwct8cAjZkmg==
X-Google-Smtp-Source: AGHT+IHNLaKXJiC+zXQ2uAPY4azg+7W3/1g8JczFufMn8mQqgVOZ73ifHuYY/OKrygFTvfUSeCcOcw==
X-Received: by 2002:a17:907:3e90:b0:afe:cbee:7660 with SMTP id a640c23a62f3a-b07c34d63c8mr797483566b.21.1757822335865;
        Sat, 13 Sep 2025 20:58:55 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0cf2112639sm91581266b.104.2025.09.13.20.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:58:55 -0700 (PDT)
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
Subject: [PATCH RESEND 52/62] init: rename do_retain_initrd to retain_initramfs
Date: Sun, 14 Sep 2025 06:58:50 +0300
Message-ID: <20250914035850.3762697-1-safinaskar@gmail.com>
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
 init/initramfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 30e94ebf4902..40c8e4b05886 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -570,13 +570,13 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	return message;
 }
 
-static int __initdata do_retain_initrd;
+static int __initdata retain_initramfs;
 
 static int __init retain_initrd_param(char *str)
 {
 	if (*str)
 		return 0;
-	do_retain_initrd = 1;
+	retain_initramfs = 1;
 	return 1;
 }
 __setup("retain_initrd", retain_initrd_param);
@@ -584,7 +584,7 @@ __setup("retain_initrd", retain_initrd_param);
 #ifdef CONFIG_ARCH_HAS_KEEPINITRD
 static int __init keepinitrd_setup(char *__unused)
 {
-	do_retain_initrd = 1;
+	retain_initramfs = 1;
 	return 1;
 }
 __setup("keepinitrd", keepinitrd_setup);
@@ -743,9 +743,9 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
-	} else if (do_retain_initrd && virt_external_initramfs_start) {
+	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
 		bin_attr_initrd.private = (void *)virt_external_initramfs_start;
 		if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
-- 
2.47.2

