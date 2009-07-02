From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCEMENT] dracut-0.3
Date: Thu, 02 Jul 2009 12:54:14 +0200
Message-ID: <4A4C91D6.2070009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here it is, dracut-0.3!

Featuring booting from all kind of block devices, NFS, iSCSI and NBD.

How to get started, if you want to test.

On Fedora 11 or Fedora rawhide (you might have to wait until the mirrors catch up):
# yum install dracut-0.3

or download the tarball:
http://harald.fedorapeople.org/downloads/dracut/dracut-0.3.tar.bz2

# tar xzf dracut-0.3.tar.bz2
# cd dracut-0.3
# make install sbindir=/sbin sysconfdir=/etc



To generate a initramfs image, run:

# dracut <imagename> <kernel version>

to overwrite an existing image:

# dracut -f <imagename> <kernel version>

Try to boot from that image by modifying /etc/grub.conf. Be sure to have a 
fallback entry.

If you want to boot from network have a look at the manpage.
Basically everything can be specified on the kernel command line.

Bug reports can be send directly to me (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) or to this list.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
