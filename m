From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH series] mount nfs with fstab-sys
Date: Mon, 30 Jan 2012 17:23:53 +0800
Message-ID: <4F2661A9.70201@redhat.com>
References: <20120130065052.GA7144@darkstar.nay.redhat.com> <jg5jld$3qk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jg5jld$3qk$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:16 PM, Cong Wang wrote:

> On Mon, 30 Jan 2012 at 06:50 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Forgot to send patch as a series, sorry about it.
>>
>> These patches can be applied as below order:
>> 01 - [PATCH v2 resend] allow ifup bring up network manually even without netroot
>> 02 - [PATCH] auto setup network without netroot
>> 03 - [PATCH] split out nfs rpc process startup
>> 04 - [PATCH] fix fstab-sys module check
>> 05 - [PATCH] deal with nfs in fstab-sys
>>
> 
> Please put "M/N" in the Subject: per patch, for people to read the
> patches in a correct order more easily.


Yes, should do, just press enter/send two quickly

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
