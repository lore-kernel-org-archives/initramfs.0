From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Run plymouth only if on a normal console
Date: Wed, 25 May 2011 12:26:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.1105251221110.7357@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Run plymouth only when running on a normal console. When the machine is 
using a serial console or braille terminal etc. do not start plymouth.

That will give people the ability to type in crypto passphrases etc. on a 
serial terminal.

---
 modules.d/50plymouth/plymouth-pretrigger.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/modules.d/50plymouth/plymouth-pretrigger.sh b/modules.d/50plymouth/plymouth-pretrigger.sh
index 25ed06f..d3c8a2a 100755
--- a/modules.d/50plymouth/plymouth-pretrigger.sh
+++ b/modules.d/50plymouth/plymouth-pretrigger.sh
@@ -2,7 +2,18 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-if getargbool 1 rd.plymouth -n rd_NO_PLYMOUTH; then
+# Check for normal console
+is_normal_console() {
+    for con in $(getargs console); do
+        case $con in
+            tty[0..9]) continue;;
+            *) return 1;;
+        esac
+    done
+    return 0
+}
+
+if getargbool 1 rd.plymouth -n rd_NO_PLYMOUTH && is_normal_console; then
     [ -c /dev/null ] || mknod -m 0666 /dev/null c 1 3
     # first trigger graphics subsystem
     udevadm trigger --action=add --attr-match=class=0x030000 >/dev/null 2>&1
-- 
1.7.4.4
