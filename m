From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 17:03:23 +0800
Message-ID: <4F265CDB.7070204@gmail.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org> <4F265A0B.1000402@redhat.com> <4F265A22.2090407@gmail.com> <4F265C01.4010701@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jn3LEi4PouLYaih2aEthcFwhVGBJmui9GBOG7COVynA=;
        b=S6aAUj/2wYQSriksZ/3WMdpvpVdKw908pwiFj2PGXo4HSo2eoLHKI1yClyll+pPzVs
         s6x7HnuEMSXYYzzfDSBo/ppmDV+yvXI+VJds6ZQ8Sh/i5sACg3HogIKvhukEvahmt1tc
         fNn+y40uwu+ZvCTumjuH2qzgTfIWCpkXyigxI=
In-Reply-To: <4F265C01.4010701-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:59 PM, Dave Young wrote:
> On 01/30/2012 04:51 PM, Cong Wang wrote:
>
>> On 01/30/2012 04:51 PM, Dave Young wrote:
>>>
>>> We will also setup network when rd.neednet=1 in case no special ip=
>>> provided for convenience.
>>>
>>
>> With rd.neednet=1 but without ip=, how can you know which nic we need to
>> bring up?
>
>
> current behavior of net-genrule.sh is below:
>
> # Default: We don't know the interface to use, handle all
>
> It will be ok and convenient at least when we have only one nic

So, rd.neednet=1 will bring up all when there is no ip=, what kdump 
needs is a cmdline that tells dracut to bring up only the ones we need.

You still don't tell why re-using ip= doesn't work. So far, I think ip= 
can be re-used for kdump case, and is better than your rd.neeednet=1.
