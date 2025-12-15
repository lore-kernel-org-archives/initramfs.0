Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF83233E8
	for <initramfs@vger.kernel.org>; Mon, 15 Dec 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821584; cv=none; b=QUaZs3kYmwhZZk2DX8txiVzwFNeu7YRaE0KWWsqhjMWAF8ivdOhoKOBdgDtD/lcdwGK0o8a165RzlLsCVdZ6QjW16fM+VY52ir81cyb75GlLiohUF7QxvISqVYq6g+R0ckpXzbDTmHm7uO3zqm3qd5qdHOYIfssKFZQ7zbIe4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821584; c=relaxed/simple;
	bh=rKVKnsmZY5Zk5WseCbLhC70tZU73oYSI0ZX68nvqOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgNhlcnxX4w4PKrkTVsnYceKQ+eF4/FTUHGXa8VgEXtjjYWOjMItBIqVO9PKMlCmVTbGcxGPn4/6uUA3fZkIYH+4BCrSmFiN8JmIntPoaM/wSmcdyzSFHt86DxXlRpO8A+AINXOzdhme462ISn4ZyAdO+QkwwrDaZUhVlWFdkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWcISiYv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWcISiYv"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5943b62c47dso3758743e87.1
        for <initramfs@vger.kernel.org>; Mon, 15 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821580; x=1766426380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=mWcISiYvQDMyWrcSRycAfbgC2LcfDHeiHNEwlrIHZIiej1AYC1xSGsNIQAQ09hrYkV
         JX5RKvAXPuBpvT42pleeeJWKLBH2sgmOEqfv/KpJmG2j4MZwEb/VhmN2KUWZSKmpR4y8
         W9Y9TRYiK/LUJSWBxJeCtVm6+grs9CMML+9OjkE4C8237semIawFtJN/0+n1tfa/B4sH
         4PXZxM7CBczsbeXD5LrxS/cB7X27CZ/SgFLeQqgNRSooR0u6fqf5viqD1bfmET98d1BJ
         y+OTGkBGOVpj54S8EoEEBS6SOazJkp5BEh/6fqKDGAxYCvW45iAXLY5VypDKgUjIZ0ta
         NCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821580; x=1766426380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=dO8oNY74T1In+/LH7U5BiKdYKiI4qBg9ien7KQcigpNcQiFY3ddEw/onWqMvY7mlzZ
         FFgRVs7Q8/6kRbNTZXUTNqiN7nabu3p4MEnk8OruXUAtuCctdo0b35k38gHkYvPGL265
         /n5jm3a1ZJGXQnFU2JkdBPvEvqd1H49QLt1dqG8zqlMznj95Un0rLWugh9I4rhvFqZYP
         RomH+VUvhUhpeZaNBM7Qeb0mF6LBqOv77GQf8FnP0SviIj866b4NSX9VpeNFlRQe63TE
         C+x0unFMtGLXh/rXbvi3qOM0EnwPpb4orRK/WoEHmVuL7tewC1hh4MeQsyJKfdAudrIL
         EsAg==
X-Gm-Message-State: AOJu0Ywf/+v0VUzy8xkpgyg2WUB/iYjYZPpQ4yaB5xwqp3/7VYsgiu04
	1LKH5zWmKOOv8MnqkCAv6ETF7fRv6tTlUOVhY+YFQIImJ07RGeKZpv1e
X-Gm-Gg: AY/fxX6AJKP9J3hBOQ7rbZVJUZiSh+KZWHX4y5Haz9Wdqov5pKJR1zS3X87PR98TwDa
	lx5E1nycghunJN/Q/QhHUt1b78BxBqvhnyViD6SdBWtiVzVcVDy/SJINbUxYgZO/jlRrMTt69jE
	IAGR8T5gnioCIJLT3kJNhq//OaLg00hFWhVSuO1hrBbQjpsN2Nx15NMnVmQypI4cEqh8weZIwTi
	cxivhDn9Y0dXrJrZODfJ0W7SmE5y4LqexMReUYaTk32IqPkHqZUXMlSlUI1e+GRyRmz90dw2+RO
	V0oO7bKj188eRVykLxdMMvX9NvspBZb8OYoaUWKli8fawZa3NqBU67oh5s6KzBpfPm2g8tvboBw
	THylRcKyoX3/3y+E+TuJ9Ckrr1dDim/vTJv8CBb9dp194SoFHeXxshaKFYLQrUHclCdztG1yFi9
	jHchv/9ZFd
X-Google-Smtp-Source: AGHT+IFsDUVoZATaLzj9N1/hjfRE03GZ2gIP+Qj4HQeX9tt2ONoJL779FMDFpau9DQULSPR5u/L2Cg==
X-Received: by 2002:a05:6512:1154:b0:597:d59a:69ca with SMTP id 2adb3069b0e04-598faa4d5b5mr3889154e87.28.1765821580147;
        Mon, 15 Dec 2025 09:59:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5990da11dbfsm5648e87.13.2025.12.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:59:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rdunlap@infradead.org
Cc: initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Mon, 15 Dec 2025 20:59:27 +0300
Message-ID: <20251215175927.300936-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
References: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Randy Dunlap <rdunlap@infradead.org>:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you!

P. S. For unknown reasons I don't see your email in my Gmail. Not even in
spam folder.


-- 
Askar Safin
