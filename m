From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] dracut iscsi module: early attempt to launch iscsid from the initramfs
Date: Mon, 10 Dec 2012 14:08:36 -0800
Message-ID: <1355177316-25803-5-git-send-email-cleech@redhat.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355177316-25803-1-git-send-email-cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Not complete, but working well for iBFT configured iSCSI boot for me.
---
 modules.d/95iscsi/cleanup-iscsi.sh        |  3 ++-
 modules.d/95iscsi/iscsid-initrd.service   | 10 ++++++++++
 modules.d/95iscsi/iscsid-initrd.socket    |  9 +++++++++
 modules.d/95iscsi/iscsiroot.sh            | 26 ++++++++++++++------------
 modules.d/95iscsi/iscsiuio-initrd.service | 11 +++++++++++
 modules.d/95iscsi/iscsiuio-initrd.socket  |  9 +++++++++
 modules.d/95iscsi/module-setup.sh         | 14 ++++++++++++--
 7 files changed, 67 insertions(+), 15 deletions(-)
 create mode 100644 modules.d/95iscsi/iscsid-initrd.service
 create mode 100644 modules.d/95iscsi/iscsid-initrd.socket
 create mode 100644 modules.d/95iscsi/iscsiuio-initrd.service
 create mode 100644 modules.d/95iscsi/iscsiuio-initrd.socket

diff --git a/modules.d/95iscsi/cleanup-iscsi.sh b/modules.d/95iscsi/cleanup-iscsi.sh
index a2d5951..0dc0ceb 100755
--- a/modules.d/95iscsi/cleanup-iscsi.sh
+++ b/modules.d/95iscsi/cleanup-iscsi.sh
@@ -2,5 +2,6 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-[ -e /sys/module/bnx2i ] && killproc iscsiuio
+NEWROOT=/sysroot
+iscsiadm --newroot $NEWROOT
 
diff --git a/modules.d/95iscsi/iscsid-initrd.service b/modules.d/95iscsi/iscsid-initrd.service
new file mode 100644
index 0000000..16dc4c4
--- /dev/null
+++ b/modules.d/95iscsi/iscsid-initrd.service
@@ -0,0 +1,10 @@
+[Unit]
+Description=Open-iSCSI
+Documentation=man:iscsid(8) man:iscsiadm(8)
+After=network.target NetworkManager-wait-online.service
+
+[Service]
+Type=forking
+ExecStart=/usr/sbin/iscsid --initrd
+PIDFile=/var/run/iscsid.pid
+KillMode=none
diff --git a/modules.d/95iscsi/iscsid-initrd.socket b/modules.d/95iscsi/iscsid-initrd.socket
new file mode 100644
index 0000000..58a8d12
--- /dev/null
+++ b/modules.d/95iscsi/iscsid-initrd.socket
@@ -0,0 +1,9 @@
+[Unit]
+Description=Open-iSCSI iscsid Socket
+Documentation=man:iscsid(8) man:iscsiadm(8)
+
+[Socket]
+ListenStream=@ISCSIADM_ABSTRACT_NAMESPACE
+
+[Install]
+WantedBy=sockets.target
diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
index 1a8cc8d..c2766a1 100755
--- a/modules.d/95iscsi/iscsiroot.sh
+++ b/modules.d/95iscsi/iscsiroot.sh
@@ -49,7 +49,9 @@ if getargbool 0 rd.iscsi.firmware -d -y iscsi_firmware ; then
 	iscsi_param="$iscsi_param --param $p"
     done
 
-    iscsistart -b $iscsi_param
+    # iscsistart -b $iscsi_param
+    iscsiadm -m fw -l
+    iscsiadm -m session > /run/initramfs/iscsi.sessions
     exit 0
 fi
 
@@ -146,17 +148,17 @@ handle_netroot()
     # force udevsettle to break
     > $hookdir/initqueue/work
 
