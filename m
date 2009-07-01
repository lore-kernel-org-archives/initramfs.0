From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: netroot= IRC
Date: Wed, 01 Jul 2009 08:13:54 -0400
Message-ID: <4A4B5302.5030004@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> <haraldh> yep
> <haraldh> user:password is not for the command line, you say
> <haraldh> dhcp root_path could be used
> <haraldh> and config files
> <haraldh> ah, damn.. forgot that warren removed "netroot="
> <haraldh> it's called "root-path=" now :)
> <haraldh> hansg, !

I only removed netroot= for NFS because it was a redundant variation.

There is nothing called root-path= anywhere that I know.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
