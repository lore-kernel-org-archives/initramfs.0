Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+43kwrf"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322FA10E7
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 06:56:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f575d4b2so6827111fa.1
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702133798; x=1702738598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mf3m230go+hstXOTf9ankcbYCo0D3jAopeLS2IZs3GE=;
        b=G+43kwrf0C0EWNgabNyilN3KF/VKl3w+lDLx2hWTXsNbpWecp4uqUS6nleKvSvrqT8
         7lqy0UAhgkfCswOjvPQjRuz1LX7qH5SEofoCrRoSvl7w1imd9DwC/g/xMRbz2ZrOTeFP
         MyZmJ1ucCncGaTICMKvd2wr/paZQs2G2IDAsg6acsjcC3WUtskDLoCSvQprCCFtYrHtX
         BvVjLK7UEED6jshsARVqCw28zEAG/a/LRROJtebxIj8vpS5caUCNPOX9QAZPsJJoN9ID
         +77V2DrprUsDAFCOPxiERLq4sGHShEhTREkQkNoz+Cl1kuVMSYgfpAS4jEY6iOC0Phnt
         NcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702133798; x=1702738598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf3m230go+hstXOTf9ankcbYCo0D3jAopeLS2IZs3GE=;
        b=sRTu9XSJVk4sPZtIt99W9ZwjOMrwKp6Sgy8sj8gq6Tp72Qoprw08bcRLEe9T2R0fe0
         qO20qtGTlyUh8t8pA0QStaAIqdN/GRDh3quSEPFQmT7rbeFEGhAn3EW8T+v2oWC6gIK+
         Xh3CEGZzUd9YQQmUXaKRWcZn1BBpI3V0BabZiMKaUyQls42V9EAyKKfIPm4FtR8/hSDr
         yDqaNToTUIO991OgwcvsgAkNAAdfNNE3DxYWT2/Y9eOOVL4t1KLNILdH+dsDy9eP7aNF
         JFDRA3lcGOv/AVGhq3yRwNMsKC4ycFso6Xr3x0SmzH5JMtP/0tDWVtbE/gsijOhz0U6Z
         4qyA==
X-Gm-Message-State: AOJu0Yygn5WfwNeyD+Lpf9zkmV52B3u8AYLiQQCJnoviNLSGdjiHClk8
	R+sWUxoVz+zLKrkyZFmGMT8=
X-Google-Smtp-Source: AGHT+IF0rDFGcK9lsnHNzN5SG/VpCiPxZXPgShLvgEnLoUe1KF5UpSu++uH2lyZ2M+/XVYPS6V4psA==
X-Received: by 2002:a2e:720b:0:b0:2c8:8326:bd7d with SMTP id n11-20020a2e720b000000b002c88326bd7dmr1336652ljc.0.1702133798086;
        Sat, 09 Dec 2023 06:56:38 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:2474:c9a2:7c3b:a03c:4a60? ([2a00:1370:8180:2474:c9a2:7c3b:a03c:4a60])
        by smtp.gmail.com with ESMTPSA id u25-20020a2e8559000000b002c9f454f51dsm573264ljj.128.2023.12.09.06.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 06:56:37 -0800 (PST)
Message-ID: <ac1728d2-1e85-41fb-876b-adb98f0d2dff@gmail.com>
Date: Sat, 9 Dec 2023 17:56:36 +0300
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Content-Language: en-US, ru-RU
To: Eric Curtin <ecurtin@redhat.com>, Luca Boccassi <bluca@debian.org>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
 Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>,
 Douglas Landgraf <dlandgra@redhat.com>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
 <CAOgh=Fz9aVO3p=tWQuTtQf-+91dRxyFvNjCk9CGnzvbHWE0u-Q@mail.gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAOgh=Fz9aVO3p=tWQuTtQf-+91dRxyFvNjCk9CGnzvbHWE0u-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.12.2023 17:42, Eric Curtin wrote:
> On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
>>
>> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
>>>
>>> We have been working on a new initial filesystem called initoverlayfs.
>>> It is a new filesystem that provides a more scalable approach to
>>> initial filesystems as opposed to just using initrds. We are writing
>>> this RFC to the systemd and dracut mailing lists (feel free to forward
>>> to UAPI group also) because although this solution works without
>>> changing the code in these projects, it operates in the same area as
>>> systemd, udev, dracut, etc. and uses these tools.
>>
>> It seems to me everything you described already exists? If you want to
>> avoid having an initrd -> rootfs transition, you can already do that -
> 
> You need a initrd -> rootfs transition for generic linux operating
> systems right?

No, you do not. Nothing stops you from running off initramfs (today you 
do not really have init*RAM Disk* - the content of initrd is unpacked 
into initramfs.

> Or else you start building all sorts of things directly
> into the kernel which isn't really scalable.
>

See above.

