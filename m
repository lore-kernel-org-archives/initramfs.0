From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 6/6] Fix manpage display errors
Date: Fri, 27 Nov 2009 11:57:16 +0100
Message-ID: <1259319436-14925-7-git-send-email-philippe.seewer@bfh.ch>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Some lines in dracut's manpage are just too long for justified
display on 80c terminals. These small corrections fix this. In addition
man --warnings does not complain anymore about anything at all.
---
 dracut.8 |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/dracut.8 b/dracut.8
index 851a5ce..8303fd0 100644
--- a/dracut.8
+++ b/dracut.8
@@ -104,8 +104,9 @@ root filesystem.
 .B init=<path to real init>
 .TP
 .B root=<path to blockdevice>
-specify e.g. \fI/dev/sda1\fR or
-\fI/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1\fR
+specify blockdevice to use as root filesystem.
+e.g. \fI/dev/sda1\fR
+e.g. \fI/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1\fR
 .TP
 .B rootfstype=<filesystem type>
 "auto" if not specified, e.g. \fIrootfstype=ext3\fR
@@ -120,7 +121,9 @@ do not honor special mount options for the root filesystem found in
 /etc/fstab of the real root.
 
 .SH I18N
+.ad l
 e.g. LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=de-latin1-nodeadkeys
+.ad
 .TP
 .B KEYBOARDTYPE=sun|pc
 will be written to /etc/sysconfig/keyboard in the initramfs
@@ -200,6 +203,7 @@ to the specified values
 .TP
 .B rd_ZFCP=<zfcp adaptor device bus ID>,<WWPN>,<FCPLUN>
 rd_ZFCP can be specified multiple times on the kernel command line.
+
 example: rd_ZFCP=0.0.4000,0x5005076300C213e9,0x5022000000000000 
 .TP
 .B rd_NO_ZFCPCONF
@@ -208,9 +212,9 @@ ignore zfcp.conf included in the initramfs
 .SH CCW
 .TP
 .B rd_CCW=<nettype>,<subchannels>,<options>
-rd_CCW can be specified multiple times on the kernel command line.
-e.g. rd_CCW=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
-e.g. rd_CCW=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar
+rd_CCW can be specified multiple times on the kernel command line. Examples:
+    rd_CCW=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
+    rd_CCW=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar
 .SH DHCP
 .TP
 .B root=dhcp
@@ -244,7 +248,7 @@ Set the NFSv4 domain name. Will overwrite the settings in /etc/idmap.conf.
 
 .SH iSCSI
 .TP
-.B root=iscsi:[username:password[reverse:password]@][<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+.B root=iscsi:[username:password[:reverse:password]@][<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
 protocol defaults to "6", LUN defaults to "0".
 
 If the "servername" field is provided by BOOTP or DHCP, then that
@@ -261,10 +265,15 @@ http://tools.ietf.org/html/rfc4173
 e.g. root=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0
 .TP
 .B root=??? netroot=iscsi:[username:password[:reverse:password]@][<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname> ...
+.ad l
 multiple netroot options allow setting up multiple iscsi disks
 e.g. 
-   root=UUID=12424547 netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0 netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target1
-.B not yet implemented
+   root=UUID=12424547
+   netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0
+   netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target1
+
+.B not yet implemented!
+.ad
 .TP
 .B root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip= iscsi_target_port= iscsi_target_group= iscsi_username=  iscsi_password= iscsi_in_username= iscsi_in_password=
 .TP
@@ -284,13 +293,11 @@ the MAC-address must be lowercase!
 mount nbd share from <server>
 .TP
 .B root=dhcp 
-   with dhcp root-path=nbd:<server>:<port>[:<fstype>][:<mountopts>]
+with dhcp root-path=nbd:<server>:<port>[:<fstype>][:<mountopts>]
 root=dhcp alone directs initrd to look at the DHCP root-path where NBD options can be specified.
 This syntax is only usable in cases where you are directly mounting the volume as the rootfs.
 
 .SH Network
-.TP bootdev=<interface>
-.B specify the network interface to boot from
 .TP
 .B ip={dhcp|on|any}
 get ip from dhcp server from all interfaces. If root=dhcp, loop sequentially through all interfaces (eth0, eth1, ...) and use the first with a valid DHCP root-path.
@@ -298,7 +305,9 @@ get ip from dhcp server from all interfaces. If root=dhcp, loop sequentially thr
 .B ip=<interface>:{dhcp|on|any}
 get ip from dhcp server on a specific interface
 .TP
-.B ip=<client-IP-number>:[<server-id>]:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:{none|off}
+.ad l
+.B ip=<client-IP>:[<server-id>]:<gateway-IP>:<netmask>:<client\%hostname>:<interface>:{none|off}
+.ad
 explicit network configuration
 .TP
 .B ifname=<interface>:<MAC>
@@ -306,6 +315,9 @@ Assign network device name <interface> (ie eth0) to the NIC with MAC <MAC>.
 Note letters in the MAC-address must be lowercase!
 Note that if you use this option you \fBmust\fR specify an ifname= argument
 for all interfaces used in ip= or fcoe= arguments
+.TP
+.B bootdev=<interface>
+specify network interface to use routing and netroot information from. Required if multiple ip= lines are used.
 
 .SH Plymouth Boot Splash
 .TP
@@ -331,7 +343,7 @@ set -x for the dracut shell and logs to dmesg, console and /init.log
 .B rdbreak
 drop to a shell at the end
 .TP
-.B rdbreak={cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot}
+.B rdbreak={cmdline | pre-udev | pre-trigger | initqueue | pre-mount | mount | pre-pivot}
 drop to a shell on defined breakpoint
 .TP
 .B rdudevinfo
-- 
1.6.5.3
