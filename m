From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [dracut] Loading of modules that don't have a uevent or pci
	device: ideas?
Date: Mon, 21 Dec 2009 16:26:00 -0500
Message-ID: <20091221212600.GA7132@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Harald and initramfs mailing list, 

I am working on de-coupling a lot of Xen modules from the PV-OPS
kernel (git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git)
so that it is not neccessary to have them compiled in.

I've gotten to the point that all of the drivers (fbfront, kbdfront,
netfront, blkfront, pcifront) can be loaded on demand. Some of them
can't be unloaded (still working on that).

The next stage is to make the loading automatic, and detect if the kernel
is running under Xen (PV) and if so load the neccesssary modules.

To solve that, my thought was to:

a) Write udev rules that would be act up if the kernel emitted such
rules. But the kernel does not emit any uevents for this purpose and
it does not emit any virtualization ones until the virtualization modules
are loaded.  I could write up code that would emit this
information and be generic enough that it would do so for anything
that uses the paravirt strutures. So basically a SysFS interface for
the paravirt interface. 

b) Or utilize xen-detect and load the appropiate modules if we are
running in Xen PV land. The second is by far much simpler but I don't
know if more appropiate. I am attaching an example patch to demonstrate
what I had in mind. (Caveat: I didn't include the pre-requisite for
xen-tools yet).

c). Another way? Any ideas would be much appreciated.


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dracut_xen_support.patch"

diff -uNpr dracut-003.orig/dracut.spec dracut-003/dracut.spec
--- dracut-003.orig/dracut.spec	2009-12-21 15:41:45.574109292 -0500
+++ dracut-003/dracut.spec	2009-12-21 16:02:09.019109359 -0500
@@ -162,6 +162,7 @@ rm -rf $RPM_BUILD_ROOT
 %{_datadir}/dracut/modules.d/10redhat-i18n
 %{_datadir}/dracut/modules.d/10rpmversion
 %{_datadir}/dracut/modules.d/50plymouth
+%{_datadir}/dracut/modules.d/60xen
 %{_datadir}/dracut/modules.d/90crypt
 %{_datadir}/dracut/modules.d/90dm
 %{_datadir}/dracut/modules.d/90dmraid
@@ -216,6 +217,9 @@ rm -rf $RPM_BUILD_ROOT
 %dir /var/lib/dracut/overlay
 
 %changelog
+* Mon Dec 21 2009 Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> 003
+- add support for loading Xen modules.
+
 * Mon Nov 23 2009 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> 002-26
 - add WITH_SWITCH_ROOT make flag
 - add fips requirement conditional
diff -uNpr dracut-003.orig/modules.d/60xen/check dracut-003/modules.d/60xen/check
--- dracut-003.orig/modules.d/60xen/check	1969-12-31 19:00:00.000000000 -0500
+++ dracut-003/modules.d/60xen/check	2009-12-21 16:26:35.754120140 -0500
@@ -0,0 +1,12 @@
+#!/bin/bash
+
+# No Xen-detect? Boo!!
+which xen-detect >/dev/null 2>&1 || exit 1
+
+. $dracutfunctions
+[[ $debug ]] && set -x
+
+# Yes, we are under Xen PV env.
+xen-detect | egrep -q -v 'PV' || exit 0
+
+exit 1
diff -uNpr dracut-003.orig/modules.d/60xen/install dracut-003/modules.d/60xen/install
--- dracut-003.orig/modules.d/60xen/install	1969-12-31 19:00:00.000000000 -0500
+++ dracut-003/modules.d/60xen/install	2009-12-21 15:57:08.243111382 -0500
@@ -0,0 +1,4 @@
+#!/bin/bash
+inst xen-detect 
+inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
+
diff -uNpr dracut-003.orig/modules.d/60xen/installkernel dracut-003/modules.d/60xen/installkernel
--- dracut-003.orig/modules.d/60xen/installkernel	1969-12-31 19:00:00.000000000 -0500
+++ dracut-003/modules.d/60xen/installkernel	2009-12-21 16:00:08.388121268 -0500
@@ -0,0 +1,9 @@
+#!/bin/bash
+
+for i in \
+    xenbus_probe_frontend xen-pcifront \
+    xen-fbfront xen-kbdfront xen-blkfront xen-netfront \
+    ; do
+    modinfo -k $kernel $i >/dev/null 2>&1 && instmods $i
+done
+
diff -uNpr dracut-003.orig/modules.d/60xen/xen-pre-udev.sh dracut-003/modules.d/60xen/xen-pre-udev.sh
--- dracut-003.orig/modules.d/60xen/xen-pre-udev.sh	1969-12-31 19:00:00.000000000 -0500
+++ dracut-003/modules.d/60xen/xen-pre-udev.sh	2009-12-21 16:03:52.735120719 -0500
@@ -0,0 +1,10 @@
+xen-detect
+RC=$?
+if [ "$RC" = "1" ] ; then
+        modprobe xenbus_probe_frontend
+        modprobe xen-kbdfront
+        modprobe xen-fbfront
+        modprobe xen-blkfront
+        modprobe xen-netfront
+        modprobe xen-pcifront
+fi

--envbJBWh7q8WU6mo--
