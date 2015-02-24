From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] base/dracut-lib.sh: remove bashism
Date: Tue, 24 Feb 2015 22:28:24 +0300
Message-ID: <E1YQLG5-00009v-BS@puleglot.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Message-Id:To:Subject:Date:From; bh=Bh4OoAViDyxuyx801bItNsjZilHSqe5dPvFRqvYE+Lk=;
	b=c2FEdMjRUmxkZT02lX/lU4BwkdEkhj5GnErhYke5ocsBl/i3WlR1KHiOL7oQU7CM4HnSGJlJFUXh2O7eP1DFXDpyOm55dqClobLVgI0OKWLE3IuLJCab5CgodEkZ4LVVitCYXowuRFc1l64xDrhBeSGin+q3B9lOGtxln1GhOQQ=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/99base/dracut-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 079c9a2..fd627dc 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -886,7 +886,9 @@ dev_unit_name()
     dev="${dev##/}"
     dev="$(str_replace "$dev" '\' '\x5c')"
     dev="$(str_replace "$dev" '-' '\x2d')"
-    dev=${dev/#\./\\x2e}
+    if [ "${dev##.}" != "$dev" ]; then
+        dev="\x2e${dev##.}"
+    fi
     dev="$(str_replace "$dev" '/' '-')"
 
     printf -- "%s" "$dev"
-- 
2.0.5
