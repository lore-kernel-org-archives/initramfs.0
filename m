From: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Tue, 12 Mar 2013 09:14:12 +0800
Message-ID: <513E8164.8000908@gmail.com>
References: <513964D9.7060700@gmail.com> <51398CEE.5090502@redhat.com> <513C528C.2010200@gmail.com> <513DA469.80505@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aTpvWObWREhdgK+995jjp/uGpC44GEGIzo4eh2zlOFw=;
        b=XMXCUWnPKfQ40KcGOWYJiC+2lrViZYEVfHD8u7cRIQtpOIFQLVRTxEfzNTVMbWrx0v
         jWxMurRGfr60bvnwl39k0phEAJ/uGRQlRnh9c2jBh1Z0EJnniaSZA0BXgf18RI2rQs3q
         a0KJWtm4TCazxJ97B+Y8ab6e7saSPQ/rolPv/bgq5p27yzU3EfNc7eUpzvQ7wZTk6skn
         uH8hRwzSPbdGGoswQCy9Rip8DXERrqw4UFcKpXAgXuBQZdVFLR17ftMtmwTR2+Jdb2aj
         5op6IFan12ItaYKd+Bz2hXagKETS/7JdU7tVTAE81n2J0+Igne7Eebb4xNwbSLG7AiCc
         d52w==
In-Reply-To: <513DA469.80505-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=E4=BA=8E 2013-3-11 17:31, Harald Hoyer =E5=86=99=E9=81=93:
> Am 10.03.2013 10:29, schrieb yeyouqun:
>> =E4=BA=8E 2013-3-8 15:02, Harald Hoyer =E5=86=99=E9=81=93:
>>> Am 08.03.2013 05:11, schrieb yeyouqun:
>>>> Recently I upgraded linux kernel to 3.6.10 and upgrade dracut vers=
ion to 024,
>>>> system starts up OK on 3.6.10. But when I upgraded kernel from 3.6=
=2E10 to 3.8.2,
>>>> dracut failed to start up the system. Message when start up reads:
>>>>
>>>> ......
>>>>      dracut: dracut-dracut-024-
>>>>       rpcbind: cannot create socket for udp6
>>>>       rpcbind: cannot create socket for tcp6
>>>>       mount: unknoun filesys
>>>>       udev: starting version 147
>>>>       systend-udevd (139): /proc/139/oom_adj is deprecated, please=
 use
>>>>       /proc/139/oom_score_adj instead.
>>>>       dracut Warning: Could not boot.
>>>>       dracut Warning: Could not boot.
>>>>       Dropping to debug shell.
>>>>       /bin/sh: can't access tty; job control turned off
>>>> ......
>>>>
>>>> But when I unpack the initrd-3.8.2.img, the /lib/modules directory=
 shows as
>>>> below:
>>>>
>>>> modules ---- 3.8.2
>>>>            |
>>>>            |__ 3.6.10
>>>>
>>>> all the kernel modules reside in "3.6.10" directory and other file=
s, such as
>>>> "modules.dep" and etc. reside in 3.8.2, I think this is the reason=
 why system
>>>> can't start up.
>>>>
>>>> I upgraded kernel by the steps as(in kernel source tree of 3.8.2):
>>>>
>>>>       make
>>>>       make modules_install
>>>>       make install
>>>>
>>>> Any one can tell how to fix this behavior of dracut?
>>> What's the output of:
>> output is two big, I appende it.
>>> # dracut --debug test.img 3.8.2
> /usr/lib/dracut/dracut-functions.sh@1377(dracut_kernel_post): xargs -=
r modprobe
> -a -d / --ignore-install --show-depends --set-version 3.8.2
> /usr/lib/dracut/dracut-functions.sh@1382(dracut_kernel_post): [[ insm=
od =3D insmod ]]
> /usr/lib/dracut/dracut-functions.sh@1383(dracut_kernel_post): echo
> ///lib/modules/3.6.10/kernel/arch/x86/crypto/crc32c-intel.ko
>
>
> This looks fishy...
>
>
> What is the output of:
>
> # modprobe -a --ignore-install --show-depends --set-version 3.8.2 xor
>
[root@localhost mnt]# modprobe -a --ignore-install --show-depends=20
--set-version 3.8.2 xor
insmod /lib/modules/3.8.2/kernel/crypto/xor.ko
