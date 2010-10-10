From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] base: don't bother with rmmod/modprobe links for module-less initramfs
Date: Sun, 10 Oct 2010 12:01:05 +0100 (BST)
Message-ID: <20101010110105.827009D401B@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

/bin/true is 23kb, bigger than rmmod itself!

And a module-less initramfs runs just fine without rmmod and modprobe.
---
 modules.d/99base/install |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

I'm also not clear on why --ignore-kernel-modules exists as a separate
argument; I would think that the functionality of --ignore-kernel-modules
falls nicely into the scope of --no-kernel

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 6fac851..1655eb2 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -3,11 +3,7 @@
 
 dracut_install mount mknod mkdir pidof sleep chroot sed ls flock cp mv dmesg \
     rm ln mkfifo less 
-if [[ ${ignore_kmodules} = yes ]]; then
-    inst /bin/true
-    ln -s /bin/true "${initdir}"/sbin/modprobe
-    ln -s /bin/true "${initdir}"/sbin/rmmod
-else
+if [[ ${ignore_kmodules} != yes ]]; then
     dracut_install modprobe rmmod
 fi
 if [ ! -e "${initdir}/bin/sh" ]; then
-- 
1.7.2.3
