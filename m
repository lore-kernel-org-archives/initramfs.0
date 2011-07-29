From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Q: How to add more modules when -H is specified?
Date: Fri, 29 Jul 2011 08:57:09 +0000 (UTC)
Message-ID: <j0tsl5$2kj$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi, dracut people,

I am not sure about the expected behaviour when I specify both
-H and --add foo (where module foo is not automatially added
by -H). It looks like with -H specified, --add foo will not
take any effect?

At least `-H --add nfs` doesn't work if my rootfs is not nfs,
I see the following check in modules.d/95nfs/module-setup.sh,

    [ $hostonly ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && return 1

So, is this expected? I mean as long as I specify -H, there is
no way to add more modules? Or just the nfs check code is wrong?

Also, I am looking for a way to add all needed modules for
devices mounted in current system, as -H only adds modules
needed by rootfs.

Thanks!
