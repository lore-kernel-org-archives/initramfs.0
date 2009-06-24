From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 1/5] Bugfix: Fix BOOTIF argument translation
Date: Wed, 24 Jun 2009 20:08:28 +0200
Message-ID: <1245866912-3643-2-git-send-email-philippe.seewer@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

fix_bootif() in net-genrules stripped the first part off the
passed string, resulting in invalid mac addresses. fixed
---
 modules.d/40network/net-genrules.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 3d50435..dbd0474 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -2,7 +2,7 @@
 
 # pxelinux provides macaddr '-' separated, but we need ':'
 fix_bootif() {
-    local macaddr=${1##??-}
+    local macaddr=${1}
     local IFS='-'
     macaddr=$(for i in ${macaddr} ; do echo -n $i:; done)
     macaddr=${macaddr%:}
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
