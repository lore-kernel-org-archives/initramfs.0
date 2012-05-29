From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/8] Add doc for vlan= cmdline
Date: Tue, 29 May 2012 17:00:29 +0800
Message-ID: <1338282035-14262-2-git-send-email-amwang@redhat.com>
References: <1338282035-14262-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338282035-14262-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Document vlan= cmdline in dracut.cmdline(7).

Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.cmdline.7.asc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 61cd139..95c6aea 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -304,6 +304,11 @@ auto6::: do IPv6 autoconfiguration
 **rd.neednet=1**::
     boolean, bring up network even without netroot set
 
+**vlan=_<vlanname>_:_<phydevice>_**::
+    Setup vlan device named <vlanname> on <phydeivce>.
+    We support the four styles of vlan names: VLAN_PLUS_VID (vlan0005), VLAN_PLUS_VID_NO_PAD (vlan5),
+    DEV_PLUS_VID (eth0.0005), DEV_PLUS_VID_NO_PAD (eth0.5)
+
 NFS
 ~~~
 **root=**[_<server-ip>_:]_<root-dir>_[:_<nfs-options>_]::
-- 
1.7.7.6
