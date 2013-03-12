From: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Tue, 12 Mar 2013 17:34:32 +0800
Message-ID: <513EF6A8.9030903@gmail.com>
References: <513964D9.7060700@gmail.com> <51398CEE.5090502@redhat.com> <513C528C.2010200@gmail.com> <513DA469.80505@redhat.com> <513E8164.8000908@gmail.com> <513EE93F.1090909@redhat.com> <513EF097.4040405@gmail.com> <513EF163.3020106@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HHEBICFKtLeVIarzrOQuBO0859YFCLL3U77vvtPDepc=;
        b=Dd1dZC68EdKJX6BfqIp3KJhhTpRIFLuoiE/9XgoJtrARylNMtN15BHPu6vI4aK5mMF
         zep1UjRZQOBXelNAK7nHecRkWUMzlgi5IW7XLyJfAuieyASBPM8+GTY6ohghmJH3pVTr
         GctTLtERyB51VRU8UXsoTLpxTCTheOVMShvCY/AvqQRWotV+QvSy61APlsWpKRuNJa08
         eq90DAhK8pX9Ns4ah/5LXJMs3KV8NWBjLPnQxypaEAI0w2IHDD26L4imLF8pjinCnJGj
         U2v/Qt13mT919cATUk/M43MLvi8oB22hur3J0FJH+nLzGJy0DmUDXsRj1bJHUpdaK2MX
         TpKQ==
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
Yes, you are right, I upgrade modprobe to 3.15 and run the same command=
,=20
the output is:

[root@localhost mnt]# modprobe -a -d / --ignore-install --show-depends=20
--set-version 3.8.2 xor
insmod //lib/modules/3.8.2/kernel/crypto/xor.ko

Thank you.
