From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: No stdout when using dash
Date: Sat, 23 May 2009 13:34:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


When using the 00dash module in dracut, the emergency_shell currently has 
no stderr.

Problem is related to dash closing stderr if opening /dev/tty fails.

I just triggered an update to dash in fedora F11 and rawhide fixing this 
behaviour.
This should make the emergency shell much easier to work with.

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
