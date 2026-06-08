Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B10343891
	for <initramfs@vger.kernel.org>; Mon,  8 Jun 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936128; cv=none; b=t1ZZdec+/Jr7fi8q8NSynTZi5APSJdrluou513oSWRqAN/4hD2ru+toWEMfKsiGo0WxNu+DSZNwfSSrRl9LcJUolZScaewvSVKNgEmmM13MedzZgW4faXp80bkyKH26rHUKyb/AdVnyyxBbSFNehro0/SBrO0AmQ/guuRx9yAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936128; c=relaxed/simple;
	bh=XGRs0DdlMs5Z0WGQ1SxqxBYE40tg3YvCbsexQZnYp04=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=UxOrIlXRhvRpTf3MBqWNWwdZmN4f4ij4VuLGqMpImcUHotPCM4fGLXaIKEn6EBUPsp0gIs5gEjkxeGVUYoY9Y9h7WzPv1frQ/p26ZtBbTZ3WldLL9JWJciyhd6Fo3VCy47buqaaCXA2EbGqIxgD57Sckf0Qdwo+bhS05FHL+c8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+0W2W6k; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+0W2W6k"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4601949975dso761038f8f.0
        for <initramfs@vger.kernel.org>; Mon, 08 Jun 2026 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936126; x=1781540926; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XGRs0DdlMs5Z0WGQ1SxqxBYE40tg3YvCbsexQZnYp04=;
        b=Y+0W2W6k1Vb538NBSB300xtOJs2K1mSWZxSkqE1bVb6m1ZivRK8l3FSu3E6rbipAXi
         AQsTD9WECq0BS3AJ19/ZmPQoMf6ElIr0VKafua1P/C3h1AFCadE7MXOOHM33M416TV6v
         N5dNytfACVFhfvxNuSTP6pWHwqX58xULBzlOWvidBVZK4jZbPjzSR1i2qatvnW214jeC
         B47WSBIemXB1g5x6eU5prgEdagE/T2HxERQWxPQI6c0Q97v3uDtQMFnEgWDBCMhnJ00P
         Xo2bRp/mj77MWcBSNmsVao8M91c9cC3ppjeHsI8dntCdTNsbNeVTMDJsc+nLIiwss5cx
         fnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936126; x=1781540926;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGRs0DdlMs5Z0WGQ1SxqxBYE40tg3YvCbsexQZnYp04=;
        b=MjBls3j03TprtihyaAUDJr7102YhIzHBpDzV8lsPMcyZcYzVdQowNkqVEOcw7c8jJT
         bVD0A315Sjia48uHh2KD39SzALYg+s5TOjW1S4Cjv0qy8MaikVJo1xVb2zkfu9+UE5Oy
         LjiVqbpwNmBvpjEI6R1GdRadJJoa974vV6/lZIsmz6MsQMXXxXvgt6emBI4vKP0AupyJ
         5A7CengIz5WVN5epX3cMcEa9x1Q0tu/OPI+2pIPBiEtgFKZ486HApaL5nFndK+/gRFUq
         pgh1JJ/o+4BN76EYxwaNmcaQTViMySU0t9fPrWjB0Z/WGSKAppkXL3RaU3DiTcvetSMn
         Sdqw==
X-Gm-Message-State: AOJu0Yw7qpOqbv8dOR8XdCtGrTX/s0KV3NwBX9KCPg2C17eJYUI6jmTO
	WlBJbNwSkE+qnmzjQIqCTfFZcHJxnz9BfYzbovGOx1Ht7dgE+iZ6x17yJqAam9M=
X-Gm-Gg: Acq92OHUtVsncJ0jt6j+VUPYGbA68+VoeziT0qz4lTGoM+lI00/VPbOWT5lrlkfzET9
	7k7dLf3H1z204psb0aZaRK45xqUCTeml191D2co4ejpR5BPri/w9upXOctE8Fm+cl6SYi9w1xjc
	2z89GmQQmBjBEK1DTQwGrOiaIf3Kuzc7E2BRY6c0BA/IBWvP7U1xO4x4o0dmsSBXJM3ELRFUOa2
	93OZ6+3J6vlanvZ6rk9w/pcQ1w4zxwlVlQWubK0WGcYhVUrYb0GdAq2Y381SpYKFxY7STRaWeqT
	Zh/yOjamzdRIB51AM2a0q/BMTtFC/9FSHBqlj1Fx/PUrNCOHwBkbckPvhrzEyx+Pn9TdquA9iPz
	Ikeh+5KZbZaKrUrrwlBNWcpAYs7KCTeu9l8WxqNBaxRR+ojMD01wYtTUmkpvirT8CcYuErsCQo3
	Nqr6pjawyG9GsAzJoh4zD9PTYkcxg9ycP73DpNoS+LxlE5KFPG5oOPD2HkYQ7LgrOYi5R0/LySD
	McWcMF9bUoh57wO+sDmkBo=
X-Received: by 2002:a05:600c:6096:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490c25c70cfmr262620205e9.11.1780936125722;
        Mon, 08 Jun 2026 09:28:45 -0700 (PDT)
Received: from DESKTOP-LAN43DA ([39.46.247.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344148sm51739846f8f.19.2026.06.08.09.28.44
        for <initramfs@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2026 09:28:45 -0700 (PDT)
Message-ID: <6a26edbd.a1a40faf.21a46d.e4a4@mx.google.com>
Date: Mon, 08 Jun 2026 09:28:45 -0700 (PDT)
X-Google-Original-Date: 8 Jun 2026 12:28:45 -0400
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: forrest.mypackagingpro@gmail.com
To: initramfs@vger.kernel.org
Subject: Customized Bags and Boxes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCldlIGFyZSBhIHBhY2thZ2luZyBjb21wYW55IHNwZWNpYWxpemluZyBpbiBj
dXN0b21pemVkIGJveGVzIGFuZCBsYWJlbHMgaW4gYWxsIHNpemVzLCBtYXRlcmlhbHMs
IGFuZCBzdHlsZXMuIFdlIG9mZmVyIHR1Y2sgYm94ZXMsIHJpZ2lkIGJveGVzLCBtYWls
ZXIgYm94ZXMsIHJldGFpbCBib3hlcywgc2hvcHBpbmcgYmFncywgYW5kIGEgd2lkZSBy
YW5nZSBvZiBvdGhlciBwYWNrYWdpbmcuDQoNClBsZWFzZSBzaGFyZSB5b3VyIHBhY2th
Z2luZyBkZXRhaWxzIChib3ggc2l6ZSwgcXVhbnRpdHksIGFuZCBzdHlsZSksIGFuZCB3
ZeKAmWxsIGJlIGhhcHB5IHRvIGFzc2lzdCB5b3UuIFdlIGFsc28gcHJvdmlkZSBkZXNp
Z24gYXNzaXN0YW5jZS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHF1ZXN0
aW9ucyBvciBqb2IgdGhhdCB5b3Ugd291bGQgbGlrZSB0byB0cnkgdXMgb24uDQoNCkJl
c3QgcmVnYXJkcywNCkZvcnJlc3QgU2FnZQ0KTWFya2V0aW5nIEV4ZWN1dGl2ZQ0KTXkg
UGFja2FnaW5nIFByby4=

