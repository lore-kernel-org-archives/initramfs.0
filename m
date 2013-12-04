From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: lvm thin_* binaries are installed in hostonly mode?
Date: Wed, 4 Dec 2013 22:05:17 +0800
Message-ID: <20131204140517.GD3430@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi, Harald

I notice these thin_* binaries are installed to kdump initramfs in spite
of the fact that I don't use thinp lvm:

# ll sbin/thin_*
-rwxr-xr-x. 1 root root  384648 Dec  4 20:37 sbin/thin_check
-rwxr-xr-x. 1 root root 2184112 Dec  4 20:37 sbin/thin_dump
-rwxr-xr-x. 1 root root 2179792 Dec  4 20:37 sbin/thin_repair
-rwxr-xr-x. 1 root root 2179928 Dec  4 20:37 sbin/thin_restore

This is introduced here:

commit 5d623b1
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Oct 21 09:09:26 2013 +0200

    lvm: always install thin utils for lvm


These binaries are totally 6.6M in size. That's too much for a kdump
environment.

As you probably know, in kdump kernel, we only have very limited memory
(~128M) and makedumpfile (a vmcore dump tool) is more faster if there's
more available memory out there.

IMO, it's best we only install these thin_* bins when people are
actually using these ones.

Anyway, I don't know if you have any particular reason to do this..


Thanks
WANG Chao
