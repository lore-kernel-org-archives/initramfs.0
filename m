From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/8] inst_simple, inst_dir: make fast case faster
Date: Tue, 30 Aug 2011 21:39:19 -0700
Message-ID: <4E5DBAF7.1010401@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This small stuff saves 1.7% per dropped statement during "dracut --profile".
Fixing the comment about /lib -> lib64 is REQUIRED!

---
 dracut-functions |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index c28766e..f6ffa1d 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -266,19 +266,13 @@ check_vol_slaves() {
 }
  # Install a directory, keeping symlinks as on the original system.
-# Example: if /lib64 points to /lib on the host, "inst_dir /lib/file"
+# Example: if /lib points to /lib64 on the host, "inst_dir /lib/file"
 # will create ${initdir}/lib64, ${initdir}/lib64/file,
 # and a symlink ${initdir}/lib -> lib64.
 inst_dir() {
-    local _file=""
-    local _oldifs="$IFS"
-    local _part
-    local _dir="$1"
+    [[ -e ${initdir}"$1" ]] && return 0  # already there
-    # fast out
-    [[ -e ${initdir}$_dir ]] && return 0
-
-    _part=${_dir%/*}
+    local _dir="$1" _part=${_dir%/*} _file
     while [[ "$_part" != "${_part%/*}" ]] && ! [[ -e "${initdir}${_part}" ]]; do
         _dir="$_part $_dir"
         _part=${_part%/*}
@@ -310,9 +304,9 @@ inst_dir() {
 # Location of the image dir is assumed to be $initdir
 # We never overwrite the target if it exists.
 inst_simple() {
-    local _src target
     [[ -f $1 ]] || return 1
-    _src=$1 target="${2:-$1}"
+
+    local _src=$1 target="${2:-$1}"
     if ! [[ -d ${initdir}$target ]]; then
         [[ -e ${initdir}$target ]] && return 0
         [[ -h ${initdir}$target ]] && return 0
-- 
1.7.6


-- 
