From: Taras Kondratiuk <takondra@cisco.com>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Thu, 25 Jan 2018 14:13:56 -0800
Message-ID: <151691843634.9300.9473350782231091007@takondra-t460s>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
 <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
 <151691200536.5378.11544479301138437367@takondra-t460s>
 <CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=530; q=dns/txt; s=iport;
  t=1516919008; x=1518128608;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=Jkf8NMJxOf9ruJaWwzYOfLDlv2ea8PiCxrtPJWM6X0k=;
  b=IcItVI9edKqKK1CcZodO0gcGQMmfE/eAhZXzRaYoU/KDOKTvYTvCJuh2
   G7wGFsR0EYTQ3T3MqpLYUzPBEsgWWpiAKKZEeL7eqIYTKWp6S2gjmOeKd
   k3nbB91IhoR+tSyxBdx1GkDzrGI5UYmjhQv9kTmWv5CvPcaw/iWuDemPQ
   E=;
In-Reply-To: <CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, xe-linux-external@cisco.com

Quoting Arnd Bergmann (2018-01-25 13:02:49)
> On Thu, Jan 25, 2018 at 9:26 PM, Taras Kondratiuk <takondra@cisco.com> wr=
ote:
> =

> > For initramfs nanoseconds field can be ignored during
> > unpacking.
> =

> That sounds like a pointless microoptimization. Most likely we won't ever
> need the nanoseconds in the initramfs, but it's trivial to just copy them
> into the right field, and not adding that one source line would probably
> involve adding a one-line source comment to explain the omission ;-)

Agree.
