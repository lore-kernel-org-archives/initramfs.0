From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Wed, 10 Nov 2010 20:44:45 +0100
Message-ID: <AANLkTikGCZofdYvX78vw+Rj_XmKyY1FmVcp_NT=_B_fF@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
	<AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
	<20101109125820.GO19612@vostochny.stro.at>
	<AANLkTimfYTDFkUgk3x0ry6Z1Q_COYyij5CKMs_50t9MK@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y5E4i8Lji/hFoGjU91HfNzoHDVnBOBkEZONRbHbxCas=;
        b=eq8XwhRzLNd472OpQ8gtdQemDfMzjUy/S3upQcSOtUz9i+d34SxLO7XZDnUN1e6+vr
         LOtrYY9YDaCCudeST7GDl9HmK5WRhJlKZXWiO6bCN6FU1wS4g1DvTaG1QJbePGL7kYGD
         P9C0lT4mzD4gaR61ItRsgk+10ZtnGaEoNoqY8=
In-Reply-To: <AANLkTimfYTDFkUgk3x0ry6Z1Q_COYyij5CKMs_50t9MK-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi maximilian,

2010/11/9 Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2010/11/9 maximilian attems <max-U9r9yeDMy7A@public.gmane.org>:
>
>>> - Postinst script can be executed when installing first time dracut=
,
>>> and when we are upgrading Dracut. Check if it should create a new
>>> initramfs or if it should upgrade it.
>>>
>>> diff -urN dracut/debian/dracut.postinst dracut-007/debian/dracut.po=
stinst
>>> --- dracut/debian/dracut.postinst =A0 =A0 2010-08-09 16:13:51.00000=
0000 +0200
>>> +++ dracut-007/debian/dracut.postinst 2010-10-21 02:49:45.714564995=
 +0200
>>> @@ -2,7 +2,11 @@
>>>
>>> =A0set -e
>>>
>>> -# Regenerate initramfs when we're `installed`
>>> -DPKG_MAINTSCRIPT_PACKAGE=3D'' dracut-update-initramfs -u
>>> +if [ -f /boot/dracut.img-`uname -r` ]; then
>>> + =A0 =A0# Regenerate initramfs when we're `installed`
>>> + =A0 =A0DPKG_MAINTSCRIPT_PACKAGE=3D'' dracut-update-initramfs -t -=
u
>>> +else
>>> + =A0 =A0dracut-update-initramfs -c -k `uname -r`
>>> +fi
>>
>> not sure why you want a create at all here, create should be called
>> by linux-2.6 images not the wrapper script itself.
>
> But you probably will install dracut once you have a linux kernel
> installed, so if you do so, the kernel postinst script will create
> dracut initramfs for any new kernel image installed, but not for the
> current installed one.

Sorry, =BFDid you read this email? 0:-)

Thanks,

Jon Ander.
