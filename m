From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Q: How to add more modules when -H is specified?
Date: Fri, 29 Jul 2011 11:24:40 +0200
Message-ID: <4E327C58.1000406@redhat.com>
References: <j0tsl5$2kj$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j0tsl5$2kj$2@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 29.07.2011 10:57, WANG Cong wrote:
> 
> Hi, dracut people,
> 
> I am not sure about the expected behaviour when I specify both
> -H and --add foo (where module foo is not automatially added
> by -H). It looks like with -H specified, --add foo will not
> take any effect?
> 
> At least `-H --add nfs` doesn't work if my rootfs is not nfs,
> I see the following check in modules.d/95nfs/module-setup.sh,
> 
>     [ $hostonly ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && return 1
> 
> So, is this expected? I mean as long as I specify -H, there is
> no way to add more modules? Or just the nfs check code is wrong?

Hmm, yes, currently all "add" modules also have the hostonly check.
Sometimes you want that behaviour, sometimes not..

We might want s.th. like "--force-add" for that use case.

> 
> Also, I am looking for a way to add all needed modules for
> devices mounted in current system, as -H only adds modules
> needed by rootfs.
> 
> Thanks!
> 

Not (yet) implemented. I accept patches :-)
