From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5 branch usrmove v2] deal common part of etc passwd
 in 99base
Date: Thu, 29 Dec 2011 11:03:30 +0800
Message-ID: <4EFBD882.2090707@redhat.com>
References: <20111226062910.GA3141@darkstar.nay.redhat.com> <jdcb3i$9bf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jdcb3i$9bf$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/27/2011 07:44 PM, Cong Wang wrote:

> On Mon, 26 Dec 2011 at 06:29 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> ssh module will need root user in /etc/passwd, so add root and nobody
>> to /etc/passwd in 99base instead of nfs module
>>
> 
> Sorry, for people who don't use nfs/ssh module,
> this is totally unnecessary.


I dont think so, but if you insist I can add an dracut function like
inst_root_user

> 
> And, I don't think duplicating 2 lines of code is a problem here...
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
