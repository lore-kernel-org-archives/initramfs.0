From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] modules: kernel: add phy and power modules to generic initrd
Date: Mon,  4 Jul 2016 17:05:10 +0100
Message-ID: <1467648310-27834-1-git-send-email-pbrobinson@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cTIf9EX8Uo1h1lREfSiX7CI5ufvi26fkhxp7OaQcoSw=;
        b=LHYChTGOvS/YPiBJfCME5WMp7VuaH0/PjBiMqiNHIT8DZJ+Tf2hcYeZu6nutMQ1CTz
         i+5ifyXLCwItA04SA2KxvRM2nSXb6xrZV+hceBcjysF/AeqNipixOaH7C2ibEDuY0g9t
         lXsoLf+mHmDO0Z5O6v1gJlH29EDzoQr1lNCIYWmaS/nssY1kG/Q+6Bu1RP/VhCWBYopD
         jmyCNW1nLeUQGQNOilvefEcqyX5xPwttldTzIBRXuoSHwZjJyw92wEb+0qUdD4o7NMUL
         l46q9rz2dQgTm3uMCdeVcB5l7E2APcNgey0/Xm+S0Yh93EZ8merikIbn2KUeHgT78pAH
         QX7w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The phy and power modules are needed by some of the recent ARM
devices that have appeared like CHIP and some exynos devices.

Signed-off-by: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 7904c02..5a5c771 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -28,6 +28,8 @@ installkernel() {
             instmods \
                 "=drivers/clk" \
                 "=drivers/i2c/busses" \
+                "=drivers/phy" \
+                "=drivers/power" \
                 "=drivers/regulator" \
                 "=drivers/rtc" \
                 "=drivers/usb/host" \
-- 
2.7.4
