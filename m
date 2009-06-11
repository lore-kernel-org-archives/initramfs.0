From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 2/3] network: add support for netroot=...
Date: Thu, 11 Jun 2009 11:09:44 -0400
Message-ID: <1244732985-14927-3-git-send-email-dave@thedillows.org>
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

This adds support for a command line option netroot=, which is currently
equivalent to root=. This will allow us to break out handling in NBD and
iSCSI to support constructs such as "root=LABEL=/ netroot=dhcp" to make
use of our block device handling with network attached devices.

iSCSI has not been changed in this patch as I don't currently have a way
to test it.
---
 modules.d/40network/dhcp-fallback.sh |   10 +++++++-
 modules.d/40network/netroot          |    2 +-
 modules.d/95nbd/nbd-netroot.sh       |    6 ++--
 modules.d/95nbd/parse-nbdroot.sh     |    8 +++++-
 modules.d/95nfs/nfs-netroot.sh       |   38 +++++++++++++++++-----------------
 modules.d/95nfs/parse-nfsroot.sh     |   13 +++++++++-
 modules.d/99base/init                |    2 +-
 test/TEST-20-NFS/test.sh             |   37 +++++++++++++++++++++++++++++++-
 test/TEST-40-NBD/test.sh             |    8 +++++++
 9 files changed, 92 insertions(+), 32 deletions(-)

diff --git a/modules.d/40network/dhcp-fallback.sh b/modules.d/40network/dhcp-fallback.sh
index 1f4ec0c..484a121 100755
--- a/modules.d/40network/dhcp-fallback.sh
+++ b/modules.d/40network/dhcp-fallback.sh
@@ -1,12 +1,18 @@
 # We should go last, and default the root if needed
 
-if [ -z "$root" ]; then
-    root=dhcp
+if [ -z "$root" -a -z "$netroot" ]; then
+    netroot=dhcp
 fi
 
 if [ "$root" = "dhcp" -a -z "$netroot" ]; then
     rootok=1
     netroot=dhcp
+    unset root
+fi
+
+# Cleanup any coversions from root->netroot if they are the same
+if [ "$netroot" = "$root" ]; then
+    unset root
 fi
 
 if [ "${netroot+set}" = "set" ]; then
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index b61e2fc..d874799 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -46,7 +46,7 @@ fi
 # Run the handler; don't store the root, it may change from device to device
 # XXX other variables to export?
 export NEWROOT
-if $handler $netif $root; then
+if $handler $netif $netroot; then
     # Network rootfs mount successful
     [ -f /tmp/dhclient.$netif.lease ] &&    cp /tmp/dhclient.$netif.lease    /tmp/net.$netif.lease
     [ -f /tmp/dhclient.$netif.dhcpopts ] && cp /tmp/dhclient.$netif.dhcpopts /tmp/net.$netif.dhcpopts
diff --git a/modules.d/95nbd/nbd-netroot.sh b/modules.d/95nbd/nbd-netroot.sh
index 20f4f09..9513982 100755
--- a/modules.d/95nbd/nbd-netroot.sh
+++ b/modules.d/95nbd/nbd-netroot.sh
@@ -1,9 +1,9 @@
-if [ "$root" = "dhcp" ]; then
+if [ "$netroot" = "dhcp" ]; then
     if [ -n "$new_root_path" -a -z "${new_root_path%%nbd:*}" ]; then
-	root="$new_root_path"
+	netroot="$new_root_path"
     fi
 fi
 
-if [ -z "${root%nbd:*}" ]; then
+if [ -z "${netroot%nbd:*}" ]; then
     handler=/sbin/nbdroot
 fi
diff --git a/modules.d/95nbd/parse-nbdroot.sh b/modules.d/95nbd/parse-nbdroot.sh
index ba40207..426d281 100755
--- a/modules.d/95nbd/parse-nbdroot.sh
+++ b/modules.d/95nbd/parse-nbdroot.sh
@@ -39,9 +39,13 @@ case "$root" in
 	;;
 esac
 
-if [ "${root%%:*}" = "nbd" ]; then
+if [ -z "$netroot" -a -n "$root" -a -z "${root%%nbd:*}" ]; then
+    netroot="$root"
+    unset root
+fi
+
+if [ "${netroot%%:*}" = "nbd" ]; then
     # XXX validate options here?
     # XXX generate udev rules?
     rootok=1
-    netroot=nbd
 fi
diff --git a/modules.d/95nfs/nfs-netroot.sh b/modules.d/95nfs/nfs-netroot.sh
index 365d394..71ab00d 100755
--- a/modules.d/95nfs/nfs-netroot.sh
+++ b/modules.d/95nfs/nfs-netroot.sh
@@ -3,47 +3,47 @@
 # that the number of colons match what we expect, and our glob didn't
 # inadvertently match a different handler's.
 #
-if [ "$root" = "dhcp" -o "$root" = "nfs" -o "$root" = "nfs4" ]; then
+if [ "$netroot" = "dhcp" -o "$netroot" = "nfs" -o "$netroot" = "nfs4" ]; then
     nfsver=nfs
