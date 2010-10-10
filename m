From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] base: don't bother with rmmod/modprobe links for
 module-less initramfs
Date: Sun, 10 Oct 2010 18:17:59 +0100
Message-ID: <AANLkTinVg6GGv+wNUAbj7-coYcV5W8ww_xzLt-cebjg1@mail.gmail.com>
References: <20101010110105.827009D401B@zog.reactivated.net>
	<1286712502-sup-7547@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bs2TzoXVFPVJS2qAKVMHzRzhuG5sS4xyFMIkFPWGJPQ=;
        b=dU37FI3Zee+xBles05fOJ9voQRo1W4qkA75c3kMyMKlTb8Kywlpvxa06gUYEMO67pU
         XOjeDOWaRwbDfLQoehBLhgkGUdhBLyJFOzk0YJ05JZi8dSfVhcFqYST+mtwdVwFvPwY7
         0p86H3DvMngYlCl3HE0+ImjSXeye9cGYpEils=
In-Reply-To: <1286712502-sup-7547@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/10/10 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Excerpts from Daniel Drake's message of Sun Oct 10 13:01:05 +0200 201=
0:
>> /bin/true is 23kb, bigger than rmmod itself!
>
> Yes, I know=E2=80=A6 =C2=A0It was supposed to be temporary workaround=
 only=E2=80=A6 :-)

What's the longer term solution?

> Hm=E2=80=A6 you're right to some extent. =C2=A0udev seems not to comp=
lain about
> missing modprobe. =C2=A0Although there are few usages of modprobe in =
some
> Dracut modules.

We could add an early hook (which only gets installed in the
ignore-kernel-modules case) which defines modprobe as a shell
function:

modprobe()
{
    return 0
}

Actually, this should be even simpler:

alias modprobe=3Dtrue

(in this case, true is used an inbuilt shell command -- not the one in
/bin, which we won't need or use)

What do you think?

Daniel
