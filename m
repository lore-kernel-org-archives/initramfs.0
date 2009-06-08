From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 08/11] dracut init: add rdnetdebug to exclude list
Date: Mon,  8 Jun 2009 00:40:21 -0400
Message-ID: <9fe7bc1bba2f51967dbc2dfe29d187a63c93a489.1244435634.git.dave@thedillows.org>
References: <cover.1244435634.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

---
 modules.d/99base/init |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 53e28ef..b1115e1 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -133,6 +133,7 @@ for x in "$@"; do
     [ "${x%%=*}" = "rdinitdebug" ] && continue
     [ "${x%%=*}" = "rdudevinfo" ] && continue
     [ "${x%%=*}" = "rdudevdebug" ] && continue
+    [ "${x%%=*}" = "rdnetdebug" ] && continue
     initargs="$initargs $x"
 done
 exec switch_root "$NEWROOT" "$INIT" $initargs || {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