-    if [ "$root" = "nfs4" ]; then
+    if [ "$netroot" = "nfs4" ]; then
 	nfsver=nfs4
     fi
     case "$new_root_path" in
-    nfs:*|nfs4:*) root="$new_root_path" ;;
+    nfs:*|nfs4:*) netroot="$new_root_path" ;;
     *:/*:*)
 	if check_occurances "$new_root_path" ':' 2; then
-	    root="$nfsver:$new_root_path"
+	    netroot="$nfsver:$new_root_path"
 	fi ;;
     *:/*,*)
 	if check_occurances "$new_root_path" ':' 1; then
-	    root="$nfsver:$new_root_path"
+	    netroot="$nfsver:$new_root_path"
 	fi ;;
     *:/*)
 	if check_occurances "$new_root_path" ':' 1; then
-	    root="$nfsver:$new_root_path:"
+	    netroot="$nfsver:$new_root_path:"
 	fi ;;
     /*:*)
 	if check_occurances "$new_root_path" ':' 1; then
-	    root="$nfsver::$new_root_path"
+	    netroot="$nfsver::$new_root_path"
 	fi ;;
     /*,*)
 	if check_occurances "$new_root_path" ':' 0; then
-	    root="$nfsver::$new_root_path"
+	    netroot="$nfsver::$new_root_path"
 	fi ;;
     /*)
 	if check_occurances "$new_root_path" ':' 0; then
-	    root="$nfsver::$new_root_path:"
+	    netroot="$nfsver::$new_root_path:"
 	fi ;;
-    '') root="$nfsver:::" ;;
+    '') netroot="$nfsver:::" ;;
     esac
 fi
 
-if [ -z "${root%%nfs:*}" -o -z "${root%%nfs4:*}" ]; then
+if [ -z "${netroot%%nfs:*}" -o -z "${netroot%%nfs4:*}" ]; then
     # Fill in missing information from DHCP
-    nfsver=${root%%:*}; root=${root#*:}
-    nfsserver=${root%%:*}; root=${root#*:}
-    nfspath=${root%%:*}
-    nfsflags=${root#*:}
+    nfsver=${netroot%%:*}; netroot=${netroot#*:}
+    nfsserver=${netroot%%:*}; netroot=${netroot#*:}
+    nfspath=${netroot%%:*}
+    nfsflags=${netroot#*:}
 
     # XXX where does dhclient stash the next-server option? Do we care?
     if [ -z "$nfsserver" -o "$nfsserver" = "$nfspath" ]; then
@@ -51,9 +51,9 @@ if [ -z "${root%%nfs:*}" -o -z "${root%%nfs4:*}" ]; then
     fi
 
     # Handle alternate syntax of path,options
-    if [ "$nfsflags" = "$nfspath" -a "${root#*,}" != "$root" ]; then
-	nfspath=${root%%,*}
-	nfsflags=${root#*,}
+    if [ "$nfsflags" = "$nfspath" -a "${netroot#*,}" != "$netroot" ]; then
+	nfspath=${netroot%%,*}
+	nfsflags=${netroot#*,}
     fi
 
     # Catch the case when no additional flags are set
@@ -62,6 +62,6 @@ if [ -z "${root%%nfs:*}" -o -z "${root%%nfs4:*}" ]; then
     fi
 
     # XXX validate we have all the required info?
-    root="$nfsver:$nfsserver:$nfspath:$nfsflags"
+    netroot="$nfsver:$nfsserver:$nfspath:$nfsflags"
     handler=/sbin/nfsroot
 fi
diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index c2ecf4e..294ca28 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -2,6 +2,7 @@
 #
 # Preferred format:
 #	root=nfs[4]:[server:]path[:options]
+#	netroot=nfs[4]:[server:]path[:options]
 #
 # If server is unspecified it will be pulled from one of the following
 # sources, in order:
@@ -38,9 +39,17 @@ case "$root" in
 	;;
 esac
 
-case "$root" in
+if [ -z "$netroot" -a -n "$root" -a -z "${root%%nfs*}" ]; then
+    netroot="$root"
+    unset root
+fi
+
+case "$netroot" in
     nfs|nfs4|nfs:*|nfs4:*)
     	rootok=1
-    	netroot=nfs
+	if [ -n "$root" -a "$netroot" != "$root" ]; then
+	    echo "WARNING: root= and netroot= do not match, ignoring root="
+	fi
+	unset root
     ;;
 esac
diff --git a/modules.d/99base/init b/modules.d/99base/init
index fb1a604..998f5e6 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -45,7 +45,7 @@ if [ -z "$rootok" -a -n "${root%%error:*}" ]; then
     root="error: No handler for root=${root}"
 fi
 
-if [ -z "${root%%error:*}" ]; then
+if [ -n "$root" -a -z "${root%%error:*}" ]; then
     case "${root%%:*}" in
        '') echo "FATAL: no root= option specified, and no network support" ;;
        error) echo "FATAL: ${root#error:}" ;;
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index e87a14d..9b1c1cc 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -100,7 +100,10 @@ test_nfsv3() {
     # MAC numbering scheme:
     # NFSv3: last octect starts at 0x00 and works up
     # NFSv4: last octect starts at 0x80 and works up
-    
+
+    client_test "NFSv3 netroot=dhcp DHCP path only" 52:54:00:12:34:00 \
+	"netroot=dhcp" 192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv3 root=dhcp DHCP path only" 52:54:00:12:34:00 \
 	"root=dhcp" 192.168.50.1 -wsize=4096 || return 1
 
@@ -110,6 +113,9 @@ test_nfsv3() {
     client_test "NFSv3 root=/dev/nfs DHCP path only" 52:54:00:12:34:00 \
 	"root=/dev/nfs" 192.168.50.1 -wsize=4096 || return 1
 
+    client_test "NFSv3 netroot=dhcp DHCP IP:path" 52:54:00:12:34:01 \
+	"netroot=dhcp" 192.168.50.2 -wsize=4096 || return 1
+
     client_test "NFSv3 root=dhcp DHCP IP:path" 52:54:00:12:34:01 \
 	"root=dhcp" 192.168.50.2 -wsize=4096 || return 1
 
@@ -122,9 +128,16 @@ test_nfsv3() {
     client_test "NFSv3 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:02 \
 	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
 
+    client_test "NFSv3 netroot=dhcp DHCP proto:IP:path:options" \
+	52:54:00:12:34:03 "netroot=dhcp" 192.168.50.3 wsize=4096 || return 1
+
     client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:03 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
+    client_test "NFSv3 netroot=nfs:..." 52:54:00:12:34:04 \
+	"netroot=nfs:192.168.50.1:/nfs/client" 192.168.50.1 \
+	-wsize=4096 || return 1
+
     client_test "NFSv3 root=nfs:..." 52:54:00:12:34:04 \
 	"root=nfs:192.168.50.1:/nfs/client" 192.168.50.1 -wsize=4096 || return 1
 
@@ -168,24 +181,40 @@ test_nfsv4() {
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
 
+    client_test "NFSv4 netroot=nfs4 DHCP path only" 52:54:00:12:34:80 \
+	"netroot=nfs4" 192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:80 \
 	"root=nfs4" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:80 \
 	"root=/dev/nfs4" 192.168.50.1 -wsize=4096 || return 1
 
+    client_test "NFSv4 netroot=nfs4 DHCP IP:path" 52:54:00:12:34:81 \
+	"netroot=nfs4" 192.168.50.2 -wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:81 \
 	"root=nfs4" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:81 \
 	"root=/dev/nfs4" 192.168.50.2 -wsize=4096 || return 1
 
+    client_test "NFSv4 netroot=dhcp DHCP proto:IP:path" 52:54:00:12:34:82 \
+	"netroot=dhcp" 192.168.50.3 -wsize=4096 || return 1
+
     client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:82 \
 	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
 
+    client_test "NFSv4 netroot=dhcp DHCP proto:IP:path:options" \
+	52:54:00:12:34:83 "netroot=dhcp" 192.168.50.3 wsize=4096 || return 1
+
     client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:83 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
+    client_test "NFSv4 netroot=nfs4:..." 52:54:00:12:34:84 \
+	"netroot=nfs4:192.168.50.1:/client" 192.168.50.1 \
+	-wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4:..." 52:54:00:12:34:84 \
 	"root=nfs4:192.168.50.1:/client" 192.168.50.1 \
 	-wsize=4096 || return 1
@@ -201,8 +230,12 @@ test_nfsv4() {
 	52:54:00:12:34:84 "root=nfs4 nfsroot=/client,wsize=4096" \
 	192.168.50.1 wsize=4096 || return 1
 
-    # This one only works with NFSv4 in the test suite -- NFSv3 needs
+    # These two only work with NFSv4 in the test suite -- NFSv3 needs
     # a /nfs prefix due to our server configuration
+
+    client_test "NFSv4 netroot=nfs4" 52:54:00:12:34:84 \
+	"netroot=nfs4" 192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4" 52:54:00:12:34:84 \
 	"root=nfs4" 192.168.50.1 -wsize=4096 || return 1
 
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 0f449cf..39ec746 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -146,6 +146,14 @@ test_run() {
 
     client_test "NBD root=dhcp DHCP root-path nbd:srv:port:fstype:fsopts" \
 	52:54:00:12:34:04 "root=dhcp" ext2 errors=panic || return 1
+
+    # netroot handling
+
+    client_test "NBD netroot=nbd:IP:port" 52:54:00:12:34:00 \
+	"netroot=nbd:192.168.50.1:2000" || return 1
+
+    client_test "NBD netroot=dhcp DHCP root-path nbd:srv:port:fstype:fsopts" \
+	52:54:00:12:34:04 "netroot=dhcp" ext2 errors=panic || return 1
 }
 
 make_client_root() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
