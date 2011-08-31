From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 7/8] build initramfs: cpio avoids per-file /bin/cp
Date: Tue, 30 Aug 2011 21:41:00 -0700
Message-ID: <4E5DBB5C.2010100@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Replacing most /bin/cp with one cpio reduces execve and increases parallelism.
This is a large savings in real time.
TODO: Fix permissions on directories (cpio 775 should be inst_dir 755.)

---
 dracut           |    5 +++++
 dracut-functions |   20 ++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index fd36805..d42f258 100755
--- a/dracut
+++ b/dracut
@@ -500,6 +500,8 @@ if [[ $prefix ]]; then
     done
 fi
+export cpio_stdin; (  # begin pipe into cpio to avoid per-file 'cp'
+
 if [[ $kernel_only != yes ]]; then
     for d in bin etc lib "$libdir" sbin tmp usr var usr/bin usr/sbin; do
         [[ -e "${initdir}${prefix}/$d" ]] && continue
@@ -613,6 +615,9 @@ if [[ $kernel_only != yes ]]; then
     fi
 fi
+# bash sets cpio_stdin to a new fd >= 10.  See REDIRECTION in bash manpage.
+)  {cpio_stdin}>&1  |  cpio -pdmu "${initdir}"
+
 if (($maxloglvl >= 5)); then
     ddebug "Listing sizes of included files:"
     du -c "$initdir" | sort -n | ddebug
diff --git a/dracut-functions b/dracut-functions
index 6278eb4..8109699 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -306,6 +306,17 @@ inst_dir() {
 inst_simple() {
     [[ -f $1 ]] || return 1
+    if [[ 1 = $# || $2 = $1 ]]; then
+        [[ -e ${initdir}$1 ]] && return 0
+
+        local _hmac="${1%/*}/.${1##*/}.hmac"
+        [[ -e $_hmac ]] && echo "$_hmac" >&${cpio_stdin}
+
+        # ddebug "Installing $1"
+        echo "$1" >&${cpio_stdin}
+        return 0
+    fi
+
     local _src=$1 target="${2:-$1}"
     if ! [[ -d ${initdir}$target ]]; then
         [[ -e ${initdir}$target ]] && return 0
@@ -313,9 +324,9 @@ inst_simple() {
         inst_dir "${target%/*}"
     fi
     # install checksum files also
-    if [[ -e "${_src%/*}/.${_src##*/}.hmac" ]]; then
-        inst_simple "${_src%/*}/.${_src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
-    fi
+    local _hmac="${_src%/*}/.${_src##*/}.hmac"
+    [[ -e $_hmac ]] && inst_simple "$_hmac" "${target%/*}/.${target##*/}.hmac"
+
     ddebug "Installing $_src"
     cp -pfL "$_src" "${initdir}$target"  }
@@ -820,7 +831,7 @@ install_kmod_with_fw() {
 for_each_kmod_dep() {
     local _func=$1 _kmod=$2 _cmd _modpath _options _found=0
     shift 2
-    modprobe "$@" --ignore-install --show-depends $_kmod 2>&$modprobe_stderr | (
+    modprobe "$@" --ignore-install --show-depends $_kmod 2>&${modprobe_stderr} | (
         while read _cmd _modpath _options; do
             [[ $_cmd = insmod ]] || continue
             $_func ${_modpath} || exit $?
@@ -947,6 +958,7 @@ instmods() {
      # Capture all stderr from modprobe onto a new fd $modprobe_stderr,
     # and pipe it into egrep.  See REDIRECTION in bash manpage.
+    export modprobe_stderr
     ( instmods_1 "$@" ) {modprobe_stderr}>&1 \
     | egrep -v 'FATAL: Module .* not found.' | derror
     return $?
-- 
1.7.6


-- 
