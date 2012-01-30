From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 16:51:46 +0800
Message-ID: <4F265A22.2090407@gmail.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org> <4F265A0B.1000402@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RAovzkcaFkG1PDnAM38w3opOPzKYh6NJdC/TrJHXyUk=;
        b=fQTHIXgTzwGDa94kqEAG5zdI5emPaF3nOYWYiuTUisiBx+O4Ucpmq6KzqYz3iZFTi4
         HE0YaqrmgaX98ivlhnnDf3ehinO83HS/10AtzkLvcKFYmgAxb5mwajfswBjsJUgpIwIn
         thJiSPq1Pw1Xen3NxIk9V2YerLjlwgxsRife0=
In-Reply-To: <4F265A0B.1000402-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:51 PM, Dave Young wrote:
> On 01/30/2012 04:33 PM, Cong Wang wrote:
>
>> On Mon, 30 Jan 2012 at 06:43 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
>>> Current dracut network only will be setup when netroot is used. But there are
>>> some cases we need network even without netroot. For example kdump will need
>>> copy vmcore to remote machine via scp or nfs mount. OTOH, if we use dracut as
>>> a recovery system the network is helpful even root is not a network device.
>>>
>>> This implementation is based on the manually bring up method. Here add a kernel
>>> cmdline argument rd.neednet. If rd.neednet is set dracut will bring up network
>>> with ifup $INTERFACE -m. If netroot is used we still keep original behavior.
>>>
>>
>> I don't think we really need to introduce a new cmdline, I think we
>> can re-use ip= cmdline. Currently, if ip= is specified but netroot is
>> not, ip= will be ignored. We can change this, let dracut bring up
>> network as long as we have ip=, even we don't have netroot.
>
>
> For netroot case it is supported as well for no ip= or other network
> cmdline, please see the net-genrules.sh code


Irrelevant.

>
> We will also setup network when rd.neednet=1 in case no special ip=
> provided for convenience.
>

With rd.neednet=1 but without ip=, how can you know which nic we need to 
bring up?
