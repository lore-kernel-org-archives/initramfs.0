From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4 branch usrmove] Add job control support to emergency
 shell
Date: Mon, 26 Dec 2011 10:06:18 +0800
Message-ID: <4EF7D69A.4010800@redhat.com>
References: <20111223080423.GA12666@darkstar.nay.redhat.com> <jd737r$rf9$3@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jd737r$rf9$3@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/25/2011 07:59 PM, Cong Wang wrote:

> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Option --ctty will optionally add setsid binary to dracut's image.
>>
>> During runtime, if rd.ctty is set and is a character device,
>> emergency shells will be spawned with job control.
>>
>> in case no ctty was provided, shell was spawned without caring about
>> /dev/console. Also, the ctty is more opportunistic. If the image was
>> generated with --ctty, we will fallback to /dev/tty1 if rc.ctty is
>> invalid or missing. Otherwise we spawn standard shell on /dev/console
>>
>> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> IIRC, Michal is the author of this patch? If so, you need to
> add "From:" in the beginning of this patch...


It does not apply on the usrmove branch, I refreshed it based on this
branch, so maybe add sighed-off-by of Michal is ok. Michal? any suggestion?

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
