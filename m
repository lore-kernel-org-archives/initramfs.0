From: Mariusz Tkaczyk <mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mdraid: add grow continue service.
Date: Wed, 26 Aug 2020 09:52:59 +0200
Message-ID: <20200826075259.9416-1-mariusz.tkaczyk@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

During raid assembly mdadm will call mdadm-grow-continue.service if reshape is
in progress.
If service doesn't exist then it is done via fork. But systemd will kill
it unconditionally after processing all events. 

Add proper service and allow systemd to manage reshape correctly.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 modules.d/90mdraid/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index f59d84a8..67acb047 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -136,6 +136,9 @@ install() {
         if [ -e $dracutsysrootdir$systemdsystemunitdir/mdadm-last-resort@.timer ]; then
             inst_simple $systemdsystemunitdir/mdadm-last-resort@.timer
         fi
+        if [ -e $dracutsysrootdir$systemdsystemunitdir/mdadm-grow-continue@.service ]; then
+            inst_simple $systemdsystemunitdir/mdadm-grow-continue@.service
+        fi
     fi
     inst_hook pre-shutdown 30 "$moddir/mdmon-pre-shutdown.sh"
     dracut_need_initqueue
-- 
2.25.0

