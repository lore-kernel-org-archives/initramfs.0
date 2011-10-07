From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 1/4] convert_abs_rel() fixups
Date: Fri,  7 Oct 2011 22:23:49 +0200
Message-ID: <1318019032-12787-1-git-send-email-soltys@ziu.info>
References: <4E86385C.6040706@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- IFS was not preserved, and modified value could leak to outside functions

- the '.' relative path should be returned for arguments such as /x/y/z
  /x/y - but not for $1 == $2 ones

- $1 == $2 is self-looping link, so it returns final component of its
  name

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut-functions |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index c4f7f61..12dfa70 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -91,20 +91,24 @@ normalize_path() {
 }
 
 convert_abs_rel() {
-    local __current __absolute __abssize __cursize __i __level __newpath
+    local __current __absolute __abssize __cursize __newpath="" __oldifs
+    local -i __i __level=0
 #    PS4='${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';
 
-    if [[ "$1" == "$2" ]]
-    then
-        echo "."
-        return
-    fi
+    # corner case #1 - self looping link
+    [[ "$1" == "$2" ]] && { echo "${1##*/}"; return; }
+
+    # corner case #2 - own dir link
+    [[ "${1%/*}" == "$2" ]] && { echo "."; return; }
+
     __current=$(normalize_path "$1")
     __absolute=$(normalize_path "$2")
-    IFS="/"
 
+    __oldifs="$IFS"
+    IFS="/"
     __current=($__current)
     __absolute=($__absolute)
+    IFS="$__oldifs"
 
     __abssize=${#__absolute[@]}
     __cursize=${#__current[@]}
-- 
1.7.5.3
