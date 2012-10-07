From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] dracut-functions.sh: find_binary: path starting with variable
Date: Sun,  7 Oct 2012 15:29:03 +0200
Message-ID: <1349616543-1471-2-git-send-email-aidecoe@aidecoe.name>
References: <1349616543-1471-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349616543-1471-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Credits go to Alexander Tsoy <bugs+gentoo-C3g8GgeTu50ox3rIn2DAYQ@public.gmane.org> who provided the
patch with following explanation:

  I get messages "Skipping program $env{DM_SBIN_PATH}/..." when
  generating initramfs. This happens because some udev rules contains
  variables in path to command:

  $ egrep -r 'IMPORT\{program\}=\"\$' /lib64/udev/rules.d/
  /lib64/udev/rules.d/10-dm.rules:ENV{DM_COOKIE}=="?*", IMPORT{program}="$env{DM_SBIN_PATH}/dmsetup udevflags $env{DM_COOKIE}"

  [...]

  $ sudo dracut -f "" 3.5.4-hardened-r1
  I: *** Including module: dm ***
  I: Skipping program $env{DM_SBIN_PATH}/dmsetup using in udev rule 10-dm.rules as it cannot be found
---
 dracut-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 8f59ff4..58b0b4d 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -45,7 +45,7 @@ find_binary() {
         fi
     fi
 
-    type -P $1
+    type -P ${1##*/}
 }
 
 if ! [[ $dracutbasedir ]]; then
-- 
1.7.12
