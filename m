From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. 8c4549ff18aa27d46969db8deb32725be6ecaf35
Date: Thu,  3 Feb 2011 11:48:03 +0000
Message-ID: <E1PkxfX-0002sC-4L@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  8c4549ff18aa27d46969db8deb32725be6ecaf35 (commit)
       via  ca77f36f8e9995072de0309fb670765187e432bc (commit)
      from  f4dad880857d7c2f11d27cf8450071754e9a3ac7 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 8c4549ff18aa27d46969db8deb32725be6ecaf35
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 13:34:34 2011 +0100

    multipath: use new "-B" parameter

diff --git a/modules.d/90multipath/multipathd.sh b/modules.d/90multipath/multipathd.sh
index c9a2b3f..2f8460f 100755
--- a/modules.d/90multipath/multipathd.sh
+++ b/modules.d/90multipath/multipathd.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-if [ -e /etc/multipath.conf -a -e /etc/multipath/wwids ]; then
+if [ -e /etc/multipath.conf ]; then
     modprobe dm-multipath
-    multipathd
+    multipathd -B || multipathd
 else
     rm /etc/udev/rules.d/??-multipath.rules 2>/dev/null    
 fi
commit ca77f36f8e9995072de0309fb670765187e432bc
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 14:48:37 2011 +0100

    fips: add aes-xts module

diff --git a/modules.d/01fips/installkernel b/modules.d/01fips/installkernel
index bce58e4..6cb2dc0 100755
--- a/modules.d/01fips/installkernel
+++ b/modules.d/01fips/installkernel
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-FIPSMODULES="aead aes_generic aes-x86_64 ansi_cprng cbc ccm chainiv ctr"
+FIPSMODULES="aead aes_generic aes-xts aes-x86_64 ansi_cprng cbc ccm chainiv ctr"
 FIPSMODULES="$FIPSMODULES des deflate ecb eseqiv hmac seqiv sha256 sha512"
 FIPSMODULES="$FIPSMODULES cryptomgr crypto_null tcrypt" 
 
-----------------------------------------------------------------------

Summary of changes:
 modules.d/01fips/installkernel      |    2 +-
 modules.d/90multipath/multipathd.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


-- 
dracut - Initramfs generator using udev
