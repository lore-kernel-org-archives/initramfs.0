From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/3] dracut: install ld.so.conf* with dracut_install instead of cp
Date: Wed, 16 Mar 2011 21:24:28 +0100
Message-ID: <1300307070-10087-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 2ae7f8c..4d50472 100755
--- a/dracut
+++ b/dracut
@@ -494,7 +494,7 @@ done
 unset item
 
 # make sure that library links are correct and up to date
-cp -ar /etc/ld.so.conf* "$initdir"/etc
+dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
 ldconfig -r "$initdir" || [[ $UID != "0" ]] && \
     dinfo "ldconfig might need uid=0 (root) for chroot()"
 
-- 
1.7.4.1
