From: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Tue, 12 Mar 2013 17:08:39 +0800
Message-ID: <513EF097.4040405@gmail.com>
References: <513964D9.7060700@gmail.com> <51398CEE.5090502@redhat.com> <513C528C.2010200@gmail.com> <513DA469.80505@redhat.com> <513E8164.8000908@gmail.com> <513EE93F.1090909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=huj36rpOuX7yMLWAgB0Ahrmf5DTZKi/qssh3wfxNoCA=;
        b=bi5FSTqegYKSTYUQS5xN7GZe0o1pMoDkoQY8t0IlJSCzl8YX/Df6xJ4mUQntOj8BBz
         z42/sxWUT/8M7Qwq4VmElM4GUPcm3h0h5Z41oJ/+qDolVG573NM6mGZr2Q0BOPed3ZaJ
         ZJZhV1fcLSsxVY/hqboWPjoZIqsLMMThSi6cx7pEHB2eQ0+MkdNY41Z0EmAbuXkrhcB9
         ykgWO7MHJpjV6qqoajPX7OnSKWJ/DpJgzCMpmJhL6UIBn9jX09cKwJxXlff3R7ZWJVFT
         ePW6qe70MWw18V7s/cDxI85+wm4QBry7PS8AR7AMuylfXTQ0g/wm69a6gJ2SXzT0yRYM
         Qcbg==
In-Reply-To: <513EE93F.1090909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=E4=BA=8E 2013-3-12 16:37, Harald Hoyer =E5=86=99=E9=81=93:
> Am 12.03.2013 02:14, schrieb yeyouqun:
>> =E4=BA=8E 2013-3-11 17:31, Harald Hoyer =E5=86=99=E9=81=93:
>>> Am 10.03.2013 10:29, schrieb yeyouqun:
>>>> =E4=BA=8E 2013-3-8 15:02, Harald Hoyer =E5=86=99=E9=81=93:
>>>>> Am 08.03.2013 05:11, schrieb yeyouqun:
>>>>>> Recently I upgraded linux kernel to 3.6.10 and upgrade dracut ve=
rsion to 024,
>>>>>> system starts up OK on 3.6.10. But when I upgraded kernel from 3=
=2E6.10 to
>>>>>> 3.8.2,
>>>>>> dracut failed to start up the system. Message when start up read=
s:
>>>>>>
>>>>>> ......
>>>>>>       dracut: dracut-dracut-024-
>>>>>>        rpcbind: cannot create socket for udp6
>>>>>>        rpcbind: cannot create socket for tcp6
>>>>>>        mount: unknoun filesys
>>>>>>        udev: starting version 147
>>>>>>        systend-udevd (139): /proc/139/oom_adj is deprecated, ple=
ase use
>>>>>>        /proc/139/oom_score_adj instead.
>>>>>>        dracut Warning: Could not boot.
>>>>>>        dracut Warning: Could not boot.
>>>>>>        Dropping to debug shell.
>>>>>>        /bin/sh: can't access tty; job control turned off
>>>>>> ......
>>>>>>
>>>>>> But when I unpack the initrd-3.8.2.img, the /lib/modules directo=
ry shows as
>>>>>> below:
>>>>>>
>>>>>> modules ---- 3.8.2
>>>>>>             |
>>>>>>             |__ 3.6.10
>>>>>>
>>>>>> all the kernel modules reside in "3.6.10" directory and other fi=
les, such as
>>>>>> "modules.dep" and etc. reside in 3.8.2, I think this is the reas=
on why system
>>>>>> can't start up.
>>>>>>
>>>>>> I upgraded kernel by the steps as(in kernel source tree of 3.8.2=
):
>>>>>>
>>>>>>        make
>>>>>>        make modules_install
>>>>>>        make install
>>>>>>
>>>>>> Any one can tell how to fix this behavior of dracut?
>>>>> What's the output of:
>>>> output is two big, I appende it.
>>>>> # dracut --debug test.img 3.8.2
>>> /usr/lib/dracut/dracut-functions.sh@1377(dracut_kernel_post): xargs=
 -r modprobe
>>> -a -d / --ignore-install --show-depends --set-version 3.8.2
>>> /usr/lib/dracut/dracut-functions.sh@1382(dracut_kernel_post): [[ in=
smod =3D
>>> insmod ]]
>>> /usr/lib/dracut/dracut-functions.sh@1383(dracut_kernel_post): echo
>>> ///lib/modules/3.6.10/kernel/arch/x86/crypto/crc32c-intel.ko
>>>
>>>
>>> This looks fishy...
>>>
>>>
>>> What is the output of:
>>>
>>> # modprobe -a --ignore-install --show-depends --set-version 3.8.2 x=
or
>>>
>> [root@localhost mnt]# modprobe -a --ignore-install --show-depends --=
set-version
>> 3.8.2 xor
>> insmod /lib/modules/3.8.2/kernel/crypto/xor.ko
> and what is the output of:
>
> # modprobe -a -d / --ignore-install --show-depends --set-version 3.8.=
2 xor
[root@localhost mnt]# modprobe -a -d / --ignore-install --show-depends=20
--set-version 3.8.2 xor
insmod ///lib/modules/3.6.10/kernel/crypto/xor.ko

BTW:I tried to upgrade dracut to 025 and problem seems gone!
