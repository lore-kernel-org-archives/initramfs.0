From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-functions.sh: move early mkdir code to dracut.sh
Date: Thu, 25 Jun 2015 10:08:02 +0800
Message-ID: <20150625020802.GA20085@dhcp-128-31.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Move early mkdir code to dracut.sh so that dracut-fuctions.sh can
be used by other components.

For example Fedora kdump mkdumprd uses several functions which were
copied from dracut-functions.sh, with this patch applied dracut-functions.sh
contains only functions so that we can remove the duplicate code in kdump.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh |   11 -----------
 dracut.sh           |   11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

Index: dracut/dracut-functions.sh
===================================================================
--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -19,17 +19,6 @@
 #
 export LC_MESSAGES=C
 
-if [[ $DRACUT_KERNEL_LAZY ]] && ! [[ $DRACUT_KERNEL_LAZY_HASHDIR ]]; then
-    if ! [[ -d "$initdir/.kernelmodseen" ]]; then
-        mkdir -p "$initdir/.kernelmodseen"
-    fi
-    DRACUT_KERNEL_LAZY_HASHDIR="$initdir/.kernelmodseen"
-fi
-
-if [[ $initdir ]] && ! [[ -d $initdir ]]; then
-    mkdir -p "$initdir"
-fi
-
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ $1 = *"$2"* ]]; }
 # Generic glob matching function. If glob pattern $2 matches anywhere in $1, OK
Index: dracut/dracut.sh
===================================================================
--- dracut.orig/dracut.sh
+++ dracut/dracut.sh
@@ -917,6 +917,17 @@ if [[ -f $dracutbasedir/dracut-version.s
     . $dracutbasedir/dracut-version.sh
 fi
 
+if [[ $DRACUT_KERNEL_LAZY ]] && ! [[ $DRACUT_KERNEL_LAZY_HASHDIR ]]; then
+    if ! [[ -d "$initdir/.kernelmodseen" ]]; then
+        mkdir -p "$initdir/.kernelmodseen"
+    fi
+    DRACUT_KERNEL_LAZY_HASHDIR="$initdir/.kernelmodseen"
+fi
+
+if [[ $initdir ]] && ! [[ -d $initdir ]]; then
+    mkdir -p "$initdir"
+fi
+
 if [[ -f $dracutbasedir/dracut-functions.sh ]]; then
     . $dracutbasedir/dracut-functions.sh
 else
