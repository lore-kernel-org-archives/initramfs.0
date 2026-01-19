Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CD31B13B
	for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842842; cv=none; b=FHGY3sIOsqso04SsBdyesNpCk9EwV8xTMrZVeGq/mxLO8+Z7wohEwV6OzRL6MhT/zhhxgCrTRj6FHN6DLTsA205FoZ2Jols18EMYMDjoYdpEFlXGhpG75ONF1rHivG1wvR9bRx3v3ftymhySrFTeBCuloofzuNeh/XHCbcqEdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842842; c=relaxed/simple;
	bh=HltWzhCU/jyKg3OH86O7zVr1VGgKXVSd9KnWS0kbuZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qglwc+vA3q3MQIj2k/JzGvXmBeJnZqtzc4QW9Viv30ptVhtvjSJR3vZjzcxeptETix41YwcWd3lYP4cLOBqP+s3HDs1oGDJxUD/H7KcLNzNFiL9PCRcf67rQR9O6tKNmrK6dxzYU01tqSe2IZ92h3HL+Owo+erdF97jPi9T7mdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/XtslX8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/XtslX8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee0291921so30119075e9.3
        for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768842839; x=1769447639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFPZYWBsnoffalizcrUMTn6MQic+Yir2jaF7eYeMMsE=;
        b=H/XtslX8LIAnTJwS1EVkymRnTq3doHz1nEYBPg9HSQNWr472FqEZbK+VAO0jNWrV8G
         9hzanuF9m1ELmedyeeW+Tb74It/wf/djAB5KB2qjFveWQhuxw4h45f3uCO1YcQffL+PW
         hG+Bun9ERX7jMylC85H0J1En909396v36NfsfY2CNcFF0NiTehEanjB1rEUgTIgLpNrF
         pZd9nZ69DAKKnqUKtgAoTCEHaZLJp/LgMxrv0LsfzwOTOFFXV6EwY90Zs7rz951nwP0L
         zhTvVJiv7xhchqA7CoESKAl1FOV9D/VBPBVRIEFtSTHUODdic3c7LQlZO7TkoLXZ73ks
         /1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842839; x=1769447639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFPZYWBsnoffalizcrUMTn6MQic+Yir2jaF7eYeMMsE=;
        b=eOQjic2Kjiv5cJLgow7Mh4BWdqfFNGSpbCXncgI0n7z8pBjbjsKJtbi3zT7gmwDrIj
         h0vuWbR1EHFSAS2fRAuBRpDthq9dK4KlLpBaiV5CodHLSWJeVY8hIfYq8W3Ph+iyOUAX
         SGRyRwawkKCcqLm43pmM8rGI56ziZaWoApSSpoCDuK+7fslp1LgY53DF7+zs1joMGFkW
         5YUhCKRp+b7aZtNpV0w9HvZmiW0bMhxq28C/WBbGSaiUwhltXsbh9DKTyZkQBin3re6x
         /+prA3sVzDHnvC+OC7bbdyP77mOY2ZEdfUPoAuSV+8Qfipvc5IDbNTWds1cKgMqOnsTT
         Bm1A==
X-Forwarded-Encrypted: i=1; AJvYcCWUAbdNOm8fghhAY/bWXJ9PvPOI94898BBgD9M7cMrPyJ8Zxf4gQpZlYrj8oIUGb4sVzCsElyEjLSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wc1aazAVtxqIpMi2asd4ZcCwff7GvFkNBNgHmQJDbK9HcaFZ
	hBEW/d2q+5Vj1Q7/aH2AYwcv2uZ13JSBhUjuaFrsc3EAXrLFP1UJn3+O
X-Gm-Gg: AY/fxX46i3QyiDr2XFtZ5rEMO8ZNug6A5BxAsOocMIcDxpRT/t1bO4bCBUUMtmzFG8A
	NOEuNqY3c0b4uyYzwa5hBLQ69DsVClbagnipsKsKivCTDgtd1PX4k3bng7GhSX4LefFZEHyBC09
	0R/BQ4IGcpJMZIwgyccEWHq+22iDT+082mIZRDrhQNgq3y7jmyRQlW89uymbYvf4dFtEmMWrm2n
	YNAxhXn7iQGULaE4vTygpQIO++87yfVu9IKxHE1t3WdkGHrOSM+EOJO3Jt3CpImypWzMYxORqJ0
	Ch1yrTVjRZqMHWWwNid+GwDdVAMZCmeYBpMczJhrTCg5qsqDCMyz7z0St3RiZLMVE1lwQlaWydw
	Xf+qvNEra30viSAmF+Hne7hyLjQNVRy2UtSHBkVhOO+1YIsUxxog9di1TtdOouhmiFhXRe3/LnA
	kfsoj5uiggBIvMRkInuQ==
X-Received: by 2002:a05:600c:474a:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-4801eab5647mr145969725e9.4.1768842839032;
        Mon, 19 Jan 2026 09:13:59 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4801e9daaabsm85035595e9.4.2026.01.19.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:13:58 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: akpm@linux-foundation.org,
	anders.f.bjorklund@gmail.com,
	axboe@kernel.dk,
	emily@redcoat.dev,
	giuseppe@scrivano.org,
	hch@lst.de,
	initramfs@vger.kernel.org,
	t+github@chainguard.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Date: Mon, 19 Jan 2026 20:12:46 +0300
Message-ID: <20260119171246.3218393-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
References: <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Rob and Emily. All problems mentioned in this thread are solved!!!
Let me explain.

Rob Landley <rob@landley.net>:
> Your mount tree in a container does NOT start empty.

We got [1], which allows us to create new empty mount namespace.

Well, not quite empty. Assuming that we also have [2] and we passed
"nullfs_rootfs" in kernel command line, then open_tree(OPEN_TREE_NAMESPACE)
will create new mount
namespace, which will contain (in usual case) exactly two mounts: nullfs
and whatever we passed to open_tree call.

I. e. [1] solves "create new empty mount namespace" problem.

And [2] introduces nullfs you mentioned.

These patches are already in next, but not yet in mainline. So you have
some time to try to raise some concerns. If you have some concerns,
raise them in [1] and [2].

> despite the openat() family being in posix-2008 we sadly don't appear to have a
> mountat()...". I dunno. That's design work to properly fix the issue.

We do have mountat. It is called fsopen+fsconfig+fsmount+move_mount.
By the way, we very recently got them documented:
https://manpages.debian.org/unstable/manpages-dev/fsopen.2.en.html .


[1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
[2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

-- 
Askar Safin
