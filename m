From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: Re: [PATCH] Re: control what kernel modules get loaded into ramdisk
Date: Tue, 03 Nov 2009 12:07:33 +0100
Message-ID: <1257246453.3790.48.camel@eagle.danny.cz>
References: <1257183267.3755.286.camel@eagle.danny.cz>
	 <1257243945.3790.45.camel@eagle.danny.cz>  <4AF0065A.4070100@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mZKWhPmbrj6eF+MI7vvL"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF0065A.4070100-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-mZKWhPmbrj6eF+MI7vvL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Harald Hoyer píše v Út 03. 11. 2009 v 11:30 +0100: 
> > I have solved the problem with filesystem modules with an introduction
> > of new command line/config file parameter. It controls the list of
> > filesystem modules that will be included when running in generic mode.
> > See the attached patch for details.
> >
> >> limit the list of drivers for block devices would be also nice. Is there
> >> a way to control what kernel modules get loaded into the ramdisk, like
> >> some black- or whitelist?
> >
> >
> > Dan
> >
> 
> s/kenrel/kernel/
> 
> s/modules to be loaded into generic initramfs/modules to be included in the 
> generic initramfs/

updated and joined into 1 commit with better description


Dan


--=-mZKWhPmbrj6eF+MI7vvL
Content-Disposition: attachment; filename="filesystems.patch"
Content-Type: text/x-patch; name="filesystems.patch"; charset="utf-8"
Content-Transfer-Encoding: 8bit

From e67c382bd883ef6b567933b4800c135fd62c8244 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Date: Tue, 3 Nov 2009 11:50:55 +0100
Subject: [PATCH] control filesystems included in the generic initramfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

New "filesystems" command line/config file option is added with the ability to
control the list of kernel filesystem modules that are included in the generic
initramfs.

Signed-off-by: Dan Horák <dan-mBPqX7VnFd4@public.gmane.org>
---
 dracut                                   |    7 ++++++-
 dracut.8                                 |    3 +++
 dracut.conf                              |    3 +++
 modules.d/90kernel-modules/installkernel |   10 +++++++---
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index 7b9304f..1954177 100755
--- a/dracut
+++ b/dracut
@@ -37,6 +37,9 @@ Creates initial ramdisk images for preloading modules
                         exclusively include in the initramfs.
   --add-drivers [LIST]  Specify a space-separated list of kernel 
                         modules to add to the initramfs.
+  --filesystems [LIST]  Specify a space-separated list of kernel filesystem
+                        modules to exclusively include in the generic
+                        initramfs.
   -k, --kmoddir [DIR]   Specify the directory, where to look for kernel 
                         modules
   --fwdir [DIR]         Specify additional directories, where to look for 
@@ -76,6 +79,7 @@ while (($# > 0)); do
 	-a|--add) add_dracutmodules_l="$2"; shift;;
 	-d|--drivers) drivers_l="$2"; shift;;
 	--add-drivers) add_drivers_l="$2"; shift;;
+	--filesystems) filesystems_l="$2"; shift;;
 	-k|--kmoddir) drivers_dir_l="$2"; shift;;
 	--fwdir) fw_dir_l="$2"; shift;;
 	--kernel-only) kernel_only="yes"; nokernel="no";;
@@ -127,6 +131,7 @@ fi
 [[ $add_dracutmodules_l ]] && add_dracutmodules="$add_dracutmodules $add_dracutmodules_l"
 [[ $drivers_l ]] && drivers=$drivers_l
 [[ $add_drivers_l ]] && add_drivers=$add_drivers_l
+[[ $filesystems_l ]] && filesystems=$filesystems_l
 [[ $drivers_dir_l ]] && drivers_dir=$drivers_dir_l
 [[ $fw_dir_l ]] && fw_dir=$fw_dir_l
 [[ $do_strip_l ]] && do_strip=$do_strip_l
@@ -180,7 +185,7 @@ chmod 755 "$initdir"
 
 export initdir hookdirs dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug beverbose no_kernel kernel_only \
-    add_drivers mdadmconf lvmconf
+    add_drivers mdadmconf lvmconf filesystems
 
 if [[ $kernel_only != yes ]]; then
     # Create some directory structure first
diff --git a/dracut.8 b/dracut.8
index 309d0dd..6dc90ad 100644
--- a/dracut.8
+++ b/dracut.8
@@ -32,6 +32,9 @@ specify a space-separated list of kernel modules to exclusively include in the i
 .BR \-\-add-drivers " \fILIST\fR"
 specify a space-separated list of kernel modules to add to the initramfs.
 .TP
+.BR \-\-filesystems " \fILIST\fR"
+specify a space-separated list of kernel filesystem modules to exclusively include in the generic initramfs.
+.TP
 .BR \-k ", " \-\-kmoddir " \fI{DIR}\fR   
 specify the directory, where to look for kernel modules
 .TP
diff --git a/dracut.conf b/dracut.conf
index 2ebeeda..8c8db21 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -9,6 +9,9 @@
 # additional kernel modules to the default
 #add_drivers=""
 
+# list of kernel filesystem modules to be included in the generic initramfs
+#filesystems=""
+
 # build initrd only to boot current hardware
 #hostonly="-h"
 #
diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index b5e4c93..c739bfc 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -6,16 +6,20 @@ if [[ -z $drivers ]]; then
 	 nm -uPA "$1" | egrep -q "$blockfuncs"
     }
     instmods pcmcia sd_mod $(filter_kernel_modules block_module_test) "=drivers/pcmcia" =ide
-    # if not on hostonly mode, install all known filesystems.
+    # if not on hostonly mode, install all known filesystems if the required list is not set via the filesystems variable
     if [[ $hostonly = '' ]]; then
-	instmods '=fs'
+	if [[ -z $filesystems ]]; then
+	    instmods '=fs'
+	else
+	    instmods $filesystems
+	fi
     else
 	instmods $(get_fs_type "/dev/block/$(find_root_block_device)")
     fi
     # hardcoded list of exceptions
     rm -fr ${initdir}/lib/modules/*/kernel/fs/ocfs2
 else
-  instmods $drivers
+  instmods $drivers $filesystems
 fi
 
 [[ $add_drivers ]] && instmods $add_drivers
-- 
1.6.3.3


--=-mZKWhPmbrj6eF+MI7vvL--
