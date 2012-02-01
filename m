From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] split nfsroot rpc start code
Date: Wed, 01 Feb 2012 15:56:12 +0800
Message-ID: <4F28F01C.4020208@gmail.com>
References: <20120201020054.GA9567@darkstar.nay.redhat.com> <jgaqo7$n39$1@dough.gmane.org> <4F28F017.3030908@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OJW715TjouZ7N/DxE7OQCHOHuDYxdtSh/Xh96aEAYhA=;
        b=VdukdKcEoBqKV0jl7qmeoXZjYiY3NgbrQxNiElr/UZbkxu/ECLd4AAMnkMmOlpCwPT
         uuMIZwm2YXpzd3SDcdKKApBhwYlqoLC1rXXx7vddmchQehtBNMD0W3ZXHiarRtrCTFmr
         SxOA5gEdBzG+BsNj431sZxDfrI2tX4S2cD3Nc=
In-Reply-To: <4F28F017.3030908-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/01/2012 03:56 PM, Dave Young wrote:
> On 02/01/2012 03:48 PM, Cong Wang wrote:
>> On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
>>> Index: dracut/modules.d/95nfs/module-setup.sh
>>> ===================================================================
>>> --- dracut.orig/modules.d/95nfs/module-setup.sh
>>> +++ dracut/modules.d/95nfs/module-setup.sh
>>> @@ -57,6 +57,7 @@ install() {
>>>       dracut_install $(for _i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/null); do echo $_i;done | egrep "$_nsslibs")
>>>
>>>       inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
>>> +    inst_hook cmdline 91 "$moddir/nfs-start-rpc.sh"
>>
>> I am sure this is wrong. You need pre-pivot.
>
>
> I want to start them as early as we can, I always think about user use
> dracut as a minimal recovery system, they need do something manually.
>

Then install it as pre-pivot 00.

Do one thing at one time, I know this patch now is for kdump. If you 
really need a minimal recovery system, do that later. :)
