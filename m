From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] strip "init=" from INIT
Date: Wed, 04 Mar 2009 13:48:42 +0100
Message-ID: <49AE78AA.8070401@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090006060006040200090609"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------090006060006040200090609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090006060006040200090609
Content-Type: text/plain;
 name="0001-strip-init-from-INIT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-strip-init-from-INIT.patch"

From 5e043b9fd529b1cfb0358a69f263b84620ffbd1b Mon Sep 17 00:00:00 2001
From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 4 Mar 2009 13:45:21 +0100
Subject: [PATCH] strip "init=" from INIT

---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 581c2b9..9605141 100755
--- a/init
+++ b/init
@@ -90,7 +90,7 @@ ln -s "$root" /dev/root
 fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
 mount $fstype -o $rflags /dev/root $NEWROOT || emergency_shell
 
-INIT=$(getarg init)
+INIT=$(getarg init); INIT=${INIT#init=}
 [ "$INIT" ] || {
     for i in /sbin/init /etc/init /init /bin/sh; do
 	[ -x "$NEWROOT$i" ] && { INIT="$i"; break; }
-- 
1.6.0.6


--------------090006060006040200090609--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
