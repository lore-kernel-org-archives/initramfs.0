From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/13] make iSCSI boot with root=dhcp and mount partitions labeled with "ROOT" or "/"
Date: Fri, 19 Jun 2009 13:05:45 +0200
Message-ID: <1245409551-30493-8-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/95iscsi/iscsiroot   |    8 ++++++++
 modules.d/99base/install      |    5 ++---
 test/TEST-30-ISCSI/dhcpd.conf |    2 +-
 test/TEST-30-ISCSI/test.sh    |    2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index e273fc5..783306b 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -118,6 +118,14 @@ echo "InitiatorName='$iscsi_initiator'" > /dev/.initiatorname.iscsi
 
 # FIXME $iscsi_lun?? $iscsi_protocol??
 
+# if root does not specify a block device
+# we set a fallback to recognize any filesystems labeled 
+# LABEL=/ or LABEL=ROOT
+if [ "${root#block:*}" = "$root" ]; then
+    ( root="block:/dev/disk/by-label/\x2f" . /pre-udev/30-block-genrules.sh )
+    ( root="block:/dev/disk/by-label/ROOT" . /pre-udev/30-block-genrules.sh )
+fi
+
 iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
     -g $iscsi_target_group -a $iscsi_target_ip	\
     -p $iscsi_target_port \
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 68d40fb..06cf6db 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -7,9 +7,8 @@ fi
 # install our scripts and hooks
 inst "$moddir/init" "/init"
 # Bail out if switch_root does not exist
-if [ ! -x "$moddir/switch_root" ]; then
-    # assume it is installed in the standard path
-    dracut_install switch_root
+if which switch_root >/dev/null 2>&1; then
+    dracut_install switch_root 
 else
     inst "$moddir/switch_root" "/sbin/switch_root"
 fi
diff --git a/test/TEST-30-ISCSI/dhcpd.conf b/test/TEST-30-ISCSI/dhcpd.conf
index 515922a..6eb035b 100644
--- a/test/TEST-30-ISCSI/dhcpd.conf
+++ b/test/TEST-30-ISCSI/dhcpd.conf
@@ -15,7 +15,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 	# NFSv3: last octect starts at 0x00 and works up
 
 	group {
-		option root-path "iscsiroot=192.168.50.1::::test";
+		option root-path "iscsi:192.168.50.1::::iqn.2009-06.dracut:target0";
 
 		host iscsi-1 {
 			hardware ethernet 52:54:00:12:34:00;
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index 134ee73..a6833bf 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -37,7 +37,7 @@ run_client() {
   	-net nic,macaddr=52:54:00:12:34:00,model=e1000 \
   	-net socket,mcast=230.0.0.1:1234 \
   	-kernel /boot/vmlinuz-$KVERSION \
-	-append "root=LABEL=ROOT netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0 rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
+	-append "root=dhcp rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
   	-initrd initramfs.testing
     grep -m 1 -q iscsi-OK client.img || return 1
 }
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
