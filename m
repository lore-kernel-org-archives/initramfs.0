From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: 90livenet/module-setup.sh: do not pollute stdout
Date: Thu, 20 Oct 2011 12:56:35 -0700
Message-ID: <4EA07CF3.6070306@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050702080401090700050906"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------050702080401090700050906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

stdout is not for kibitzing.

-- 

--------------050702080401090700050906
Content-Type: text/plain;
 name="0001-do-not-pollute-stdout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-do-not-pollute-stdout.patch"

From e6a60c3bd845eae4b710377008cccf3e05c3df50 Mon Sep 17 00:00:00 2001
From: John Reiser <jreiser-L8/tzxVKHrlWk0Htik3J/w@public.gmane.org>
Date: Thu, 20 Oct 2011 12:50:25 -0700
Subject: [PATCH] do not pollute stdout

---
 modules.d/90livenet/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
index 3ee7521..a6ee3e0 100755
--- a/modules.d/90livenet/module-setup.sh
+++ b/modules.d/90livenet/module-setup.sh
@@ -4,7 +4,7 @@
 check() {
     # a live, host-only image doesn't really make a lot of sense
     [[ $hostonly ]] && return 1
-    command -v wget || return 1
+    command -v wget >/dev/null || return 1
     return 0
 }
 
-- 
1.7.6.4


--------------050702080401090700050906--
