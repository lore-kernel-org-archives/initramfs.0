From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: TODO: instmods() firmware is broken
Date: Thu, 28 May 2009 15:06:31 -0400
Message-ID: <4A1EE0B7.4030907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Note this as a TODO if you want some drivers to be usable during the initrd.

dracut-functions instmods() seems to be broken in that it only looks for 
firmware in cases where instmods() was called with a single module as a 
parameter.  Most drivers are copied by dracut as the result of 
=groupname groups, thus firmware is not being copied for storage and 
network drivers.

A better fix might be to wait until all installs are done, then run a 
modinfo loop across all copied .ko's to install all firmware?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
