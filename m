From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 8/8] Close original fd after bash-generated high redirection.
Date: Tue, 30 Aug 2011 21:41:09 -0700
Message-ID: <4E5DBB65.6060500@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut           |    3 ++-
 dracut-functions |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index d42f258..c46244f 100755
--- a/dracut
+++ b/dracut
@@ -616,7 +616,8 @@ if [[ $kernel_only != yes ]]; then
 fi
  # bash sets cpio_stdin to a new fd >= 10.  See REDIRECTION in bash manpage.
-)  {cpio_stdin}>&1  |  cpio -pdmu "${initdir}"
+# Pipe that new fd as stdin into cpio, and ignore the old stdout of subshell.
+)  {cpio_stdin}>&1  1>&-  |  cpio -pdmu --quiet "${initdir}"
  if (($maxloglvl >= 5)); then
     ddebug "Listing sizes of included files:"
diff --git a/dracut-functions b/dracut-functions
index 8109699..1942bf9 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -959,7 +959,7 @@ instmods() {
     # Capture all stderr from modprobe onto a new fd $modprobe_stderr,
     # and pipe it into egrep.  See REDIRECTION in bash manpage.
     export modprobe_stderr
-    ( instmods_1 "$@" ) {modprobe_stderr}>&1 \
+    ( instmods_1 "$@" ) {modprobe_stderr}>&1  1>&- \
     | egrep -v 'FATAL: Module .* not found.' | derror
     return $?
 }
-- 
1.7.6


-- 
