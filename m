Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="mlK8j83P"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD76FD
	for <initramfs@vger.kernel.org>; Sat,  2 Dec 2023 15:27:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b427507b7so27712425e9.2
        for <initramfs@vger.kernel.org>; Sat, 02 Dec 2023 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701559661; x=1702164461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1xdE4ovzj76sAVqJy//t2Hu6Y4a/OJtI3z/XB4Wugc=;
        b=mlK8j83Pp3sw3ofd5VcmFIsCcmwokcIvK36Sk9yTw1UmBZSNTtEgOwa03HAIT5ADpL
         PJRZWoyUYaCirtaN0lvr4npXa/hSluRj9BrfXyqDPryDgYNM4RpxX4Kg4DlC/1OCimQj
         S33aDPYR+7XYk1q5yYldnoS3rmV4ZQkPWaQms/vMKthGg2/loh85PPWzoq+AYKaImqEU
         T2RPQKsFcgdeG2kGSsEqameopfBPffKDk8D7zd7NIbm502wrZ57wmrcug5fAgAqmloEq
         D9DePxYsXbGhW79j6xgYBb+vxclSKet8PlZQhknJHKVaWshHdB9U5Xl9A2V9QxQlBi4T
         lbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701559661; x=1702164461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1xdE4ovzj76sAVqJy//t2Hu6Y4a/OJtI3z/XB4Wugc=;
        b=kKxQbPXiK9lNpgcVjJk7wd9G6s+fhHT6eOucUdD0I23QpXZCVw57hqJB0yQp8x2uJC
         7hc5P+fhBydpA6Q7JB+yH4vXTxa/Eg3dFEBJhqsYUvmdPVyndz4wVFVARF83UhMw/a22
         qoPIP2wZpO55BUf348GAdf6UP0cIZIFo71G/F3laurSusEdbtyYCcN3FQySkguhU0yOu
         jPJ2vrj+NAFcy2WEJZjGIq8OTejnDT7nJ4as82bz9Sycfuaeb8+BeHfi6p/6oswW/zYm
         un4zE4eZAXzuhIg+mBYkvLLBLzLUej9tRHdc0oMrmOMRpwIidY2Wp9cPi66LFngnKqtG
         neMw==
X-Gm-Message-State: AOJu0YzoXEqcOSc15GSiIcLis6iwWPMN+zdJHiiZezXxlRBw5X1a45T3
	AhY8E5EcKNtuw7Swv/DsllSMDbdZwowKUDXNrvU++w==
X-Google-Smtp-Source: AGHT+IHlGkZ6KDlDZ5fYpqdV9rLGNch8JdeFVmF3AGvPlW3ITTT2bSHGxrBif21B3jjZRk0OtiwxVQ==
X-Received: by 2002:a05:600c:468a:b0:40a:5b3c:403 with SMTP id p10-20020a05600c468a00b0040a5b3c0403mr1304579wmo.14.1701559660693;
        Sat, 02 Dec 2023 15:27:40 -0800 (PST)
Received: from test ([2a00:23c7:1fab:4e01:4915:193d:c8fb:a42c])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b00405959469afsm10056301wmb.3.2023.12.02.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 15:27:39 -0800 (PST)
Date: Sat, 2 Dec 2023 23:27:38 +0000
From: Emily Shepherd <emily@redcoat.dev>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, initramfs@vger.kernel.org, 
	Thomas =?utf-8?Q?Str=C3=B6mberg?= <t+github@chainguard.dev>, Anders =?utf-8?Q?Bj=C3=B6rklund?= <anders.f.bjorklund@gmail.com>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Message-ID: <27lpybxaozczmjd6hrfkkch7ttjioenqngynoyqji6c3pt6ati@rfabur7kygwc>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
 <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
 <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
 <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>
 <37yuynohcuve46jhgzbz24ip6yb2lqvwcn6gpxwxpw6msgtk4b@7dgqfkdtjngb>
 <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
 <l6s4ngxtj6v7n5z6npcj4gmvr6x6vrvldwsfmyufovrj6teu3r@vajcufu3lltc>
 <ec6d7c0f-8408-ba51-f2ed-2bd068a6f673@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ec6d7c0f-8408-ba51-f2ed-2bd068a6f673@landley.net>

On Fri, Dec 01, 2023 at 11:40:37PM -0600, Rob Landley wrote:
>No, "the perfect is the enemy of the good" applies. Blocking a small 
>fix to
>force a large fix isn't always reasonable.
>
>I just dislike adding special cases. Right now when you root=/dev/sda1 you
>specify what to overmount on rootfs at runtime, so if you're going to overmount
>something _else_ that seems the layer to do it at. A CONFIG_BLAH=y option to do
>a similar thing (changing the semantics from a different area entirely) seems
>painful, especially as a workaround for a self-inflicted issue in a userspace
>package.

Understood.

>At least until the network admin running kernel.org gets his way and closes down
>the open mailing list, replaced by one that only approved people are allowed to
>join:
>
>https://social.kernel.org/objects/9b3adb80-4198-4c86-abbd-aa3c58700975

Haha wow, I have to say: reading the LKML discussion about this is so 
surreal. Lots of people are suggesting features that have been standard 
in all of the git hosting platforms for years like they are new. I 
really don't understand the reluctance to move to one of the existing 
platforms. Most support outputting plaintext patches, or raising / 
responding to patches via email for people who like that flow. Seems 
like a win win, as it would come with all the extra patch / pull request 
management for free.

>I'm weird enough to still _try_. At least in the parts common to the 
>systems I'm
>building on a dozen different architectures. (_Everybody_ has to go through
>early boot.)

Fair point :)

>I'm currently trying to get vanilla u-boot, linux, and devuan 
>debootstrap to run
>on the orange pi 3b.

Nice. My current project started life on the raspberry pi :) I wanted to 
run containers, but quickly became frustrated at all the extra stuff 
that Raspberry Pi OS was running, which was slowing everything down for 
no reason, so I went on a crusade to make a much more minimal system - 
it looks like there were actually some similarities with mkroot! Great 
minds think alike, I suppose :) Anyway, I have now moved over to support 
amd64 too as I realised what I'd built could boot to kubernetes faster 
than AWS' tailored images can, so looking at options there.

>(Unlike raspberry pi which is still
>binary blobs as far as the bootloader can see and a forked kernel.)

Gah, the weird binary blobs really, really bug me on the RPI. Not least 
because the whole point of the Pis was meant to be a learning / 
exploration tool, so having a "just trust me bro" blackbox of a 
bootloader is so absurd.

>The change under discussion here is a case where explaining the design context
>behind this distinction, let alone the decision to change it, is multiple
>minutes for a domain expert to unpack the backstory for you, and hours if not
>days to pick apart yourself. It changes what the design IS. I personally already
>_know_ (some of?) the backstory, but I don't expect other people to, and really
>don't look forward to having to document it.

It looks like this patch isn't going to go anywhere - I'll keep it in my 
own tree for the moment, as it is useful for me, but may play around 
with the CLONE_NEWROOTFS idea if I have time - certainly would be 
interesting to see how easy it would be create proper independent mount 
namespaces (cue: something random falling over!).

-- 
Emily Shepherd

Red Coat Development Limited
