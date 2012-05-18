From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch] check ifenslave instead of brctl in parse-bond.sh
Date: Fri, 18 May 2012 13:38:17 +0800
Message-ID: <1337319497-32738-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is obviously wrong, ifenslave instead of brctl is needed for bonding.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/modules.d/40network/parse-bond.sh b/modules.d/40network/parse-bond.sh
index 0a4c006..ae0ae97 100755
--- a/modules.d/40network/parse-bond.sh
+++ b/modules.d/40network/parse-bond.sh
@@ -18,7 +18,7 @@ if getarg bond= >/dev/null ; then
     if [ -z "$netroot" ] ; then
         die "No netboot configured, bond is invalid"
     fi
-    command -v brctl >/dev/null 2>&1 || die "No 'brctl' installed"
+    command -v ifenslave >/dev/null 2>&1 || die "No 'ifenslave' installed"
 fi
 
 # We translate list of slaves to space-separated here to mwke it easier to loop over them in ifup
