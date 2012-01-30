From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] deal with nfs in fstab-sys
Date: Mon, 30 Jan 2012 16:43:07 +0800
Message-ID: <4F26581B.4040305@gmail.com>
References: <20120130064451.GA7125@darkstar.nay.redhat.com> <jg5jri$3qk$3@dough.gmane.org> <4F2657B4.3030200@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NJsDOzmAO+Jk9SJCPLIQ4fT1UfBh1cJsHsXJC5fZBUs=;
        b=V1ibWW7IfYdVNcTr8X9x3hkNG2Yir0HC7+CCSZNdhfkiXM/xfcPy12GjgSvUeV6p4o
         KjH9LuyRt2QRA+xSAFi+dCnRmBgAGgiKgSdmS0D7fqRaCgQH5sYIrLO5MdNw3fxavwOi
         tABOcojn6KSPcyp00A30wjJI7fPYVWI9szdD4=
In-Reply-To: <4F2657B4.3030200-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:41 PM, Dave Young wrote:
> On 01/30/2012 04:20 PM, Cong Wang wrote:
>
>> On Mon, 30 Jan 2012 at 06:44 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
>>> If we need to mount nonroot nfs in fstab we also need to launch rpc processes
>>> Add nfs-start-rpc code, also do not check and fsck $_dev in this case
>>
>> Isn't it nfs module's responsibility to call nfs-start-rpc code?
>> Why do you put it in fs-systab?
>
>
> nfs know nothing about fstab mount, it only deal with nfsroot thing. So
> I have to do this in fstab-sys

Sure, but nfs module knows it needs to start rpc before mounting NFS.

So, what's the problem if we call nfs-start-rpc script in pre-pivot hook 
of nfs module (before mount-sys.sh, of course)?
