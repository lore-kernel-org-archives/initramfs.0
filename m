From: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Tue, 12 Mar 2013 17:14:53 +0800
Message-ID: <513EF20D.4070108@gmail.com>
References: <513964D9.7060700@gmail.com> <51398CEE.5090502@redhat.com> <513C528C.2010200@gmail.com> <513DA469.80505@redhat.com> <513E8164.8000908@gmail.com> <513EE93F.1090909@redhat.com> <513EF097.4040405@gmail.com> <513EF163.3020106@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aOFTwZEmpsM0TOoWqTvqbLDxI2HTPBS47yT4Cl2nHuA=;
        b=0QQ+8xayde6J0DN217GuoPWQ7WUMFhS1Mn1fYOYGHjGKe3PmOoZa8+PylF48ZW3wS2
         KSVW9PCRq8ieBX1W/BQA+bhia6GTpA/NjMRyf09CP9zVhmW+M8SHg8YluUF92Gu9W/fM
         JLM2TaA3rfv2fwrmgoYhcuia/1PuDymY2x0H7nMPKyTTDwxEmI4aMKPA8dgIJRGn3feZ
         PPcBNd0T4nLeJp/hdkUvq2fl8yx9TClzzl0zO+tpfFn3uTqnj0nd4nwCI0C9grULUtqp
         RNI/8XmTREt5F5gFijAyo7inPQZL+B8YotvH9pZEnbBJNG7bUIWLNHytk3EBUoecwrV8
         0RVQ==
In-Reply-To: <513EF163.3020106-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=E4=BA=8E 2013-3-12 17:12, Harald Hoyer =E5=86=99=E9=81=93:
>> [root@localhost mnt]# modprobe -a -d / --ignore-install --show-depen=
ds
>> --set-version 3.8.2 xor
>> insmod ///lib/modules/3.6.10/kernel/crypto/xor.ko
> This seems like a bug in modprobe!!
>
But when I update dracut to version 025, the problem seams gone?
