From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 04/15] 95fcoe: Store current configuration in dracut cmdline
Date: Fri, 21 Nov 2014 14:20:40 +0100
Message-ID: <1416576051-62838-5-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

When running with --hostonly-cmdline we should be storing
the current configuration in /etc/cmdline.d so that dracut
will be configure the system automatically.

References: bnc#877288

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe/module-setup.sh | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/modules.d/95fcoe/module-setup.sh b/modules.d/95fcoe/module-setup.sh
index b67aa04..174745a 100755
--- a/modules.d/95fcoe/module-setup.sh
+++ b/modules.d/95fcoe/module-setup.sh
@@ -2,7 +2,16 @@
 
 # called by dracut
 check() {
+    [[ $hostonly ]] || [[ $mount_needs ]] && {
+        for c in /sys/bus/fcoe/devices/ctlr_* ; do
+            [ -L $c ] || continue
+            fcoe_ctlr=$c
+        done
+        [ -z "$fcoe_ctlr" ] && return 255
+    }
+
     require_binaries dcbtool fipvlan lldpad ip readlink || return 1
+
     return 0
 }
 
@@ -17,12 +26,55 @@ installkernel() {
     instmods fcoe 8021q edd
 }
 
+get_vlan_parent() {
+    local link=$1
+
+    [ -d $link ] || return
+    read iflink < $link/iflink
+    for if in /sys/class/net/* ; do
+	read idx < $if/ifindex
+	if [ $idx -eq $iflink ] ; then
+	    echo ${if##*/}
+	fi
+    done
+}
+
+# called by dracut
+cmdline() {
+
+    for c in /sys/bus/fcoe/devices/ctlr_* ; do
+        [ -L $c ] || continue
+        read enabled < $c/enabled
+        [ $enabled -eq 0 ] && continue
+        d=$(cd -P $c; echo $PWD)
+        i=${d%/*}
+        read mac < ${i}/address
+        s=$(dcbtool gc ${i##*/} dcb | sed -n 's/^DCB State:\t*\(.*\)/\1/p')
+        if [ -z "$s" ] ; then
+	    p=$(get_vlan_parent ${i})
+	    if [ "$p" ] ; then
+	        s=$(dcbtool gc ${p} dcb | sed -n 's/^DCB State:\t*\(.*\)/\1/p')
+	    fi
+        fi
+        if [ "$s" = "on" ] ; then
+	    dcb="dcb"
+        else
+	    dcb="nodcb"
+        fi
+        echo "fcoe=${mac}:${dcb}"
+    done
+}
+
 # called by dracut
 install() {
     inst_multiple ip dcbtool fipvlan lldpad readlink lldptool
 
     mkdir -m 0755 -p "$initdir/var/lib/lldpad"
 
+    if [[ $hostonly_cmdline == "yes" ]] ; then
+        local _fcoeconf=$(cmdline)
+        [[ $_fcoeconf ]] && printf "%s\n" "$_fcoeconf" >> "${initdir}/etc/cmdline.d/95fcoe.conf"
+    fi
     inst "$moddir/fcoe-up.sh" "/sbin/fcoe-up"
     inst "$moddir/fcoe-edd.sh" "/sbin/fcoe-edd"
     inst "$moddir/fcoe-genrules.sh" "/sbin/fcoe-genrules.sh"
-- 
1.8.5.2
