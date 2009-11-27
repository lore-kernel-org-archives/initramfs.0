From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 2/2] Debian support: Add necessary control files for packaging
Date: Fri, 27 Nov 2009 14:46:31 +0100
Message-ID: <1259329591-23148-2-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch adds all necessary files to build dracut debian packages.

- I've split dracut into two parts: The dracut package for booting from block
  devices and dracut-net for netroot.
- I've deliberately left out all redhat specific modules, they do not make any
  sense on debian at all
---
 debian/changelog          |   53 +++++++++++++++++++++++++++++++++++++++++++++
 debian/compat             |    1 +
 debian/control            |   40 ++++++++++++++++++++++++++++++++++
 debian/copyright          |   39 +++++++++++++++++++++++++++++++++
 debian/dracut-net.dirs    |    5 ++++
 debian/dracut-net.install |    5 ++++
 debian/dracut.dirs        |   22 ++++++++++++++++++
 debian/dracut.docs        |    4 +++
 debian/dracut.install     |   25 +++++++++++++++++++++
 debian/dracut.manpages    |    2 +
 debian/dracut.postinst    |    8 ++++++
 debian/dracut.triggers    |    1 +
 debian/rules              |    3 ++
 13 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 debian/changelog
 create mode 100644 debian/compat
 create mode 100644 debian/control
 create mode 100644 debian/copyright
 create mode 100644 debian/dracut-net.dirs
 create mode 100644 debian/dracut-net.install
 create mode 100644 debian/dracut.dirs
 create mode 100644 debian/dracut.docs
 create mode 100644 debian/dracut.install
 create mode 100644 debian/dracut.manpages
 create mode 100644 debian/dracut.postinst
 create mode 100644 debian/dracut.triggers
 create mode 100755 debian/rules

