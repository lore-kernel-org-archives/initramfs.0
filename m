From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: ChangeLog 2009-06-04
Date: Thu, 04 Jun 2009 17:57:02 +0200
Message-ID: <4A27EECE.50405@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

$ make rpm
should work now

- made the installation paths configurable in the Makefile
- dracutbasedir=/usr/lib/dracut can be modified in dracut.conf
- dracutlogfile is now /var/log/dracut.log instead of /var/log/dracut/log
- dwarning/dinfo/derror check before they write to $dracutlogfile
- add sample dracut.conf with comments
- add /tmp/udevtriggeropts which used by plymouth to omit already triggered 
events in the big udev trigger
- switch_root will be installed from the system, if not present in the module dir
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
