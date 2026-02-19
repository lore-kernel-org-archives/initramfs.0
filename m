Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8F32471A
	for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535039; cv=none; b=CCDfKpOcleoGTDKLaHKzXwT0JjLXu3cYRMxYLciCqHqqGI/YIQyrPtvukO4QoJaLAZzhBP1sUYimytBwJ0DhjRoUFGLFBQqw25WfFI3jgWOWcMABw1XwhWl9zjj6HpcmvwNsh8/h7lfcs7ZO1zr1Y0J2jk2tnSgKlqGAc64sn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535039; c=relaxed/simple;
	bh=pNvvwCxaWteDSrjz3ya2LND8dS5HAFVN2gK9oksO2ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F52V3T5Vlj8rMVt/DrVPbTpjm5wUAou7JTsMBlKgGT6w5u6l3dZhzD+21nTwlpl1GIbGRGmsSQM8AqYoAS10Novi/emj0XxGnV5Fo8vcTt12vRStyyrtd908kT/NRHRcFhULuv2guy+l7DdrVdkZdaUjg6s5liKiVbDETWMlfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHn0rmsF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHn0rmsF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e555so13466525e9.2
        for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535036; x=1772139836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAxExF3Bh85aqNqMomIsLZH79MhB2KBo6F6PX7ObPew=;
        b=SHn0rmsF50AYxL4vve23IsSI5TPwEOCPsbTgctziEi8TBxzvPbyCGWvjnoUCetMzrV
         jSzRs1BRKVpJOaxnBLxzmUmpVLMbhdpq4DWjKSfWW7JLPzq3qJoJGThg/02SkE3dFaza
         6ig3x6jxtVk8RzxLJjSCI01ugjq0jy3Qa0JVE9cj65LVI54z7ol5Jaf4P3jc7wpvJlJT
         r7fgE+LeHQlwlRsNS77HC0GtBGaKMTaP5o1NRQp5gEwlMLEccyLOQX5200TWJhsY7ve+
         fNPftuwq/ZosU1BJj/SDQbxYNP9GmQiWcx2FV+syM23YMrgUSQk6QZNNT8QqDidizHjo
         Evxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535036; x=1772139836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAxExF3Bh85aqNqMomIsLZH79MhB2KBo6F6PX7ObPew=;
        b=G0XviV5sVlGspbCED31HQ1nhEe4VVtPYuWpixTeJZtlsOyXndoWe3SS9PDQpctBJX9
         k/TUbmdW+2vOcC4Y2bKQ//RBGMcEIpq3tL3urUx5MzEaPWwNy8ylFjZM3+4vG2mZ/UWf
         42qZ6e2uymukFt0Egry7XI2/GkzVre1SknCqVObP9eKozEPaPsB2ZgLQfo7yGLbdoXGr
         Xj7K/nPXjYsiTIMs5YNc6dTOdeZax2QSsLQFW9nYcec95TPcZiHs7yve/yeUJi3H+dM8
         6EV/9pdcO64mKkQiLpzF81sA1TLSwYUdB57wln8xohUBW/I9RTEAPAYOVYn5cOJJV9Co
         ebiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLKBstFVK2VRreVdsffJ1K0NS6hpvgyEMnakRph3DHYhWjuw4kpZ0v8SRlFGMxU7MeB27kHm1njQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvH40uqZqkjhUWpaMHaxwZobg1ddKzIO+fSIcHL5wC1pXU+7q
	82K4cmX/xK293T6oBMg7HPUlwfvObTljyj+Sleir2dnovapkCv73l4rJ0CpxmA==
X-Gm-Gg: AZuq6aKM6SvvoVDYo5KbxIOjQcN/Wbhp8QqIQlS/6UviK9uq44ErsI01u2jQ9PMPy6S
	xEVfhylcn0q0/2ugJ6gDyu1lGo+k8Ss7T1VXs/Lm+CjSvMb/Ni5K6yBAG3u3M2zH4g2189U2ieb
	uIBooi94MTg3x1qi15vrUSIBav7eddbwsJgv0MBfJ95YpGcqM9rCoOuVAVbkdAsgPG6bZO+6jPp
	okV83kabP6paRcMRz351E5QWKrRsGcWUVR3jdCKb3MUPcEbvSVwfBXgKHr2fJNA4TtZU46quKAv
	4ydEicQZH2XZj5mY8e/iqS0KahWzwAJUEXUWmHkcr99FIHZ5x2Lq8ePNr21VtqArtFeOkbVfeW+
	7DLvnxs7iAt/0Wk7kqcDrWavJT0X2uYllm+1b8nswudUDyAyV9OsLrvKDv4Gy+2fTccyaqzNiUs
	1LJzJTmifo9GSba8zYpjs=
X-Received: by 2002:a05:600c:848a:b0:483:aa2:6bce with SMTP id 5b1f17b1804b1-48379c00bf9mr264391715e9.30.1771535035717;
        Thu, 19 Feb 2026 13:03:55 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a316eb08sm30113295e9.0.2026.02.19.13.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:03:55 -0800 (PST)
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
Subject: [PATCH 0/2] init: ensure that /dev/console and /dev/null are (nearly) always available in initramfs
Date: Thu, 19 Feb 2026 21:03:10 +0000
Message-ID: <20260219210312.3468980-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for VFS.

See commit messages for motivation and details.

Askar Safin (2):
  init: ensure that /dev/console is (nearly) always available in
    initramfs
  init: ensure that /dev/null is (nearly) always available in initramfs

 .../filesystems/ramfs-rootfs-initramfs.rst    |  4 +--
 init/do_mounts.c                              | 11 ++++++++
 init/do_mounts.h                              |  2 ++
 init/initramfs.c                              |  2 ++
 init/main.c                                   |  6 +++-
 init/noinitramfs.c                            | 28 +++----------------
 usr/Makefile                                  |  2 +-
 usr/default_cpio_list                         |  6 +---
 8 files changed, 28 insertions(+), 33 deletions(-)


base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122 (mainline)
-- 
2.47.3

