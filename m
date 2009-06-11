From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 1/3] NBD test: add more option parsing tests
Date: Thu, 11 Jun 2009 11:09:43 -0400
Message-ID: <1244732985-14927-2-git-send-email-dave@thedillows.org>
References: <1244732985-14927-1-git-send-email-dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244732985-14927-1-git-send-email-dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

---
 test/TEST-40-NBD/client-init |    6 +++-
 test/TEST-40-NBD/dhcpd.conf  |   27 ++++++++++++++
 test/TEST-40-NBD/test.sh     |   79 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/test/TEST-40-NBD/client-init b/test/TEST-40-NBD/client-init
index dde5c16..88b3d65 100755
--- a/test/TEST-40-NBD/client-init
+++ b/test/TEST-40-NBD/client-init
@@ -1,6 +1,10 @@
 #!/bin/sh
 exec >/dev/console 2>&1
-echo "nbd-OK" >/dev/sda
+while read dev fs fstype opts rest; do
+    [ "$dev" != "/dev/nbd0" ] && continue
+    echo "nbd-OK $fstype $opts" >/dev/sda
+    break
+done < /proc/mounts
 export TERM=linux
 export PS1='nbdclient-test:\w\$ '
 stty sane
diff --git a/test/TEST-40-NBD/dhcpd.conf b/test/TEST-40-NBD/dhcpd.conf
index e7d5a08..f9eeead 100644
--- a/test/TEST-40-NBD/dhcpd.conf
+++ b/test/TEST-40-NBD/dhcpd.conf
@@ -26,4 +26,31 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 			fixed-address 192.168.50.101;
 		}
 	}
+
+	group {
+		host nbd-3 {
+			option root-path "nbd:192.168.50.1:2000:ext2";
+
+			hardware ethernet 52:54:00:12:34:02;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		host nbd-4 {
+			option root-path "nbd:192.168.50.1:2000::errors=panic";
+
+			hardware ethernet 52:54:00:12:34:03;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		host nbd-5 {
+			option root-path "nbd:192.168.50.1:2000:ext2:errors=panic";
+
+			hardware ethernet 52:54:00:12:34:04;
+			fixed-address 192.168.50.101;
+		}
+	}
 }
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index cfe894a..0f449cf 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -4,7 +4,7 @@ TEST_DESCRIPTION="root filesystem on NBD"
 KVERSION=${KVERSION-$(uname -r)}
 
 # Uncomment this to debug failures
-#DEBUGFAIL="rdinitdebug rdnetdebug"
+#DEBUGFAIL="rdinitdebug rdnetdebug rdbreak"
 
 run_server() {
     # Start server first
@@ -30,6 +30,12 @@ client_test() {
     local test_name="$1"
     local mac=$2
     local cmdline="$3"
+    local fstype=$4
+    local fsopt=$5
+    local found opts nbdinfo
+
+    [[ $fstype ]] || fstype=ext3
+    [[ $fsopt ]] || fsopt="errors=continue"
 
     echo "CLIENT TEST START: $test_name"
 
@@ -51,6 +57,28 @@ client_test() {
 	return 1
     fi
 
+    # nbdinfo=( fstype fsoptions )
+    nbdinfo=($(awk '{print $2, $3; exit}' flag.img))
+
+    if [[ "${nbdinfo[0]}" != "$fstype" ]]; then
+	echo "CLIENT TEST END: $test_name [FAILED - WRONG FS TYPE]"
+	return 1
+    fi
+
+    opts=${nbdinfo[1]},
+    while [[ $opts ]]; do
+	if [[ ${opts%%,*} == $fsopt ]]; then
+	    found=1
+	    break
+	fi
+	opts=${opts#*,}
+    done
+
+    if [[ ! $found ]]; then
+	echo "CLIENT TEST END: $test_name [FAILED - BAD FS OPTS]"
+	return 1
+    fi
+
     echo "CLIENT TEST END: $test_name [OK]"
 }
 
@@ -60,9 +88,39 @@ test_run() {
 	return 1
     fi
 
-    client_test "NBD root=nbd:..." 52:54:00:12:34:00 \
+    # The default is ext3,errors=continue so use that to determine
+    # if our options were parsed and used
+
+    client_test "NBD root=nbd:IP:port" 52:54:00:12:34:00 \
 	"root=nbd:192.168.50.1:2000" || return 1
 
+    client_test "NBD root=nbd:IP:port:fstype" 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000:ext2" ext2 || return 1
+
+    client_test "NBD root=nbd:IP:port::fsopts" 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000::errors=panic" \
+	ext3 errors=panic || return 1
+
+    client_test "NBD root=nbd:IP:port:fstype:fsopts" 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000:ext2:errors=panic" \
+	ext2 errors=panic || return 1
+
+    # There doesn't seem to be a good way to validate the NBD options, so
+    # just check that we don't screw up the other options
+
+    client_test "NBD root=nbd:IP:port:::NBD opts" 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000:::bs=2048" || return 1
+
+    client_test "NBD root=nbd:IP:port:fstype::NBD opts" 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000:ext2::bs=2048" ext2 || return 1
+
+    client_test "NBD root=nbd:IP:port:fstype:fsopts:NBD opts" \
+	52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000:ext2:errors=panic:bs=2048" \
+	ext2 errors=panic || return 1
+
+    # Check legacy parsing
+
     client_test "NBD root=nbd nbdroot=srv:port" 52:54:00:12:34:00 \
 	"root=nbd nbdroot=192.168.50.1:2000" || return 1
 
@@ -75,13 +133,24 @@ test_run() {
     client_test "NBD root=dhcp nbdroot=srv,port" 52:54:00:12:34:00 \
 	"root=dhcp nbdroot=192.168.50.1,2000" || return 1
 
+    # DHCP root-path parsing
+
     client_test "NBD root=dhcp DHCP root-path nbd:srv:port" 52:54:00:12:34:01 \
 	"root=dhcp" || return 1
+
+    client_test "NBD root=dhcp DHCP root-path nbd:srv:port:fstype" \
+	52:54:00:12:34:02 "root=dhcp" ext2 || return 1
+
+    client_test "NBD root=dhcp DHCP root-path nbd:srv:port::fsopts" \
+	52:54:00:12:34:03 "root=dhcp" ext3 errors=panic || return 1
+
+    client_test "NBD root=dhcp DHCP root-path nbd:srv:port:fstype:fsopts" \
+	52:54:00:12:34:04 "root=dhcp" ext2 errors=panic || return 1
 }
 
 make_client_root() {
     dd if=/dev/zero of=nbd.ext2 bs=1M count=30
-    mke2fs -F nbd.ext2
+    mke2fs -F -j nbd.ext2
     mkdir mnt
     sudo mount -o loop nbd.ext2 mnt
 
@@ -90,7 +159,7 @@ make_client_root() {
 	initdir=mnt
 	. $basedir/dracut-functions
 	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
-	    /lib/terminfo/l/linux dmesg mkdir cp ping 
+	    /lib/terminfo/l/linux dmesg mkdir cp ping
 	inst ./client-init /sbin/init
 	(
 	    cd "$initdir";
@@ -163,7 +232,7 @@ test_setup() {
 
     sudo $basedir/dracut -l -i overlay / \
 	-m "dash crypt lvm mdraid udev-rules base rootfs-block nbd debug" \
-	-d "ata_piix ext2 sd_mod e1000" \
+	-d "ata_piix ext2 ext3 sd_mod e1000" \
 	-f initramfs.testing $KVERSION || return 1
 }
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
