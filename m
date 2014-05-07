From: Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch] dracut: write-ifcfg.sh: load net-lib.sh
Date: Wed, 7 May 2014 10:18:27 -0400
Message-ID: <20140507141827.27588.20483.sendpatchset@dhcp-33-231.bos.redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When kdump boots the second kernel, it complains:

dracut-pre-pivot[429]: //lib/dracut/hooks/pre-pivot/85-write-ifcfg.sh: line 168: is_persistent_ethernet_name: command not found 

is_persistent_ethernet_name is defined in net-lib.sh, but write-ifcfg.sh
doesn't load that library.  Solution is to load the library.

Tested that this fix eliminates the error message.

Signed-off-by: Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 5de2e90..e30749b 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -5,6 +5,8 @@
 # NFS root might have reached here before /tmp/net.ifaces was written
 udevadm settle --timeout=30
 
+command -v is_persistent_ethernet_name || . /lib/net-lib.sh
+
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
 fi
