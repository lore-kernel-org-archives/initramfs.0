From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 33/33] nfs: Add ip=... and root=nfs... parameters to internal dracut
Date: Thu, 20 Nov 2014 15:57:08 +0100
Message-ID: <1416495428-36978-34-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 cmdline

If the rootfs is an nfs mount, also know as nfsroot, add the correct
parameter to the dracut cmdline.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh | 46 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index e1340b3..41c6ef7 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -14,7 +14,6 @@ check() {
         done
         return 255
     }
-
     return 0
 }
 
@@ -29,14 +28,56 @@ installkernel() {
     instmods nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files
 }
 
+cmdline() {
+    local nfs_device
+    local nfs_options
+    local nfs_root
+    local nfs_address
+    local lookup
+    local ifname
+
+    ### nfsroot= ###
+    nfs_device=$(findmnt -t nfs4 -n -o SOURCE /)
+    if [ -n "$nfs_device" ];then
+        nfs_root="root=nfs4:$nfs_device"
+    else
+        nfs_device=$(findmnt -t nfs -n -o SOURCE /)
+        [ -z "$nfs_device" ] && return
+        nfs_root="root=nfs:$nfs_device"
+    fi
+    nfs_options=$(findmnt -t nfs4,nfs -n -o OPTIONS /)
+    [ -n "$nfs_options" ] && nfs_root="$nfs_root:$nfs_options"
+    echo "$nfs_root"
+
+    ### ip= ###
+    if [[ $nfs_device = [0-9]*\.[0-9]*\.[0-9]*.[0-9]* ]] || [[ $nfs_device = \[.*\] ]]; then
+        nfs_address="$nfs_device"
+    else
+        lookup=$(host $(echo ${nfs_device%%:*})| head -n1)
+        nfs_address=${lookup##* }
+    fi
+    ifname=$(ip -o route get to $nfs_address | sed -n 's/.*dev \([^ ]*\).*/\1/p')
+    if [ -e /sys/class/net/$ifname/address ] ; then
+        ifmac=$(cat /sys/class/net/$ifname/address)
+        printf 'ifname=%s:%s ' ${ifname} ${ifmac}
+    fi
+
+    printf 'ip=%s:static\n' ${ifname}
+}
+
 # called by dracut
 install() {
     local _i
     local _nsslibs
     inst_multiple -o portmap rpcbind rpc.statd mount.nfs \
-        mount.nfs4 umount rpc.idmapd sed /etc/netconfig
+        mount.nfs4 umount rpc.idmapd sed /etc/netconfig host sed
     inst_multiple /etc/services /etc/nsswitch.conf /etc/rpc /etc/protocols /etc/idmapd.conf
 
+    if [[ $hostonly_cmdline == "yes" ]]; then
+        local _netconf="$(cmdline)"
+        [[ $_netconf ]] && printf "%s\n" "$_netconf" >> "${initdir}/etc/cmdline.d/95nfs.conf"
+    fi
+
     if [ -f /lib/modprobe.d/nfs.conf ]; then
         inst_multiple /lib/modprobe.d/nfs.conf
     else
@@ -75,4 +116,3 @@ install() {
         && chown rpc.rpc "$initdir/var/lib/rpcbind"
     dracut_need_initqueue
 }
-
-- 
1.8.5.2
