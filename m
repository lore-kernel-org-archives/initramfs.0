From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 4/5] crypt: functions for ask-for-password and reading key
Date: Thu,  5 May 2011 13:34:20 +0200
Message-ID: <1304595261-11077-4-git-send-email-aidecoe@aidecoe.name>
References: <1304595261-11077-1-git-send-email-aidecoe@aidecoe.name>
 <1304595261-11077-2-git-send-email-aidecoe@aidecoe.name>
 <1304595261-11077-3-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1304595261-11077-3-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Asking for password and reading key parts are moved to separate
functions in crypt-lib.sh: ask_for_password and readkey.
---
 modules.d/90crypt/crypt-lib.sh     |  102 ++++++++++++++++++++++++++++++++++++
 modules.d/90crypt/cryptroot-ask.sh |   42 ++++-----------
 2 files changed, 113 insertions(+), 31 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index f423289..4bcd468 100644
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -4,6 +4,78 @@
 
 command -v getarg >/dev/null || . /lib/dracut-lib.sh
 
+# ask_for_password
+#
+# Wraps around plymouth ask-for-password and adds fallback to tty password ask
+# if plymouth is not present.
+#
+# --cmd command
+#   Command to execute. Required.
+# --prompt prompt
+#   Password prompt. Note that function already adds ':' at the end.
+#   Recommended.
+# --tries n
+#   How many times repeat command on its failure.  Default is 3.
+# --ply-[cmd|prompt|tries]
+#   Command/prompt/tries specific for plymouth password ask only.
+# --tty-[cmd|prompt|tries]
+#   Command/prompt/tries specific for tty password ask only.
+# --tty-echo-off
+#   Turn off input echo before tty command is executed and turn on after.
+#   It's useful when password is read from stdin.
+ask_for_password() {
+    local cmd; local prompt; local tries=3
+    local ply_cmd; local ply_prompt; local ply_tries=3
+    local tty_cmd; local tty_prompt; local tty_tries=3
+    local ret
+
+    while [ $# -gt 0 ]; do
+        case "$1" in
+            --cmd) ply_cmd="$2"; tty_cmd="$2" shift;;
+            --ply-cmd) ply_cmd="$2"; shift;;
+            --tty-cmd) tty_cmd="$2"; shift;;
+            --prompt) ply_prompt="$2"; tty_prompt="$2" shift;;
+            --ply-prompt) ply_prompt="$2"; shift;;
+            --tty-prompt) tty_prompt="$2"; shift;;
+            --tries) ply_tries="$2"; tty_tries="$2"; shift;;
+            --ply-tries) ply_tries="$2"; shift;;
+            --tty-tries) tty_tries="$2"; shift;;
+            --tty-echo-off) tty_echo_off=yes;;
+        esac
+        shift
+    done
+
+    { flock -s 9;
+        # Prompt for password with plymouth, if installed and running.
+        if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
+            /bin/plymouth ask-for-password \
+                --prompt "$ply_prompt" --number-of-tries=$ply_tries \
+                --command="$ply_cmd"
+            ret=$?
+        else
+            if [ "$tty_echo_off" = yes ]; then
+                stty_orig="$(stty -g)"
+                stty -echo
+            fi
+
+            local i=1
+            while [ $i -le $tty_tries ]; do
+                [ -n "$tty_prompt" ] && \
+                    printf "$tty_prompt [$i/$tty_tries]:" >&2
+                eval "$tty_cmd" && ret=0 && break
+                ret=$?
+                i=$(($i+1))
+                [ -n "$tty_prompt" ] && printf '\n' >&2
+            done
+
+            [ "$tty_echo_off" = yes ] && stty $stty_orig
+        fi
+    } 9>/.console.lock
+
+    [ $ret -ne 0 ] && echo "Wrong password" >&2
+    return $ret
+}
+
 # Try to mount specified device (by path, by UUID or by label) and check
 # the path with 'test'.
 #
@@ -118,3 +190,33 @@ getkey() {
 
     return 1
 }
+
+# readkey keypath keydev device
+#
+# Mounts <keydev>, reads key from file <keypath>, optionally processes it (e.g.
+# if encrypted with GPG) and prints to standard output which is supposed to be
+# read by cryptsetup.  <device> is just passed to helper function for
+# informational purpose.
+readkey() {
+    local keypath="$1"
+    local keydev="$2"
+    local device="$3"
+
+    local mntp=$(mkuniqdir /mnt keydev)
+    mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
+
+    case "${keypath##*.}" in
+        gpg)
+            if [ -f /lib/dracut-crypt-gpg-lib.sh ]; then
+                . /lib/dracut-crypt-gpg-lib.sh
+                gpg_decrypt "$mntp" "$keypath" "$keydev" "$device"
+            else
+                die "No GPG support to decrypt '$keypath' on '$keydev'."
+            fi
+            ;;
+        *) cat "$mntp/$keypath" ;;
+    esac 
+
+    umount "$mntp"
+    rmdir "$mntp"
+}
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 6c7f18d..252e3a0 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -76,38 +76,18 @@ if [ -n "$(getarg rd.luks.key)" ]; then
     fi
     unset tmp
 
-    mntp=$(mkuniqdir /mnt keydev)
-    mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
-    cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"
-    umount "$mntp"
-    rmdir "$mntp"
-    unset mntp keypath keydev
+    info "Using '$keypath' on '$keydev'"
+    readkey "$keypath" "$keydev" "$device" \
+        | cryptsetup -d - luksOpen "$device" "$luksname"
+    unset keypath keydev
 else
-    # Prompt for password with plymouth, if installed and running.
-    if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
-        prompt="Password [$device ($luksname)]:" 
-        if [ ${#luksname} -gt 8 ]; then
-            sluksname=${sluksname##luks-}
-            sluksname=${luksname%%${luksname##????????}}
-            prompt="Password for $device ($sluksname...)"
-        fi
-        
-        # flock against other interactive activities
-        { flock -s 9; 
-            /bin/plymouth ask-for-password \
-                --prompt "$prompt" --number-of-tries=5 \
-                --command="$(command -v cryptsetup) luksOpen -T1 $device $luksname"
-        } 9>/.console.lock
-        
-        unset sluksname prompt
-        
-    else
-        # flock against other interactive activities
-        { flock -s 9;
-            echo "$device ($luksname) is password protected"
-            cryptsetup luksOpen -T5 $device $luksname
-        } 9>/.console.lock
-    fi
+    luks_open="$(command -v cryptsetup) luksOpen"
+    ask_for_password --ply-tries 5 \
+        --ply-cmd "$luks_open -T1 $device $luksname" \
+        --ply-prompt "Password ($device)" \
+        --tty-tries 1 \
+        --tty-cmd "$luks_open -T5 $device $luksname"
+    unset luks_open
 fi
 
 unset device luksname
-- 
1.7.5.rc3
