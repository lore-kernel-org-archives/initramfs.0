From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5 branch usrmove v2] deal common part of etc passwd in
 99base
Date: Tue, 27 Dec 2011 11:44:51 +0000 (UTC)
Message-ID: <jdcb3i$9bf$1@dough.gmane.org>
References: <20111226062910.GA3141@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 26 Dec 2011 at 06:29 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> ssh module will need root user in /etc/passwd, so add root and nobody
> to /etc/passwd in 99base instead of nfs module
>

Sorry, for people who don't use nfs/ssh module,
this is totally unnecessary.

And, I don't think duplicating 2 lines of code is a problem here...
