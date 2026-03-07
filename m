Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747030215A
	for <initramfs@vger.kernel.org>; Sat,  7 Mar 2026 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853789; cv=none; b=jHHhMoGMXtXgz3iF8huIw5zHKA51x0vgTnLtZIjRw3TJxc+ut4DPXbbg9FW6BoSlJ9Op5ZHQ80nYusFUyHQJmL8KYz/2qbKTRbBCmxMMq2Sk7spA8Zo9XKwlnR22HoBNSvi5Ts8KyN1Pw600Nk/qBDxtgKzUKhRtEIQYTFIA4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853789; c=relaxed/simple;
	bh=yl/5Y/nXTvOWLCUjZ9vsmgVgWr8lK//l1u24qGNKCsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJFcpH+rP1qt1C6OFtv1Lgj2hMsV2kxO0I6Z+j1GJMTMoHjoKSVEpghIGho079SD5zYIfdPMJCnNBxS0/gSXsndXAN1F84tN21LPaa8bjCcuy/dzsiKv3IMC7No0pJtzN20Yc+D5fQqRTBbkgTZ/KKkQm2vg7PdwkFxgQYcTTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJT1t/r7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJT1t/r7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327790c4e9so7567586f8f.2
        for <initramfs@vger.kernel.org>; Fri, 06 Mar 2026 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772853787; x=1773458587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JIeptY94fGiMe9NnDArQDFW08JE5xRTT4JTPEDHqCQ=;
        b=FJT1t/r7ZGEZWYv9QimsR4un2BxAIZ84HvnR0KpLYNvlicYTsB6VHmeTGMrBwGEW4c
         uz5VOwYsKoT26N1XvPzaN27LIC542UoF06G+By5jqhpiD5hhnZCoh4sr3PFblePYXsbN
         INkXbyVzjbsaK30pKz2ErK2MkbIGSgOQQUo9LElYZNmYiPfqdbwUuN8wmdVED3asyh+Q
         M0rHDBToGRaz/uMcibguC0agiQEJw6FCNktfWtXH2r1q2uPFy4wdX/GU2vcPEjGb0VA7
         VfR7F8tewWWRVdCjZELBRqpLqYOG9KX8V2PJ0ZbNVR9mS6YEjsMobBoiKq5shxt3U4yz
         A/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772853787; x=1773458587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JIeptY94fGiMe9NnDArQDFW08JE5xRTT4JTPEDHqCQ=;
        b=m0/RMfH70ic+wE9egZRirQtVJyu93Ktd5bvQZoFyFHOByWAAFu1HqwOsG2vTDv95sA
         ic1z6C6fK5qXhTKAu9oaKwwjdAUchva1nFyftdZGyMoFrIJos4VroTMyGyF6EGUmP94J
         7NB/O0oYchop2t68PkxzkiUi8d+BCTIbmPNnP9cTWk2U9qWc3mLyblc9zVaghRKiO+dL
         2W0/vchruzVksaI7ou04SKsWpmY+dvOTLVwEQsGpoxlMvoQoJnM8AusrJw1IoqtHv9cE
         KAkwoTlQVo/RRfYldVJ2uat3UhFRTtHhYfclhmeHjNmn9x7aHXC7qm5+o0U3cKwe0C7i
         uD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM9RcgL0pUAwkLwYhaDzLW7XMpw5xCHvnK87VP0WNzloIOKAO/REyN4q6+H3HmXHqSkpLG9bsqAmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTOfMhAj7XF3MYETFLdlGLD9UDHwHR8URlL2I+XLJu+tffzBX
	Q7fMWQGj/nIoPJh2sR0r7cUNvwsooruZQQGkQqzZR9OXKym8D6i3qktL
X-Gm-Gg: ATEYQzxFeXzFoKcD6QDm3gS3cYuMzFsOrH5Fc3m669RQGGuXkJd7sFHOMSXHq9S+PQf
	39yq7zwjdp6jCtVg0bwUiAFlP7L1cJGCS9lVMVzqMLzgXFm6NDuR9wLEti/Z4EU7inYNGYjLOqe
	d5MfZdRVsknCJKq7fwuTk2HzC6Bs+Gc2LzDyNL2Mc+b5RraR1l/jD57xjytGMdL3U411oZW/fYc
	V926XpnxKYJ7t46BS9uYITC4X6m/4iScfKdGnR+S0k1l7AXCYZbF7mFjIwy9FtD0zXFxFv7VKhd
	foAjlGSa0tgEWaJ3Re39hyc0hLBeHg1QrL2RN6fnw3HF+PQsTcrs93Io14Z2UBx/C8o6U3Sli0F
	Zcpph0CCWk2vFRVduneuPV5MH3v4LGbDuMIX4/8yIIGL/6JdVtDfotnPuly8wouSMS8E7md3KU5
	D5PYRwh19iexIti7HgiS77iOQAuV8Qcg==
X-Received: by 2002:a05:600c:5250:b0:485:3025:162 with SMTP id 5b1f17b1804b1-48530250228mr2832345e9.35.1772853786749;
        Fri, 06 Mar 2026 19:23:06 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4851fae538bsm202029975e9.7.2026.03.06.19.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 19:23:05 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: brauner@kernel.org,
	ddiss@suse.de,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are (nearly) always available in initramfs
Date: Sat,  7 Mar 2026 06:22:58 +0300
Message-ID: <20260307032258.2857157-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bd45c86c-e1ea-4995-bb00-df83cc873105@landley.net>
References: <bd45c86c-e1ea-4995-bb00-df83cc873105@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rob, I kindly ask you to test this solution to your problems:

https://lore.kernel.org/all/CAPnZJGDDonspVK1WxDac2omkLJVX=_1Tybn4ne+sf3KyaAuofA@mail.gmail.com/

-- 
Askar Safin
