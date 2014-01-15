From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] add a new option "testonly"
Date: Wed, 15 Jan 2014 20:53:48 +0800
Message-ID: <1389790430-17808-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Since 04watchdog is used only for test cases. If watchdog want to
be handled, the relevant operation need be differentiated. In this
patch add a new option "testonly" to set. User can set
"--testonly" or "--no-testonly" to decide current execution is for
test cases running or building normal initram.
---
 dracut-bash-completion.sh |  3 ++-
 dracut.8.asc              |  7 +++++++
 dracut.conf               |  4 ++++
 dracut.conf.5.asc         |  3 +++
 dracut.sh                 | 10 +++++++++-
 5 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/dracut-bash-completion.sh b/dracut-bash-completion.sh
index 9f359c6..b713b14 100644
--- a/dracut-bash-completion.sh
+++ b/dracut-bash-completion.sh
@@ -34,7 +34,8 @@ _dracut() {
                               --local --hostonly --no-hostonly --fstab=
 --help --bzip2 --lzma
                               --xz --no-compress --gzip --list-modules=
 --show-modules --keep
                               --printsize --regenerate-all --noimageif=
notneeded --early-microcode
-                              --no-early-microcode --print-cmdline --p=
relink --noprelink'
+                              --no-early-microcode --print-cmdline --p=
relink --noprelink
+                              --testonly --no-testonly'
=20
                        [ARG]=3D'-a -m -o -d -I -k -c -L --kver --add -=
-force-add --add-drivers
                               --omit-drivers --modules --omit --driver=
s --filesystems --install
diff --git a/dracut.8.asc b/dracut.8.asc
index d381dcf..1115f69 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -203,6 +203,13 @@ example:
 **--nolvmconf**::
     do not include local _/etc/lvm/lvm.conf_
=20
+
+**--testonly**::
+    execute to run test cases
+
+**--no-testonly**::
+    execute to build normal initram
+
 **--fscks** [LIST]::
     add a space-separated list of fsck tools, in addition to _dracut.c=
onf_'s
     specification; the installation is opportunistic (non-existing too=
ls are
diff --git a/dracut.conf b/dracut.conf
index 8533f99..d18d185 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -33,6 +33,10 @@
=20
 # install local /etc/lvm/lvm.conf
 #lvmconf=3D"no"
+#
+
+#execute to build normal initram, not for test cases running=20
+#testonly=3D"no"
=20
 # A list of fsck tools to install. If it's not specified, module's har=
dcoded
 # default is used, currently: "umount mount /sbin/fsck* xfs_db xfs_che=
ck
diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index 30b7e03..3921f61 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -104,6 +104,9 @@ If chrooted to another root other than the real roo=
t device, use --fstab and pro
 *lvmconf=3D*"__{yes|no}__"::
     Include local _/etc/lvm/lvm.conf_ (default=3Dyes)
=20
+*testonly=3D*"__{yes|no}__"::
+    execute to run test cases only (default=3Dno)
+
 *fscks=3D*"=C2=A0__<fsck tools>__=C2=A0"::
     Add a space-separated list of fsck tools. If nothing is specified,=
 the
     default is: "umount mount /sbin/fsck* xfs_db xfs_check xfs_repair =
e2fsck
diff --git a/dracut.sh b/dracut.sh
index 11dcd0e..88920b3 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -107,6 +107,8 @@ Creates initial ramdisk images for preloading modul=
es
   --nomdadmconf         Do not include local /etc/mdadm.conf
   --lvmconf             Include local /etc/lvm/lvm.conf
   --nolvmconf           Do not include local /etc/lvm/lvm.conf
+  --testonly            Execute to run test cases
+  --no-testonly         Execute for real initram building=20
   --fscks [LIST]        Add a space-separated list of fsck helpers.
   --nofscks             Inhibit installation of any fsck helpers.
   --ro-mnt              Mount / and /usr read-only by default.
@@ -333,6 +335,8 @@ TEMP=3D$(unset POSIXLY_CORRECT; getopt \
     --long nomdadmconf \
     --long lvmconf \
     --long nolvmconf \
+    --long testonly \
+    --long no-testonly \
     --long debug \
     --long profile \
     --long sshkey: \
@@ -417,6 +421,8 @@ while :; do
         --nomdadmconf) mdadmconf_l=3D"no";;
         --lvmconf)     lvmconf_l=3D"yes";;
         --nolvmconf)   lvmconf_l=3D"no";;
+        --testonly)    testonly_l=3D"yes";;
+        --no-testonly) testonly_l=3D"no";;
         --debug)       debug=3D"yes";;
         --profile)     profile=3D"yes";;
         --sshkey)      sshkey=3D"$2"; shift;;
@@ -682,6 +688,8 @@ stdloglvl=3D$((stdloglvl + verbosity_mod_l))
 [[ $use_fstab_l ]] && use_fstab=3D$use_fstab_l
 [[ $mdadmconf_l ]] && mdadmconf=3D$mdadmconf_l
 [[ $lvmconf_l ]] && lvmconf=3D$lvmconf_l
+[[ $testonly_l ]] && testonly=3D$testonly_l
+[[ $testonly ]] || testonly=3Dno
 [[ $dracutbasedir ]] || dracutbasedir=3D/usr/lib/dracut
 [[ $fw_dir ]] || fw_dir=3D"/lib/firmware/updates /lib/firmware"
 [[ $tmpdir_l ]] && tmpdir=3D"$tmpdir_l"
@@ -1062,7 +1070,7 @@ export initdir dracutbasedir dracutmodules \
     debug host_fs_types host_devs sshkey add_fstab \
     DRACUT_VERSION udevdir prefix filesystems drivers \
     systemdutildir systemdsystemunitdir systemdsystemconfdir \
-    host_modalias host_modules
+    host_modalias host_modules testonly
=20
 mods_to_load=3D""
 # check all our modules to see if they should be sourced.
--=20
1.8.3.1
