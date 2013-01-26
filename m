From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Mount /proc before including dracut-lib.sh.
Date: Sat, 26 Jan 2013 18:13:28 +0000
Message-ID: <1359224008-4761-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

When dracut-lib.sh is sourced it checks the command line (when not using systemd)
as part of the check_quiet() call.

Therefore mount /proc earlier in init.

Avoids the error:

init: 77: /lib/dracut-lib.sh: /proc/cmdline: No such file or directory
---
 modules.d/99base/init.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 0259053..37b5996 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -17,9 +17,6 @@ OLDPATH=$PATH
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 export PATH
 
-RD_DEBUG=""
-. /lib/dracut-lib.sh
-
 # mount some important things
 [ ! -d /proc/self ] && \
     mount -t proc -o nosuid,noexec,nodev proc /proc >/dev/null
@@ -37,6 +34,9 @@ if [ "$?" != "0" ]; then
     exit 1
 fi
 
+RD_DEBUG=""
+. /lib/dracut-lib.sh
+
 if [ -x /lib/systemd/systemd-timestamp ]; then
     RD_TIMESTAMP=$(/lib/systemd/systemd-timestamp)
 else
-- 
1.8.1
