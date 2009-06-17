From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Reminder: /tmp/net.$netif.* files
Date: Wed, 17 Jun 2009 13:57:10 -0400
Message-ID: <4A392E76.5020909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

If you write a file to /tmp/net.$netif.* please be sure it only exists 
if that interface ends up as part of the netboot.  The net.* files are 
to be considered post-switch_root by initscripts or NetworkManager.  We 
don't want those tools to be confused by net.* files from aborted 
interfaces that were not part of the netboot.

A tricky part might be ensuring net.* files for constituent interfaces 
part of layered interfaces like bridges or bonds, in addition to net.* 
files for the bridge or bond.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
