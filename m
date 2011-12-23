From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4 branch usrmove] deal common part of etc passwd in 99base
Date: Fri, 23 Dec 2011 16:04:20 +0800
Message-ID: <20111223080420.GA12664@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

ssh module will need root user in /etc/passwd, so add root and nobody
to /etc/passwd in 99base instead of nfs module
---
 modules.d/95nfs/module-setup.sh  |    2 --
 modules.d/99base/module-setup.sh |    4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index bb3b793..674a438 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -65,8 +65,6 @@ install() {
 
     # Rather than copy the passwd file in, just set a user for rpcbind
     # We'll save the state and restart the daemon from the root anyway
-    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
-    egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
     egrep '^nfsnobody:' /etc/passwd >> "$initdir/etc/passwd"
     egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
     egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 5297a9d..f6c1209 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -20,6 +20,10 @@ install() {
         dracut_install bash
         (ln -s bash "${initdir}/bin/sh" || :)
     fi
+
+    #add common users in /etc/passwd, it will be used by nfs/ssh currently
+    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
+    egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
     # install our scripts and hooks
     inst "$moddir/init" "/init"
     inst "$moddir/initqueue" "/sbin/initqueue"
-- 
1.7.1
