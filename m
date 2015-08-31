From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 4/6] [PATCH 4/5] Revert "dracut-emergency.service: do not start for
 "action_on_fail=continue""
Date: Mon, 31 Aug 2015 10:43:18 +0800
Message-ID: <20150831024413.967907693@redhat.com>
References: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0004-Revert-dracut-emergency.service-do-not-start-for-act.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This reverts commit b78e6ac2c328c76057b17059a761ab44707f9aa0.

action_on_fail is useless thus remove the commits for it one by one.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../98dracut-systemd/dracut-emergency.service      |  1 -
 9 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/modules.d/98dracut-systemd/dracut-emergency.service b/modules.d/98dracut-systemd/dracut-emergency.service
index a4b81bc..a523671 100644
--- a/modules.d/98dracut-systemd/dracut-emergency.service
+++ b/modules.d/98dracut-systemd/dracut-emergency.service
@@ -13,7 +13,6 @@ DefaultDependencies=no
 After=systemd-vconsole-setup.service
 Wants=systemd-vconsole-setup.service
 Conflicts=emergency.service emergency.target
-ConditionKernelCommandLine=!action_on_fail=continue
 
 [Service]
 Environment=HOME=/

