From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: 90kernel-modules-loaded must be --hostonly
Date: Thu, 28 May 2009 14:26:11 -0400
Message-ID: <4A1ED743.3010107@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> /sbin/lsmod | while read mod rest; do
>         instmods "$mod"
> done

This part relies on looking at the running system, and thus must not be 
part of the default dracut run.  This seems OK for --hostonly mode.

Changing this will likely break some users depending on modules not 
otherwise pulled in elsewhere?  Should I just go ahead and see what breaks?

>
> [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
> dracut_install $(find /etc/modprobe.d/ -type f )

This part is fine.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
