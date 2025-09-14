Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387C26FD84
	for <initramfs@vger.kernel.org>; Sun, 14 Sep 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822377; cv=none; b=DrDhyTcXQRxOFfRq8gdNWsWKAT8IX/lyF4gqsRVk6FWUpv2Jk5JLG+tQkB86kaSGuhpH92v8uuLK5je0IBFyE6wCxmpAAOPIHxVGpThQom0NB3chXG2ZGGGLVzp5Rb49S4TNcPpWEVBEa22tbstpgpD0wDz8yGonKubUSeClFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822377; c=relaxed/simple;
	bh=dWOevKs33KVPp7BfwW01lTdoAaIwqA9A0zVQ5+zAb7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlsKzOMZ78Jzvj/PmR01Oo3P5hAqqNjpdarOInRsdozRSBdqHo65/Vbkie1JxrGlbTPkkGOE1Fbc7xw3xUREqjJiYkfhtWwXD2iiW6Azr2//RItbshOoOtRAqNSYFIEbJiIqbs5D54NUAgTfkJ6RXlkSj9uAdxDKKGcY8EOzDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs6hFjH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs6hFjH"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78ead12so403704666b.1
        for <initramfs@vger.kernel.org>; Sat, 13 Sep 2025 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822372; x=1758427172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=HKs6hFjH8hGEx8kFtB0nX1YwQKxkyNvIdKjk/YzKI/z0N2ZDpeaXyG20MCSaoI/O2G
         2InbYsM0JIlQw7fF9JQOjh6n9wTE10N4NGXAGVvOCQCKKy9hNkIvXHLpTaffaQ6s4mep
         pn0gal8CFQcQZ85hI0z7RZR+ISakVK9tsmvSpSebNlKb7PJPBY29jl/n1UT+16TV+0Kq
         W5Tf98TOSJKftoJa69Zn2ced0NPDfmm4/u8FNqhdlooOtvVHogWf1HBA6yplUDCHmgHZ
         OkkxLOYjZIXLTHxcdVwz73zpMIl1H00w+5KjoLiwvSIKL2neU5Q4/hIDRV0tsOcrkaR0
         rIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822372; x=1758427172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=ZHbLwvlXSgARYNYjO4YSAek4EPBE2f1oXz9kr+pyQX0bnBFJokOaSDWhbNObyIbYHk
         rXd4k/L80lEiMoBq22ZFUjPB2ut2Iw652u9Hww+xORqms05Pu59koIcH+vfw5LzMEvDV
         BkuqRn5PoELfWxaOUxAtBO5KqQAQ9i0ELa+NYmPm9wv3Qgo27BG/eAh9ZHmqniyiw1qi
         mExEMKO0ng5qFBF9j/Ae5rxewhVlazbfLwi5EeRwu0Eqd0NV1R6lpw6whDTFg9ZeWgEk
         ff5ELBzQ8j5Hu01O8Qh8xgg4m6v/k1IVGdf33dCRdHsQYa4iR7+FKJCHOPJjs3BR/kB+
         JlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTcALTRYtYWC1gCd5f+EuFMSEy6JMaVVKcPRiQ+gJRiO/UzHixOQHyOgD9N7eHa7LVJ9IExmiuZDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6quMI4CKslhwwVB7YOfOcmIZ2J3OQMpw/7hO44GT4D7T4JHS6
	ViQdkD4WYwNI7Ly9XIFcUpQ6vEnRzAteZjMPYQhiFH6z7dNREs0gsLGD
X-Gm-Gg: ASbGncs40RgQPO+BqH+01BtdjGg8QZvK59qiW3U08P4636sh3h6cgDUp4B5QDwLr8IV
	JGbN/X0Hmy6id9Q4+KYkgVdTySNDwSzXJAsL0gPhtjx3DHUGRyuIbbU/ZqtnGuqzfzOvJ5GOT46
	JUSbdTYGc2UUwb41U5thPbd+uR3bKre42kvxmzF2l/h/TpYG4WCcoH0scmbXJyOzWrtXzeSASVw
	zb858ta8OlnqItS8jirT69h8ef9JO+hBLXdT8jiR2oKmF/aNFQu4/+jpdc3qHFL5C3Gtl7LfuJS
	5lO1ImysNZgGQjKLHZpxu74xzztoPd43e+5ZEJvbPeWrED/7JSRFNTcdahsFr+sUBb3x8Pqy/9K
	MKxvm8rllySn7IKBcwNM=
X-Google-Smtp-Source: AGHT+IHIaNmlQUOqaI2XvHaD2x2sJJCA+iwXMxeIqgPaozK4MzRrxS2gXxwIxVkINaRf0GrOSh3U1Q==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7ad with SMTP id a640c23a62f3a-b0948c6c6a4mr387666066b.57.1757822371514;
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07de03d93csm287001766b.12.2025.09.13.20.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
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
Subject: [PATCH RESEND 53/62] init: rename kexec_free_initrd to kexec_free_initramfs
Date: Sun, 14 Sep 2025 06:59:26 +0300
Message-ID: <20250914035926.3770703-1-safinaskar@gmail.com>
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
 init/initramfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 40c8e4b05886..d52314b17c25 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -690,7 +690,7 @@ void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_CRASH_RESERVE
-static bool __init kexec_free_initrd(void)
+static bool __init kexec_free_initramfs(void)
 {
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
@@ -713,7 +713,7 @@ static bool __init kexec_free_initrd(void)
 	return true;
 }
 #else
-static inline bool kexec_free_initrd(void)
+static inline bool kexec_free_initramfs(void)
 {
 	return false;
 }
@@ -743,7 +743,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initramfs()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
 	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
-- 
2.47.2

