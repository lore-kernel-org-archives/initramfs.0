From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/8] Update the documentation of ifname= cmdline
Date: Tue, 29 May 2012 17:00:34 +0800
Message-ID: <1338282035-14262-7-git-send-email-amwang@redhat.com>
References: <1338282035-14262-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338282035-14262-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The documentation about ifname= needs to update.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.cmdline.7.asc |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index c131f1c..0c61069 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -288,8 +288,10 @@ auto6::: do IPv6 autoconfiguration
 **ifname=**_<interface>_:_<MAC>_::
     Assign network device name <interface> (ie eth0) to the NIC with MAC <MAC>.
     Note: If you use this option you _must_ specify an ifname= argument for all
-    interfaces used in ip= or fcoe= arguments. This parameter can be specified
-    multiple times.
+    interfaces used in ip= or fcoe= arguments. However, if the interface in
+    ip= or fcoe= is a bridge, bonding or vlan interface, you should specify
+    an ifname= for _each_ of its underlying interfaces. This parameter can be
+    specified multiple times.
 
 **bootdev=**_<interface>_::
     specify network interface to use routing and netroot information from.
-- 
1.7.7.6
