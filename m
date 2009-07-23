From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Race condition? /tmp/net.ifaces and pre-pivot
Date: Thu, 23 Jul 2009 17:37:44 -0400
Message-ID: <4A68D828.40506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I am running into an odd issue that is supposedto be impossible.

pre-pivot/20write-ifcfg.sh is often being run but fails to write 
net.*.ifcfg files because /tmp/net.ifaces does not exist at that moment. 
  The mount was otherwise successful, and rdbreak before switch_root 
sees that /tmp/net.ifaces exists.

With plain "root=dhcp" with a NFS rootfs, it seems to never happen. 
However with "root=dhcp bridge", perhaps 25-75% of the time it is 
failing to write ifcfg files.

Some kind of race going on?  An inspection of the code seems to me that 
/tmp/net.ifaces should have already been created prior to pre-pivot?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
