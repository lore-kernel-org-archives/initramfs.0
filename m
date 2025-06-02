Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F579478
	for <initramfs@vger.kernel.org>; Mon,  2 Jun 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890774; cv=none; b=pwQ/pHpK/mdSHmUajZKLBKnxOV6weJ2C3DZL+9zq8Qq6yMI0qllCAM1qUyyeYRwypyQaSJD1O2a4uoPKirm/rQI6X/P+vmVkcstc5kj/RQy6LFtTTLhmzFoLLMH7Qs7r9fLxj8wdpBUYA4L+QfWMgmQtIyNVlnEAnNVLeX82Brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890774; c=relaxed/simple;
	bh=VHh3yfwYBCrEn3aLRyHU/0WXZCEcKfejXJwEjj/40og=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F5Gh77wVkaJUOxrK3k8bU/c9xPW6FkeNNIZLv717uizSj6oxkIhp63M+0O3Ebjr+Sx0fLCx6xbfaeL7bM16Djc7zaO2b3YRcg7uKDJ5OHD9sqkaXlRVpirtDGWVRl8XJZKS0FcXeL6yc4bII/Z6k83I1mH4oa/AxIhIpX/IOZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifeQd2Yq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifeQd2Yq"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so8892213a12.1
        for <initramfs@vger.kernel.org>; Mon, 02 Jun 2025 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748890770; x=1749495570; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VHh3yfwYBCrEn3aLRyHU/0WXZCEcKfejXJwEjj/40og=;
        b=ifeQd2YqFzhzsn+UM23y9ghj678NOIoxcqimmGWue4NgeZzGleYj9a5QRQqT9xvrJu
         UUMzA29GzgLdnGVzhB5D6h4Arf2EDdPI81gUmv23ECPfM6vI+AhxAB2M/nDnmyqLSbyB
         9PXXIJv/y2Z/2Eud908Fl7jaZmk6R8XhRDRn8Y45TIwN1wjRoH5nNcTC1oCluV489vga
         qSJk4MpkS9pEqrpVOsWwUMRwgrwdlRkkhbIpCr+jXznnpocjwKjnVsfiZOgWl5LS/Gea
         QZ+RNOGZJTTpinrCfh+ypzzqQcruVvWzq7EiweVSdlmYRgTWZpEv2+qyYZqP56hzB+Ve
         xTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890770; x=1749495570;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHh3yfwYBCrEn3aLRyHU/0WXZCEcKfejXJwEjj/40og=;
        b=Enu1ejjWe7doiaTsWvEpcK6vQM05uQnnTosyC/PFR/FNrZ5ZCl+4w5sEG24irVe0fv
         tEhOmpTAI3HAcSm/+7VJKIxEK8LAuKZmzBNHXVso8eCwfidNjnfG8/roTyoq6pdyEkVT
         EpkTX8Nl+VE5UmDoBowxGNk2q0qPgGSyUEVqWotpe9xHtg2T0ZnJsoofR2AQ6jZI3Tnd
         Y8sWbOJUQx2J7J4fOimtJnJ9rXUacTuYQU88zOq3o4sqJ6Tsb21VcWG2Fzi0/4RWE+oo
         mAFCbELAY7mh6k+Wfnxp9RN+LQ6s0K9rhetdT/EaQnVUCt4w35JNxPs+AU+/0sBjon2F
         LF8A==
X-Gm-Message-State: AOJu0Yw2HmrFHG3M/vMxNaGgiEaVpob4tf0qkVPHA1HKTX7dRktEdy8K
	JkZ9zarVOhLDMk2kifskMJevckdR0P7HVINupYq1ZuvLqlc4JnMoY65IEE8qEQyszYqwt6vLtTx
	xCPixnbo9AMN6pYGIY5Oh4mSaCZ6+0zwAnw==
X-Gm-Gg: ASbGncvSHeQD+8PV1EXgzTI9fYKvfST0bSNJOKuYlQCScUBP+6YWWjK0ZXQkAXLa5ch
	Wwq4LqU5JBlLjLES4d46smHo/GwbgtIs/XGlXAkLCCDgJ5oTUNsA5YVlR6Svtvrjxt5xVraMMLM
	cVq9Ad2GFRtOyiIgAsd7edHLF1rj0DDER52m0TJeyq8kFapfx4ltoBzLI3YB/3H6s=
X-Google-Smtp-Source: AGHT+IEPszmhAMhQ4bHdwFd9zJpfiNrOlISQ+W4+TBh4xnOTPsoDiBT83d4nEuTuo3HjwSRL0L7vFVMVBfp6wU63d8w=
X-Received: by 2002:a17:906:6a1e:b0:ad8:93a3:299d with SMTP id
 a640c23a62f3a-adb36be2359mr1192260466b.30.1748890770057; Mon, 02 Jun 2025
 11:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Merrick Geoff <merrick.mypackagingpro@gmail.com>
Date: Mon, 2 Jun 2025 15:00:49 -0400
X-Gm-Features: AX0GCFsiSMWa1nm5PAoce4pBplOSeEnueH_Ts_9AzcXnc5A_vMyC0RG09DheJ3M
Message-ID: <CANuX7KUfjanj3kw8-qkjpOZvQ6OiZUiK1znOwOpH1UjMonnLRw@mail.gmail.com>
Subject: Personalised Bags and Boxes
To: initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We make personalized packaging=E2=80=94tuck boxes, CBD boxes, mailer boxes,
rigid boxes, bakery boxes, retail boxes, shopping bags, label stickers
and more.

Simply provide us with the dimensions (L x W x H), quantity, and
preferred box style, and we'll provide you with a competitive quote.
Plus, for a limited time, we=E2=80=99re also providing complimentary design
services and shipping on all orders.

Thanks, and looking forward to potentially working together.

Best regards
Merrick Geoff
Marketing Executive
My Packaging Pro.
