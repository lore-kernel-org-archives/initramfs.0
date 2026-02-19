Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1131D38B
	for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544580; cv=none; b=M/tKHj3p9LJHiMhpodbbjXN7n0rfz7FWDW+JTCxPATCFrlhckZwWTOs5MZl5eQ4wAbZMEY5i6b+y6Pn7V1P0fSzjYOH1MDE24LmnxQGfdTR7pYWitBZbNnwlCt2EfxSggIWeowIL+H/nHoTgDjgtYlstOabTILxe5YQh7i62etQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544580; c=relaxed/simple;
	bh=quE5sGl3Uk/gMNmwDYmHMacZa/Zg+chR5zy0mjgEh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgkkghBPAqc8GJ6Ug4kvpHIBW+7DH7IyWnJSbeWoOysD9eCk2EvOKXsoG8iuLhBUb+CQHXd2xKMtelA9Rd5CLa/h8Wo4AiYwdRFXHVexKUttvZ65i01EBVAxIfFtKF7IVmPm/neM2ihPqSRqm81y9El9H2+O1LGdpGVNGw66CYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfQcgfQX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfQcgfQX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48375f1defeso10640215e9.0
        for <initramfs@vger.kernel.org>; Thu, 19 Feb 2026 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771544577; x=1772149377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=UfQcgfQXQy+pYZ6LXrr9RBMeLnuzdqzm13XEFaa5QkNWUZcmJ241fUUe8Cqas9iInE
         Rx/OLeqATRTaT9UFghx2R2YUrh60VeM9q1gBCqVQKa9U+Jxprjj4tj6sov/A/DnjhP2J
         zOS1DfxoNfNg3j2OOVvKMCb/Xzyz+LhmQsyNb0TNhUEkus4xluqIIQIX6Eua36gAiYmd
         LLD6KyKE/dY94xjs0z4jy+o9yXlTGvuVI1SBZGDoisBPmF04N9gUlhqeHisj33IaXNIi
         gLSVGbUIGlvaAYq3drOD5i99jhPZhetE15bWfy/5E5cl730+9fQFX2m5YUnv8bs5qdcm
         rA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544577; x=1772149377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=TlDKM1I1m3kKxcwQdovYkZ80yFC8L3i1IO+qhdGPPZrojAVi8Cke8wUu8AoaRCm5t/
         J3pyPtKVYENeQeofKFXWoRKdkU8tiyPppZT/A4E0Pyfjf4p/L79h1KO1DArBrRNr53kV
         HBcFusVByo0mKLAPc38GUXJ65lTHRKp4zBTeb23aEvnSvf9isdJJFjQ+s9LzG4Ei6NhT
         wWBCqA5YbvA4YXA9xU4O8WZ3VQohqc17S9JtxuudGyq3QXUHWZQ7FGLoZxuE7SVH/CLQ
         H8sOdsgV8rXqIvkmvgURVZF3zk3WKr8wznlERS/voYBPQHtAoxiK9OiJhM9+c7FLt+xO
         ZBlg==
X-Forwarded-Encrypted: i=1; AJvYcCVwrRrSh4xn11aNeXwGEf+smDcNuCaNDlxux7BsoUDOk+m2G5CFswXEPgLjlP42fW98hHcrIoY1Jhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQhIdd3oJww9r3SPfJZCmTnXMITSNXD4D9sEYIz67RgJYTZRf
	ezflTjWCuVBmiVvL4vbNIJbj0dB6hXzI8II1QWdQ3OBbEwLvobfmrYbNTdXRrw==
X-Gm-Gg: AZuq6aLr/ZvTQU6BL9MU4b1FFuFSDY+05/dkA+C+BhNIwhDvVDQKXr+VOFjPTkiw5lb
	FVP8WBJGxjyjR+CWUlh91xji3iHIuik37FobRSR0lH4divVIp2EC4FQySuY/bX3SiYBryEcWNSl
	E1+2ycBh6JyMij6emq45rn13mRSBBaZyf7/qLzNEY0xwCKbRNrOkkvWGNmEoi/quD0NXxbQXXMf
	Y6O2Mj42BSCluY/X9I5Dd1Iv7bOnFt+SPY9ncI3l5v8g0tFmf2xoI8YBy5u0QZLn15e2Baj6Hkz
	q8ePIoZuGzLaqejxCJpRsi+iG+zRGmGYlC/pK8+oBXk1i0LQ44EMS5YbzFN3e0rPB3XJEMW/XW0
	6lZR6MGWre6zthEbE5qu/cVla1Cbu9rUl+R2ip0iMQDy3+lme0zevuvvIka7hbaVakAeEDPXcR3
	R6HM+P22rZNTWY7EqhEgY=
X-Received: by 2002:a05:600c:4e54:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-4839c002d65mr111614985e9.35.1771544577127;
        Thu, 19 Feb 2026 15:42:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c048bsm35793735e9.7.2026.02.19.15.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 15:42:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: containers@lists.linux.dev,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Fri, 20 Feb 2026 02:42:49 +0300
Message-ID: <20260219234249.3757808-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
References: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rob Landley <rob@landley.net>:
> Also, could you guys make CONFIG_DEVTMPFS_MOUNT work with initramfs?

I did something similar:
https://lore.kernel.org/initramfs/20260219210312.3468980-1-safinaskar@gmail.com/T/#u

Does this solve your problem?

-- 
Askar Safin
