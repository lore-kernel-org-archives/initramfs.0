From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: generic vs. host-only
Date: Sat, 07 Mar 2009 14:02:17 +0100
Message-ID: <49B27059.7010303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Seewer Philippe proposed dracutmodules="hostonly" and to change "$mod/check".

all:
	install everything and fail, if we can't

auto:
	install everything we can and skip those we cannot

host-only:
	install everything we can but only what is needed for the local host

	Also for the host-only case, we shouldn't check for e.g. dm_mod in
	/proc/modules, because it can be compiled in. We could use blkid.

I know that dracut was started to eliminate the "host-only" strategy, but as it
is a configurable option, we might include it nevertheless for the sake of boot
speed and initrd size, if wanted by a poweruser, who knows what he does.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
