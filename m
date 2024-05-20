Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9017571
	for <initramfs@vger.kernel.org>; Mon, 20 May 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188067; cv=none; b=n02/DHz4/uS4wERxtacvd4/dyynGC7nXD45exXz3DV/AWr7661VJCiaFdI70V0x8oGw7BMd7plLrCe97s1ESd6i/Uh0HptwvFiq53I6orU5sqJ+Li9tbl3aeIy/HhJR0o3ffw1URJMLic296U9nk3rD6zZ1/2HfPZf5kCv2TSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188067; c=relaxed/simple;
	bh=p6ErBNggKyHsPOXyX4Ro5/O57PC+78+ykF+yIHx4XRg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VLYzqi1xBWyPMcpMYlZWXSPu5sJSZrf2DBGF7OJoOIgKblvCC2fei9+ZGVRQdpe9LKdNDl8P///fVP2bGuzDM5jjJX8eL2wt0xeReHMYk0IZ0JD32Icz/tgS5AYO2VralPZAFu+rCuabN7joaMb9cLm03hUKpwldbtEERFfAqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw2ncWSk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw2ncWSk"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-523b20e2615so4620370e87.1
        for <initramfs@vger.kernel.org>; Sun, 19 May 2024 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716188064; x=1716792864; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6FavgatbA7xOhEtBNACzGP7INszs3YM16v3LGpU+mY=;
        b=Qw2ncWSk4Wf1rmWl29ILUx7ddN1JlQ1Oq02pWPQz2FPxGgZkIPhLfL3aUe4xW3kEF4
         IZJxF6vakCkB4Q7Cq7EwQXE3oC5VEZ9vKC4ceHvzCQYJiLosdcerf27HVrnYUH86X/zE
         g5ByFRY+4BFMR/OJhSlPgw8hjXpyxQj+xZmsYpCwj7VzV3RfGvJK8geTDLH2YOypU+xR
         Yzsm/wIcviMU47miupwu0p0QHTIrlr2AXI89jdh5DpDlmI7zQdhJQzYjTlo0mUJ+/OdA
         3KIrsFN0CrsuvWPYv+tYZdsCjJ315liPxuAL3vyrU9OsJKGA5t06tExJTKJk4BIeeoO+
         WHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716188064; x=1716792864;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d6FavgatbA7xOhEtBNACzGP7INszs3YM16v3LGpU+mY=;
        b=XUR43am5/eShJ4BR+lkikCcCccTUWrYRu5xfEo+V+G4xSF2dEm7/Eqqv+yqs+vlmGB
         Dku8u8P+DUovDVWx/L3rQbAZmVXwBCwxtzVhLICK7KCVS1r/iJHyVpHDhdFoBizxa43t
         dl2q4uh+SVhLkx+p8UNNJjmubfGTXsGRkIAA1xENH5QD21BkfkQ6yTOH4z2xnJ3gFD5/
         jJ1IXru/5+qiEINsyRz9xjY/C7dDaqXq9bc9TG+BLcU3PHaWYcER2lnE9GuF1SMbMZ3y
         u1q4IpF0yQFH/4tUXlktI6QmyYi7IBMt63RZeuK2Ccyci+DUlaaM0x3K47vGWycvr2JA
         CN7g==
X-Gm-Message-State: AOJu0YwuUHJGwS1ur7ZCbe/G0xmrVqpnDf8X+fbPwSw9hQ+6kpNVSQiC
	7727T9uudI31lHAC1HklckCn86SM9X9KmtTw2qU+tUJ2CWBQaonex3O2BWgn
X-Google-Smtp-Source: AGHT+IG44t88DwkpLbsc/u50SNPMgAxBsHZMPUEYbh146xDoLECq7fe4Q+S54qr+u/kcVz+2M/K3Zw==
X-Received: by 2002:ac2:4a87:0:b0:51e:2282:63cf with SMTP id 2adb3069b0e04-5220fe7932amr15838330e87.45.1716188063899;
        Sun, 19 May 2024 23:54:23 -0700 (PDT)
Received: from [10.65.13.30] ([146.70.133.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b180c7sm1435091266b.221.2024.05.19.23.54.22
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 23:54:23 -0700 (PDT)
Message-ID: <f22112be-ef40-d3b4-b2fb-5a6dfeed5aa3@gmail.com>
Date: Mon, 20 May 2024 08:54:04 +0200
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Iniramfs <initramfs@vger.kernel.org>
From: Domenico Panella <pandom79@gmail.com>
Subject: Dracut info
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Could I know if dracut can generate an initramfs by a different root 
directory ?

Best regards


