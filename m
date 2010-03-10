From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add dcb support to dracut's FCoE support (rh563794)
Date: Wed, 10 Mar 2010 13:45:25 +0100
Message-ID: <1268225125-31720-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Note that there are still some patches queued upstream for fcoe-utils to
enable it to work with the new lldpad and to add support to fipvlan to
bring up FCoE connections without requiring fcoemon to run.

The invocations of the various tools as in this patch should be final though,
see the discussion in:
http://bugzilla.redhat.com/show_bug.cgi?id=563794
---
 modules.d/95fcoe/fcoe-up       |   14 +++++++++++++-
 modules.d/95fcoe/install       |   11 ++++++++++-
 modules.d/95fcoe/parse-fcoe.sh |    3 +--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/modules.d/95fcoe/fcoe-up b/modules.d/95fcoe/fcoe-up
index 8a70a62..bd6294a 100755
--- a/modules.d/95fcoe/fcoe-up
+++ b/modules.d/95fcoe/fcoe-up
@@ -6,6 +6,8 @@
 # Note currently only nodcb is supported, the dcb option is reserved for
 # future use.
 
+PATH=$PATH:/sbin:/usr/sbin
+
 # Huh? Missing arguments ??
 [ -z "$1" -o -z "$2" ] && exit 1
 
@@ -13,4 +15,14 @@ netif=$1
 dcb=$2
 
 /sbin/ip link set "$netif" up
-echo -n "$netif" > /sys/module/fcoe/parameters/create
+if [ "$dcb" = "dcb" ]; then
+    # Note lldpad will stay running after switchroot, the system initscripts
+    # are to kill it and start a new lldpad to take over. Data is transfered
+    # between the 2 using a shm segment
+    lldpad -d
+    dcbtool sc "$netif" dcb on
+    dcbtool sc "$netif" app:fcoe e:1 a:1 w:1
+    fipvlan "$netif" -c -s
+else
+    echo -n "$netif" > /sys/module/fcoe/parameters/create
+fi
diff --git a/modules.d/95fcoe/install b/modules.d/95fcoe/install
index 0bd9ed4..2cd702c 100755
--- a/modules.d/95fcoe/install
+++ b/modules.d/95fcoe/install
@@ -1,6 +1,15 @@
 #!/bin/bash
 
-dracut_install ip
+dracut_install ip dcbtool
+
+inst fipvlan
+# Not sure if fipvlan needs these, waiting for input from upstream on this
+mkdir -p "$initdir/etc/fcoe/scripts"
+cp -a /etc/fcoe/config "$initdir/etc/fcoe"
+cp -a /etc/fcoe/scripts/* "$initdir/etc/fcoe/scripts"
+
+inst lldpad
+mkdir -p "$initdir/var/lib/lldpad"
 
 inst "$moddir/fcoe-up" "/sbin/fcoe-up"
 inst_hook pre-udev 60 "$moddir/fcoe-genrules.sh"
diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index b35680f..26a5a1a 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -39,8 +39,7 @@ parse_fcoe_opts() {
 
 parse_fcoe_opts
 
-# currently only nodcb is supported
-if [ "$fcoe_dcb" != "nodcb" ] ; then
+if [ "$fcoe_dcb" != "nodcb" -a "$fcoe_dcb" != "dcb" ] ; then
     die "Invalid FCoE DCB option: $fcoe_dcb"
 fi
 
-- 
1.7.0
