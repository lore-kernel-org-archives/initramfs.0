From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd: Optionally, include efivarsfs module
Date: Mon, 16 Jun 2014 01:13:44 -0400
Message-ID: <1402895624-20478-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wEhCsdmUsbOgVaKiLPrBtCSopp1zgLg7hkh/tLVt4go=;
        b=KrK8ommRKt5Pn4Npqj/qHDplGeWRAPPI4uIHic9McQKjSsrZVaaN0URnkNqPY6+GqH
         dRTBCY0AvlUPoR7eLnlcKc2Q2kzfHOAXh1Bjl62Vu10AsUzd/SnyHmZ942AI5AeOAmTB
         Zw7+VaDByfCgBWi+mRudLu4GC5ZcH1WCk6Of4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

It is, however not an error if this module can't be found.
---
 modules.d/98systemd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index cf1b2e7..dd82ece 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -21,6 +21,7 @@ depends() {
 
 installkernel() {
     instmods autofs4 ipv6
+    instmods -s efivarfs
 }
 
 # called by dracut
-- 
1.8.4.5
