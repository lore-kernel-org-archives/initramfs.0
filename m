Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2733122A
	for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868090; cv=none; b=EuJKF8HVwUvh1CD2CiP8SIkmF0rRZNolKa2ab1u9aKf73l/k70Zx+tfL9u9rPpHxXvYV4f0uxva1J4a8GW6/T69CXnMwgflgoUoM+oeRd6L3rGn/o03C3sg7mYRe1xjsBPV18/C2Mnw79sLIGULtN8GhgV3WqMTJjEz9HyT+Kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868090; c=relaxed/simple;
	bh=pPVYjjX+g8lwuvjjX9cEbFdLG+Rgns4g94OuadbV+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kost/b5tnWNvb15T1hed2/HwNhjB5oLrqZG/EP5eNxpgMoIQhIROch6DDf/DonR2z1KooPkqH0Jo4jV1gVXo+Wfpk2GaYQnJpQ7oTc/cFBWCLKjlDNO6v+e4K6omwLNsGEWp2xNFNB17ie0194foPbtJVatVCktp0BPUM+XQ1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDD602pt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDD602pt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so42574935e9.2
        for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868088; x=1772472888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUEz6YAu4nuheVqgpSXCLvSWu/dJuHAVRYNHbZZUc14=;
        b=KDD602ptgLwZUkiYwqEY3ctJ6bnFLeGw4F3dDv3tqqouq2gA/YOh5kHWEBI4H7U6ku
         IZ/OJCPlsgJTTg6israrsbj/MEeFAkUZkN+bjK4INGcsQIu12S60FJsdLpBJ43RtVta4
         tRAEzYzILAO5PJ3FR6FLeVVICwl9syZ4Yt3N3paOpMpy9Ny69alxVadj04I+v6hhI42k
         f3Oic7cnXRPwX1WBFS0rBNWJv27MFth5hlvp++bRCvSbZpmH9O1dO4g1B2STuKHOyYJp
         HyHSxLCth9UFUddaUU3E0JquTttLRtI3BsKHC91WaOGT2GsQHCV+6VTPOpo5sgdheR/i
         2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868088; x=1772472888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUEz6YAu4nuheVqgpSXCLvSWu/dJuHAVRYNHbZZUc14=;
        b=Tw6a1vWiUGEwMnCQ8UB6RWS5JrUqB4FiKYxDmjg4Lti+lm/SLBtOCQ5l1S188Y/hO2
         yyT5MSuAtDZJ9kjRRiNu7SOGglcFFLpWgXBRGh/UxBQjXgvs6+qGBma4AY95Mu/E/utK
         kLYn3/sSNonDZHbuECuZ+dL3sVs15TXiKeYrhF9IOcb/7lM+EH5SIcxbeUepdHyLjPSR
         CLBI6zqhJ0soyLCb02B6mQNB4wul9XDKmN7d0n7daoV/HdrOtBpldCN42qxoxVIy2ko8
         wtveDOr1VlfgDtAxoqOdYO/7NLMY09UG0lQpS/1leHbXvA7YQ4YzDMlWfEDELa43F1i4
         JWWw==
X-Forwarded-Encrypted: i=1; AJvYcCXCcIaGUeav2hD6UQa88pzvGl+g32HaGs2WV3geK/p6KOFRq4Q3uP37ODkAGCSy74FBu4PbEnWt5xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJvhpQ3O/I4draBm54VRv0ZQjmZ2EA+5OxUhbj+pXa4Jch0WE
	Xa4fT/LS6/IRvhH0i0bt6hCwpgHZYio0AmUQ6mNn0EULDtkjJPnhs7Ku
X-Gm-Gg: AZuq6aKmHqxO6yUjnZwpdxYVj752UjKSeR/WZ0dfT9kDlPbDRVohF3BrGq6qaoVXE/a
	AvYnOG/+tRRmKASm0tQOFKqjZe7XHQj85v8gmzUS7y5LRDJ5PiBtT3eozzzuBpqplDqwzqtG5UD
	WYCj0Qck32SJ2MPeGYolbC4lKU7+45ZqJANa50s6gr3bo73M9BkbRcVJLmYkm1Rx4FwbgjA+VL5
	10tFDJW99eCcxm8gT558gydjPvicXSlZWLPsv3P1PN4793mbvz9AkPLMdE/OkZ7/7M7n1Gw21x5
	waTQZc3gaAAOy/UCFOFWr1Vj3uw7zvnh9UgVljWgKsSEEuop2MUZgvhCkX2++j2xD16ptKgko1s
	AIB33SO4gECEDYMj5eS02n8ZfPivMMI3NrU3NIF3GFQrM5C74vLBey7L/R0HNeJLsq3E4a4lgfo
	tSsOdT3NTavW1KFejL0WA=
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr165817715e9.2.1771868087959;
        Mon, 23 Feb 2026 09:34:47 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a9b668f3sm213824665e9.3.2026.02.23.09.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:34:47 -0800 (PST)
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
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always available in initramfs
Date: Mon, 23 Feb 2026 20:34:42 +0300
Message-ID: <20260223173443.327797-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
References: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rob Landley <rob@landley.net>:
> The real problem isn't cpio, it's that the kernel interface

So there is some bug here?

Then, please, describe properly this bug.

I. e. using usual formula "steps to reproduce - what I got - what I expected to see".

Also, does the kernel broke *documented* feature? If indeed some
*documented* feature doesn't work, then this is indeed very real bug.

I kindly ask you, please, please, describe this bug. I really want
to help you.

-- 
Askar Safin
