From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/7] auto setup network without netroot
Date: Tue, 07 Feb 2012 09:50:22 +0800
Message-ID: <4F30835E.4030904@redhat.com>
References: <20120202075952.GA12412@darkstar.nay.redhat.com>	 <1328510722.10153.13.camel@obelisk.thedillows.org>	 <4F2F8666.50907@redhat.com> <4F2F86F6.5010007@gmail.com>	 <4F2F92CB.1000804@redhat.com> <1328534517.10153.20.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328534517.10153.20.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/06/2012 09:21 PM, David Dillow wrote:

> On Mon, 2012-02-06 at 16:43 +0800, Dave Young wrote:
>> On 02/06/2012 03:53 PM, Cong Wang wrote:
>>
>>> On 02/06/2012 03:51 PM, Dave Young wrote:
>>>> I think the key problem is the network setup code split. I would not
>>>> insist on this although I don't like that we must add ip= to have
>>>> network setup
>>>
>>> With your patches, we must have rd.neednet=1. :) So, it is unfair to
>>> only blame ip= approach.
>>
>>
>> I mean for netroot we also must have ip= set because ip= will deal with
>> the network setup. Originally we might have no ip= but with proper
>> netroot param like root=nfs...
> 
> In that case, we do DHCP and it works. Having ip=BLAH on the command
> line is not a requirement.


Then I'm ok for this

> 
> As for rdbreak=cmdline, I expect that to be used by experts debugging
> dracut issues, and they should be knowledgeable enough to manually
> configure the network if they need it. I don't believe an automated
> solution is required there. That's not to say a script to do the right
> thing wouldn't be useful, just not high on the list of things to do.


Make sense to me as well.

> 
> I could easily envision a "helper script" that runs through the command
> line arguments (perhaps using the existing hooks) and brings up the
> network. But I see it as more of a user-run command than an automated
> step.


If there's such a script it will be much better because it will save
time of people to investigate the detail of dracut network.

>

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
