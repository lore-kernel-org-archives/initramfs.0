From: leho <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] (wip) successfully unlocks LUKS devices from an encrypted loop file
Date: Wed, 27 Apr 2011 11:30:12 +0300
Message-ID: <1303893012-10923-2-git-send-email-leho@kraav.com>
References: <1303893012-10923-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303893012-10923-1-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: leho <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>

---
 modules.d/90crypt/crypt-lib.sh     |   11 +++++++
 modules.d/90crypt/cryptroot-ask.sh |   52 ++++++++++++++++++++++++++++++++++-
 modules.d/90crypt/parse-keydev.sh  |    2 +
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 26f9950..449041a 100644
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -20,6 +20,17 @@ test_dev() {
     if mount -r "$dev" "$mount_point" >/dev/null 2>&1; then
         test $test_op "${mount_point}/${f}"
         ret=$?
+        if [ ${f##*.} = "img" ]; then
+            local l
+            l=`losetup -f`
+            losetup $l "${mount_point}/${f}"
+            ret=$?
+
+            # Something seems to be locking our loop device
+            while ! losetup -d $l; do
+                sleep 0.5
+            done 
+        fi
         umount "$mount_point"
     fi
 
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 6c7f18d..4411381 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -76,12 +76,57 @@ if [ -n "$(getarg rd.luks.key)" ]; then
     fi
     unset tmp
 
+    local keyfile
+
     mntp=$(mkuniqdir /mnt keydev)
     mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
-    cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"
+    keyfile="$mntp/$keypath"
+
+    if [ ${keypath##*.} = "img" ]; then
+        local l
+        info "We have a loop key container $keypath, doing cryptsetup magic on it now"
+        l=`losetup -f`
+        losetup $l $keyfile
+        # Sucky non-DRY approach here, should this password asking function be moved to crypt-lib.sh?
+        # Prompt for password with plymouth, if installed and running.
+        # Does plymouth cache entered passwords based on $prompt? I'm unlocking
+        # multiple devices and not getting a second password prompt, while the
+        # second device becomes successfully unlocked
+        if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
+            # Does plymouth also append :? I'm seeing Password:: prompt
+            prompt="Password" 
+            
+            # flock against other interactive activities
+            { flock -s 9; 
+                /bin/plymouth ask-for-password \
+                    --prompt "$prompt" --number-of-tries=5 \
+                    --command="$(command -v cryptsetup) luksOpen -T1 $l loopkey-$2" || warn 'Unlocking keyfile failed!'
+            } 9>/.console.lock
+            
+            unset prompt
+            
+        else
+            # flock against other interactive activities
+            { flock -s 9;
+                echo "$keyfile is password protected"
+                cryptsetup luksOpen -T5 $l loopkey-$2 || warn 'Unlocking keyfile failed!' 
+            } 9>/.console.lock
+        fi
+        # End sucky non-DRY approach
+
+        [ -b /dev/mapper/loopkey-$2 ] && keyfile=/dev/mapper/loopkey-$2 || warn 'Keyfile block device not found!' 
+    fi
+
+    cryptsetup -d "$keyfile" luksOpen "$device" "$luksname"
+
+    if [ -n $l ]; then
+        cryptsetup luksClose /dev/mapper/loopkey-$2 
+        losetup -d $l
+    fi
+
     umount "$mntp"
     rmdir "$mntp"
-    unset mntp keypath keydev
+    unset mntp keypath keydev keyfile
 else
     # Prompt for password with plymouth, if installed and running.
     if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
@@ -115,6 +160,9 @@ unset device luksname
 # mark device as asked
 >> /tmp/cryptroot-asked-$2
 
+# This somewhat fails when you have to assemble a multiple-device btrfs filesystem.
+# You have to make sure that your root=luks-UUID is the last one unlocked, otherwise
+# dracut thinks it has your rootfs in the middle of unlockings.
 udevsettle
 
 exit 0
diff --git a/modules.d/90crypt/parse-keydev.sh b/modules.d/90crypt/parse-keydev.sh
index 01cca58..9eb25df 100644
--- a/modules.d/90crypt/parse-keydev.sh
+++ b/modules.d/90crypt/parse-keydev.sh
@@ -17,6 +17,8 @@ if getargbool 1 rd.luks -n rd_NO_LUKS && \
         if [ -z "$keypath" ]; then
             warn 'keypath required!'
             continue
+        elif [ ${keypath##*.} = "img" ]; then
+            info 'keyfile has .img suffix, treating it as LUKS-encrypted loop keyfile container' 
         fi
 
         if [ -n "$keydev" ]; then
-- 
1.7.3.4
