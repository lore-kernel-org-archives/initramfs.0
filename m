From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 3/6] [PATCH 3/5] Revert "systemd/emergency.service: do not run for
 action_on_fail=continue"
Date: Mon, 31 Aug 2015 10:43:17 +0800
Message-ID: <20150831024413.911282532@redhat.com>
References: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0003-Revert-systemd-emergency.service-do-not-run-for-acti.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This reverts commit dcae873414ff643e1de790f256e414923e2aef8b.

action_on_fail is useless thus remove the commits for it one by one.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98dracut-systemd/emergency.service | 1 -
 1 file changed, 1 deletion(-)

diff --git a/modules.d/98dracut-systemd/emergency.service b/modules.d/98dracut-systemd/emergency.service
index c19fe37..35d9c31 100644
--- a/modules.d/98dracut-systemd/emergency.service
+++ b/modules.d/98dracut-systemd/emergency.service
@@ -12,7 +12,6 @@ Description=Emergency Shell
 DefaultDependencies=no
 After=systemd-vconsole-setup.service
 Wants=systemd-vconsole-setup.service
-ConditionKernelCommandLine=!action_on_fail=continue
 
 [Service]
 Environment=HOME=/
-- 
1.8.3.1


