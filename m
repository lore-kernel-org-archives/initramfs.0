Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10DE54B
	for <initramfs@vger.kernel.org>; Wed, 21 Jan 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997238; cv=pass; b=lKpf5qQNgVu0Dufnuyj7OlF6tiSNdphcsLCipxkFlTk5uhqTwQg//AOZFSb7hviSc+nTyAu7jeMufM4TabfuTrNyPHZMWhkVkzXu/KSHYSAX4g5KgfZAv2sdnCwzst8/by9HiLS+qVVPdLUvfOD1tuf5Jaqwjmr4GXYLcMQmcnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997238; c=relaxed/simple;
	bh=va9si66N2f8grY1bQ1s8K3JigyfuRelKdqm2qCtf9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM0J4kATZj/JAl8BGaAbUJhWXrZJnyMuOmpkldHT8Jb/1LbYfYxt8xFVMIPu/9KRXv9N6COLm+G5QPubSYUpviaBGpYObxUB+qItZgmmm0GUosAAoirFCEKmfF6wSJSghamNFHO4gTbBUrfr54yIfMqIs2heQvoI1RfFo87oTgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redcoat.dev; spf=pass smtp.mailfrom=redcoat.dev; dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b=2ao2XUt0; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redcoat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redcoat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="2ao2XUt0"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233b172f02so7965713c88.0
        for <initramfs@vger.kernel.org>; Wed, 21 Jan 2026 04:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768997234; cv=none;
        d=google.com; s=arc-20240605;
        b=Jtn3Uvy0WhWQ0M56OadKgYAET2XWUOHmj6sQJ8DaKRKP5zWkgWNcEdE0vHINy212Vz
         5HyaIVEoa/1eVFI9iutX2YbMcFc3WGe3rfgs86vD7M96Gps9p/IMh7d+LNqcJDxI/iNA
         QY81w0K+qwfCzRgRnx9F4LrLcbWJdWiwdH155VgnP+WT+A60gBT6jCsxKWoGtTMbTnPo
         VwHZuxXXVESS/FYcDmR0LM4WmUnDWvKbX4YpjxWiFVs6AIO86xqy+VEUx9nkFFfd9jId
         pUnPyZrXmuJb04Gckk32PXGMMcx98q3YfRw1uibflHv0pXLRtZ6efbAMsfOhwV7xiNSE
         ioqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=va9si66N2f8grY1bQ1s8K3JigyfuRelKdqm2qCtf9lk=;
        fh=hHw0wD0aZ6DmgW3aUy2ygm4JHTuEj5xBjPkdk3o68vc=;
        b=jaM4IjzfhhtF9xvvsfZeZ/3csiDxoVCdm7wDaPn3hLzCYoIvNbQg1vxyUDNtXBVR5T
         wH/71Co1hGBHk5tgLROghn/LqziOwX2ymuJcuLgw8e77MATkC5dY8Fp5vzZoEe8uC6FI
         RIy5oFXpHIkUF8wEyIz+uzcl0rGcswk5BZfzBk9mwqXkcWvQIyXG53Nh/Pzex3jy5F7v
         QSx8DNJopolbFcBw2YSjqWsAykTqfkCd3qxoi9z9YhlRUk8s+lF5PBNDmCnkqJU/hJlF
         s5vf8J3EojRPZS8fAaLriz9QjO1Rjc1AlGGMRziUorGgFGAi5+Yim+QPybpqwyrK0Coo
         oVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1768997234; x=1769602034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=va9si66N2f8grY1bQ1s8K3JigyfuRelKdqm2qCtf9lk=;
        b=2ao2XUt0JmPnLTPlDyRQTAvnVtspFsfN4HMdjdjSZumlJLrhSJEfeR9sWfn51EW1Y0
         6ZGbwzMhwLfDIRc+JlqqskAYuiJMLfXqEsaPl3HijQS+65EYInIhJH/s6OEg65c8W7sk
         bAj6h+GO3yiT3H8DHXP6UKWmRNatgWC0lEcReHMK/NZ5XhW5Hy+h0z3XmqonV3tMXzOw
         9vSk634CGF86v+oIOoUYLGxe64CrmpDSIAZyRka4tOHGM0soPIWKgy7Q+v8/Wr/zlssS
         ayvwfPN3T8Kqq9OQryLGPBIU+1E68hIiYdWePnn6HzC6wraMVeECCvPW+XSrFPXD1U2/
         qbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997234; x=1769602034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va9si66N2f8grY1bQ1s8K3JigyfuRelKdqm2qCtf9lk=;
        b=S5O69rLDZwvtvr2/9d6P19Q7ZTHntGF2HfLBsLCRBlAT5m5shqgro0pwAADzXFNl26
         sZxivMiW3jyU4/Pj7F9V8zVmBuTp5qqlXIH2UmEGnyTmIGStQsYoHiJt/yooi7iFUZfS
         xNivdHJAOVi9K7R9nMv+rhiNr3W6FvOM5MezVyWgHBAYeCmVyqBYo6zAjfLZmcWSF8is
         hCnQtrjwl41b4WQCVyie4b/PlCLLW6c5xSjgO2wuJNgYtfXbeXwiqLaP2CjsrtYKqh0o
         ySidIEfIXt/x2HFBUoa9CR6G1yZDIEKKNEGUVuqsGua1pFy5qzHUyvsiDO/r6cCh3o+c
         NYtg==
