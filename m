From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: mount other than rootfs problem
Date: Thu, 29 Sep 2011 10:55:47 +0800
Message-ID: <4E83DE33.4020204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

In current dracut modules there's still fstab-sys for mount something
other than root, So how about add a similar module ie. fstab-kdump which
contains the kdump target device/fstype, add mount-kdump.sh to mount all
the stuff. For rootfs we can use dracut mount point.

As discussion in mail archive I see nfs is a main problem for this
issue. I did not understand why nfs is special, could someone explain a bit?

-- 
Thanks
Dave
