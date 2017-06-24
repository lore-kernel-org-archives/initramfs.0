From: "Ali H.M. Hoseini" <alihmh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel 4.4 and 4.9 different reactions to initrd.
Date: Sat, 24 Jun 2017 20:43:07 +0430
Message-ID: <CADV=gjFmL5d841mG+KYXAONAV5LvJ91-WCXpOK0dC_5WFUeqVw@mail.gmail.com>
References: <CADV=gjHjd+cXh6Xmd0UBtb3dEzsYhKNR0XvF_BzK_0z-3r2WFg@mail.gmail.com>
 <78b51168-8f82-3ebe-1de0-b2955ee85db5@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YRF2QHMehnUAKprbA2IyBKBZzEwxb6MZd7/m742KdHs=;
        b=ihucBz44rP0Tta/ilB5x0jvNCVDM0MMBZGTJvT26ppRavRQddUJ1mENeIKJIctKh8v
         yV2jd6FIAPdd1eTnv3FF4icYV2o/dDTC6YCXFpLNFolKiHGi99pOU+5mCtwWdsTWlJAQ
         6f4ef8PvDadxOSGs9SWJm7HydeUWFy+1nAHATwIh3BCEB8q5kSQ2ekYAp+6fLpxSIBGu
         nPAKB69vHf3YxSvFGGLQ5SsRVpAbpYJSKSjXiP0lBRP5l1X6ZfbSMFANbNAUHDgp9OsY
         ZGAxJkgGQf6REaeRqLS+nrvvlI8TZ7u7VzXWe+HQg9n141ffoBQPArUcP0ZGRcoxP1gy
         2QXA==
In-Reply-To: <78b51168-8f82-3ebe-1de0-b2955ee85db5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Thank you very much. it seems during boot with default ubuntu kernels,
CONFIG_BLK_DEV_RAM changed to =3Dm.
Correcting it to =3Dy and recompiling kernel fixed the problem.

Thanks again.



On Fri, Jun 23, 2017 at 8:06 AM, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> 22.06.2017 23:30, Ali H.M. Hoseini =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi,
>>
>> I'm not sure am I supposed to ask this question here, But I did not
>> find anywhere more suitable!
>>
>> I'm using a complete root fs compressed in gz as my initrd for last
>> couple of years.
>> until kernel 4.4.x when I chose to boot kernel with my initrd, I got
>> these messages in boot process:
>>
>> ...
>> [    0.000000] Krrne  oomman  iie: BOOT_IMAGE=3Dvvmlinuz-4.4117
>> initrd=3D/utvos44.0.6.gz console=3Dtty console=3DttyS09900
>> ...
>> [   38.920053] Trying to unpack rootfs image as initramfs...
>> [   39.103577] rootfs image is not initramfs (no cpio magic); looks
>> like an initrd
>> ...
>>
>> and system boots correctly.
>>
>>
>>
>> But when I switched to kernel 4.9.30, everything went wrong:
>>
>> ....
>> [    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.9.30
>> initrd=3D/utvos.4.1.0.gz root=3D/dev/ram0 console=3Dtty console=3DttyS0,=
9600
>> ....
>> [   29.156899] Unpacking initramfs...
>> [   29.330796] Initramfs unpacking failed: no cpio magic
>> ...
>
> You need CONFIG_BLK_DEV_RAM enabled. Looks like it is not define in this
> case.
