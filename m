From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: rdblacklist intent?
Date: Wed, 17 Jun 2009 14:20:41 -0400
Message-ID: <4A3933F9.5080706@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

http://sourceforge.net/apps/trac/dracut/wiki/commandline
> Misc =B6
>
>     * rdblacklist=3D<modulename>
>           o TBD: do not load modulename


I'm not sure how this is supposed to work.  This page is full of kernel=
=20
cmdline parameters, but <modulename> no longer exists as an independent=
=20
named entity during initrd runtime.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