diff --git a/debian/changelog b/debian/changelog
new file mode 100644
index 0000000..b7a9d12
--- /dev/null
+++ b/debian/changelog
@@ -0,0 +1,53 @@
+dracut (2.26) unstable; urgency=low
+
+  [ Harald Hoyer ]
+  * multipath: install udev rules and helper tools
+  * NEWS update
+  * multipath: install xdr utils
+  * multipath: install multipath kernel module
+  * specfile update
+  * dracut.8: fixed formatting for rootfs and mount options
+  * dracut: check more return codes, check for permissions and use
+    derror
+  * dracut: create initramfs-$(kernelversion).img by default
+  * Makefile: add WITH_SWITCH_ROOT
+  * fips: search different lib paths
+  * kernel-modules: add firewire-ohci to hardcoded modules list
+  * 90dm: install more device mapper kernel modules
+  * specfile update
+
+  [ Peter Jones ]
+  * Use glob for libdir when installing multipath libraries.
+  * Add #!/bin/bash for consistency.
+  * Make sure and get all the multipath related modules.
+  * Bring up multipath devices that are configured in multipath.conf.
+  * Fix missing shell variables.
+  * This has to be executable.
+  * Handle modules with hyphens in their names properly.
+
+  [ Harald Hoyer ]
+  * lvm: scan without monitor
+
+  [ Yanko Kaneti ]
+  * Wildcards need dracut_install
+
+  [ Harald Hoyer ]
+  * lvm/dmraid: make LIBDIR depend on the binary
+  * nfs: install passwd entries for nobody and nfsnobody
+  * nfs: add rd_NFS_DOMAIN parameter to set the NFSv4 domain name
+  * dracut-functions: inst_simple(): do not bail out if target is a dir
+    and exists
+  * dm: install dmsetup
+  * multipath: corrected initqueue parameter
+  * rootfs-block/mount-root: remount root with /etc/fstab filesystem
+    options
+  * test: set PATH
+
+ -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 27 Nov 2009 10:58:26 +0100
+
+dracut (2.21) unstable; urgency=low
+  [ Harald Hoyer ]
+  * fix rd_DASD argument handling (bug #531720)
+  * Resolves: rhbz#531720
+
+ -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 06 Nov 2009 15:52:00 +0100
diff --git a/debian/compat b/debian/compat
new file mode 100644
index 0000000..7ed6ff8
--- /dev/null
+++ b/debian/compat
@@ -0,0 +1 @@
+5
diff --git a/debian/control b/debian/control
new file mode 100644
index 0000000..fbbe19c
--- /dev/null
+++ b/debian/control
@@ -0,0 +1,40 @@
+Source: dracut
+Section: utils
+Priority: optional
+Maintainer: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
+Build-Depends: debhelper (>= 5.0), cdbs
+Standards-Version: 3.8.3
+Vcs-Browser: http://dracut.git.sourceforge.net/git/gitweb-index.cgi
+Vcs-Git: git://dracut.git.sourceforge.net/gitroot/dracut/dracut
+
+Package: dracut
+Architecture: all
+Recommends: cryptsetup, dmsetup, dmraid, lvm2, mdadm
+Depends: cpio, module-init-tools, udev, ${misc:Depends}
+Provides: linux-initramfs-tool
+Description: A new initramfs infrastructure
+ Unlike existing initramfs's, this is an attempt at having as little as
+ possible hard-coded into the initramfs as possible.  The initramfs has
+ (basically) one purpose in life -- getting the rootfs mounted so that
+ we can transition to the real rootfs.  This is all driven off of
+ device availability.  Therefore, instead of scripts hard-coded to do
+ various things, we depend on udev to create device nodes for us and
+ then when we have the rootfs's device node, we mount and carry on. 
+ Having the root on MD, LVM2, LUKS is supported as well as NFS, iSCSI,
+ NBD and FCOE with dracut-net.
+
+Package: dracut-net
+Architecture: all
+Recommends: nfs-common, open-iscsi, nbd-client
+Depends: dracut, iputils-arping, dhcp3-client, ${misc:Depends}
+Description: A new initramfs infrastucture
+ Unlike existing initramfs's, this is an attempt at having as little as
+ possible hard-coded into the initramfs as possible.  The initramfs has
+ (basically) one purpose in life -- getting the rootfs mounted so that
+ we can transition to the real rootfs.  This is all driven off of
+ device availability.  Therefore, instead of scripts hard-coded to do
+ various things, we depend on udev to create device nodes for us and
+ then when we have the rootfs's device node, we mount and carry on. 
+ Having the root on MD, LVM2, LUKS is supported as well as NFS, iSCSI,
+ NBD and FCOE with dracut-net.
+
diff --git a/debian/copyright b/debian/copyright
new file mode 100644
index 0000000..c1424d0
--- /dev/null
+++ b/debian/copyright
@@ -0,0 +1,39 @@
+This package was debianized by Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org> on
+Fri Nov 20 15:45:00 +0100
+
+Sources can be downloaded from:
+
+    https://sourceforge.net/projects/dracut/
+
+Upstream Maintainer:
+    Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+Updstream Authors:
+    Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+    Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
+    David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
+    Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
+    Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Marc Grimme <grimme-lQ0MjLpiXiw@public.gmane.org>
+    Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
+    Lance Albertson <lance-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
+    Michael Ploujnikov <plouj-nIlK2fN7gY0WhyVFc8JwjA@public.gmane.org>
+    Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Michal Schmidt <mschmidt-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Peter Rajnoha <prajnoha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+    Quentin Armitage <quentin-/BKvNsQo1N6tmTQ+vhA3Yw@public.gmane.org>
+    Sergey Fionov <fionov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+    Thilo Bangert <thilo.bangert-hi6Y0CQ0nG0@public.gmane.org>
+
+Copyright:
+    Copyright 2009 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+
+License: GPLv2
+
+On Debian systems, the complete text of the GNU General Public 
+License version 2 can be found in `/usr/share/common-licenses/GPL-2'.
diff --git a/debian/dracut-net.dirs b/debian/dracut-net.dirs
new file mode 100644
index 0000000..44f96fb
--- /dev/null
+++ b/debian/dracut-net.dirs
@@ -0,0 +1,5 @@
+usr/share/dracut/modules.d/40network
+usr/share/dracut/modules.d/95fcoe
+usr/share/dracut/modules.d/95iscsi
+usr/share/dracut/modules.d/95nbd
+usr/share/dracut/modules.d/95nfs
diff --git a/debian/dracut-net.install b/debian/dracut-net.install
new file mode 100644
index 0000000..dd11096
--- /dev/null
+++ b/debian/dracut-net.install
@@ -0,0 +1,5 @@
+modules.d/40network	usr/share/dracut/modules.d
+modules.d/95fcoe	usr/share/dracut/modules.d
+modules.d/95iscsi	usr/share/dracut/modules.d
+modules.d/95nbd		usr/share/dracut/modules.d
+modules.d/95nfs		usr/share/dracut/modules.d
diff --git a/debian/dracut.dirs b/debian/dracut.dirs
new file mode 100644
index 0000000..87682f0
--- /dev/null
+++ b/debian/dracut.dirs
@@ -0,0 +1,22 @@
+usr/share/dracut
+usr/share/dracut/modules.d/00dash
+usr/share/dracut/modules.d/01fips
+usr/share/dracut/modules.d/90crypt
+usr/share/dracut/modules.d/90dm
+usr/share/dracut/modules.d/90dmraid
+usr/share/dracut/modules.d/90kernel-modules
+usr/share/dracut/modules.d/90lvm
+usr/share/dracut/modules.d/90mdraid
+usr/share/dracut/modules.d/90multipath
+usr/share/dracut/modules.d/95dasd
+usr/share/dracut/modules.d/95dasd_mod
+usr/share/dracut/modules.d/95debug
+usr/share/dracut/modules.d/95resume
+usr/share/dracut/modules.d/95rootfs-block
+usr/share/dracut/modules.d/95terminfo
+usr/share/dracut/modules.d/95udev-rules
+usr/share/dracut/modules.d/95zfcp
+usr/share/dracut/modules.d/95znet
+usr/share/dracut/modules.d/98syslog
+usr/share/dracut/modules.d/99base
+/var/lib/dracut
diff --git a/debian/dracut.docs b/debian/dracut.docs
new file mode 100644
index 0000000..883ffc9
--- /dev/null
+++ b/debian/dracut.docs
@@ -0,0 +1,4 @@
+HACKING
+README.generic
+README.kernel
+README.modules
diff --git a/debian/dracut.install b/debian/dracut.install
new file mode 100644
index 0000000..75b5fd1
--- /dev/null
+++ b/debian/dracut.install
@@ -0,0 +1,25 @@
+dracut			usr/sbin
+dracut-catimages	usr/sbin
+dracut-update-initramfs	usr/sbin
+dracut-functions	usr/share/dracut
+dracut.conf		etc
+modules.d/00dash		usr/share/dracut/modules.d
+modules.d/01fips		usr/share/dracut/modules.d
+modules.d/90crypt		usr/share/dracut/modules.d
+modules.d/90dm			usr/share/dracut/modules.d
+modules.d/90dmraid		usr/share/dracut/modules.d
+modules.d/90kernel-modules	usr/share/dracut/modules.d
+modules.d/90lvm			usr/share/dracut/modules.d
+modules.d/90mdraid		usr/share/dracut/modules.d
+modules.d/90multipath		usr/share/dracut/modules.d
+modules.d/95dasd		usr/share/dracut/modules.d
+modules.d/95dasd_mod		usr/share/dracut/modules.d
+modules.d/95debug		usr/share/dracut/modules.d
+modules.d/95resume		usr/share/dracut/modules.d
+modules.d/95rootfs-block	usr/share/dracut/modules.d
+modules.d/95terminfo		usr/share/dracut/modules.d
+modules.d/95udev-rules		usr/share/dracut/modules.d
+modules.d/95zfcp		usr/share/dracut/modules.d
+modules.d/95znet		usr/share/dracut/modules.d
+modules.d/98syslog		usr/share/dracut/modules.d
+modules.d/99base		usr/share/dracut/modules.d
diff --git a/debian/dracut.manpages b/debian/dracut.manpages
new file mode 100644
index 0000000..002d7d7
--- /dev/null
+++ b/debian/dracut.manpages
@@ -0,0 +1,2 @@
+dracut.8
+dracut.conf.5
diff --git a/debian/dracut.postinst b/debian/dracut.postinst
new file mode 100644
index 0000000..f2f61ed
--- /dev/null
+++ b/debian/dracut.postinst
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+set -e
+
+# Regenerate initramfs when we're `installed`
+DPKG_MAINTSCRIPT_PACKAGE='' dracut-update-initramfs -u
+
+#DEBHELPER#
diff --git a/debian/dracut.triggers b/debian/dracut.triggers
new file mode 100644
index 0000000..860c664
--- /dev/null
+++ b/debian/dracut.triggers
@@ -0,0 +1 @@
+interest update-initramfs
diff --git a/debian/rules b/debian/rules
new file mode 100755
index 0000000..e6192f6
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,3 @@
+#!/usr/bin/make -f
+
+include /usr/share/cdbs/1/rules/debhelper.mk
-- 
1.6.5.3
