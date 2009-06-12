From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 1/5] Add "die" and some minor changes in base
Date: Fri, 12 Jun 2009 17:11:49 +0200
Message-ID: <4A327035.6060100@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
 modules.d/99base/dracut-lib         |    6 ++++++
 modules.d/99base/init               |   14 +++-----------
 modules.d/99base/parse-root-opts.sh |    1 -
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
index df9cb52..336b235 100644
--- a/modules.d/99base/dracut-lib
+++ b/modules.d/99base/dracut-lib
@@ -21,6 +21,12 @@ source_all() {
     for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
 }
 
+die() {
+    printf "FATAL: $1\n"
+    printf "Refusing to continue\n"
+    exit 1
+}
+
 check_occurances() {
     # Count the number of times the character $ch occurs in $str
     # Return 0 if the count matches the expected number, 1 otherwise
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 998f5e6..ec9c785 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -41,17 +41,8 @@ mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 getarg 'rdbreak=cmdline' && emergency_shell
 source_all cmdline
 
-if [ -z "$rootok" -a -n "${root%%error:*}" ]; then
-    root="error: No handler for root=${root}"
-fi
-
-if [ -n "$root" -a -z "${root%%error:*}" ]; then
-    case "${root%%:*}" in
-       '') echo "FATAL: no root= option specified, and no network support" ;;
-       error) echo "FATAL: ${root#error:}" ;;
-    esac
-    emergency_shell
-fi
+[ -z "$root" ] && die "No or empty root= argument"
+[ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
 
 # Network root scripts may need updated root= options,
 # so deposit them where they can see them (udev purges the env)
@@ -59,6 +50,7 @@ fi
     echo "root='$root'"
     echo "rflags='$rflags'"
     echo "fstype='$fstype'"
+    echo "netroot='$netroot'"
     echo "NEWROOT='$NEWROOT'"
 } > /tmp/root.info
 
diff --git a/modules.d/99base/parse-root-opts.sh b/modules.d/99base/parse-root-opts.sh
index 7fc4f47..e253110 100755
--- a/modules.d/99base/parse-root-opts.sh
+++ b/modules.d/99base/parse-root-opts.sh
@@ -11,4 +11,3 @@ if [ -z "$fstype" ]; then
     fstype="auto"
 fi
 
-export fstype rflags root

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
