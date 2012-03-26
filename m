From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Use /tmp instead of /var/tmp for temporary data.
Date: Mon, 26 Mar 2012 13:39:09 +0200
Message-ID: <1332761949-7597-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

/var/tmp is supposed to store temporary data which should be preserved
over reboots, wheras /tmp is for short-term temporary data.  Moreover
/tmp is usually tmpfs which may make generating initramfs a bit faster.

Thanks to Martin von Gagern <Martin.vGagern-hi6Y0CQ0nG0@public.gmane.org> for pointing that
out.
---
 dracut.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 1bf8ad9..fb8bd1e 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -544,8 +544,8 @@ elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
     exit 1
 fi
 
-readonly TMPDIR=/var/tmp
-readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
+readonly TMPDIR=/tmp
+readonly initdir=$(mktemp --tmpdir=$TMPDIR/ -d -t initramfs.XXXXXX)
 [ -d "$initdir" ] || {
     dfatal "mktemp failed."
     exit 1
-- 
1.7.8.5
