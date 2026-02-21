Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF641CFBA
	for <initramfs@vger.kernel.org>; Sat, 21 Feb 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632988; cv=none; b=bz5xWBywxhDrQ1szs+YNl1UNLytxhe8eyoVkrIrNm7wVDUAx+2Qh1B9imwuXVNwhe3N0t4CmO5npY0AlGcuIIobnX65k3RE45Bf8CTVYMk72zJn2rPJ6xXbUiC5jxMuKofDHtsJR10O9QI2dWDNHbAeE03SRvW/778QzOnBPR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632988; c=relaxed/simple;
	bh=3CyBu6t4VMRW7+VaTdEqeBQZt8ryLT8L+AYTjT70+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6Oq8ef4PAOwMDtshaEjMxNpCWekvhRBQHn6cz2DWsFPlXxfp4xlC0nUqgO47HgQTH3WQEjyY5RUdEWHbRG7ixHi878IkMVSzp31RAkcWtkybf4vYvw14133YmrcHjASTavA5+5a6MOpxLwaGLGwez7OtRLT2sGvocbWNnaXHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmyGnR+c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmyGnR+c"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so24213045e9.2
        for <initramfs@vger.kernel.org>; Fri, 20 Feb 2026 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771632985; x=1772237785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT8043eXb3x0Y28ESC3KU+eLsSvxZ0GN6RPVeedqxFo=;
        b=gmyGnR+cTByphmKcMVQaGwrgyNnOc4mBuocXd2Bt1JNeS6DrZMvCUw7QWjM3nipa4y
         bjyuuE7o1mZcN6cHm6gHllEBqLgCoq+83y4PNmNan+G7O20r5zx1ZojRa3qS8ZwAyWOM
         uJuxLdRlotZuh4uqIYlx+EAMDXF9H6luBhKZFECbATtuPqwTGwXvAhI+VMt8NLZUsotA
         7ZHQh50HCA1hRnJ17+A2P/PER9XokOBnW3WzBQsc3KhTDSZhjDdHcC15l9EWrwQLzHdw
         TbCysF5cXa36FJTpIJiCxyDQnSe39LAowaXGxmpbdhvS/D5jrv8Gxud/WlBAs4Wcuvvv
         8rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771632985; x=1772237785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pT8043eXb3x0Y28ESC3KU+eLsSvxZ0GN6RPVeedqxFo=;
        b=nh4zBq3GIq7CQin9hZgsifbLTYXmly3pdqoZcbFE4Bzaou2oQoDEbiyNfwtS7mJHpB
         9UDXwXuauhzTKuu8OZWqAkX1qcIIy8xslcY4+mbtHRAX/9zHVw3FZ0f9Uu3BEL54NKij
         hhJeWPxTYVMbcDi3Ax1cXxu9jsxfxxOAwFJzhaBA1Rxr/gMCTlhEyho5iuXHcBfnHnRb
         6+wfgzJsHpNWL/pohOHefVMqMq9BZNLkwFT8dlWkeqku3PwgDTfZbPORC5dbJI+ebP2d
         +oZspS9Mr9K94fk359GG34M1dUYDWrBiSFz+9mXgF4f/+Zm8G6PZkoAzyUhJtQmA7Hj/
         RxYw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSev2xi5+cx1jDw4dcXjnzmfUikf7AbFkOmD7WGR0LQ7ejdjQwHvDicTY5qCwz8HedlZHG/7HJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxEMT77cPVPS2ppvFN8TOchQO0dOqhJyw4OyvZ2ieQPiP48pV
	PQ6Z7/lma7XSwy+dXF8yDDsvLQx5hFN7wqEKNUqxnwbkXGJE/+9Bbugo
X-Gm-Gg: AZuq6aJ65IfkuJ8ZiQ0ibRFQSjftKcwn2AzWhfe7b/En3b3YpId5BiRCzoQDMP541sm
	exZV1MTvAT925nyIhYNJSpHtQRalxLy3tFGjJ5v/AmYVoRy0TUVuh9L4lmd9DHpUZcCbWyaRkpC
	fvb+ti6E74NW8Yz7770cgQreJxn0xenLAtQRE5UANpGfptlv6d3V3jkWAm+lJL39pURSzTOjHNd
	0Z1AmkM34T6RFCKsUNkxGT3P6VOQTQ3m0Hk7zcGio8J0/jvxuYWwr8fSAXLCVU2brJTOpXkBuKQ
	gmTcGBPyLGPnRihZ8Gl3LA8tCNLFcD/Aes70h18zyB3K4GEjUA+YyXvfBDHP75OLy6Wu97zF1f5
	9Fpr06rMuxsa0OMbFd8h87cOxzeOSc8bHM958V+Jx0RKQ8b9vrwUZhRJDX3eA+kUDm70DJVLiSQ
	DKx/Mti2nUXdwJqUqyU3w=
X-Received: by 2002:a05:600c:1d15:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-483a95bc0cbmr16930615e9.8.1771632985095;
        Fri, 20 Feb 2026 16:16:25 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a42cd49fsm38764515e9.5.2026.02.20.16.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 16:16:23 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: ddiss@suse.de
Cc: brauner@kernel.org,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	rob@landley.net,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always available in initramfs
Date: Sat, 21 Feb 2026 03:16:09 +0300
Message-ID: <20260221001610.820321-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220112606.551099f5.ddiss@suse.de>
References: <20260220112606.551099f5.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Disseldorp <ddiss@suse.de>:
> It looks as though Bionic has extra logic to handle missing /dev/null
> during early boot, although it's dependent on !is_AT_SECURE:
>   https://cs.android.com/android/platform/superproject/main/+/main:bionic/libc/bionic/libc_init_common.cpp;drc=a7637a8f06f103c53d61a400a6b66f48f2da32be;l=400
> 
> I think this would be better addressed via documentation (e.g. in Bionic
> or ramfs-rootfs-initramfs.rst).

Okay, I see, current bionic behavior is good.

Okay, I agree that this /dev/null patch is not necessary.

-- 
Askar Safin
