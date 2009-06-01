From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 6/9] dracut-lib: add source_all to library
Date: Mon, 1 Jun 2009 00:39:56 -0400
Message-ID: <ae5bc1fd8ab2aab28b335adf456bc41c0175c4e7.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

The network root handler will need this.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/99base/dracut-lib |    6 ++++++
 modules.d/99base/init       |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
index 1f31933..7078827 100644
--- a/modules.d/99base/dracut-lib
+++ b/modules.d/99base/dracut-lib
@@ -14,3 +14,9 @@ getarg() {
     done
     return 1
 }
+
+source_all() {
+    local f
+    [ "$1" ] && [  -d "/$1" ] || return
+    for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
+}
diff --git a/modules.d/99base/init b/modules.d/99base/init
index ebbc6ad..73e96fd 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -14,12 +14,6 @@ emergency_shell()
     sh -i
 }
 
-source_all() {
-    local f
-    [ "$1" ] && [  -d "/$1" ] || return
-    for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
-}
-
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
 NEWROOT="/sysroot"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
