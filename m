From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd: if kdbus is available, include the kernel module
Date: Wed,  1 Jul 2015 20:15:13 -0300
Message-ID: <1435792513-2222-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ECf2IiYDLsyd3FvrAYaYoippvKqdyyTO7dZCclLLHGA=;
        b=BmxC/xo92kYkA2PcqKfSF2XiToWvFuxu5ugAyHP5GhiyMjCDqaXfIVsTYPhw8yWuFb
         iNQHbqoedW5i43cDie+uIz9V0o1E0woyPKuVBHMqxSxBAUanq/evAhxVwuqnS8EdR7Iq
         T46GMscvCm8vetL+B1pLhU/8UlWgOJyDeI0TE=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

---
 modules.d/00systemd/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/00systemd/module-setup.sh b/modules.d/00systemd/module-setup.sh
index ece81bb..553427a 100755
--- a/modules.d/00systemd/module-setup.sh
+++ b/modules.d/00systemd/module-setup.sh
@@ -19,7 +19,7 @@ depends() {
 
 installkernel() {
     hostonly='' instmods autofs4 ipv6
-    instmods -s efivarfs
+    instmods -s efivarfs kdbus
 }
 
 # called by dracut
-- 
2.4.3
