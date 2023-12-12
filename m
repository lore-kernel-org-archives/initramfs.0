Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3t//kIS"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13485AB
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 14:01:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso6420113a12.3
        for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 14:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702418507; x=1703023307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JRxWXMu3I15Rrw2eDCVuJda5IS3I3ST1+m2T+/GulY=;
        b=a3t//kIS2fEieLyJkectWfaj3t5e1ZqFQOwxqVNDRn0nxP1/SlFd+V0a02VKTfi45T
         cwErDh3ARRE6LPlJQ1Khvg89XbGW+7VNWpCj2MPN4okiCt1w09lVKqFgh5vzG5K4axAm
         6Rtp+DTNPvTU630YCZmcHv/yhYryBCIUwf9QPLMxfmH9nEzF5/oAjm7tH+1FSQo9PZ4K
         qnRNwIABGt0MUUx4FEWcar+0ozSmCus0ZFdbYxWgOgiZsBJAmZiueXpbeW4i4K90UUJc
         ysmp2xJrdgxySZKBG1SW8CxRThBcbHZ0TKs8UdOSd/u99Bnj+RKVspzwfIWYWouLHWUR
         /LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418507; x=1703023307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JRxWXMu3I15Rrw2eDCVuJda5IS3I3ST1+m2T+/GulY=;
        b=ab8rY/Pb7BJqEXslh8koeU+IMR+nsTYYR2WfeyQ0E9b6XV8bvAkfgFM3GrTkHO+7AT
         LTdKiYdTpjNlG8h4nPSaIWT9FEGZ2V9nADb/64qLWsXbMAnDPQSjWMTXeIjj25aqAXVG
         quRSCebVtBGA8XO4pScTk5RZrpZz0CEu8P0Yxb1idoyiDdnebmhm+WyEOCVPPgM8eDA0
         hxwggO5A+jN9qiu4FciTpxZRS+/H7dUEN2Ar2IJv9DjQ8l3PcxyVws99PhVw+7yoXELV
         26PMmVkWWMszjKi/W+XN+cTOvFu4ENyZoX4XO2v5Ew751M3a3UGvxwyabZFtY+ltxsJb
         tkVA==
X-Gm-Message-State: AOJu0YymSJlfVrd+bZSm4MAHdLse46dppdrKqAxcYBzDQPTId1m4MkqZ
	OqPGQJArs4IC58Bkqjjab1sWzI1/rCmForqUFPA=
X-Google-Smtp-Source: AGHT+IFeYim3wyPTw3tDxTdXtTZYHtWwOUvTlWazlZVMn/JTkmXu3AYmK1iRZoIn+HQY60/CUoUqLhNli1zqbcQlWr8=
X-Received: by 2002:a17:907:6d11:b0:9e0:2319:16d4 with SMTP id
 sa17-20020a1709076d1100b009e0231916d4mr4046294ejc.40.1702418507251; Tue, 12
 Dec 2023 14:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
 <ZXifwMan02j9M3n2@gardel-login> <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
 <ZXjKagDbAWpkKgOz@gardel-login>
In-Reply-To: <ZXjKagDbAWpkKgOz@gardel-login>
From: Nils Kattenbeck <nilskemail@gmail.com>
Date: Tue, 12 Dec 2023 23:01:30 +0100
Message-ID: <CAKkJDRcZkcebHKMqgyjRP8Veu1dGjfwE5pUG+smwHfop2biQ0g@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <lennart@poettering.net>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:02=E2=80=AFPM Lennart Poettering
<lennart@poettering.net> wrote:
>
> If you have 7 cpio initrds then the kernel will allocate a tmpfs and
> unpack them all into it, one after the other, on top of each other,
> and then jumps into the result.
>
> if you have an erofs and 7 cpio initds, what are you going to do? You
> cannot extract into an erofs, it's immutable. You'd need something
> like overlayfs, but that would require (at least for now) an
> additional step in userspace, which is something to avoid.
>
> Alternatively (and preferred by me) would support a mode where it
> would unpack any cpios it gets into a tmpfs, and then pass an fsopen()
> fd to that to the executable it then invokes from the erofs. the
> executable could then mount that somewhere if it wants. But this would
> require a kenrel patch.

Such a kernel patch would likely be the more advanced method.
I also saw that they now wrote to the LKML to potentially discuss
something like this.
The method with an overlaysfs would likely be easier for init systems
to use but also less customizable.

> > Even if everything is the same there are codes paths which might not
> > be taken during usual operation. An example would be services similar
> > to the new systemd-bsod which are only triggered in emergencies.
> > Having these in the cpio means that they will always be read and
> > decompressed.
>
> systemd-bsod is tiny though, less than 8K compressed here. Not sure it
> is a good example.

Yes that is right though it is the first and most universal thing
which came to mind.
A better example would be something like a fleet management SDK (in
Java or a similar language with a runtime) which phones to a
management server indicating a boot failure and publishing crash logs.

> > Using sysexts also has the drawback that each and every one of them
> > has to be decompressed. I might be mistaken but I expect that this
> > will be the case even if the extension-release in the sysext results
> > in it being discarded which is obviously another big drawback.
>
> sysexts are erofs or squashfs file systems with verity backing. Only
> the sectors you access are decompressed.

Okay I forgot that they were erofs based and mentioned cpio archives
so I assumed they would be one.
Do they need to be fully read from disk to generate the cpio archive?

> Lennart
>
> --
> Lennart Poettering, Berlin
