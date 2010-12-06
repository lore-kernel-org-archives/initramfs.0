From: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>
Subject: [PATCH] include biosdevname calls in dracut
Date: Sun, 5 Dec 2010 18:52:29 -0600
Message-ID: <20101206005229.GA687@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

For your consideration.  This allows biosdevname to be called from
network-using functions in dracut.  biosdevname is included in Fedora
15, and there are tickets open to include it in other distros.

Signed-off-by: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>

Thanks,
Matt


From ef6a283f685571c730063a666830e2f02d8e9244 Mon Sep 17 00:00:00 2001
From: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>
Date: Fri, 3 Dec 2010 23:41:01 -0600
Subject: [PATCH] add biosdevname calls to network subpackage

---
 dracut.spec                    |    1 +
 modules.d/95udev-rules/install |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index f3b92d7..f3fb3dd 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -113,6 +113,7 @@ Requires: bridge-utils
 Requires: iscsi-initiator-utils
 Requires: nfs-utils 
 Requires: dhclient
+Requires: biosdevname
 %endif
 
 %if 0%{?suse_version}
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index ee32b56..f42f68a 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -6,10 +6,11 @@
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
 dracut_install udevd udevadm /etc/udev/udev.conf /etc/group
-dracut_install basename
+dracut_install basename biosdevname
 inst_rules 50-udev-default.rules 60-persistent-storage.rules \
     61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rules \
-    60-pcmcia.rules 
+    60-pcmcia.rules \
+    71-netdevice.rules
 #Some debian udev rules are named differently
 inst_rules 50-udev.rules 95-late.rules
 
-- 
1.7.3.2
