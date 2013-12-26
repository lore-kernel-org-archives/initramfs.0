From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] crypt: Prevent asking for password multiple times if non-default crypt name is used.
Date: Thu, 26 Dec 2013 21:26:22 +0000
Message-ID: <1388093183-19045-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

If a non-default device mapper name is used for an encrypted partion is
used, (i.e. not luks-$UUID) due to parsing of /etc/crypttab, then the
short-circuits put in place to prevent asking the password twice do not
work.

This would not normally be an issue as the settled job itself should be
removed after it has run and thus cannot be run again. Sadly, due to
the corresponding udev rule using ACTION="add|changed", and the fact
that trying to unlock the device (whether successful or not) seems to
trigger a changed event, it means the settled job is recreated with
each itteration thus causing the whole loop to run again.

It is this situation that the short-circuit exits would normally come
into play but sadly do not work when non-standard names are used.

By the time the /tmp/cryptroot-asked-$2 file is written near the end of
the script, the value of $2 has already been lost due to the argument
parsing code's use of 'shift'. So while on systems where the default
name is used are protected by checking /dev/mapper/xxxx, the
/tmp/cryptroot-asked-$2 file didn't help on systems where this was not
used due to this bug.

So this commit shuffles things around somewhat such that:

 1. The /dev/mapper/xxxx device is checked *after* resolving $2 (which
    contains the default name) to whatever /etc/crypttab specifies.
 2. The cryptroot-asked-xxxx file also uses the translated name both
    for the initial check and to flag when it's written.

As a separate fix, it might make sense to change the udev rule to only
act on add events rather than add|change events, but I'm not sure of the
ramifications of such a change and there may be cases where the add
event is missed and thus the change event needs to be included.
---
 modules.d/90crypt/cryptroot-ask.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 9665e48..cf13069 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -8,20 +8,6 @@ NEWROOT=${NEWROOT:-"/sysroot"}
 # do not ask, if we already have root
 [ -f $NEWROOT/proc ] && exit 0
 
-# check if destination already exists
-[ -b /dev/mapper/$2 ] && exit 0
-
-# we already asked for this device
-[ -f /tmp/cryptroot-asked-$2 ] && exit 0
-
-# load dm_crypt if it is not already loaded
-[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
-
-. /lib/dracut-crypt-lib.sh
-
-# default luksname - luks-UUID
-luksname=$2
-
 # fallback to passphrase
 ask_passphrase=1
 
@@ -32,6 +18,9 @@ else
     device="$1"
 fi
 
+# default luksname - luks-UUID
+luksname=$2
+
 # number of tries
 numtries=${3:-10}
 
@@ -63,6 +52,17 @@ if [ -f /etc/crypttab ] && getargbool 1 rd.luks.crypttab -d -n rd_NO_CRYPTTAB; t
     unset name dev
 fi
 
+# check if destination already exists
+[ -b /dev/mapper/$luksname ] && exit 0
+
+# we already asked for this device
+[ -f /tmp/cryptroot-asked-$luksname ] && exit 0
+
+# load dm_crypt if it is not already loaded
+[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
+
+. /lib/dracut-crypt-lib.sh
+
 #
 # Open LUKS device
 #
@@ -157,7 +157,7 @@ fi
 unset device luksname luksfile
 
 # mark device as asked
->> /tmp/cryptroot-asked-$2
+>> /tmp/cryptroot-asked-$luksname
 
 need_shutdown
 udevsettle
-- 
1.8.4.5
