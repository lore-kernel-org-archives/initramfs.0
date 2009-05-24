From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Add nbd root support to dracut
Date: Sun, 24 May 2009 11:40:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905241139240.2539@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


This patch adds preliminary nbdroot support to dracut.

It does this without using udev, as module insertion creates 16 devices, each
triggering udev. For now I wanted to have nbd working, we can always implement
it in udev at a later time.

The core in question supports different root definitions:

URI Style syntax. Path is ignored, as nbd targets are defined by server and
port:

	root=nbd://server.ip.add.ress:port[/path]

mkinitrd Style syntax. This is used by the mkinitrd from RH which only accepts
this syntax as a dhcp delivered root path. Dracut does understand it as a normal
root definition as well:

	root=nbd:server.ip.add.ress:port:filesystemtype:mountoptions

Debian style syntax. With the base device being an optional number to indicate
the nbd device to use.

	root=/dev/nbd[0-9]* nbdroot=server.ip.add.ress,port[,nbd basedevice]

diffstat dracut-nbd-root.patch 
 install        |    4 +++
 nbd-prepare.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff -uNr dracut/modules.d/95nbd/install dracut/modules.d/95nbd/install
--- dracut/modules.d/95nbd/install	1970-01-01 01:00:00.000000000 +0100
+++ dracut/modules.d/95nbd/install	2009-05-23 20:11:00.438418944 +0200
@@ -0,0 +1,4 @@
+#!/bin/sh
+inst nbd-client
+inst_hook pre-mount 99 "$moddir/nbd-prepare.sh"
+instmods nbd
diff -uNr dracut/modules.d/95nbd/nbd-prepare.sh dracut/modules.d/95nbd/nbd-prepare.sh
--- dracut/modules.d/95nbd/nbd-prepare.sh	1970-01-01 01:00:00.000000000 +0100
+++ dracut/modules.d/95nbd/nbd-prepare.sh	2009-05-24 11:26:13.674261991 +0200
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+# If root=dhcp and a nbd-root has been passed, transform this into the
+# root=nbd::::: syntax
+if [ "$root" = "dhcp" ]; then
+    for dev in /net.*.dhcpopts; do 
+	if [ -f "$dev" ]; then 
+	    . "$dev"
+	    [ -n "$new_root_path" ] && root="nbd:${new_root_path}"
+	fi
+    done
+fi
+
+# Transform the debian way of using root=/dev/nbd and nbdroot=,,,
+if [ -z "${root%%/dev/nbd*}"]; then
+#    nbdroot=$(getarg nbdroot=)
+    if [ -n "$nbdroot" ]; then
+	nbdserver="${nbdroot%%,*}"
+	nbdport="${nbdroot#*,}"
+	nbdport="${nbdport%%,*}"
+	root="nbd://{$nbdserver}:${nbdport}/"
+	if [ "${nbdroot#*,*,}" != "$nbdroot" ]; then
+	    nbdbasedev="${nbdroot#*,*,}"
+	    [ -n "$nbdbasedev" ] && nbdrootdev="/dev/nbd${nbdbasedev}"
+	fi
+    fi
+fi
+
+# Only do anything if root is nbd:
+if [ "${root#nbd:}" != "$root" ]; then
+    # Parse server and port from a nbd://10.0.0.1:1234/ style URI and discard
+    # everything after the port
+    if [ "${root#nbd://}" != "$root" ]; then
+	nbdserver="${root#nbd://}"
+	nbdserver="${nbdserver%:*}"
+	nbdport="${root#nbd://$nbdserver:}"
+	nbdport="${nbdport%%/*}"
+	nbdfs=""
+	nbdopts="rw"
+
+    # Parse server, port, filesystem and options from old-style mkinitrd
+    # IPADDRESS:PORT:FILESYSTEM:OPTIONS style root definitions
+    elif [ "${root%%:*:*:*:*}" = "nbd" ]; then
+	nbdserver="${root#nbd:}"
+	nbdserver="${nbdserver%%:*}"
+	nbdport="${root#nbd:$nbdserver:}"
+	nbdport="${nbdport%%:*}"
+	nbdfs="${root#nbd:$nbdserver:$nbdport:}"
+	nbdfs="${nbdfs%%:*}"
+	nbdopts="${root#nbd:$nbdserver:$nbdport:$nbdfs:}"
+	nbdopts="${nbdopts%%:*}"
+    fi
+
+
+    if [ -n "$nbdserver" ] && [ "$nbdport" -gt 0 -a "$nbdport" -lt 65536 ]; then
+	root="${nbdrootdev:-/dev/nbd0}"
+	fstype="${nbdfs:--t auto}"
+	rflags="${nbdopts:-ro}"
+
+	modprobe nbd
+	i=0
+	# Wait till the device node really exists
+	while [ ! -b "$root" ]; do
+	    [ $i -ge 20 ] && exit 1
+	    sleep 0.1
+	    i=$(($i+1))
+	done
+
+	nbd-client "$nbdserver" "$nbdport" "$root"
+    fi
+fi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
