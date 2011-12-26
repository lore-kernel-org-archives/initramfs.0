From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5 branch usrmove v2] change root home dir to /root
Date: Mon, 26 Dec 2011 14:29:18 +0800
Message-ID: <20111226062918.GA3145@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

ssh need to read knownhosts from home directory, so change root home to /root

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 03058b1..fad6c50 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -23,7 +23,7 @@ install() {
     fi
 
     #add common users in /etc/passwd, it will be used by nfs/ssh currently
-    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
+    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
     egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
     # install our scripts and hooks
     inst "$moddir/init" "/init"
-- 
1.7.1
