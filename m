From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 5/4] dracut-functions: conv/normalize minor corrections
Date: Sat,  8 Oct 2011 00:20:50 +0200
Message-ID: <1318026050-5891-2-git-send-email-soltys@ziu.info>
References: <1318026050-5891-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318026050-5891-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
In-Reply-To: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
References: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

mostly with reference to earlier commit:

- bash doesn't need unsetting locals
- make normalize_path() a bit faster, also make sure we remove all
  trailing slashes
- normalize paths before tests

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut-functions |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 12dfa70..ce593c9 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -83,31 +83,29 @@ print_vars() {
 }
 
 normalize_path() {
-    p=$1
-    while [[ ${p#*//*} != $p ]]; do
-        p=${p/\/\///}
-    done
-    echo $p
+    shopt -q -s extglob
+    set -- "${1//+(\/)//}"
+    shopt -q -u extglob
+    echo "${1%/}"
 }
 
 convert_abs_rel() {
-    local __current __absolute __abssize __cursize __newpath="" __oldifs
-    local -i __i __level=0
+    local __current __absolute __abssize __cursize __newpath __oldifs
+    local -i __i __level
 #    PS4='${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';
 
+    set -- "$(normalize_path "$1")" "$(normalize_path "$2")"
+
     # corner case #1 - self looping link
     [[ "$1" == "$2" ]] && { echo "${1##*/}"; return; }
 
     # corner case #2 - own dir link
     [[ "${1%/*}" == "$2" ]] && { echo "."; return; }
 
-    __current=$(normalize_path "$1")
-    __absolute=$(normalize_path "$2")
-
     __oldifs="$IFS"
     IFS="/"
-    __current=($__current)
-    __absolute=($__absolute)
+    __current=($1)
+    __absolute=($2)
     IFS="$__oldifs"
 
     __abssize=${#__absolute[@]}
-- 
1.7.5.3
