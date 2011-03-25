From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 6/9] 40network: install dhclient, brctl and ifenslave optionally
Date: Fri, 25 Mar 2011 15:56:49 +0100
Message-ID: <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-5-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Warning given by check() function in case if any of those binaries
doesn't exist was removed, because it's produces by "dracut_install -o"
later.
---
 modules.d/40network/module-setup.sh |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 59f358f..f32745c 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -11,12 +11,6 @@ check() {
             return 1
         fi
     done
-    for program in dhclient brctl ifenslave tr; do
-        if ! type -P $program >/dev/null; then
-            dwarn "Could not find program \"$program\" it might be required " \
-                "by network."
-        fi
-    done
 
     return 255
 }
@@ -48,7 +42,8 @@ installkernel() {
 }
 
 install() {
-    dracut_install ip dhclient brctl arping ifenslave tr
+    dracut_install ip arping tr
+    dracut_install -o dhclient brctl ifenslave
     inst "$moddir/ifup" "/sbin/ifup"
     inst "$moddir/netroot" "/sbin/netroot"
     inst "$moddir/dhclient-script" "/sbin/dhclient-script"
-- 
1.7.4.1
