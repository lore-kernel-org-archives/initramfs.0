From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 16:51:23 +0800
Message-ID: <4F265A0B.1000402@redhat.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jg5kl4$3qk$4@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:33 PM, Cong Wang wrote:

> On Mon, 30 Jan 2012 at 06:43 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Current dracut network only will be setup when netroot is used. But there are
>> some cases we need network even without netroot. For example kdump will need
>> copy vmcore to remote machine via scp or nfs mount. OTOH, if we use dracut as
>> a recovery system the network is helpful even root is not a network device.
>>
>> This implementation is based on the manually bring up method. Here add a kernel
>> cmdline argument rd.neednet. If rd.neednet is set dracut will bring up network
>> with ifup $INTERFACE -m. If netroot is used we still keep original behavior.
>>
> 
> I don't think we really need to introduce a new cmdline, I think we
> can re-use ip= cmdline. Currently, if ip= is specified but netroot is
> not, ip= will be ignored. We can change this, let dracut bring up
> network as long as we have ip=, even we don't have netroot.


For netroot case it is supported as well for no ip= or other network
cmdline, please see the net-genrules.sh code

We will also setup network when rd.neednet=1 in case no special ip=
provided for convenience.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
