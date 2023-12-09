Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D210DF
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 04:46:41 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5d279bcce64so27352847b3.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 04:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702126000; x=1702730800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2lrvau3ZqZNb5hhh4gMxPGisVLAG+opCnVnv3w2VDA=;
        b=ZJqQwb43hOLpY+ZsBfMnXxCKOQMgBJhgOWWAEVbrn/V0b38G3hHBLJ9pXqMomH4+Tt
         +iDzwtkzXMwh16E3IYCLSPNa3ORsBZZ3TiL8qOx4XElbXvR7CNL8JpFPQXLgTxczi4le
         ku+Md/QCi0ct6AZWHcJDZn9xIqXZ1+MkMuJYfW80ui1wTXqr7JCCK4Ij0kDdk3Ptsa1c
         RlKRHfaeYuZiQyCd7jnxF0VHly8FnA2R5eW79RCe6eAhqQ0MaI6wXaASeiLn1qK6r11U
         pehTUi3Vj41wGJzx2ueaUPnL9t3OyR5m3l01vWzm/7vKWyZwKG/ODh/uHMX4GugjKKno
         ye6Q==
X-Gm-Message-State: AOJu0YyPY3TosJc70YWFeO7CPpoqiwzRfF9MZ3DAxI2Nj5Gx+qDzUHaT
	qSFmUanqjeS8iHdLvlIUrozS3uisbVhNqg==
X-Google-Smtp-Source: AGHT+IFyE0YlQwlezRFGT2kUf0qWfwtSsLAvH2qUYO2hUby8OBDZYcKwbr5sgoKoYTI1jIVXyuVZCA==
X-Received: by 2002:a0d:f846:0:b0:5d7:1941:2c1b with SMTP id i67-20020a0df846000000b005d719412c1bmr1154897ywf.72.1702126000006;
        Sat, 09 Dec 2023 04:46:40 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m13-20020a0dca0d000000b005dde6b96d58sm1432773ywd.27.2023.12.09.04.46.39
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 04:46:39 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3232527276.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 04:46:39 -0800 (PST)
X-Received: by 2002:a25:ba51:0:b0:db7:dad0:60e5 with SMTP id
 z17-20020a25ba51000000b00db7dad060e5mr949324ybj.114.1702125999468; Sat, 09
 Dec 2023 04:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
In-Reply-To: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Dec 2023 12:46:27 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
Message-ID: <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, 
	Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
>
> We have been working on a new initial filesystem called initoverlayfs.
> It is a new filesystem that provides a more scalable approach to
> initial filesystems as opposed to just using initrds. We are writing
> this RFC to the systemd and dracut mailing lists (feel free to forward
> to UAPI group also) because although this solution works without
> changing the code in these projects, it operates in the same area as
> systemd, udev, dracut, etc. and uses these tools.

It seems to me everything you described already exists? If you want to
avoid having an initrd -> rootfs transition, you can already do that -
the initrd code paths run because there's /etc/initrd-release, omit
that and the transition/phase is avoided. If you want to have an
overlay with r/o images, you can already do that with sysexts. You'll
need to reimplement and maintain separately TPM support, LUKS support,
fido2, etc etc
