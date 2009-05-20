From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: --include functionality?
Date: Wed, 20 May 2009 18:22:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905201806160.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Dracut currently has a "--include a b" switch which does copy a/* into 
initrd/b/.

Is there a real-world use case for this?

Otherwise I'd like to recycle --include to accept a list of files which 
are dracut-install()ed into the initrd image.
This would allow simple one-shot inclusion of tools such as strace without 
having to modify modules such as 95debug.

If there's a real-world use case for the original --include functionality, 
I'd have to come up with a differently named switch.

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
