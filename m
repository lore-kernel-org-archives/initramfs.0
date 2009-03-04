From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: /usr/libexec/dracut/ -> /usr/lib/dracut/
Date: Wed, 4 Mar 2009 11:28:07 +0100
Message-ID: <ac3eb2510903040228v636ce1b6y5c74aa9bef1bef7f@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Any objection to replace "libexec" with "lib"?

According to LSB/FHS, applications are required to use a named
directory in /usr/lib/:
  http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA
Some distros, like e.g. SUSE, don't allow packages to use libexec at all.

Would be nice, if we could do something like:
  sed -i 's#/usr/libexec/dracut#/usr/lib/dracut#' Makefile dracut dracut.spec

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
