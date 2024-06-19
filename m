Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB634137747
	for <initramfs@vger.kernel.org>; Wed, 19 Jun 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798119; cv=none; b=WFN5SjEKxxL8Gbt+3eHgr86Y3ozGH5BOIkjnT1iFgAAbG4bOPEJQMiHpo4RnHYmmk1u5XtntrdOc1KZSv2xR1DNh/pLfpw3KTFzL2mKXAmZuidmKP+yJKsZUqtbdu0PRrHZG8MhmBI6R/cpXw3/b2+MsNrB5RlSMTN5jEuWojLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798119; c=relaxed/simple;
	bh=9nmbPMwO/h6VYTpdV94EtYkHVFAL0ps2iLCnrYpV2Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DOeVpBnZG94JDEYj6gx64GG1jPrKlkzbmTYSCjZSO++wTp1BKyjgW/+hVvJZdHC9KuLu9Ud9foaKENJARaAVHnUbuTNFFdmxLjwySopy0ZkNSK3Mpcpvx5LLk332ko7KaeYw770YvO0G8mqv0VODPUNV5ExMgdAKZ/Tr0LyNtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKH1rv/p; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKH1rv/p"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec17f19386so3927511fa.2
        for <initramfs@vger.kernel.org>; Wed, 19 Jun 2024 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798116; x=1719402916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmM0UxLuRjf8lNuL8maFdgXxbZZAwAXd9wCbnPyKtaI=;
        b=nKH1rv/psYi9a3zKY7+Ya9vOndrsEH0h52ls9CPrrVnhzrQxQ/2Qc0Fi8d3yAbsGHK
         Hyl5h8lv9NNEjDa99jBPVgoSa25gArcnrC6vsYm9m3jS2AouUVK7XXBPq93xj7kLBe96
         0BZdW+QUVRZ7vpBLeIt2bU/hmxszOoOF9ccvF120Um7mAHWUl57vuNkCTPh4ZjRPOUz5
         LMbh3vzL23K8a8KJno35UlgUea0hRuaeO7gq3Kh7ES2DiOHJNUD8qVa2dL0vMERkYV96
         qSCkRuGpd1T8r/8ndZ29qKzkcYZtssetvSen6J7thpph8Siu/akNxMSaPf4Hhs6kVTks
         +Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798116; x=1719402916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmM0UxLuRjf8lNuL8maFdgXxbZZAwAXd9wCbnPyKtaI=;
        b=AEpFRBJC85WdKqo6qx450t1t20EWgST1kiy5Sw1UuGoSXBgwkHTgPpVS8+hceFyMjx
         j9jcVOP8NB/GtyPz39LlQBu/8LQc+xn+UjYYsO0xeg3JwfUkJwCCU1sN2g6CJuMUBf6k
         tc0F+xmx3eFCR/GHp7y875ZRSgz2N0qPASyRS38oJ9A1wGEmY6AUi+QM/ESnfyXvV0Fi
         IIQPkWqfVgswTVteNTmxnT5lzcSzjgS52ULR/bzQAx0PUs2yAkKd3XMUWfCNhUnZnFoe
         NzXF7LiHI99hy+cfwk9PfH6g0ONH8KUXKOPj9flaPHcV7ZIseS0sYxGnx0IAIGB8NH2h
         BecA==
X-Forwarded-Encrypted: i=1; AJvYcCUJr05eED36+O0l/yet3hOlA+FxiH/lI81jXhwg0urAlN6m6tYE8+Mk+b/0S5BgWIZ8qoIByxPfVsHBXs0QAtYDpc3w76mVHD3I
X-Gm-Message-State: AOJu0YwCJTJtAcZdczqFqs0G3YEp/sWU19P6DfTD9aOhJ2FmZi7Ay7AB
	v9LBJ8lBCfbaSZEjbeGZk4BQ8izS2YLqfn+K+Ht1W1jKhXv+MSqy
X-Google-Smtp-Source: AGHT+IEHdLutl8fk0RVr4dkWK14hl61rQSXllm0+GxOcVXjmq2bbsnCRoE8DtivnSGOI2tVdFZIdLw==
X-Received: by 2002:a19:4306:0:b0:52c:7f39:b3b9 with SMTP id 2adb3069b0e04-52ccaabe8bbmr1061336e87.6.1718798115557;
        Wed, 19 Jun 2024 04:55:15 -0700 (PDT)
Received: from [192.168.1.110] ([176.124.146.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2889d38sm1752083e87.303.2024.06.19.04.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 04:55:15 -0700 (PDT)
Message-ID: <3e5f74f5-3af5-4368-bfa6-b436bd44c1de@gmail.com>
Date: Wed, 19 Jun 2024 14:55:13 +0300
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Load modules in initrd
To: Carolina Jubran <cjubran@nvidia.com>,
 "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>
References: <BYAPR12MB3318839A4B6BE11ECB13E06BCBCF2@BYAPR12MB3318.namprd12.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <BYAPR12MB3318839A4B6BE11ECB13E06BCBCF2@BYAPR12MB3318.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.2024 14:51, Carolina Jubran wrote:
> 
> Hello!
> 
> I need to load RDMA modules in initrd, and I have a systemd service for that. However, when we start running in the initrd, the initrd-cleanup.service kills the service.

You already posted this in systemd list and you still failed to explain 
how kernel module is related to user space program.

> The Dracut arrangement only installs the service if the necessary hardware is present.
> I tried to add dependencies to the systemd service "Before=initrd.target" to ensure that the service loads the drivers in initrd.
> Unfortunately, this was inconsistent; sometimes we load in initrd and sometimes we don't.
> 
> Then I discovered that adding a "$SYSTEMCTL -q --root "$initdir" add-wants initrd.target <our-service>" in the module-setup.sh helps with the issue, and the driver consistently runs in initrd.
> My question is, how does "add-wants initrd.target" fit into the picture with the initramfs image and systemd?
> Do I need to make any further changes to my systemd service, or is building the image using dracut sufficient?
> 
> Thank you,
> Carolina Jubran
> 

