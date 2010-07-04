From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Failed to use read-only NFS as the root filesystem
Date: Sun, 04 Jul 2010 13:16:00 -0400
Message-ID: <1278263760.4311.59.camel@obelisk.thedillows.org>
References: <AANLkTimW2-WTf1oqheGOQgfIHcUVpFOEakpnAO8aiQGf@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimW2-WTf1oqheGOQgfIHcUVpFOEakpnAO8aiQGf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, 2010-07-05 at 00:48 +0800, Min Jun,Xi wrote:
> Hi All,
> there's one problem here.
> I tried to set one read-only NFS directory as the root filesystem, but
> there're several problems, and lead to one situation that the root
> filesystem is remounted using read-write option.

> Is there any option or flag which can be used to disable it? I think
> the developers from redhat should know about it.

Search /etc/rc.d/rc.sysinit for /etc/sysconfig/readonly-root. I don't
know if it is well documented or not. You can also use "readonlyroot" on
the command line I think, but using the file lets you set more options.
Expect more issues related to this, the last time I looked at it, it
took some tweaking to make work well.
