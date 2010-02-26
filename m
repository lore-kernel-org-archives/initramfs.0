From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] parse-kernel.sh should have a shebang
Date: Fri, 26 Feb 2010 15:39:31 +0100
Message-ID: <1267195175-15554-3-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90kernel-modules/parse-kernel.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/modules.d/90kernel-modules/parse-kernel.sh b/modules.d/90kernel-modules/parse-kernel.sh
index 59d7870..6278dac 100755
--- a/modules.d/90kernel-modules/parse-kernel.sh
+++ b/modules.d/90kernel-modules/parse-kernel.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 for p in $(getargs rdloaddriver=); do 
 	modprobe $p
 done
-- 
1.7.0
