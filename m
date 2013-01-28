From: =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: [PATCH] fix CTC example in rd.znet
Date: Mon, 28 Jan 2013 08:35:28 +0100
Message-ID: <1359358528-4119-1-git-send-email-dan@danny.cz>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The CTC interface uses 2 channels.
---
 dracut.cmdline.7.asc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index ea2d30b..62372a5 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -600,7 +600,7 @@ ZNET
 +
 ----
 rd.znet=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
-rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar
+rd.znet=ctc,0.0.0600,0.0.0601,protocol=bar
 ----
 
 Plymouth Boot Splash
-- 
1.7.7.6
