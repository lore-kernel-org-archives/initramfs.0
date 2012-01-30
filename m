From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH series] mount nfs with fstab-sys
Date: Mon, 30 Jan 2012 08:16:46 +0000 (UTC)
Message-ID: <jg5jld$3qk$1@dough.gmane.org>
References: <20120130065052.GA7144@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 30 Jan 2012 at 06:50 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Forgot to send patch as a series, sorry about it.
>
> These patches can be applied as below order:
> 01 - [PATCH v2 resend] allow ifup bring up network manually even without netroot
> 02 - [PATCH] auto setup network without netroot
> 03 - [PATCH] split out nfs rpc process startup
> 04 - [PATCH] fix fstab-sys module check
> 05 - [PATCH] deal with nfs in fstab-sys
>

Please put "M/N" in the Subject: per patch, for people to read the
patches in a correct order more easily.

