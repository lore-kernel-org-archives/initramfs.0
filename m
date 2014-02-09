From: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] Cryptroot-ask.sh: Use variables consistently
Date: Sun,  9 Feb 2014 09:08:42 +0100
Message-ID: <1391933322-17308-1-git-send-email-opensource@till.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>

- Always use $luksname instead of sometimes $2
- define $asked_file instead of using the same path twice
---
 modules.d/90crypt/cryptroot-ask.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 9665e48..1ab03bc 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -8,19 +8,21 @@ NEWROOT=${NEWROOT:-"/sysroot"}
 # do not ask, if we already have root
 [ -f $NEWROOT/proc ] && exit 0
 
+# default luksname - luks-UUID
+luksname=$2
+
 # check if destination already exists
-[ -b /dev/mapper/$2 ] && exit 0
+[ -b /dev/mapper/luksname ] && exit 0
 
 # we already asked for this device
-[ -f /tmp/cryptroot-asked-$2 ] && exit 0
+asked_file=/tmp/cryptroot-asked-$luksname
+[ -f $asked_file ] && exit 0
 
 # load dm_crypt if it is not already loaded
 [ -d /sys/module/dm_crypt ] || modprobe dm_crypt
 
 . /lib/dracut-crypt-lib.sh
 
-# default luksname - luks-UUID
-luksname=$2
 
 # fallback to passphrase
 ask_passphrase=1
@@ -45,7 +47,7 @@ if [ -f /etc/crypttab ] && getargbool 1 rd.luks.crypttab -d -n rd_NO_CRYPTTAB; t
 
         # UUID used in crypttab
         if [ "${dev%%=*}" = "UUID" ]; then
-            if [ "luks-${dev##UUID=}" = "$2" ]; then
+            if [ "luks-${dev##UUID=}" = "$luksname" ]; then
                 luksname="$name"
                 break
             fi
@@ -157,7 +159,7 @@ fi
 unset device luksname luksfile
 
 # mark device as asked
->> /tmp/cryptroot-asked-$2
+>> $asked_file
 
 need_shutdown
 udevsettle
-- 
1.8.3.1
