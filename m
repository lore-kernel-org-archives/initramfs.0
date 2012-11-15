From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] dracut: document team cmdline
Date: Thu, 15 Nov 2012 22:58:29 +0800
Message-ID: <1352991509-31740-2-git-send-email-amwang@redhat.com>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352991509-31740-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Document team= in dracut.cmdline.

Cc: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 2a74604..c2eec5e 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -411,6 +411,10 @@ interface name. Better name it "bootnet" or "bluesocket".
     then its values should be separated by semicolon.
     Bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr
 
+**team =_<teammaster>_:_<teamslaves>_**::
+    Setup team device <teammaster> on top of <teamslaves>.
+    <teamslaves> is a comma-separated list of physical (ethernet) interfaces.
+
 **bridge=_<bridgename>_:_<ethnames>_**::
     Setup bridge <bridgename> with <ethnames>. <ethnames> is a comma-separated
     list of physical (ethernet) interfaces. Bridge without parameters assumes bridge=br0:eth0
-- 
1.7.7.6
