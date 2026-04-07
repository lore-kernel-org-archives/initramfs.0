Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF738F937
	for <initramfs@vger.kernel.org>; Tue,  7 Apr 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545169; cv=none; b=PGKehzk9dqOfIkhIdLuiRka8GOHt2cM4CC9+dVNtcrH9zY3t9XuMLElpyikL0W8o0RysSf54uUzRqXycEAU4vJLJJ7aMRAxKibR3AXIWBHTadVdzqQWS7etYB2bmRjVeTjXX/e5EKgXwcTz8zZUGi5hF/ed8v4e0S+yGeMcZhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545169; c=relaxed/simple;
	bh=bBcpBqNdkL3GPcxQ06QpROEKI8JaHAFAoMDpbmSmwlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQmIWO0OUkPbKt63ejI+Wq8tHN/F9FGmVbzgXhebCMdIO0oDhsd6u/XVXzntvCpHvRFcWqLFJHyckXdgW8lsToKZQIuRAV2rYyAHrbaE1/OE0ge/ecaYxt9+5T4djgi8yepltxI+2qdhpMSTB0j/s9XGH7KuFpaf08HQJDqtTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZkpfKIE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZkpfKIE"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfbd17589so3595410f8f.0
        for <initramfs@vger.kernel.org>; Mon, 06 Apr 2026 23:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545164; x=1776149964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQDoymknzN02+yzB9HgAmTahnsrc7TSfCPMON3BQVeA=;
        b=IZkpfKIEtJhLvAD19wHxxUlqKY5LMt7jZxk6vb94toRlEBLRX6UPxJqSUj2McNJbRB
         2IURtxwOl97DNV8GemW7STl7IVvMXrY8DY21BDLm/XfQLYpP0aN3oUxZoWiZ4404Buou
         y/fKuXlu0p6sc9ERWFy88Y8rXLYyJy1CLJZ3Dm2noRLp/bFzYdRExE4B3lcuNs/5DCzK
         wOfn3c2dD2zaBkiPTcuQrcw9FQUxNjtCXHf7Wl6bjXaUVfXEPlf5uAtQTy82qVzRSQ1q
         IhRZ1K1bKqx3jD4s86ViMr1rwji29y8YXJ+Mx0GNohyFthE3vrXOQC84t9CO73Z2TvX7
         kMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545164; x=1776149964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQDoymknzN02+yzB9HgAmTahnsrc7TSfCPMON3BQVeA=;
        b=GnOhMRv331n9y9CgPqcfoZ6R9I64H4KUkc8ny+opgwV4M7KXqZRTIIXPntpBoXFjMg
         zMiRjLyUNLSJWeH/l2YYGO5vo0Cs5r530eDTkxb7VjC9P4G7i9jS3Eb3TmlvoHZrlfWB
         TWLW0EjQUl5pGUJsmPFs1B38DjTjZVDaRmM8cC4M9dW2Xq6NWA550QzdiwFzBQzkuiqk
         ajkoXF+ydx5DaUDqjwy5ydM8tLMB1B6DvqRZwCTzuImlnlyVu2uM/sPtC+lFXPV2NZTU
         Ln56Tj955hRuFFJwRxQhyfVyaEWzmSKSN+236k2BG+wy+pFZ/b+ZTda978DA6KwAs4Ja
         dd5A==
X-Forwarded-Encrypted: i=1; AJvYcCWQTaRfVqZfioe6LwhcN/ZTvsebuGq4heZCj6ivoE7Vilup/WhNIBWPImekFoFk0s7HFuZy0wbNKq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAMb0wC30YW0NfjBbDoYtOdxr8F91/OczHtvYVxBmL1ixAgMr
	DX6+KGv5HkgC3lhIj4MEztNdFyqlbn9kYqFHXwYmWvneBKAANq4ykhkO
X-Gm-Gg: AeBDiet3linzrobvQsn4eq1L0asg0RYtjgkFNeKLfDRONV147MHLeokSKAClB0QYoDO
	LI48Q4LBg2uWzJc9HBu30VL5nKEYvodrbiPQj+y6XDLE/g5ns0Nv095Y6O0e9C1153XBtB+scJ5
	VTgnB0hmlZrxv7OBT8oNy/xgBozRTJ8RWBlOv5kMMfeLPtljdbNZO/9kQ68bWHT/9djnasaGeyG
	cWXnJFjfwtpKfsEks/wR1zV8aG7OmpLSDRSDwpKribcC6s/SXa0KDQSe/WXiazxo3jcUYaDR9vP
	vYD0XIYQaJMS7B4j6hWB0C3f38aU9wLGwW6Ya/Hr16Qrsgdn3AW86pIrNqNOCXv/jqN2SISTYDJ
	/QNVQ9zLjxsf/sm05pxTwMHLSvB7MlqctcVqVn/HS4k8zZX/lR5Z74cvF9ImVkja/Rxby+7DK3L
	X7hfA5ylMt04Atr4YNxs/K9xYN8HQPdA==
X-Received: by 2002:a05:6000:208a:b0:43c:f81f:3e6f with SMTP id ffacd0b85a97d-43d2927f3f3mr19248494f8f.8.1775545164387;
        Mon, 06 Apr 2026 23:59:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43d1e4f5294sm44326818f8f.35.2026.04.06.23.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:59:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	initramfs@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] vfs: init/main.c: change comment and pr_err: opening /dev/console may fail
Date: Tue,  7 Apr 2026 06:59:19 +0000
Message-ID: <20260407065919.3246787-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is for VFS.

Today comment on console_on_rootfs says that opening /dev/console never
fails. This is false. The opening may fail if /dev/console is not
present in internal initramfs. So let's update the comment and pr_err.

I tried to fix the problem itself in [1], but the patchset was rejected,
so I will fix the comment and pr_err instead. :)

v1: https://lore.kernel.org/all/20260406090815.1495095-1-safinaskar@gmail.com/

v1 -> v2 changes: changed text and also moved it to pr_err (inspired by Al Viro)

Link: https://lore.kernel.org/all/20260219210312.3468980-1-safinaskar@gmail.com/ # [1]
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1cb395dd9..daf115d08 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1645,13 +1645,15 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
-/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
+/* Open /dev/console, for stdin/stdout/stderr */
 void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
 	if (IS_ERR(file)) {
-		pr_err("Warning: unable to open an initial console.\n");
+		pr_err("Warning: unable to open an initial console. "
+		       "You likely supplied your own internal initramfs, "
+		       "make sure /dev/console is there.\n");
 		return;
 	}
 	init_dup(file);

base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4 (mainline)
-- 
2.47.3