-    iscsistart -i $iscsi_initiator -t $iscsi_target_name        \
-        -g $iscsi_target_group -a $iscsi_target_ip      \
-        -p $iscsi_target_port \
-        ${iscsi_username+-u $iscsi_username} \
-        ${iscsi_password+-w $iscsi_password} \
-        ${iscsi_in_username+-U $iscsi_in_username} \
-        ${iscsi_in_password+-W $iscsi_in_password} \
-	${iscsi_iface_name+--param iface.iscsi_ifacename=$iscsi_iface_name} \
-	${iscsi_netdev_name+--param iface.net_ifacename=$iscsi_netdev_name} \
-        ${iscsi_param} \
-	|| :
+#    iscsistart -i $iscsi_initiator -t $iscsi_target_name        \
+#        -g $iscsi_target_group -a $iscsi_target_ip      \
+#        -p $iscsi_target_port \
+#        ${iscsi_username+-u $iscsi_username} \
+#        ${iscsi_password+-w $iscsi_password} \
+#        ${iscsi_in_username+-U $iscsi_in_username} \
+#        ${iscsi_in_password+-W $iscsi_in_password} \
+#	${iscsi_iface_name+--param iface.iscsi_ifacename=$iscsi_iface_name} \
+#	${iscsi_netdev_name+--param iface.net_ifacename=$iscsi_netdev_name} \
+#        ${iscsi_param} \
+#	|| :
 }
 
 # loop over all netroot parameter
diff --git a/modules.d/95iscsi/iscsiuio-initrd.service b/modules.d/95iscsi/iscsiuio-initrd.service
new file mode 100644
index 0000000..54883df
--- /dev/null
+++ b/modules.d/95iscsi/iscsiuio-initrd.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=iSCSI UserSpace I/O driver
+Documentation=man:iscsiuio(8)
+Before=iscsid.service
+After=network.target NetworkManager-wait-online.service
+
+[Service]
+Type=forking
+ExecStart=/usr/sbin/iscsiuio --initrd
+PIDFile=/var/run/iscsiuio.pid
+KillMode=none
diff --git a/modules.d/95iscsi/iscsiuio-initrd.socket b/modules.d/95iscsi/iscsiuio-initrd.socket
new file mode 100644
index 0000000..9eacc56
--- /dev/null
+++ b/modules.d/95iscsi/iscsiuio-initrd.socket
@@ -0,0 +1,9 @@
+[Unit]
+Description=Open-iSCSI iscsiuio
+Documentation=man:iscsiuio(8)
+
+[Socket]
+ListenStream=@ISCSID_UIP_ABSTRACT_NAMESPACE
+
+[Install]
+WantedBy=sockets.target
diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index d251a0d..7acabbe 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -5,7 +5,7 @@
 check() {
     local _rootdev
     # If our prerequisites are not met, fail anyways.
-    type -P iscsistart hostname iscsi-iname >/dev/null || return 1
+    type -P iscsid iscsiadm hostname iscsi-iname >/dev/null || return 1
 
     # If hostonly was requested, fail the check if we are not actually
     # booting from root.
@@ -73,10 +73,20 @@ installkernel() {
 }
 
 install() {
-    dracut_install umount iscsistart hostname iscsi-iname
+    dracut_install iscsid iscsiadm umount hostname iscsi-iname
     dracut_install -o iscsiuio
+    dracut_install -o /etc/iscsi/initiatorname.iscsi
+    dracut_install -o /etc/iscsi/iscsid.conf
     inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
     inst_hook cleanup 90 "$moddir/cleanup-iscsi.sh"
     inst "$moddir/iscsiroot.sh" "/sbin/iscsiroot"
     inst "$moddir/mount-lun.sh" "/bin/mount-lun.sh"
+
+    mkdir -p ${initdir}/${systemdsystemunitdir}/sockets.target.wants
+    inst_simple "${moddir}/iscsid-initrd.service" "${systemdsystemunitdir}/iscsid.service"
+    inst_simple "${moddir}/iscsid-initrd.socket" "${systemdsystemunitdir}/iscsid.socket"
+    ln -fs ../iscsid.socket "${initdir}/${systemdsystemunitdir}/sockets.target.wants/iscsid.socket"
+    inst_simple "${moddir}/iscsiuio-initrd.service" "${systemdsystemunitdir}/iscsiuio.service"
+    inst_simple "${moddir}/iscsiuio-initrd.socket" "${systemdsystemunitdir}/iscsiuio.socket"
+    ln -fs ../iscsiuio.socket "${initdir}/${systemdsystemunitdir}/sockets.target.wants/iscsiuio.socket"
 }
-- 
1.7.11.7
