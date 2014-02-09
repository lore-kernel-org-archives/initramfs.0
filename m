From: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] Cryptroot-ask.sh: Remove duplicate code
Date: Sun,  9 Feb 2014 16:17:03 +0100
Message-ID: <1391959023-8840-1-git-send-email-opensource@till.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>

Remove duplicate code introduced with commit
9b5e2e8574577cd4ec1e3645255060f749490537.
---
 modules.d/90crypt/cryptroot-ask.sh | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 1c3e792..2c8bba0 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -10,24 +10,6 @@ NEWROOT=${NEWROOT:-"/sysroot"}
 
 . /lib/dracut-lib.sh
 
-# default luksname - luks-UUID
-luksname=$2
-
-# check if destination already exists
-[ -b /dev/mapper/luksname ] && exit 0
-
-# we already asked for this device
-asked_file=/tmp/cryptroot-asked-$luksname
-[ -f $asked_file ] && exit 0
-
-# load dm_crypt if it is not already loaded
-[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
-
-. /lib/dracut-crypt-lib.sh
-
-# fallback to passphrase
-ask_passphrase=1
-
 # if device name is /dev/dm-X, convert to /dev/mapper/name
 if [ "${1##/dev/dm-}" != "$1" ]; then
     device="/dev/mapper/$(dmsetup info -c --noheadings -o name "$1")"
@@ -73,7 +55,8 @@ fi
 [ -b /dev/mapper/$luksname ] && exit 0
 
 # we already asked for this device
-[ -f /tmp/cryptroot-asked-$luksname ] && exit 0
+asked_file=/tmp/cryptroot-asked-$luksname
+[ -f $asked_file ] && exit 0
 
 # load dm_crypt if it is not already loaded
 [ -d /sys/module/dm_crypt ] || modprobe dm_crypt
-- 
1.8.3.1
