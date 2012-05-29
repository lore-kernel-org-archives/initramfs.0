From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/8] Remove rd.neednet cmdline
Date: Tue, 29 May 2012 17:00:35 +0800
Message-ID: <1338282035-14262-8-git-send-email-amwang@redhat.com>
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

rd.neednet could be removed, as we can check /tmp/net.ifaces.
After this patch, kdump can bring up the NIC without
rd.neednet.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.cmdline.7.asc                 |    3 ---
 modules.d/40network/net-genrules.sh  |    2 +-
 modules.d/90livenet/parse-livenet.sh |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 0c61069..dcdbbce 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -303,9 +303,6 @@ auto6::: do IPv6 autoconfiguration
 **biosdevname=0**::
     boolean, turn off biosdevname network interface renaming
 
-**rd.neednet=1**::
-    boolean, bring up network even without netroot set
-
 **vlan=_<vlanname>_:_<phydevice>_**::
     Setup vlan device named <vlanname> on <phydeivce>.
     We support the four styles of vlan names: VLAN_PLUS_VID (vlan0005), VLAN_PLUS_VID_NO_PAD (vlan5),
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 142634e..ca47b2b 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -14,7 +14,7 @@ fix_bootif() {
 }
 
 # Don't continue if we don't need network
-[ -z "$netroot" ] && ! getargbool 0 rd.neednet && return;
+[ -z "$netroot" ] && ! [ -e "/tmp/net.ifaces" ] && return;
 
 # Write udev rules
 {
diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index d1eb474..365eca1 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -10,7 +10,7 @@ updates=$(getarg live.updates=)
 if [ -n "$updates" ]; then
     # make sure network comes up even if we're doing a local live device
     if [ -z "$netroot" ]; then
-	echo "rd.neednet=1" > /etc/cmdline.d/90livenet.conf
+	echo > /tmp/net.ifaces
 	unset CMDLINE
     fi
     echo "$updates" > /tmp/liveupdates.info
-- 
1.7.7.6
