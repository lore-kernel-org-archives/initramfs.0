From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Fix rd.blacklist.driver when no /etc/modprobe.d exists
Date: Tue,  6 Nov 2012 00:39:04 +0100
Message-ID: <1352158744-14408-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=c5dM/rsfDCJt5k1AmhJQMo8eTHFUNMde6p7oHynckuI=;
        b=KOJDBLrSKflt+J9Rfba0DLMLqtuShTmV2qSpMX+biw8pbLkb1j3hlWKhwAZWIKVCXT
         4VDQKTnqbQ9DmicbgbqCO6oEcyICYh7KAkO8ttpaRVawuUK9k9o5Zzzx6bonqHI4vDBr
         JD3Nfrit+x0olUqUU38Cqj8Ax9ducPU3w0zZ+G4wxVA+04GqTRoSiv/jFm0gzOzBbtE6
         x9xpY3msIqNtOBnceNiUjGDTofxygdZFKQ61aiYzXB0TfQ48ORJpWQs0wCO3qVa6r5mp
         TbWHHlI09udogTDEOs9trv5ToHHv+7RkTZLO4og14YRDK/a6Im6387MZcgenQw1Gwpo4
         pq7Q==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This bug was reported as http://bugzilla.redhat.com/873220#c2

As the /etc/modprobe.d isn't created in the boot process
nor bundled within the initramfs, the initramfsblacklist.conf
cannot be created.

Instead, the /usr/lib/modprobe.d directory is available and using it
will restore the blacklist behavior.
---
 modules.d/90kernel-modules/parse-kernel.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/modules.d/90kernel-modules/parse-kernel.sh b/modules.d/90kernel-modules/parse-kernel.sh
index 485528b..7470905 100755
--- a/modules.d/90kernel-modules/parse-kernel.sh
+++ b/modules.d/90kernel-modules/parse-kernel.sh
@@ -2,6 +2,15 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+_modprobe_d=/etc/modprobe.d
+if [ -d /usr/lib/modprobe.d ] ; then
+    _modprobe_d=/usr/lib/modprobe.d
+elif [ -d /lib/modprobe.d ] ; then
+    _modprobe_d=/lib/modprobe.d
+elif [ ! -d $_modprobe_d ] ; then
+    mkdir -p $_modprobe_d
+fi
+
 for i in $(getargs rd.driver.pre -d rdloaddriver=); do
     (
         IFS=,
@@ -15,15 +24,15 @@ for i in $(getargs rd.driver.blacklist -d rdblacklist=); do
     (
         IFS=,
         for p in $i; do
-            echo "blacklist $p" >> /etc/modprobe.d/initramfsblacklist.conf
+            echo "blacklist $p" >>  $_modprobe_d/initramfsblacklist.conf
         done
     )
 done
 
 for p in $(getargs rd.driver.post -d rdinsmodpost=); do
-    echo "blacklist $p" >> /etc/modprobe.d/initramfsblacklist.conf
+    echo "blacklist $p" >>  $_modprobe_d/initramfsblacklist.conf
     _do_insmodpost=1
 done
 
 [ -n "$_do_insmodpost" ] && initqueue --settled --unique --onetime insmodpost.sh
-unset _do_insmodpost
+unset _do_insmodpost _modprobe_d
-- 
1.7.11.7
