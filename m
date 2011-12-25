From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4 branch usrmove] deal common part of etc passwd in
 99base
Date: Sun, 25 Dec 2011 11:49:20 +0000 (UTC)
Message-ID: <jd72k0$rf9$1@dough.gmane.org>
References: <20111223080420.GA12664@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> ssh module will need root user in /etc/passwd, so add root and nobody
> to /etc/passwd in 99base instead of nfs module

Huh? Even for who don't use either ssh module or nfs module??

I think you just need to copy these two lines into your ssh module...
