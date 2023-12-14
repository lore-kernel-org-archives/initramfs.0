Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxGoK7IP"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D0F5
	for <initramfs@vger.kernel.org>; Wed, 13 Dec 2023 17:18:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5526c14b8f8so175918a12.3
        for <initramfs@vger.kernel.org>; Wed, 13 Dec 2023 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702516688; x=1703121488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kD2fUH38/u1SVt0cKFgcmeVEMNP7hwD5JmbtVr+wCk=;
        b=VxGoK7IPeTqOb4ZgB8SdOlc0hkDvYzGhSjvqCcgbNNOdRn3GoALGuD76dn3Xv+EjfL
         yw0ServHXooGOfnUeVhdxIe/3YCdAQ7oOImvTt1H8xiY/5gqkzYwsXfOKma9oDYi7zO2
         gIkjCvZ8JJNjr3ueEOZ0XqcaVuRQ05st2wYBFBA1LIEKgSLFHOZJFWdep7O8iai3pU9B
         SAqKMpOK5lCzIiCnuODAhyr+Dh9UeLLWPPrCDvn8/iVW0tYBY47sTW1XJ4318Wwa1XIX
         M4b+xUUe1jb/QvEMDQWqb3Wz4RwSXlXQ7IVlJk3HTeH7mkLiDlKj37gH1iC15Huc9h3T
         GQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702516688; x=1703121488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kD2fUH38/u1SVt0cKFgcmeVEMNP7hwD5JmbtVr+wCk=;
        b=bubX48RZarnFOVnR6rey5OUBbwZ1oW7LAqX33gYmkQtBtxYnxzqjrjhHHEqlyAYtZQ
         ygSgUCK7iuc9wU0zZ7NvHByfUJ2wwUnIMCymEJu5NhLfkl3rWJT/RP7vQ5orCVyVqtV9
         mEL8jXhfC2GnLjw2XUV3cRrcrA24XRWNQ2EtovLJpjwCLjImrffMnZ/aRufm4+Jr3C6e
         HKYsmKXLt8+8JQqzyObfNAMr/iMiCcx0pic1JM4vxtsp9Zx0yqzsuMXdwuT26Wkg64Ei
         MmVP11FNcX6kqrWvc/H6DL5ZxF/TDZmhNMEmj4ePEe1cP5hfsVCgscZv/OyKM84WQpXs
         hY2Q==
X-Gm-Message-State: AOJu0YzDn0ICuo4/+hN7QrslsuyDbrKRxR8DZnMWJReK/Ej+a8ZCt0Ht
	jT1clrtccLWnbeAzUq1N7WQHq2vcdptK26whpz0=
X-Google-Smtp-Source: AGHT+IEgI/5AAi7LaHNHZwCxfHP62hB/xQV4OODvmB31UFIv8H2iN2wTQNrLXoz7pwjOSRZCRdLcwd9vTxgpgtDu7JA=
X-Received: by 2002:a17:907:c91a:b0:a1b:853b:93f2 with SMTP id
 ui26-20020a170907c91a00b00a1b853b93f2mr1896597ejc.26.1702516688250; Wed, 13
 Dec 2023 17:18:08 -0800 (PST)
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
 <ZXjKagDbAWpkKgOz@gardel-login> <CAKkJDRcZkcebHKMqgyjRP8Veu1dGjfwE5pUG+smwHfop2biQ0g@mail.gmail.com>
 <ZXlzSydKiEG_KNzx@gardel-login>
In-Reply-To: <ZXlzSydKiEG_KNzx@gardel-login>
From: Nils Kattenbeck <nilskemail@gmail.com>
Date: Thu, 14 Dec 2023 02:17:51 +0100
Message-ID: <CAKkJDReTmx2pn61+BQyhmo2=g1b3y0nyO00rZ7JwpOwRT9Wzgw@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <lennart@poettering.net>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Yariv Rachmani <yrachman@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:03=E2=80=AFAM Lennart Poettering
<lennart@poettering.net> wrote:
>
> On Di, 12.12.23 23:01, Nils Kattenbeck (nilskemail@gmail.com) wrote:
>
> > > sysexts are erofs or squashfs file systems with verity backing. Only
> > > the sectors you access are decompressed.
> >
> > Okay I forgot that they were erofs based and mentioned cpio archives
> > so I assumed they would be one.
> > Do they need to be fully read from disk to generate the cpio archive?
>
> erofs is a file system, cpio is a serialized archive. Two different
> things. The discussion here is whether to pass the initrd to the
> kernel as one or the other. But noone is suggesting to convert one to
> the other at boot time.

I was referring to the following line from sd-stub's man page: "The
following resources are passed as initrd cpio archives to the booted
kernel: [...] /.extra/sysext/*.raw [...]". I assume the initrd
containing the sysexts has to be created at some point?
