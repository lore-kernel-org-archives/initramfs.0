From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/7] auto setup network without netroot
Date: Mon, 06 Feb 2012 16:43:55 +0800
Message-ID: <4F2F92CB.1000804@redhat.com>
References: <20120202075952.GA12412@darkstar.nay.redhat.com> <1328510722.10153.13.camel@obelisk.thedillows.org> <4F2F8666.50907@redhat.com> <4F2F86F6.5010007@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F2F86F6.5010007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/06/2012 03:53 PM, Cong Wang wrote:

> On 02/06/2012 03:51 PM, Dave Young wrote:
>> I think the key problem is the network setup code split. I would not
>> insist on this although I don't like that we must add ip= to have
>> network setup
> 
> With your patches, we must have rd.neednet=1. :) So, it is unfair to
> only blame ip= approach.


I mean for netroot we also must have ip= set because ip= will deal with
the network setup. Originally we might have no ip= but with proper
netroot param like root=nfs...

> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
