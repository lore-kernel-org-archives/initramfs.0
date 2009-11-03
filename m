From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: [PATCH] Re: control what kernel modules get loaded into ramdisk
Date: Tue, 03 Nov 2009 11:25:45 +0100
Message-ID: <1257243945.3790.45.camel@eagle.danny.cz>
References: <1257183267.3755.286.camel@eagle.danny.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ck8LuoF0hgHLKzMVwSe2"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1257183267.3755.286.camel-Gu2OudDT4ISyu7giWUE+hA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-ck8LuoF0hgHLKzMVwSe2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Dan Horák píše v Po 02. 11. 2009 v 18:34 +0100: 
> Hello,
> 
> I started to use dracut for preparing generic ramdisk for Fedora/ARM.
> The issue with ramdisks on ARM is that they are usually limited in size
> because they are stored in the internal flash memories whose capacity
> can be 8 or 16 MB (for kernel, ramdisk and other stuff) in the
> commercial devices (like NAS from QNAP). So I used the
> "omit_dracutmodules" option in the config file to drop stuff like i18n,
> plymouth etc. It works, the created ramdisk is usable, but what remains
> quite large are the kernel modules for all filesystems. The ability to

I have solved the problem with filesystem modules with an introduction
of new command line/config file parameter. It controls the list of
filesystem modules that will be included when running in generic mode.
See the attached patch for details.

> limit the list of drivers for block devices would be also nice. Is there
> a way to control what kernel modules get loaded into the ramdisk, like
> some black- or whitelist?


Dan


--=-ck8LuoF0hgHLKzMVwSe2
Content-Disposition: attachment; filename="filesystems.patch"
Content-Type: text/x-patch; name="filesystems.patch"; charset="utf-8"
Content-Transfer-Encoding: 8bit

From c903db8863923a6f9d32f6ac5e5481b74cb1e75c Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Date: Tue, 3 Nov 2009 10:39:59 +0100
Subject: [PATCH 1/3] specify a list of kernel filesystem modules to be exlusively included in the initramfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Dan Horák <dan-mBPqX7VnFd4@public.gmane.org>
---
 dracut                                   |    6 +++++-
 dracut.8                                 |    3 +++
 modules.d/90kernel-modules/installkernel |    8 ++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index 7b9304f..dbc5d73 100755
--- a/dracut
+++ b/dracut
@@ -37,6 +37,8 @@ Creates initial ramdisk images for preloading modules
                         exclusively include in the initramfs.
   --add-drivers [LIST]  Specify a space-separated list of kernel 
                         modules to add to the initramfs.
+  --filesystems [LIST]  Specify a space-separated list of filesystem kenrel
+                        modules to exclusively include in the initramfs.
   -k, --kmoddir [DIR]   Specify the directory, where to look for kernel 
                         modules
   --fwdir [DIR]         Specify additional directories, where to look for 
@@ -76,6 +78,7 @@ while (($# > 0)); do
 	-a|--add) add_dracutmodules_l="$2"; shift;;
 	-d|--drivers) drivers_l="$2"; shift;;
 	--add-drivers) add_drivers_l="$2"; shift;;
+	--filesystems) filesystems_l="$2"; shift;;
 	-k|--kmoddir) drivers_dir_l="$2"; shift;;
 	--fwdir) fw_dir_l="$2"; shift;;
 	--kernel-only) kernel_only="yes"; nokernel="no";;
@@ -127,6 +130,7 @@ fi
 [[ $add_dracutmodules_l ]] && add_dracutmodules="$add_dracutmodules $add_dracutmodules_l"
 [[ $drivers_l ]] && drivers=$drivers_l
 [[ $add_drivers_l ]] && add_drivers=$add_drivers_l
+[[ $filesystems_l ]] && filesystems=$filesystems_l
 [[ $drivers_dir_l ]] && drivers_dir=$drivers_dir_l
 [[ $fw_dir_l ]] && fw_dir=$fw_dir_l
 [[ $do_strip_l ]] && do_strip=$do_strip_l
@@ -180,7 +184,7 @@ chmod 755 "$initdir"
 
 export initdir hookdirs dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug beverbose no_kernel kernel_only \
-    add_drivers mdadmconf lvmconf
+    add_drivers mdadmconf lvmconf filesystems
 
 if [[ $kernel_only != yes ]]; then
     # Create some directory structure first
diff --git a/dracut.8 b/dracut.8
index 309d0dd..93dafc9 100644
--- a/dracut.8
+++ b/dracut.8
@@ -32,6 +32,9 @@ specify a space-separated list of kernel modules to exclusively include in the i
 .BR \-\-add-drivers " \fILIST\fR"
 specify a space-separated list of kernel modules to add to the initramfs.
 .TP
+.BR \-\-filesystems " \fILIST\fR"
+specify a space-separated list of kernel filesystem modules to exclusively include in the initramfs.
+.TP
 .BR \-k ", " \-\-kmoddir " \fI{DIR}\fR   
 specify the directory, where to look for kernel modules
 .TP
diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index b5e4c93..77fbe09 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -6,9 +6,13 @@ if [[ -z $drivers ]]; then
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
-- 
1.6.3.3

From d9912f909196d7d53981720b444d1aa23d1edbe6 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Date: Tue, 3 Nov 2009 11:05:12 +0100
Subject: [PATCH 2/3] add the "filesystems" option into config file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Dan Horák <dan-mBPqX7VnFd4@public.gmane.org>
---
 dracut.conf |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/dracut.conf b/dracut.conf
index 2ebeeda..44cecaf 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -9,6 +9,9 @@
 # additional kernel modules to the default
 #add_drivers=""
 
+# list of kernel filesystem modules to be loaded into generic initramfs
+#filesystems=""
+
 # build initrd only to boot current hardware
 #hostonly="-h"
 #
-- 
1.6.3.3

From 80fe42e3224d4240319ddf56ea3deb807ab1e9aa Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Date: Tue, 3 Nov 2009 11:06:38 +0100
Subject: [PATCH 3/3] append the filesystems list to the exclusive list of kernel modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Dan Horák <dan-mBPqX7VnFd4@public.gmane.org>
---
 modules.d/90kernel-modules/installkernel |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index 77fbe09..c739bfc 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -19,7 +19,7 @@ if [[ -z $drivers ]]; then
     # hardcoded list of exceptions
     rm -fr ${initdir}/lib/modules/*/kernel/fs/ocfs2
 else
-  instmods $drivers
+  instmods $drivers $filesystems
 fi
 
 [[ $add_drivers ]] && instmods $add_drivers
-- 
1.6.3.3


--=-ck8LuoF0hgHLKzMVwSe2--
