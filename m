From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: [PATCH] add fake root support
Date: Tue, 19 Oct 2010 17:49:43 +0300
Message-ID: <4CBDB007.4090802@hoster-ok.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020902060703020806080207"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------020902060703020806080207
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch for "fake" root functionality,
I'm (mostly) duplicating issue's description from my previous e-mail
(for commit message if this is to be pushed):

===============
fakeroot use case -
* initramfs includes ext3 filesystem wrapped into squashfs (like
ovirt-node-image has)
* that filesystem is used as a live root (initramfs is pulled from TFTP)
* kernel cmdline has CLIENTSTATE variable set to address of NFS mount.
Then rc.sysinit will mount $CLIENTSTATE/$HOSTNAME (as a last resort
case) and will use it as a STATE_MOUNT.

Thus, we have read-only root in RAM and all state files mounted from
NFS. So server can operate totally diskless (opposed to ovirt-node which
has to be set-up on a local disk or iSCSI target, both of which seem to
be an overkill if one has 16+ servers). An adding new servers to a pool
requires only correct DHCP server settings, nothing more (probably some
files on a nfs server too, but that's another story).

What we need from dracut is to set up networking and pass ifcfg's to a
system via /dev/.initramfs (for DHCP). But then we need to some-how
"simulate" networked root because otherwise there is no chance to bring
network up.

To achieve this we could pass "netroot=fake root=live:blablabla
CLIENTSTATE=xxx.yyy.zzz.www:/mnt" via kernel's cmdline.
==============

Best,
Vladislav

--------------020902060703020806080207
Content-Type: text/x-patch;
 name="dracut-fakeroot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-fakeroot.patch"

diff --git a/modules.d/95fakeroot/check b/modules.d/95fakeroot/check
new file mode 100755
index 0000000..1829b66
--- /dev/null
+++ b/modules.d/95fakeroot/check
@@ -0,0 +1,8 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# We depend on network modules being loaded
+[ "$1" = "-d" ] && echo network
+
+exit 0
diff --git a/modules.d/95fakeroot/fakeroot b/modules.d/95fakeroot/fakeroot
new file mode 100755
index 0000000..caae40c
--- /dev/null
+++ b/modules.d/95fakeroot/fakeroot
@@ -0,0 +1,41 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+#
+
+. /lib/dracut-lib.sh
+
+PATH=$PATH:/sbin:/usr/sbin
+
+# Huh? Empty $1?
+[ -z "$1" ] && exit 1
+
+# Huh? Empty $2?
+[ -z "$2" ] && exit 1
+
+# Huh? Empty $3? This isn't really necessary, since NEWROOT isn't 
+# used here. But let's be consistent
+[ -z "$3" ] && exit 1
+
+netif="$1"
+root="$2"
+
+# This is for NFS RW state partition, just set a variable
+[ -z "$CLIENTSTATE" ] && CLIENTSTATE=$(getarg CLIENTSTATE=)
+
+echo
+echo "****"
+echo "** Allowing network to start without real networked root."
+echo "** This makes possible to use readonly root with nfs-mounted RW state partition."
+echo "** Real root will be mounted from $root."
+echo "** Network interface $netif will be passed to a real system."
+if [ -n "$CLIENTSTATE" ] ;then
+    echo "** RW state partition will be mounted by a real system from $CLIENTSTATE."
+else
+    echo "** Warning: nothing is passed in CLIENTSTATE variable."
+fi
+echo
+echo "****"
+echo
+
+exit 0
diff --git a/modules.d/95fakeroot/install b/modules.d/95fakeroot/install
new file mode 100755
index 0000000..79abdf7
--- /dev/null
+++ b/modules.d/95fakeroot/install
@@ -0,0 +1,5 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+inst_hook cmdline 90 "$moddir/parse-fakeroot.sh"
+inst "$moddir/fakeroot" "/sbin/fakeroot"
diff --git a/modules.d/95fakeroot/parse-fakeroot.sh b/modules.d/95fakeroot/parse-fakeroot.sh
new file mode 100755
index 0000000..9d22dd2
--- /dev/null
+++ b/modules.d/95fakeroot/parse-fakeroot.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+#
+# Format:
+#       netroot=fake root=*
+#
+# both netroot=fake and root= should be set
+#
+# Note: this differs from other netroot handlers which usually replace netroot's value with
+# what root is set too.
+#
+
+# This script is sourced, so root should be set. But let's be paranoid
+[ -z "$root" ] && root=$(getarg root=)
+[ -z "$netroot" ] && netroot=$(getarg netroot=)
+
+if [ "${netroot%%:*}" = "fake" ] ; then
+    if [ -z "$root" ] ; then
+        echo "Warning: both root and netroot should be set for a 'fake' netroot"
+    fi
+fi
+

--------------020902060703020806080207--
