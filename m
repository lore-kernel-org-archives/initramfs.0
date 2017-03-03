From: Cristian Rodriguez <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd 233 requires sha256, hmac and algif_hash modules
Date: Fri,  3 Mar 2017 13:21:46 +0000
Message-ID: <20170303132146.4968-1-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=E74bzqpnNwolxpABDfb4zk9fjTtmJ7fwtOGM51w9FFM=;
        b=LrmzPTBGyH1npQxX/7MApBtzCYDPwptiVlxS/V6Y03ziQ6m1GYfO5X8Tx9kTpdeqjc
         w0vU3LyrTcK5n32RCam+qbax0iu1Ysw3cpMYogLC6IbpVNSFe8iSLmjFmBqaL3P8+rov
         bi9Bl+JkXf532+GUvB4SsO//Rp9KesBsqium8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cristian Rodriguez <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

---
 modules.d/00systemd/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/00systemd/module-setup.sh b/modules.d/00systemd/module-setup.sh
index 51904c56..3c3e25d8 100755
--- a/modules.d/00systemd/module-setup.sh
+++ b/modules.d/00systemd/module-setup.sh
@@ -18,7 +18,7 @@ depends() {
 }
 
 installkernel() {
-    hostonly='' instmods autofs4 ipv6
+    hostonly='' instmods autofs4 ipv6 algif_hash hmac sha256
     instmods -s efivarfs
 }
 
-- 
2.12.0
