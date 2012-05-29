From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/8] Add doc for bond= cmdline
Date: Tue, 29 May 2012 17:00:30 +0800
Message-ID: <1338282035-14262-3-git-send-email-amwang@redhat.com>
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

Document bond= cmdline in dracut.cmdline(7).

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.cmdline.7.asc |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 95c6aea..79a4577 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -309,6 +309,15 @@ auto6::: do IPv6 autoconfiguration
     We support the four styles of vlan names: VLAN_PLUS_VID (vlan0005), VLAN_PLUS_VID_NO_PAD (vlan5),
     DEV_PLUS_VID (eth0.0005), DEV_PLUS_VID_NO_PAD (eth0.5)
 
+**bond=_<bondname>_[:_<bondslaves>_:[:_<options>_]]**::
+    Setup bonding device <bondname> on top of <bondslaves>.
+    <bondslaves> is a comma-separated list of physical (ethernet) interfaces.
+    <options> is a comma-separated list on bonding options (modinfo bonding for details)
+    in format compatible with initscripts. If <options> includes multi-valued arp_ip_target option,
+    then its values should be separated by semicolon.
+    Bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr
+
+
 NFS
 ~~~
 **root=**[_<server-ip>_:]_<root-dir>_[:_<nfs-options>_]::
-- 
1.7.7.6
