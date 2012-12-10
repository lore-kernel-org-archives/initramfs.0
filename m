From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] iscsi unit files and helper script
Date: Mon, 10 Dec 2012 14:08:35 -0800
Message-ID: <1355177316-25803-4-git-send-email-cleech@redhat.com>
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

iSCSI service and socket files, and the iscsi_mark_root_nodes helper script to
preserve sessions started in the initramfs.

diff -Naur a/iscsid.service b/iscsid.service
--- a/iscsid.service	1969-12-31 16:00:00.000000000 -0800
+++ b/iscsid.service	2012-12-10 13:38:38.643307001 -0800
@@ -0,0 +1,9 @@
+[Unit]
+Description=Open-iSCSI
+Documentation=man:iscsid(8) man:iscsiadm(8)
+After=network.target NetworkManager-wait-online.service iscsiuio.service tgtd.service targetcli.service
+
+[Service]
+Type=simple
+ExecStart=/usr/sbin/iscsid -f -n
+ExecStop=/sbin/iscsiadm -k 0 2
diff -Naur a/iscsid.socket b/iscsid.socket
--- a/iscsid.socket	1969-12-31 16:00:00.000000000 -0800
+++ b/iscsid.socket	2012-12-10 13:38:38.643307001 -0800
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
diff -Naur a/iscsi.service b/iscsi.service
--- a/iscsi.service	1969-12-31 16:00:00.000000000 -0800
+++ b/iscsi.service	2012-12-10 13:38:38.643307001 -0800
@@ -0,0 +1,18 @@
+[Unit]
+Description=Login and scanning of iSCSI devices
+Documentation=man:iscsiadm(8) man:iscsid(8)
+#Requires=iscsid.service
+#BindTo=iscsid.service
+After=network.target NetworkManager-wait-online.service iscsid.service
+ConditionPathExists=/etc/iscsi/initiatorname.iscsi
+
+[Service]
+Type=oneshot
+ExecStart=/usr/libexec/iscsi_mark_root_nodes
+ExecStart=/sbin/iscsiadm -m node --loginall=automatic
+ExecStop=/bin/sync
+ExecStop=/sbin/iscsiadm -m node --logoutall=automatic
+RemainAfterExit=true
+
+[Install]
+WantedBy=remote-fs.target
diff -Naur a/iscsiuio.service b/iscsiuio.service
--- a/iscsiuio.service	1969-12-31 16:00:00.000000000 -0800
+++ b/iscsiuio.service	2012-12-10 13:38:38.643307001 -0800
@@ -0,0 +1,11 @@
+[Unit]
+Description=iSCSI UserSpace I/O driver
+Documentation=man:iscsiuio(8)
+Requires=iscsid.service
+BindTo=iscsid.service
+Before=iscsid.service
+After=network.target NetworkManager-wait-online.service
+
+[Service]
+Type=simple
+ExecStart=/usr/sbin/iscsiuio -f
diff -Naur a/iscsiuio.socket b/iscsiuio.socket
--- a/iscsiuio.socket	1969-12-31 16:00:00.000000000 -0800
+++ b/iscsiuio.socket	2012-12-10 13:38:38.643307001 -0800
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
diff -Naur a/usr/libexec/iscsi_mark_root_nodes b/usr/libexec/iscsi_mark_root_nodes
--- a/usr/libexec/iscsi_mark_root_nodes	1969-12-31 16:00:00.000000000 -0800
+++ b/usr/libexec/iscsi_mark_root_nodes	2012-12-10 13:38:47.322082141 -0800
@@ -0,0 +1,14 @@
+#!/bin/bash
+
+ISCSIADM=/sbin/iscsiadm
+SESSION_FILE=/run/initramfs/iscsi.sessions
+
+if [ ! -f $SESSION_FILE ] ; then
+  exit 0
+fi
+
+while read t num i target; do
+  ip=${i%:*}
+  $ISCSIADM -m node -p $ip -T $target -o update -n node.startup -v onboot
+done < $SESSION_FILE
+