X-Forwarded-Encrypted: i=1; AJvYcCWwzNuBIv/vZRytPYHKu69ss/PeymUqx+zKprQeOlURfqO5SjUUAXXz8E04YtEmCISCJmoZRa4PJPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+ov3Ew/+pKGXf6Z//R5QvKxAVFjlLsedjZ4hLUmf0Y61LA/u
	hGeAWPGulpNunx39sZoJ35lfcYNw3nh6uRcEqMb/slu7T5FDklILjwhuAHlOJ390jt1qOAXJaDs
	goZsKqomM35K1jot+99Z8q8zomXt6HpzsU2FDCr5SoQ==
X-Gm-Gg: AZuq6aIq5M0gm7AQWFlfUK8/H/jVR2MXTvKbg7RFWrqgsFJaBAmhBY59pg7vATqmvBt
	AhPS5b1srdO5ShAbfRqrDOyeqfPgVmpGsBWGNAuqrgNhX9GQx1hIHCZlvb1K0ajp5aLu3azLtoj
	kH5G4D7ouF9511XiEPWsEKro1R9A2eqT+ZCpVAX64SCAp/a7ud/cnRboOilrAuhA7YAbMDbtZI2
	PGYZAej5iC/7APAY+4lh109ysK2bBRFDmQpopEzdQ5WinOwpsdDHTzseH0sw4MYn+9bHzWoapSJ
	doSFiGpVtT/SwXhExLLCTxJXqPhEFg==
X-Received: by 2002:a05:7022:394:b0:11b:923d:7735 with SMTP id
 a92af1059eb24-1246a9583ecmr3095802c88.1.1768997232768; Wed, 21 Jan 2026
 04:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net> <20260119171246.3218393-1-safinaskar@gmail.com>
In-Reply-To: <20260119171246.3218393-1-safinaskar@gmail.com>
From: Emily Shepherd <emily@redcoat.dev>
Date: Wed, 21 Jan 2026 12:06:49 +0000
X-Gm-Features: AZwV_QjOPdLHn6kNOVYFpu_9st-K2EhtndgQs0PykyM1UgvOTB_41wVXBmYmVRU
Message-ID: <CACHV8Xq_QAYp+15TSHBFRH4gnBnfqPhUfccnKmrtaVKcUaAJ5g@mail.gmail.com>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
To: Askar Safin <safinaskar@gmail.com>
Cc: rob@landley.net, akpm@linux-foundation.org, anders.f.bjorklund@gmail.com, 
	axboe@kernel.dk, giuseppe@scrivano.org, hch@lst.de, initramfs@vger.kernel.org, 
	t+github@chainguard.dev, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Thanks for flagging these patches, Askar.

Adding an immutable rootfs [2] does seem to achieve both what my patchset
was aiming for + some of the extra suggestions from Rob, so I am glad to see
it.

[2]: https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

Emily Shepherd
Red Coat Development
