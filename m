Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E673487
	for <initramfs@vger.kernel.org>; Mon, 18 Dec 2023 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPBEVlUj"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd52216c63so31794276.0
        for <initramfs@vger.kernel.org>; Mon, 18 Dec 2023 13:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702936795; x=1703541595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aZqk++h4toppAwuTsmB4cCdZoiKrfdceYrWfSu4x494=;
        b=kPBEVlUjtbumSBMiYuUBUDLqGyYhr6Z4727HWHXk5itQeIc77lN/BtKe331YWfwNM5
         Lc55Ps3Vz2PFIAhRcHYycfRwZiYJ6FGA0TVUULJ4YqaT6TZD+VOy1bNyv5+yLz8j6t+s
         FnPUeX7K6CKpKS4OW9vVJVMdubOlnf+fw8b7pMYGSkNmUj+BGM0ClwXi0nN6R7vCbQVF
         1UZgCaL3wyNAkp/K8CM3/tGTpKcoXwS9matlMFQ4r6vb5Pna/mMlx/MJOPTY2rNKaQgm
         jDT68IJVWto7iUtM5CVc/42/aOxXlwqAbDQhUQwb89zt+JpNR7vRWJGy1lDDevw5ghU9
         v8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702936795; x=1703541595;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZqk++h4toppAwuTsmB4cCdZoiKrfdceYrWfSu4x494=;
        b=Yxnb2MEPVwx86YF/ucDzt1Tokt/Sx6DOASZaYbSFZpW1YARMsc8ihlpy+iGSQkG9KK
         zMjeU+wjd8vG4tHPkvnWDhJXjMi/Lg097kP4ky0XPCryUrQRRXQymph7pAQyOBlavh8H
         offBgutysn3V3zHC61OdreiP81oWuiZrptqpObVGiyPZ/R6asNi7CRZ+2broJANzPZ3y
         97BOzHxPsVPpIPs9mSkoUDNBKDgndrHfMWhs3CepGvGCMnrekR+HLr9gpFLB0MTkcKZi
         PsW3beAwvHAOPbwOz7vecqbyVyVAf+2DfHFk4RvS8lul5T27uQ3zeusY+08WPsK3JWr9
         z9iQ==
X-Gm-Message-State: AOJu0YyQU1WhTPwLppHfR+JGZS7xyEmQ6LmF645OA7ehZGGSnMKCYVzh
	EqdswPCISlhr7l8/Piq4a3FsY8559m59dJxgi/8=
X-Google-Smtp-Source: AGHT+IGcDElAhWyNeG3yiKYUniHR6xbzjbE/+AR/IvJaOggbXji9Bm9AuqGYOwYEMNP/HHooErYJXTCw2HSM+teIvTE=
X-Received: by 2002:a25:b7c8:0:b0:dbd:4628:fde0 with SMTP id
 u8-20020a25b7c8000000b00dbd4628fde0mr1575638ybj.4.1702936794722; Mon, 18 Dec
 2023 13:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 19 Dec 2023 00:59:11 +0300
Message-ID: <CAPnZJGCPd7Z4PYkNf8ES1t0ZBE=p2Lny6HKzhqNmyfq5UGw0+g@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: ecurtin@redhat.com
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi. Unfortunately, this is not clear enough from
https://github.com/containers/initoverlayfs how exactly the
second-stage early filesystem is mounted. So, please, add that
information to README. Let me describe how I understand this.

First, init program from (small) first-stage early filesystem mounts
boot/ESP partition, where second-stage early filesystem image (i. e.
erofs) is located. Then that init program mounts that erofs image.
Without copying the whole erofs image into memory. In other words, if
some part of erofs image is not accessed, then not only it is not
uncompressed, it even is not loaded from disk to memory at all. Is my
understanding correct?

-- 
Askar Safin
