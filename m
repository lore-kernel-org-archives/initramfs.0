Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A1387587
	for <initramfs@vger.kernel.org>; Tue,  7 Apr 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544232; cv=none; b=RVnIFOqB8hBLdCmeRLsSIdorEqgIveIioXZChYhXGVkRkr6nWeK+724UeL8HYD0JK02yX/2YchNH5WXN2WHKw3e1S5Q4ix9Nr2gFwwfTMWTuk9ATr1BLZjwH6S1zC+oS4GVfn4SXab8Hla+VK6n4elQg5E3Op3mAcKyvRqbRmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544232; c=relaxed/simple;
	bh=aFb1INi/NUNadwFavlaxDB5+UNJh/ScJxVg4b+I3juQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7AN+V6MFkoicFl7Ob71CZMHqDOIPontMdOv/0cv73nML0RRjIV/fXTBPQY1pa/vKd+dEFmqDlHcpcZm/f+wytUfr2MB7FVh1O4C0UNCML2dK+BErGaDBGLJ7xWXA4tIyr2C41u/+lBgbfbBqAblqnunufwAFGKT7qUeQ6sNlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4aHZLc5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4aHZLc5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so16414515e9.1
        for <initramfs@vger.kernel.org>; Mon, 06 Apr 2026 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544230; x=1776149030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZGa67ZFGELe5bUP+eZlyvbCuIknlSmdEyMWxXen444=;
        b=T4aHZLc5Gh1yzq1Hm4a3SF7o1PTKXtDWEvb8vJYIlGQXPH4BOyGTuJug873oM+t7Fk
         3ICFGg0Mk/B3gcmQNL1w/S7tTn6qLOKKboahDXsdqPJi04DZCFxXom0Gx3t9+VXpqJbw
         8/AOlfaJWK2IZgOfUanrhEqcKDRZTIPftq8zOpYeOsvquoxEJxKA/lAu2B8gvv0NADzu
         axa7Szxee4ymfYS52X+ldWW/4nLgP8AGXNsJtK4ummqVXYIc84rN7ZuVhyGfgIrIcf2l
         wCR6Q0pBPdplK8sDx5juu3x3Xh29ngL8xfsm5WkxE1oh1Ms2VzIe7362RSA8zKv6aDpH
         n/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544230; x=1776149030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZGa67ZFGELe5bUP+eZlyvbCuIknlSmdEyMWxXen444=;
        b=kW6TXnkzLB3gVv5mHX6zRZN4cwSO1CASuqEpVOtAx/BE4nuLVtsBQOgUmJ/MUjfl62
         FQUtySzhkSXrzW1o1Rh8/iozPF9v9u2LX4Yret1ogXtsYc7UfYlEzWEcbXsArYPyUNI8
         o90Wleuvco8Cbqo+rd8pb5zTLJMxxfQJbkjSVSGGEn6CZpoGvVRExznOKnA0rjmBavqq
         794ovt8YU1gcTpXoQgqWHhzCFFe/M9cqVd/TIEqBK4iDvoDCBzkyNZ7YklNMUje/Nese
         drvkm06mot39tA6VQCYe85/WiDs9fmCmWC8FaoL0Hok4/F6TE9OlORbhteCzt6X+hxbw
         +Wyw==
X-Forwarded-Encrypted: i=1; AJvYcCWPxmxO0PtNgUsVcDki6+Z428pPXsT+NWeifS86vmO5Bp6rWtlRm6hQUsFMV7kRum90radQe9oz3s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL27FNbI2FRZTkUUbDK3c/vxVEWa17UurGG0OxATkYWuswjggL
	Tvxe23rFvrDwxUeQUJUj2+Ak2Wi9e/OWtIMhbhFnYAfMHX5Ef8MYcpuU
X-Gm-Gg: AeBDievpJbWNUmlguLNo6tc9/sefjvoKfmUBJF1rvcFzWq0nFLe5aRNuKmF/uYAACYh
	WWPVuLC5Hct/GKjxGl0Z73WfU07d6yo5X0n05fdl2M13xrY6yKXimlbBby/7v4zw20EvTCgyO2t
	ais7ZchdkFNpIdmgzucuWBhW2gGGeipdvJDSOvXWu/3hPbXZD64UdHwUnE1WW1zPKxPv1AqZDWX
	2ZO+zqDUPxXAZLQfni9KElrsTUD1gi32GDb5Swym0U9uYlmidzqLRLHBDnLZl1e9Nx32IGhXHuS
	Zzf7zXh0CRCvyOcfHEJUtgKAHRvZZfEjJ7J4ke/BtX/ZWeFuunbVQMwbWJWOwJVj6eA5KUtVWsc
	LtVYWRFxW9+nCpCNECm34oGAvhLbqCB80e9pCPbhC0i5jR8/axYCuRqURJOKs4kfK790xCOAXlx
	biUn1kS24VVqef7ez49+4=
X-Received: by 2002:a05:600c:4512:b0:488:9324:3ab8 with SMTP id 5b1f17b1804b1-4889977604emr216797945e9.18.1775544229793;
        Mon, 06 Apr 2026 23:43:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488be58c982sm10502235e9.31.2026.04.06.23.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:43:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	ddiss@suse.de,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	safinaskar@gmail.com
Subject: Re: [PATCH] vfs: init/main.c: change comment: opening /dev/console may fail
Date: Tue,  7 Apr 2026 09:43:09 +0300
Message-ID: <20260407064309.3223598-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406095452.GY3836593@ZenIV>
References: <20260406095452.GY3836593@ZenIV>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al Viro <viro@zeniv.linux.org.uk>:
> ITYM "so if you supply your own internal initramfs, make sure /dev/console is there"

I want to write browser extension for expanding your acronyms like "ITYM".

Okay, I will fix in the next version.

-- 
Askar Safin
