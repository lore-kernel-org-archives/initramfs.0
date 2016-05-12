From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 11/12] mulitpath: Boot up, also without multipath.conf, it is not mandatory
Date: Thu, 12 May 2016 20:03:35 +0200
Message-ID: <1463076216-410-12-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

If rootfs is on multipath, but platform does not have an /etc/multipath.conf
file which is not urgently needed, they system will not boot, due to:

multipathd is not started and rootfs and swap are not found:
systemctl status multipathd.service
* multipathd.service - Device-Mapper Multipath Device Controller
   Loaded: loaded (/usr/lib/systemd/system/multipathd.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
Condition: start condition failed at Thu 2015-05-07 11:49:11 CEST; 7min ago
           ConditionPathExists=/etc/multipath.conf was not met


and exit to dracut shell.

Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/90multipath/multipathd.service | 1 -
 1 file changed, 1 deletion(-)

diff --git a/modules.d/90multipath/multipathd.service b/modules.d/90multipath/multipathd.service
index b64b02c..f7bc65f 100644
--- a/modules.d/90multipath/multipathd.service
+++ b/modules.d/90multipath/multipathd.service
@@ -6,7 +6,6 @@ Conflicts=shutdown.target
 ConditionKernelCommandLine=!nompath
 ConditionKernelCommandLine=!rd.multipath=0
 ConditionKernelCommandLine=!rd_NO_MULTIPATH
-ConditionPathExists=/etc/multipath.conf
 
 [Service]
 Type=simple
-- 
2.1.4
