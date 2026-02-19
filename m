Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7A327C10
	for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535085; cv=none; b=aqGuyI/AUSKE7qXmO4/L9MvCv3SclW1JjphccDNA2sTagtRfaerfD+DorpljJRo/saWjMUMo5eupwa1i4GKs+ASuPItm3uUlrdcJCx/2xDPAR0ePTSVnxN/jR2XQ5+YlByhZjtLdVA8n1XLnYioNeXppvA0FKNEzd4Rvk6FcPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535085; c=relaxed/simple;
	bh=FRv7eowAcNyO65MPdC6mYQ+EkktIEpwQbRI5qwDk7Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPyTC5YpNscglA7cTfo8Vm8zFZXaUIweyo8iSulMlk9fkAcNoGLB3g/k2UaUERKskaK11WdpxfNVXz7hjqjjdc7FGPF7fDXTGzmBsRnG0+WtLhU7TcOhX65KA83NARNeutlII2F1Y8vpKaROiblxD2ZIahP9JnB1bVkWDsWw2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7sr/7xO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7sr/7xO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43945763558so843686f8f.3
        for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535081; x=1772139881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0GUcmDt7bO2Sn9J+9uf0HNcJyXZ2g0c2Cg3p3pl5n4=;
        b=d7sr/7xOKDrfhuaSB0ZaM8z+I9/E3H2P1grkmIKoq0mrR2YMOLI7Ei5lN3G+1tuL1M
         bAh1L+IT/x/2I2nzZvOksXY/2pW3tkPfoGlHSM47Mfk6bEEliZO3+cixLQyWldh8KJWA
         7D6mPT/cJoeEcqs2TFWDXW1cuBZOu0Lq7s4CD6i4ewyM1iOnXl/kdRZqGfcqiNZkPjZu
         bH6lcohp9EM2RMUZViYeI6u5y62YyI4ET6XnnedizeSr6N58QC+Z9JjAWyHBNq6vYbSH
         YGs0TFuSpiT0SF6tgNVHZQJSWiHrPR1NsyqkYLPEjJ4vnJvjHwn3zTmQU6KUpwrl8KcV
         WJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535081; x=1772139881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0GUcmDt7bO2Sn9J+9uf0HNcJyXZ2g0c2Cg3p3pl5n4=;
        b=VVshUUI3OZwm2Ag7IeEkdfR+wWWIRNxN6f0xygu3ERyw/I/t1IXhdo7yePu0VHRQnm
         QGHFHGIcAKyzjDSP+dOWBU5Cq1F/6RYgJDegSBQcsvW12ZMoVluMLYKUiKKzuYWdypnc
         c7rvQGKsmVzC//Uwvy59llIUjgtGRO0tDXCGzATKFsBMMnfWCkVLERzL3W2lffe3vq9H
         j2IsX/GQLQCS6VXrDUR9AXEdzf94erfWieDCoF5mt7neAvAVdo4d8T6x1TuCRq7kxH+y
         rnJOVQyaK74zEBziTq2gwGH9Iz3JkZsBNmDnqa6qJLGeBc5xQvgq7UlGxo1FhYVbk+yE
         dNnw==
X-Forwarded-Encrypted: i=1; AJvYcCWz/+T7RsnCXpYwDTjhhxx4710ARc1U+22Hm6CKLBa9u46ltrkwO2FLyO2ciuVGQnNPrI1XKdnZwec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMK++RmIs6hbyr+rPRSNLNkBYhjzKZiVTfh0WusHsfydSqQo2
	vAnzi+y9uj8bg4HxM2z6of/xthp0ft3CehOrFascMpltrtYJpAQbevb4
X-Gm-Gg: AZuq6aJm5HmqRmxO7UzWL0RwDuivWkRcgPFQ6hic1q5v0FV9Q+FoWzX6zWfR/CjRN5+
	Kb17b1S6rMi8sXyc2j9UW7rqqz1Gevi94D3lday9Wp8ltkZsrCThJ1rLYHxw52wZdjaqAF6VRbB
	mbWxzmrbpRXn+k1oZlHFhAUStcAzx/H61wtBYNfTwMweJKt+8lOTwykLiZGj3iKzuy1L+5+kMyR
	+dFkA4ogmCu3QbgmIFBl0VQnX/WMWBUnuOhvEu/3YOnISNUPas4MnlYE5zkbMBSCEPCKxrpDRyB
	Ud3qTX+YcNI8BTpKuJEWGaH2cH2pWY36N01yUHgq/GRlDZiE+ddfI5Ue6SZ8pqh7xzpMBWDftxJ
	Pa8px4E7opm63hehwfp13hvSuUWYB85USAt1cfjuyx46YA7T9Lgvoyrv5K8TQVoKxOfCtFzg3Wy
	qnOT/b6O40oC/ns8cmiHFF3gyTTWXg6w==
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr43835401f8f.23.1771535081365;
        Thu, 19 Feb 2026 13:04:41 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796a5b4cdsm55044994f8f.8.2026.02.19.13.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:04:41 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	Rob Landley <rob@landley.net>,
	David Disseldorp <ddiss@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH 2/2] init: ensure that /dev/null is (nearly) always available in initramfs
Date: Thu, 19 Feb 2026 21:03:12 +0000
Message-ID: <20260219210312.3468980-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219210312.3468980-1-safinaskar@gmail.com>
References: <20260219210312.3468980-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binaries linked with bionic libc require /dev/null to be present,
otherwise they will crash before entering "main", as explained
in https://landley.net/toybox/faq.html#cross3 .

So we should put /dev/null to initramfs, but this is impossible
if we create initramfs using "cpio" and we are running as normal
user.

This problem can be solved by using gen_init_cpio.

But let's make sure instead that /dev/null is always available as
a quality-of-implementation feature. This will reduce number
of failure modes and will make it easier for developers to
get early boot right. (Early boot issues are very hard to debug.)

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index f911280a348e..3e71049b3dcf 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -525,5 +525,8 @@ void __init create_basic_rootfs(void)
 	WARN_ON_ONCE(init_mkdir("/dev", 0755) != 0);
 	WARN_ON_ONCE(init_mknod("/dev/console", S_IFCHR | 0600,
 			new_encode_dev(MKDEV(5, 1))) != 0);
+	WARN_ON_ONCE(init_mknod("/dev/null", S_IFCHR,
+			new_encode_dev(MKDEV(1, 3))) != 0);
+	WARN_ON_ONCE(init_chmod("/dev/null", 0666) != 0);
 	WARN_ON_ONCE(init_mkdir("/root", 0700) != 0);
 }
-- 
2.47.3

