From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5 branch usrmove v2] Add job control support to emergency
 shell
Date: Mon, 23 Jan 2012 12:03:39 +0100
Message-ID: <4F1D3E8B.80703@redhat.com>
References: <20111226062915.GA3143@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111226062915.GA3143-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Am 26.12.2011 07:29, schrieb Dave Young:
> From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
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
> [dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: Rebased to usrmove branch]
> 
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

pushed
