From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 90kernel-modules: fixed handling rd.driver.post=
Date: Thu, 30 Jun 2011 22:45:24 +0200
Message-ID: <1309466724-4972-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90kernel-modules/insmodpost.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/modules.d/90kernel-modules/insmodpost.sh b/modules.d/90kernel-modules/insmodpost.sh
index 1b8ccfa..168a907 100755
--- a/modules.d/90kernel-modules/insmodpost.sh
+++ b/modules.d/90kernel-modules/insmodpost.sh
@@ -2,11 +2,13 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-for p in $(getargs rd.driver.post rdinsmodpost=); do
+. /lib/dracut-lib.sh
+
+for modlist in $(getargs rd.driver.post rdinsmodpost=); do
     (
         IFS=,
-        for p in $i; do
-            modprobe $p
+        for m in $modlist; do
+            modprobe $m
         done
     )
 done
-- 
1.7.5.3
