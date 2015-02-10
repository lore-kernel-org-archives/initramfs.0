From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd: include systemd-random-seed.service
Date: Tue, 10 Feb 2015 02:26:47 -0300
Message-ID: <1423546007-1385-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zkRhjZN86cHMq4upTpolh5CLZhwBnbM4AZmJupQelWk=;
        b=WJdOPv1v0u+rU7e3vGkAbvsJ2Caqbx45WWD3S9JLC9mU+SQd5LdLf943+zvoMIxrKC
         dzNBb88C+IT4sUgTpkebWV6zYL+r2XfPr8kf3+EEY1P1WGT8KfhRENOBoAPerO46hyPX
         6zsUu6KgEZPc7tHJGZ+AH6JX+nOqieuN7zsRU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

In current systemd releases there is no random-seed-load service
only systemd-random-seed.service
---
 modules.d/98systemd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index a28df30..1410055 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -99,6 +99,7 @@ install() {
         $systemdsystemunitdir/systemd-journald.service \
         $systemdsystemunitdir/systemd-vconsole-setup.service \
         $systemdsystemunitdir/systemd-random-seed-load.service \
+        $systemdsystemunitdir/systemd-random-seed.service \
         $systemdsystemunitdir/systemd-sysctl.service \
         \
         $systemdsystemunitdir/sysinit.target.wants/systemd-modules-load.service \
-- 
2.2.2
