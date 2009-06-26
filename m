From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: TODO: Legacy NFS should be root= only
Date: Fri, 26 Jun 2009 00:26:21 -0400
Message-ID: <4A444DED.7040601@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

mkinitrd Legacy
	root=IP:path
	(IP:path is OK in DHCP root-path too.)
nfsroot.tx Legacy
	root=/dev/nfs [nfsroot=...]

netroot= equivalents of the two Legacy we shouldn't support.  They are 
not from legacy precedents.

(I tried to get de-support netroot= by unconditionally netroot=$root, 
but the argument parser can't recognize root=dhcp in that case.  Dillow 
says he has an idea to split and clean up argument parsing.)

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
