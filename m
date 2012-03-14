From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] remove --ctty arg and make cttyhack the default
Date: Wed, 14 Mar 2012 11:01:49 -0400
Message-ID: <1331737309-24315-4-git-send-email-wwoods@redhat.com>
References: <1331737309-24315-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331737309-24315-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--ctty wasn't the default, basically, because it didn't work.

Now that it works as expected, make it the default - although we'll
still fall back to openvt if setsid is missing and plain old sh if
openvt isn't usable.
---
 dracut.sh                        |    5 ++---
 modules.d/99base/module-setup.sh |    3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 417008c..fde4040 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -121,7 +121,6 @@ Creates initial ramdisk images for preloading modules
                          build.
   --keep                Keep the temporary initramfs for debugging purposes
   --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
-  --ctty                Add control tty for emergency shells
 
 If [LIST] has multiple arguments, then you have to put these in quotes.
 For example:
@@ -241,7 +240,7 @@ while (($# > 0)); do
         --nolvmconf)   lvmconf_l="no";;
         --debug)       debug="yes";;
         --profile)     profile="yes";;
-        --ctty)        cttyhack="yes";;
+        --ctty)        :;; # ignored
         --sshkey)      read_arg sshkey   "$@" || shift;;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
@@ -625,7 +624,7 @@ done
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers omit_drivers mdadmconf lvmconf filesystems \
-    use_fstab fstab_lines libdir usrlibdir fscks nofscks cttyhack \
+    use_fstab fstab_lines libdir usrlibdir fscks nofscks \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
     debug host_fs_types host_devs sshkey
 
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 5a97770..f478b08 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -15,8 +15,7 @@ install() {
     local _d
     dracut_install mount mknod mkdir modprobe pidof sleep chroot \
         sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink
-    dracut_install -o less
-    [[ $cttyhack = yes ]] && dracut_install -o setsid
+    dracut_install -o less setsid
     if [ ! -e "${initdir}/bin/sh" ]; then
         dracut_install bash
         (ln -s bash "${initdir}/bin/sh" || :)
-- 
1.7.7.6
