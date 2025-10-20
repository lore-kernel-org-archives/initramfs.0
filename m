Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A41CEADB
	for <initramfs@vger.kernel.org>; Mon, 20 Oct 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976481; cv=none; b=Fw13NCmWYJAfG1B4no21qqORfrGnLm7BICnMcEoDgbK2YKXcg/g4H813j1y6kxGU1cIp3ryPMJ1RyqXXaQf0pojo+C75RpZmmdKY6g5R+Shyvh7HD+s60X2ymNBrY63w75vLUaJCC8g1+RyZZXtirkxRhTvhPWqBZHn/1oOj+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976481; c=relaxed/simple;
	bh=aA6Fh4oj4DlvKPiBtlqW05wJ8Nxj+qGFqUUhKBcxy3w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RaVlHJ4c9ldoa1ayvqxFiNY9rah4iBIrGsRv80s5F5ZR8l1FGYxGyLApav2SoMa6C/MFuA1Up8Va7nOSCQq3EK/k6Dy+sL1BPWph19MggHe/ggaUCiZ7iE3UMlAPmhBICFjiuw2RnMRfqPheI51TdWVl7s5CkeHheYUkI+ZFC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjkEd6LM; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjkEd6LM"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-63e336b1ac4so2070164d50.1
        for <initramfs@vger.kernel.org>; Mon, 20 Oct 2025 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760976479; x=1761581279; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6Fh4oj4DlvKPiBtlqW05wJ8Nxj+qGFqUUhKBcxy3w=;
        b=WjkEd6LMT114m9jlz0OvHHNdAN+86QLQSSdNeJKjt5oJLaDmK1hAWANp7ObZpeHxC8
         0jQsXi2Vj3YtE9/3Pbkk2D7gkPRrc+IM46o+AUq1+dN6z+uNHeN/8RMm++kzFl8zVdNP
         DT5rlmt8wLXCW+kKVpZlST6VkgY5ppk5yse0APp8WJGMRYm8qVxOfgZkduWWnraeJUz8
         nPDBsNB6ev0x0engETnSu0e+raudPt7/yVnIA99rOp2i9lFHT6MhXHix6dpfzCDMDcH2
         UP+rBNet6SNYEscPQXBI+05476GPhn0W5hBeE3WPKadSyagVIywL754BM+Ih52lYOEZI
         acZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976479; x=1761581279;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA6Fh4oj4DlvKPiBtlqW05wJ8Nxj+qGFqUUhKBcxy3w=;
        b=JP8PvBA9V3R5+XQvPcOWj2qG3O1rIEW5V1lpkluzv6KL9Wk3kttxXMmghrb7O0wZHR
         H5K3bKcEXkHph34lkwIiYGGJzIs0oAUrlTpEq4pzRpPKQUamkYsWKRWpNHzg1Z/eRMF8
         +uH+82o93sxpVnK8Lv0XFjiHuoEPbtstexUWYcOOnahHIafQyf51TKtrNBlrExCIwJej
         Vl/P14Ua7oaEBG5RdbRzTx12Bi6CW+56rPSJXlCMyUZQdhBB+M2b1UCa6vo8MT2u+dz9
         6LuoUH4APhGtskqSjJzgba0OjzOtulWL7dKyCl8ZicCUwMdJlFH2iZ0ibXBrK1YpJt4B
         SV5g==
X-Gm-Message-State: AOJu0YzYeV58Yo4fE8q5e6o3qBS6pPASwUgfCP49YJ+KORHH7vnpEN0N
	ypA5wOz2URoEqpU1VCPrwAB3WFeiB3c4e8qFn4KyzFTH/7XN6y5Gz0D3pHmV01mh2pvGiYUSgK9
	mEHYc5GHU4Jp4HVE8gQUo3Jjkjr/rvFbcXee8
X-Gm-Gg: ASbGncsGC2PCBwBV2hNQd47ffVmAGKfonv7yzTCzTjVQNc9hg/lo5InpNa0dvPuJwhI
	fRejHAqZN63dYFCbyqRoRHDNifIr7ji1M+bE+nP+ZdoJOsym9Gz0UZFf8O2BUMv86WybkqAr7ED
	BkIWw4zrtV4njIS1mipWit41QEZhuQjxQ7PFrZiz8twr7qjXQJIcOxHR7MJYdpCZWx2LOwbOT3Y
	47LV1EUlrsrDh2sFJ9WarZ+zcHVKea7f4IpHh3OAm0LFBHWfaotNQB+PStPs+/MYE50ARv0ashg
	6EPSKrjYiA==
X-Google-Smtp-Source: AGHT+IFp0YJ5HrahRhLkI9Ds3ZYA6KfqoRmPnUB3Knr/RbXySxgt0QUT/XfU/FNWSAT5yR1wCre79J6r8AD8UJI2Wls=
X-Received: by 2002:a53:acce:0:10b0:63e:11e4:8b5c with SMTP id
 956f58d0204a3-63e1615c865mr9541328d50.2.1760976478680; Mon, 20 Oct 2025
 09:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Harold Ramis <harold.mypackagingpro@gmail.com>
Date: Mon, 20 Oct 2025 12:09:27 -0400
X-Gm-Features: AS18NWDaSVlgOKZTu8x0QekPTJvZQ9T-RG-akTNGNO9apW-GUOD_tpYGu9uLWR4
Message-ID: <CAJKNRUxfMRYSFvUttjJU-ki+P8=OYk6ut7V0KWy7=Cbu8Mn+jA@mail.gmail.com>
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
Harold Ramis
Marketing Executive
My Packaging Pro.
