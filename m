From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: iSCSI and root
Date: Tue, 02 Jun 2009 18:10:21 +0200
Message-ID: <4A254EED.3080902@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Because root=dhcp with root_path=iscsi:.. or root=iscsi:... would just add a 
harddisk to the system, we still might want a root=/dev/... to specify the path 
to the root partition.

Or should we just mount the whole disk? If so, how do we detect the newly added 
disk after iscsistart? Do we add a udev rule to mount it?

We might want to use the code from /lib/udev/path_id, which parses 
$full_sysfs_device_path and scans for  */session[0-9]*/*

Any suggestions?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
