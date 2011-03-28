From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut: don't skip zero-length string outfile argument
Date: Tue, 29 Mar 2011 00:52:16 +0200
Message-ID: <1301352736-5715-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

When '' was passed as outfile, dracut generated name with following
pattern:

  /boot/initramfs-$kernel

With commit 486a1b9324d6fc7bc534d8147d64b8b259692c46 dracut skips ''
argument.
---
 dracut |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 6b67dc0..e7d0990 100755
--- a/dracut
+++ b/dracut
@@ -188,6 +188,7 @@ push_arg() {
 }
 
 kernel="unset"
+outfile="unset"
 verbosity_mod_l=0
 
 while (($# > 0)); do
@@ -237,7 +238,7 @@ while (($# > 0)); do
                        ;;
         -*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;;
         *) 
-            if ! [[ $outfile ]]; then
+            if [[ $outfile = "unset" ]]; then
                 outfile=$1
             elif [[ $kernel = "unset" ]]; then
                 kernel=$1
-- 
1.7.4.1
