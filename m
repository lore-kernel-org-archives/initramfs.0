From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 05/10] dracut: detect lib paths more carefully
Date: Tue, 18 Oct 2011 20:33:21 +0200
Message-ID: <1318962806-24000-6-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- consider that they can point to the same directory - in such case
  ignore the one that is a symlink
- move the detection function to dracut-functions

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut           |   12 ++----------
 dracut-functions |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/dracut b/dracut
index a93dade..115f1c4 100755
--- a/dracut
+++ b/dracut
@@ -456,16 +456,8 @@ ddebug "Executing $0 $dracut_args"
 }
 
 # Detect lib paths
-[[ $libdir ]] || for libdir in /lib64 /lib; do
-    [[ -d $libdir ]] && break
-done || {
-    dfatal 'No lib directory?!!!'
-    exit 1
-}
-
-[[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
-    [[ -d $usrlibdir ]] && break
-done || dwarn 'No usr/lib directory!'
+libdir="$(det_lib_paths)" || { dfatal 'No lib directory?!!!'; exit 1; }
+usrlibdir="$(det_lib_paths /usr)" || dwarn 'No usr/lib directory!'
 
 # This is kinda legacy -- eventually it should go away.
 case $dracutmodules in
diff --git a/dracut-functions b/dracut-functions
index 3b971c7..7b6aa5a 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -958,3 +958,24 @@ instmods() {
     | egrep -v 'FATAL: Module .* not found.' | derror
     return $?
 }
+
+# determine lib paths in specified prefix
+# if they point to the same, ignore the one that is a symlink
+# prefer lib64 over lib
+function det_lib_paths() {
+    local _lib _d _d64
+    _d=$(readlink -e "$1/lib")
+    _d64=$(readlink -e "$1/lib64")
+    if [[ $_d = $_d64 ]]; then
+        [[ -h $1/lib ]] && unset _d
+        [[ -h $1/lib64 ]] && unset _d64
+    fi
+    if [[ -n $_d64 ]]; then
+        _lib=$1/lib64
+    elif [[ -n $_d ]]; then
+        _lib=$1/lib
+    else
+        return 1
+    fi
+    echo "$_lib"
+}
-- 
1.7.5.3
