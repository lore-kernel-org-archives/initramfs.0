From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Fri, 08 Mar 2013 08:02:06 +0100
Message-ID: <51398CEE.5090502@redhat.com>
References: <513964D9.7060700@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513964D9.7060700-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.03.2013 05:11, schrieb yeyouqun:
> 
> Recently I upgraded linux kernel to 3.6.10 and upgrade dracut version to 024,
> system starts up OK on 3.6.10. But when I upgraded kernel from 3.6.10 to 3.8.2,
> dracut failed to start up the system. Message when start up reads:
> 
> ......
>    dracut: dracut-dracut-024-
>     rpcbind: cannot create socket for udp6
>     rpcbind: cannot create socket for tcp6
>     mount: unknoun filesys
>     udev: starting version 147
>     systend-udevd (139): /proc/139/oom_adj is deprecated, please use
>     /proc/139/oom_score_adj instead.
>     dracut Warning: Could not boot.
>     dracut Warning: Could not boot.
>     Dropping to debug shell.
>     /bin/sh: can't access tty; job control turned off
> ......
> 
> But when I unpack the initrd-3.8.2.img, the /lib/modules directory shows as below:
> 
> modules ---- 3.8.2
>          |
>          |__ 3.6.10
> 
> all the kernel modules reside in "3.6.10" directory and other files, such as
> "modules.dep" and etc. reside in 3.8.2, I think this is the reason why system
> can't start up.
> 
> I upgraded kernel by the steps as(in kernel source tree of 3.8.2):
> 
>     make
>     make modules_install
>     make install
> 
> Any one can tell how to fix this behavior of dracut?

What's the output of:

# dracut --debug test.img 3.8.2
