From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] livenet: take into account other ca-bundle paths; use inst_any for that
Date: Sun, 21 Aug 2011 12:47:14 +0200
Message-ID: <1313923634-14453-2-git-send-email-aidecoe@aidecoe.name>
References: <1313923634-14453-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313923634-14453-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90livenet/module-setup.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
index 3ae72de..b166859 100755
--- a/modules.d/90livenet/module-setup.sh
+++ b/modules.d/90livenet/module-setup.sh
@@ -15,7 +15,9 @@ depends() {
 install() {
     dracut_install wget
     mkdir -m 0755 -p "$initdir/etc/ssl/certs"
-    if ! inst_simple /etc/ssl/certs/ca-bundle.crt; then
+    if ! inst_any -t /etc/ssl/certs/ca-bundle.crt \
+            /etc/ssl/certs/ca-bundle.crt \
+            /etc/ssl/certs/ca-certificates.crt; then
         dwarn "Couldn't find SSL CA cert bundle; HTTPS won't work."
     fi
 
-- 
1.7.6
