From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4 branch usrmove] Add job control support to emergency
 shell
Date: Sun, 25 Dec 2011 11:59:55 +0000 (UTC)
Message-ID: <jd737r$rf9$3@dough.gmane.org>
References: <20111223080423.GA12666@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Option --ctty will optionally add setsid binary to dracut's image.
>
> During runtime, if rd.ctty is set and is a character device,
> emergency shells will be spawned with job control.
>
> in case no ctty was provided, shell was spawned without caring about
> /dev/console. Also, the ctty is more opportunistic. If the image was
> generated with --ctty, we will fallback to /dev/tty1 if rc.ctty is
> invalid or missing. Otherwise we spawn standard shell on /dev/console
>
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

IIRC, Michal is the author of this patch? If so, you need to
add "From:" in the beginning of this patch...
