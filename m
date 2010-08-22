From: Matt Smith <shadowfax-KK0ffGbhmjU@public.gmane.org>
Subject: [PATCH] Merged cryptroot-ask.sh from plymouth to crypt module.
Date: Sat, 21 Aug 2010 18:59:10 -0600
Message-ID: <1282438750-22161-1-git-send-email-shadowfax@gmx.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

First, it's duplicate code.

Second, it did not allow those who had plymouth installed to use other
methods, like the new usb key file. When building the initram,
it would install the plymouth cryptroot-ask script, and not
the crypt module one.

Added these new items to crypt module's cryptroot-ask.sh:
  - 'unset' for used variables
  - udevsettle

The non-plymouth cryptsetup prompt was using $1 instead of $device.
Changed prompt number from 1 to 5, as this is much nicer.
I believe plymouth already does infinite prompts.

Also added unset for usb key. Just saw it didn't unset its vars.
---
 modules.d/50plymouth/cryptroot-ask.sh |   76 ---------------------------------
 modules.d/50plymouth/install          |    3 +-
 modules.d/90crypt/cryptroot-ask.sh    |   36 +++++++++++++--
 3 files changed, 32 insertions(+), 83 deletions(-)
 delete mode 100755 modules.d/50plymouth/cryptroot-ask.sh

diff --git a/modules.d/50plymouth/cryptroot-ask.sh b/modules.d/50plymouth/cryptroot-ask.sh
deleted file mode 100755
index d1c4770..0000000
--- a/modules.d/50plymouth/cryptroot-ask.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/sh
-
-# do not ask, if we already have root
-[ -f /sysroot/proc ] && exit 0
-
-# check if destination already exists
-[ -b /dev/mapper/$2 ] && exit 0
-
-# we already asked for this device
-[ -f /tmp/cryptroot-asked-$2 ] && exit 0
-
-# load dm_crypt if it is not already loaded
-[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
-
-. /lib/dracut-lib.sh
-
-# default luksname - luks-UUID
-luksname=$2
-
-# if device name is /dev/dm-X, convert to /dev/mapper/name
-if [ "${1##/dev/dm-}" != "$1" ]; then
-    device="/dev/mapper/$(dmsetup info -c --noheadings -o name "$1")"
-else
-    device="$1"
-fi
-
-if [ -f /etc/crypttab ] && ! getarg rd_NO_CRYPTTAB; then
-    while read name dev rest; do
-	# ignore blank lines and comments
-	if [ -z "$name" -o "${name#\#}" != "$name" ]; then
-	    continue
-	fi
-
-	# UUID used in crypttab
-	if [ "${dev%%=*}" = "UUID" ]; then
-	    if [ "luks-${dev##UUID=}" = "$2" ]; then
-		luksname="$name"
-		break
-	    fi
-	
-	# path used in crypttab
-	else
-	    cdev=$(readlink -f $dev)
-	    mdev=$(readlink -f $device)
-	    if [ "$cdev" = "$mdev" ]; then
-		luksname="$name"
-		break
-	    fi
-	fi
-    done < /etc/crypttab
-    unset name dev rest
-fi
-
-prompt="Password [$device ($luksname)]:" 
-if [ ${#luksname} -gt 8 ]; then
-    sluksname=${sluksname##luks-}
-    sluksname=${luksname%%${luksname##????????}}
-    prompt="Password for $device ($sluksname...)"
-fi
-
-# flock against other interactive activities
-{ flock -s 9; 
-    /bin/plymouth ask-for-password \
-	--prompt "$prompt" \
-	--command="/sbin/cryptsetup luksOpen -T1 $device $luksname"
-} 9>/.console.lock
-
-unset ask device luksname
-
-# mark device as asked
->> /tmp/cryptroot-asked-$2
-
-udevsettle
-
-exit 0
-# vim:ts=8:sw=4:sts=4:et
diff --git a/modules.d/50plymouth/install b/modules.d/50plymouth/install
index 86d8efd..ba5ef89 100755
--- a/modules.d/50plymouth/install
+++ b/modules.d/50plymouth/install
@@ -12,5 +12,4 @@ fi
 inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
 inst_hook pre-trigger 10 "$moddir"/plymouth-pretrigger.sh
 inst_hook emergency 50 "$moddir"/plymouth-emergency.sh
-inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
-inst readlink
\ No newline at end of file
+inst readlink
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 8bed056..efec56c 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -117,16 +117,42 @@ if [ -n "$keydev_uuid" ]; then
     cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"
     umount "$mntp"
     rmdir -p "$mntp" 2>/dev/null
+    unset mntp keypath keydev_uuid
 else
-    # flock against other interactive activities
-    { flock -s 9;
-        echo -n "$device ($luksname) is password protected"
-        cryptsetup luksOpen -T1 $1 $luksname
-    } 9>/.console.lock
+    # Prompt for password with plymouth, if installed.
+    # Should we check if plymouthd is running?
+    if [ -x /bin/plymouth ]; then
+        prompt="Password [$device ($luksname)]:" 
+        if [ ${#luksname} -gt 8 ]; then
+            sluksname=${sluksname##luks-}
+            sluksname=${luksname%%${luksname##????????}}
+            prompt="Password for $device ($sluksname...)"
+        fi
+        
+	# flock against other interactive activities
+        { flock -s 9; 
+            /bin/plymouth ask-for-password \
+	        --prompt "$prompt" \
+	        --command="/sbin/cryptsetup luksOpen -T1 $device $luksname"
+        } 9>/.console.lock
+	
+	unset sluksname prompt
+	
+    else
+        # flock against other interactive activities
+        { flock -s 9;
+             echo "$device ($luksname) is password protected"
+             cryptsetup luksOpen -T5 $device $luksname
+        } 9>/.console.lock
+    fi
 fi
 
+unset device luksname
+
 # mark device as asked
 >> /tmp/cryptroot-asked-$2
 
+udevsettle
+
 exit 0
 # vim:ts=8:sw=4:sts=4:et
-- 
1.7.2.1
