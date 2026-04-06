Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC325317165
	for <initramfs@vger.kernel.org>; Mon,  6 Apr 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466595; cv=none; b=GzkEyLem+6g2I349ZF3GpCzKSX9LzacuKixbW1O8SMhIDQCblHoQQMFJE+IqMZUG/Hykqh6imfnWYC0I8DK2ijxXPxv8Y4k8ahCXYpkGXn6jdMqWmvL5OKg+gKDW95OWmUim0mwa+MDbm9uBCqy/Y6HLMZ8XocP/UzLiZgCFrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466595; c=relaxed/simple;
	bh=dHkShzaaB1FzwSSJnCTbci/A1jSN+Xil0HDTvzSXpKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMtK+3UUtsyFYmUPqVewCwGkprENUo/Ar1+uec5DHzUQrTwIatUl60mTyFlkRYFIuA1g+ST4Ah7VxZJGe2ioyzM6OGWxQwLKstCArHyRSRRiQs/SOMwzs6NJ2JDxvSPl85Auzktx6Sf/BnSrQ7bqhFGVD2+KxtgajRKxf/sfl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVMcxcwM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVMcxcwM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so21596565e9.2
        for <initramfs@vger.kernel.org>; Mon, 06 Apr 2026 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775466592; x=1776071392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXHc8wsb4o8lZNG+myCrfyCC4E7lywwXo4HWR9KJ3SE=;
        b=pVMcxcwMBMiAzARSBYrWqs0H2xcjCl1BO2gTLJSbaDbRcPTFP+N9cJ3xb3MgeJTF6C
         JEpe4UdcW+/iXTgrES9tYl5JpVBe9v6bmINdW6O7QRv+ioUolYCyha8e8VUToW/MXCyg
         +fw29Lc2uOBx/MhvFlX3ec4uecJknieOpACzU37j6o2Zx41oUffTHRrkwQvuKPCR7Pwo
         C7yV8uzg69QheA3lsBQBrwfMtJId4DNP5rjH0EqPYfz+JUAsybOKnUA8b12kjeM26yyH
         f2a2QCH6O8ClGjHfwA2N+0c//DqYswoq8UpX7jv3V7rBD8B3O6cy8OXgdQiRVz0PNHXv
         6pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466592; x=1776071392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXHc8wsb4o8lZNG+myCrfyCC4E7lywwXo4HWR9KJ3SE=;
        b=KTCqcZ60k1sye8udx/YMRV+fgegNyLJaPiqvcyGpanWH/f+X2XojNKgATXYZnIInjL
         yf9iZb1iqsuAIZdQwkBbHxkzFtCU8qBxRXrwArlRcWC5lFv3KIqUYW3ULD6NfQhvFORn
         3WRxMLoDIoub94kwHXUPF+WGLdEtYeiSQrMFGP9GgdaxhkxMrtOAy3yEDMGkRSm/8t9r
         rYyh2n1icmTZLKxXrwJ0NOZ0SEnd5paypIMqPRt8wV/Oi3X538rftZbdXzTLvtAh2qsB
         sFB247L2UkLii5GeuG4+aza8K1QgM/vwg3u74GpfSd1YjviUIaUEnPuad4G/MyQ9IyHr
         3/IA==
X-Forwarded-Encrypted: i=1; AJvYcCV0YO53bIB7Itb/yrrySsRDnO1lXeuHG36d4HezDo/Xo9n0h50/e4e+jvE8ysn6pO8qremGzTR40NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwQ65DTMK9UJaNrpOrEVlwX9cWPZeuWf0Nh+N6Nna1hOuGQgh
	r2i+sC2z+BzBonPZ50wfzcrILC87z6AQ33+O6SG1Y8T2AO8Ch1xhAvJ3DKJHrQ==
X-Gm-Gg: AeBDietWIBokaKLOTvGtff6Ah35bzKzFRBPmdBmAZLnSysTdhL/aCRSi7qZIEdkJtPl
	V2+C3Hycun/thUV1HLH0FBB4Pq9MV3Eh5vZ9kXs7tIXYFve8WUg/L3wbHcBRZMBJG5KOdrHy7L6
	k3kNAccNx06Uuc9z0whpElj2l3mtd9969oQihITVOmuhNL4wWY472ukcgD5T7G8+tkxN2vPqEOb
	6RF1Sx+gbpFK+Y9n71qnT8/Nc8uS9czb1qyKFYDxw4YoW57b4C7khsq+25pHBrwXPBjDWrQQy/u
	dAiH3CO1GonDtdDu5CbGYJySA95LbeBtAEdRRf1t9O95BWb1wpTICLM0AKUip/B3Jqq5qlMY0dI
	FNw5sWVZgcyXpU9g8dQ1x4oyw+cxT1ALoMwog+Y4tnOrtfLQLGPAQbWaFObdbb2eNYts7W3+EiG
	9Tcf2h0ZGXMxX5k6343tY=
X-Received: by 2002:a05:600c:8b84:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-488997b2345mr174598415e9.15.1775466591913;
        Mon, 06 Apr 2026 02:09:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4888a7165aasm427753755e9.14.2026.04.06.02.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 02:09:51 -0700 (PDT)
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
Subject: [PATCH] vfs: init/main.c: change comment: opening /dev/console may fail
Date: Mon,  6 Apr 2026 09:08:15 +0000
Message-ID: <20260406090815.1495095-1-safinaskar@gmail.com>
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
present in internal initramfs. So let's update the comment.

I tried to fix the problem itself in [1], but the patchset was rejected,
so I will fix the comment instead. :)

Link: https://lore.kernel.org/all/20260219210312.3468980-1-safinaskar@gmail.com/ # [1]
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 1cb395dd9..40cfda9aa 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1645,7 +1645,10 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
-/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
+/*
+ * Open /dev/console, for stdin/stdout/stderr, this may fail if you supplied
+ * your own internal initramfs without /dev/console
+ */
 void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);

base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2 (mainline)
-- 
2.47.3

