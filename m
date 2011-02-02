From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 534b0525a5bf41c7181c43ebc7ca9222e4dc7fb7
Date: Wed,  2 Feb 2011 16:43:07 +0000
Message-ID: <E1PkfnT-0004ne-Ls@sfp-scmshell-3.v30.ch3.sourceforge.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  534b0525a5bf41c7181c43ebc7ca9222e4dc7fb7 (commit)
       via  051501eea6ecba6f220dd891efc4a3590237aad0 (commit)
       via  71df3c432983010d9d024f83a07e1d417c952e8e (commit)
       via  6ae5caf00899e89684e250bbe25c7de201ecc45b (commit)
       via  b9d7fda0e13341ab0ac13b0bb1272c1f58f04fa1 (commit)
       via  e6752f1a6c25783917c19979d2c570f8670c259c (commit)
       via  46bc0593ac684b06fb1186dd25f2516a0fda8370 (commit)
       via  76c4613abcc402e01e6d009eb5f205220bb7d3c7 (commit)
       via  7238aa0cf0b849889fdd9455ab7a4d2beef1de0b (commit)
       via  95d2dabc250b39d2452e0e8f57a702ab80db895c (commit)
      from  07caee2662c97d302cde244a1f7b22f9a089fd3f (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 534b0525a5bf41c7181c43ebc7ca9222e4dc7fb7
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 17:43:03 2011 +0100

    dracut.spec: add biosdevname

diff --git a/dracut.spec b/dracut.spec
index 4d71c6d..f3aa82e 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -242,6 +242,7 @@ rm -rf $RPM_BUILD_ROOT
 %{_datadir}/dracut/modules.d/95terminfo
 %{_datadir}/dracut/modules.d/95udev-rules
 %{_datadir}/dracut/modules.d/96insmodpost
+%{_datadir}/dracut/modules.d/97biosdevname
 %{_datadir}/dracut/modules.d/98selinux
 %{_datadir}/dracut/modules.d/98syslog
 %{_datadir}/dracut/modules.d/99base
commit 051501eea6ecba6f220dd891efc4a3590237aad0
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 17:39:45 2011 +0100

    add rpmversion and fips to the fedora default modules

diff --git a/dracut.conf.d/fedora.conf.example b/dracut.conf.d/fedora.c=
onf.example
index e6fe677..2b2639e 100644
--- a/dracut.conf.d/fedora.conf.example
+++ b/dracut.conf.d/fedora.conf.example
@@ -3,3 +3,4 @@
=20
 # i18n
 i18n_vars=3D"/etc/sysconfig/keyboard:KEYTABLE-KEYMAP /etc/sysconfig/i1=
8n:SYSFONT-FONT,FONTACM-FONT_MAP,FONT_UNIMAP"
+add_dracutmodules+=3D" rpmversion fips "
diff --git a/dracut.spec b/dracut.spec
index b1e5e8d..4d71c6d 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -165,8 +165,6 @@ make install DESTDIR=3D$RPM_BUILD_ROOT sbindir=3D/s=
bin \
      sysconfdir=3D/etc mandir=3D%{_mandir} WITH_SWITCH_ROOT=3D0%{?with=
_switch_root}
=20
 echo %{name}-%{version}-%{release} > $RPM_BUILD_ROOT/%{_datadir}/dracu=
t/modules.d/10rpmversion/dracut-version
-rm $RPM_BUILD_ROOT/%{_datadir}/dracut/modules.d/10rpmversion/check
-rm $RPM_BUILD_ROOT/%{_datadir}/dracut/modules.d/01fips/check
=20
 %if 0%{?fedora} =3D=3D 0
 rm -fr $RPM_BUILD_ROOT/%{_datadir}/dracut/modules.d/01fips
commit 71df3c432983010d9d024f83a07e1d417c952e8e
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 16:35:18 2011 +0100

    renamed module-info.sh to module-setup.sh

diff --git a/NEWS b/NEWS
index 18c483d..ef00e9a 100644
--- a/NEWS
+++ b/NEWS
@@ -2,7 +2,7 @@ dracut-008
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - removed --ignore-kernel-modules option (no longer necessary)
 - renamed kernel command line arguments to follow the rd. naming schem=
e
-- merged check, install, installkernel to module-info.sh
+- merged check, install, installkernel to module-setup.sh
 - support for bzip2 and xz compressed initramfs images.
 - source code beautification
 - lots of documentation
diff --git a/dracut-functions b/dracut-functions
index a183a43..e80a638 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -518,14 +518,14 @@ inst_opt_decompress() {
 module_check() {
     local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
     [[ -d $moddir ]] || return 1
-    if [[ ! -f $moddir/module-info.sh ]]; then
+    if [[ ! -f $moddir/module-setup.sh ]]; then
         # if we do not have a check script, we are unconditionally inc=
luded
         [[ -x $moddir/check ]] || return 0
         $moddir/check $hostonly
         return $?
     else
         unset check depends install installkernel
-        . $moddir/module-info.sh
+        . $moddir/module-setup.sh
         is_func check || return 0
         check
         ret=3D$?
@@ -537,14 +537,14 @@ module_check() {
 module_depends() {
     local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
     [[ -d $moddir ]] || return 1
-    if [[ ! -f $moddir/module-info.sh ]]; then
+    if [[ ! -f $moddir/module-setup.sh ]]; then
         # if we do not have a check script, we have no deps
         [[ -x $moddir/check ]] || return 0
         $moddir/check -d
         return $?
     else
         unset check depends install installkernel
-        . $moddir/module-info.sh
+        . $moddir/module-setup.sh
         is_func depends || return 0
         depends
         ret=3D$?
@@ -556,12 +556,12 @@ module_depends() {
 module_install() {
     local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
     [[ -d $moddir ]] || return 1
-    if [[ ! -f $moddir/module-info.sh ]]; then
+    if [[ ! -f $moddir/module-setup.sh ]]; then
         [[ -x $moddir/install ]] && . "$moddir/install"
         return $?
     else
         unset check depends install installkernel
-        . $moddir/module-info.sh
+        . $moddir/module-setup.sh
         is_func install || return 0
         install
         ret=3D$?
@@ -573,12 +573,12 @@ module_install() {
 module_installkernel() {
     local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
     [[ -d $moddir ]] || return 1
-    if [[ ! -f $moddir/module-info.sh ]]; then
+    if [[ ! -f $moddir/module-setup.sh ]]; then
         [[ -x $moddir/installkernel ]] && . "$moddir/installkernel"
         return $?
     else
         unset check depends install installkernel
-        . $moddir/module-info.sh
+        . $moddir/module-setup.sh
         is_func installkernel || return 0
         installkernel
         ret=3D$?
diff --git a/dracut.xml b/dracut.xml
index 089f8ee..9b70f0c 100644
--- a/dracut.xml
+++ b/dracut.xml
@@ -613,7 +613,7 @@ Common used functions are in <filename>dracut-lib.s=
h</filename>, which can be so
     <section>
       <title>Writing a Module</title>
       <para>A simple example module is <filename>96insmodpost</filenam=
e>, which modprobes a kernel module after udev has settled and the basi=
c device drivers have been loaded.</para>
-      <para>All module installation information is in the file module-=
info.sh.</para>
+      <para>All module installation information is in the file module-=
setup.sh.</para>
       <para>First we create a <function>check()</function> function, w=
hich just exits with <errorcode>0</errorcode> indicating that this modu=
le should be included by default.</para>
       <para><function>check()</function>:</para>
       <programlisting>return 0</programlisting>
diff --git a/modules.d/00bootchart/module-info.sh b/modules.d/00bootcha=
rt/module-setup.sh
similarity index 100%
rename from modules.d/00bootchart/module-info.sh
rename to modules.d/00bootchart/module-setup.sh
diff --git a/modules.d/00dash/module-info.sh b/modules.d/00dash/module-=
setup.sh
similarity index 100%
rename from modules.d/00dash/module-info.sh
rename to modules.d/00dash/module-setup.sh
diff --git a/modules.d/01fips/module-info.sh b/modules.d/01fips/module-=
setup.sh
similarity index 100%
rename from modules.d/01fips/module-info.sh
rename to modules.d/01fips/module-setup.sh
diff --git a/modules.d/05busybox/module-info.sh b/modules.d/05busybox/m=
odule-setup.sh
similarity index 100%
rename from modules.d/05busybox/module-info.sh
rename to modules.d/05busybox/module-setup.sh
diff --git a/modules.d/10i18n/module-info.sh b/modules.d/10i18n/module-=
setup.sh
similarity index 100%
rename from modules.d/10i18n/module-info.sh
rename to modules.d/10i18n/module-setup.sh
diff --git a/modules.d/10rpmversion/module-info.sh b/modules.d/10rpmver=
sion/module-setup.sh
similarity index 100%
rename from modules.d/10rpmversion/module-info.sh
rename to modules.d/10rpmversion/module-setup.sh
diff --git a/modules.d/40network/module-info.sh b/modules.d/40network/m=
odule-setup.sh
similarity index 100%
rename from modules.d/40network/module-info.sh
rename to modules.d/40network/module-setup.sh
diff --git a/modules.d/45ifcfg/module-info.sh b/modules.d/45ifcfg/modul=
e-setup.sh
similarity index 100%
rename from modules.d/45ifcfg/module-info.sh
rename to modules.d/45ifcfg/module-setup.sh
diff --git a/modules.d/50gensplash/module-info.sh b/modules.d/50genspla=
sh/module-setup.sh
similarity index 100%
rename from modules.d/50gensplash/module-info.sh
rename to modules.d/50gensplash/module-setup.sh
diff --git a/modules.d/50plymouth/module-info.sh b/modules.d/50plymouth=
/module-setup.sh
similarity index 100%
rename from modules.d/50plymouth/module-info.sh
rename to modules.d/50plymouth/module-setup.sh
diff --git a/modules.d/60xen/module-info.sh b/modules.d/60xen/module-se=
tup.sh
similarity index 100%
rename from modules.d/60xen/module-info.sh
rename to modules.d/60xen/module-setup.sh
diff --git a/modules.d/90btrfs/module-info.sh b/modules.d/90btrfs/modul=
e-setup.sh
similarity index 100%
rename from modules.d/90btrfs/module-info.sh
rename to modules.d/90btrfs/module-setup.sh
diff --git a/modules.d/90crypt/module-info.sh b/modules.d/90crypt/modul=
e-setup.sh
similarity index 100%
rename from modules.d/90crypt/module-info.sh
rename to modules.d/90crypt/module-setup.sh
diff --git a/modules.d/90dm/module-info.sh b/modules.d/90dm/module-setu=
p.sh
similarity index 100%
rename from modules.d/90dm/module-info.sh
rename to modules.d/90dm/module-setup.sh
diff --git a/modules.d/90dmraid/module-info.sh b/modules.d/90dmraid/mod=
ule-setup.sh
similarity index 100%
rename from modules.d/90dmraid/module-info.sh
rename to modules.d/90dmraid/module-setup.sh
diff --git a/modules.d/90dmsquash-live/module-info.sh b/modules.d/90dms=
quash-live/module-setup.sh
similarity index 100%
rename from modules.d/90dmsquash-live/module-info.sh
rename to modules.d/90dmsquash-live/module-setup.sh
diff --git a/modules.d/90kernel-modules/module-info.sh b/modules.d/90ke=
rnel-modules/module-setup.sh
similarity index 100%
rename from modules.d/90kernel-modules/module-info.sh
rename to modules.d/90kernel-modules/module-setup.sh
diff --git a/modules.d/90lvm/module-info.sh b/modules.d/90lvm/module-se=
tup.sh
similarity index 100%
rename from modules.d/90lvm/module-info.sh
rename to modules.d/90lvm/module-setup.sh
diff --git a/modules.d/90mdraid/module-info.sh b/modules.d/90mdraid/mod=
ule-setup.sh
similarity index 100%
rename from modules.d/90mdraid/module-info.sh
rename to modules.d/90mdraid/module-setup.sh
diff --git a/modules.d/90multipath/module-info.sh b/modules.d/90multipa=
th/module-setup.sh
similarity index 100%
rename from modules.d/90multipath/module-info.sh
rename to modules.d/90multipath/module-setup.sh
diff --git a/modules.d/95dasd/module-info.sh b/modules.d/95dasd/module-=
setup.sh
similarity index 100%
rename from modules.d/95dasd/module-info.sh
rename to modules.d/95dasd/module-setup.sh
diff --git a/modules.d/95dasd_mod/module-info.sh b/modules.d/95dasd_mod=
/module-setup.sh
similarity index 100%
rename from modules.d/95dasd_mod/module-info.sh
rename to modules.d/95dasd_mod/module-setup.sh
diff --git a/modules.d/95debug/module-info.sh b/modules.d/95debug/modul=
e-setup.sh
similarity index 100%
rename from modules.d/95debug/module-info.sh
rename to modules.d/95debug/module-setup.sh
diff --git a/modules.d/95fcoe/module-info.sh b/modules.d/95fcoe/module-=
setup.sh
similarity index 100%
rename from modules.d/95fcoe/module-info.sh
rename to modules.d/95fcoe/module-setup.sh
diff --git a/modules.d/95fstab-sys/module-info.sh b/modules.d/95fstab-s=
ys/module-setup.sh
similarity index 100%
rename from modules.d/95fstab-sys/module-info.sh
rename to modules.d/95fstab-sys/module-setup.sh
diff --git a/modules.d/95iscsi/module-info.sh b/modules.d/95iscsi/modul=
e-setup.sh
similarity index 100%
rename from modules.d/95iscsi/module-info.sh
rename to modules.d/95iscsi/module-setup.sh
diff --git a/modules.d/95nbd/module-info.sh b/modules.d/95nbd/module-se=
tup.sh
similarity index 100%
rename from modules.d/95nbd/module-info.sh
rename to modules.d/95nbd/module-setup.sh
diff --git a/modules.d/95nfs/module-info.sh b/modules.d/95nfs/module-se=
tup.sh
similarity index 100%
rename from modules.d/95nfs/module-info.sh
rename to modules.d/95nfs/module-setup.sh
diff --git a/modules.d/95resume/module-info.sh b/modules.d/95resume/mod=
ule-setup.sh
similarity index 100%
rename from modules.d/95resume/module-info.sh
rename to modules.d/95resume/module-setup.sh
diff --git a/modules.d/95rootfs-block/module-info.sh b/modules.d/95root=
fs-block/module-setup.sh
similarity index 100%
rename from modules.d/95rootfs-block/module-info.sh
rename to modules.d/95rootfs-block/module-setup.sh
diff --git a/modules.d/95terminfo/module-info.sh b/modules.d/95terminfo=
/module-setup.sh
similarity index 100%
rename from modules.d/95terminfo/module-info.sh
rename to modules.d/95terminfo/module-setup.sh
diff --git a/modules.d/95udev-rules/module-info.sh b/modules.d/95udev-r=
ules/module-setup.sh
similarity index 100%
rename from modules.d/95udev-rules/module-info.sh
rename to modules.d/95udev-rules/module-setup.sh
diff --git a/modules.d/95zfcp/module-info.sh b/modules.d/95zfcp/module-=
setup.sh
similarity index 100%
rename from modules.d/95zfcp/module-info.sh
rename to modules.d/95zfcp/module-setup.sh
diff --git a/modules.d/95znet/module-info.sh b/modules.d/95znet/module-=
setup.sh
similarity index 100%
rename from modules.d/95znet/module-info.sh
rename to modules.d/95znet/module-setup.sh
diff --git a/modules.d/96insmodpost/module-info.sh b/modules.d/96insmod=
post/module-setup.sh
similarity index 100%
rename from modules.d/96insmodpost/module-info.sh
rename to modules.d/96insmodpost/module-setup.sh
diff --git a/modules.d/97biosdevname/module-info.sh b/modules.d/97biosd=
evname/module-setup.sh
similarity index 100%
rename from modules.d/97biosdevname/module-info.sh
rename to modules.d/97biosdevname/module-setup.sh
diff --git a/modules.d/98selinux/module-info.sh b/modules.d/98selinux/m=
odule-setup.sh
similarity index 100%
rename from modules.d/98selinux/module-info.sh
rename to modules.d/98selinux/module-setup.sh
diff --git a/modules.d/98syslog/module-info.sh b/modules.d/98syslog/mod=
ule-setup.sh
similarity index 100%
rename from modules.d/98syslog/module-info.sh
rename to modules.d/98syslog/module-setup.sh
diff --git a/modules.d/99base/module-info.sh b/modules.d/99base/module-=
setup.sh
similarity index 100%
rename from modules.d/99base/module-info.sh
rename to modules.d/99base/module-setup.sh
commit 6ae5caf00899e89684e250bbe25c7de201ecc45b
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 16:33:35 2011 +0100

    version 008

diff --git a/AUTHORS b/AUTHORS
index ddc38a8..bca5480 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -25,6 +25,7 @@ Peter Rajnoha <prajnoha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
 Alexander Todorov <atodorov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 Andy Lutomirski <luto-3s7WtUTddSA@public.gmane.org>
+Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 Dan Hor=C3=A1k <dhorak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 Frederic Crozat <fcrozat-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
@@ -32,6 +33,7 @@ Glen Gray <slaine-MO9OTSYphQodnm+yROfE0A@public.gmane.org>
 Ian Dall <ian-Xg6/AsmM8Z5B3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
 James Laska <jlaska-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
+Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
 Luca Berra <bluca-1WC7Or56Oao@public.gmane.org>
 Matt <smoothsailing72-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
 Matt Smith <shadowfax-KK0ffGbhmjU@public.gmane.org>
@@ -41,5 +43,6 @@ P=C3=A1draig Brady <P@draigBrady.com>
 Quentin Armitage <quentin-/BKvNsQo1N6tmTQ+vhA3Yw@public.gmane.org>
 Sergey Fionov <fionov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 Thilo Bangert <thilo.bangert-hi6Y0CQ0nG0@public.gmane.org>
+Tomasz Torcz <tomek-e+FrjxkDqoI/dUmziOgvOQ@public.gmane.org>
 Ville Skytt=C3=A4 <ville.skytta-X3B1VOXEql0@public.gmane.org>
 Yanko Kaneti <yaneti-jUE9FD3ILm5BDgjK7y7TUQ@public.gmane.org>
diff --git a/NEWS b/NEWS
index a2a7c7b..18c483d 100644
--- a/NEWS
+++ b/NEWS
@@ -1,6 +1,21 @@
 dracut-008
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - removed --ignore-kernel-modules option (no longer necessary)
+- renamed kernel command line arguments to follow the rd. naming schem=
e
+- merged check, install, installkernel to module-info.sh
+- support for bzip2 and xz compressed initramfs images.
+- source code beautification
+- lots of documentation
+- lsinitrd: "catinitrd" functionality
+- dracut: --list-modules
+- lvm: support for dynamic LVM SNAPSHOT root volume
+- 95fstab-sys: mount all /etc/fstab.sys volumes before switch_root
+- 96insmodpost dracut module
+- rd.shell=3D1 per default
+- rootfs-block:mount-root.sh add fsck
+- busybox shell replacements module
+- honor old "real_init=3D"
+- 97biosdevname dracut module
=20
 dracut-007
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/dracut.spec b/dracut.spec
index a14a2ec..b1e5e8d 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -15,7 +15,7 @@
=20
 Name: dracut
 Version: 008
-%define release_prefix 0.10%{?rdist}
+%define release_prefix 1%{?rdist}
 Release: %{release_prefix}
=20
 Summary: Initramfs generator using udev
@@ -81,7 +81,7 @@ Requires: tar
 Requires: udev
=20
 %if 0%{?fedora}
-Requires: util-linux-ng >=3D 2.16
+Requires: util-linux >=3D 2.16
 Requires: initscripts >=3D 8.63-1
 Requires: plymouth >=3D 0.8.0-0.2009.29.09.19.1
 %endif
commit b9d7fda0e13341ab0ac13b0bb1272c1f58f04fa1
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 15:10:42 2011 +0100

    selinux: call emergency_shell for failures

diff --git a/modules.d/98selinux/selinux-loadpolicy.sh b/modules.d/98se=
linux/selinux-loadpolicy.sh
index 7cb794b..86a99e9 100755
--- a/modules.d/98selinux/selinux-loadpolicy.sh
+++ b/modules.d/98selinux/selinux-loadpolicy.sh
@@ -52,7 +52,7 @@ rd_load_policy()
         if [ $ret -eq 3 -o $permissive -eq 0 ]; then
             warn "Machine in enforcing mode."
             warn "Not continuing"
-            sleep 100d
+            emergency_shell -n selinux
             exit 1
         fi
         return 0
@@ -60,7 +60,7 @@ rd_load_policy()
         warn "Machine in enforcing mode and cannot execute load_policy=
=2E"
         warn "To disable selinux, add selinux=3D0 to the kernel comman=
d line."
         warn "Not continuing"
-        sleep 100d
+        emergency_shell -n selinux
         exit 1
     fi
 }
commit e6752f1a6c25783917c19979d2c570f8670c259c
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 14:48:37 2011 +0100

    fips: add aes-xts module

diff --git a/modules.d/01fips/module-info.sh b/modules.d/01fips/module-=
info.sh
index 78541c1..cdcded6 100755
--- a/modules.d/01fips/module-info.sh
+++ b/modules.d/01fips/module-info.sh
@@ -11,7 +11,7 @@ depends() {
 }
=20
 installkernel() {
-    FIPSMODULES=3D"aead aes_generic aes-x86_64 ansi_cprng cbc ccm chai=
niv ctr"
+    FIPSMODULES=3D"aead aes_generici aes-xts aes-x86_64 ansi_cprng cbc=
 ccm chainiv ctr"
     FIPSMODULES=3D"$FIPSMODULES des deflate ecb eseqiv hmac seqiv sha2=
56 sha512"
     FIPSMODULES=3D"$FIPSMODULES cryptomgr crypto_null tcrypt"=20
=20
commit 46bc0593ac684b06fb1186dd25f2516a0fda8370
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 13:38:07 2011 +0100

    dracut: use derror for error messages

diff --git a/dracut b/dracut
index 2122d1c..85884f7 100755
--- a/dracut
+++ b/dracut
@@ -215,9 +215,9 @@ fw_dir=3D${fw_dir//:/ }
 if [[ -f $dracutbasedir/dracut-functions ]]; then
     . $dracutbasedir/dracut-functions
 else
-    echo "Cannot find $dracutbasedir/dracut-functions."
-    echo "Are you running from a git checkout?"
-    echo "Try passing -l as an argument to $0"
+    derror "Cannot find $dracutbasedir/dracut-functions."
+    derror "Are you running from a git checkout?"
+    derror "Try passing -l as an argument to $0"
     exit 1
 fi
=20
@@ -264,19 +264,19 @@ srcmods=3D"/lib/modules/$kernel/"
 export srcmods
=20
 if [[ -f $outfile && ! $force ]]; then
-    echo "Will not override existing initramfs ($outfile) without --fo=
rce"
+    derror "Will not override existing initramfs ($outfile) without --=
force"
     exit 1
 fi
=20
 outdir=3D${outfile%/*}
 if [[ ! -d "$outdir" ]]; then
-    echo "Can't write $outfile: Directory $outdir does not exist."
+    derror "Can't write $outfile: Directory $outdir does not exist."
     exit 1
 elif [[ ! -w "$outdir" ]]; then
-    echo "No permission to write $outdir."
+    derror "No permission to write $outdir."
     exit 1
 elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
-    echo "No permission to write $outfile."
+    derror "No permission to write $outfile."
     exit 1
 fi
=20
commit 76c4613abcc402e01e6d009eb5f205220bb7d3c7
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 13:34:34 2011 +0100

    multipath: use new "-B" parameter

diff --git a/modules.d/90multipath/multipathd.sh b/modules.d/90multipat=
h/multipathd.sh
index 72ca2ef..24daf82 100755
--- a/modules.d/90multipath/multipathd.sh
+++ b/modules.d/90multipath/multipathd.sh
@@ -2,9 +2,9 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
 # ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
=20
-if [ -e /etc/multipath.conf -a -e /etc/multipath/wwids ]; then
+if [ -e /etc/multipath.conf ]; then
     modprobe dm-multipath
-    multipathd
+    multipathd -B || multipathd
 else
     rm /etc/udev/rules.d/??-multipath.rules 2>/dev/null   =20
 fi
commit 7238aa0cf0b849889fdd9455ab7a4d2beef1de0b
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 13:32:46 2011 +0100

    base/init: do not poll cdrom, if kernel supports polling

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 8116a4d..0a05e91 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -203,13 +203,15 @@ while :; do
     # dirty hack for some cdrom drives,
     # which report no medium for quiet
     # some time.
-    for cdrom in /sys/block/sr*; do
-        [ -e "$cdrom" ] || continue
-        # skip, if cdrom medium was already found
-        strstr "$(udevadm info --query=3Denv --path=3D${cdrom##/sys})"=
 \
-            ID_CDROM_MEDIA && continue
-        echo change > "$cdrom/uevent"       =20
-    done
+    if [ ! -e /sys/module/block/parameters/events_dfl_poll_msecs ]; th=
en
+        for cdrom in /sys/block/sr*; do
+            [ -e "$cdrom" ] || continue      =20
+            # skip, if cdrom medium was already found
+            strstr "$(udevadm info --query=3Denv --path=3D${cdrom##/sy=
s})" \
+                ID_CDROM_MEDIA && continue
+            echo change > "$cdrom/uevent"       =20
+        done
+    fi
    =20
     i=3D$(($i+1))
     [ $i -gt $RDRETRY ] \
commit 95d2dabc250b39d2452e0e8f57a702ab80db895c
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Feb 2 13:34:58 2011 +0100

    replaced check,install,installkernel with module-info.sh

diff --git a/dracut b/dracut
index 303d817..2122d1c 100755
--- a/dracut
+++ b/dracut
@@ -309,7 +309,7 @@ fi
=20
 # check all our modules to see if they should be sourced.
 # This builds a list of modules that we will install next.
-check_modules
+check_module_dir
=20
 # source our modules.
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
@@ -317,11 +317,11 @@ for moddir in "$dracutbasedir/modules.d"/[0-9][0-=
9]*; do
     if strstr "$mods_to_load" " $mod "; then
         dinfo "*** Sourcing module $mod"
         if [[ $kernel_only =3D yes ]]; then
-            [[ -x $moddir/installkernel ]] && . "$moddir/installkernel=
"
+            module_installkernel $mod
         else
-            . "$moddir/install"
-            if [[ $no_kernel !=3D yes && -x $moddir/installkernel ]]; =
then
-                . "$moddir/installkernel"
+            module_install $mod
+            if [[ $no_kernel !=3D yes ]]; then
+                module_installkernel $mod
             fi
         fi
         mods_to_load=3D${mods_to_load// $mod /}
diff --git a/dracut-functions b/dracut-functions
index 2232dc9..a183a43 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -57,6 +57,10 @@ vercmp() {
     esac
 }
=20
+is_func() {
+     [[ $(type -t $1) =3D "function" ]]=20
+}
+
 # Log initrd creation.
 if ! [[ $dracutlogfile ]]; then
     [[ $dracutbasedir =3D /usr/share/dracut ]] && \
@@ -511,85 +515,129 @@ inst_opt_decompress() {
     done
 }
=20
-check_module_deps() {
-    local moddir dep ret
-    # if we are already set to be loaded, we do not have to be checked=
 again.
-    strstr " $mods_to_load " " $1 " && return
-    strstr " $omit_dracutmodules " " $1 " && return 1
-    # turn a module name into a directory, if we can.
-    moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
-    [[ -d $moddir && -x $moddir/install ]] || return 1
-    # if we do not have a check script, we are unconditionally include=
d
-    if [[ -x $moddir/check ]]; then
-        "$moddir/check"
+module_check() {
+    local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
+    [[ -d $moddir ]] || return 1
+    if [[ ! -f $moddir/module-info.sh ]]; then
+        # if we do not have a check script, we are unconditionally inc=
luded
+        [[ -x $moddir/check ]] || return 0
+        $moddir/check $hostonly
+        return $?
+    else
+        unset check depends install installkernel
+        . $moddir/module-info.sh
+        is_func check || return 0
+        check
         ret=3D$?
-        # a return value of 255 =3D load module only as a dependency.
-        ((ret=3D=3D0||ret=3D=3D255)) || return 1
-        for dep in $("$moddir/check" -d); do
-            check_module_deps "$dep" && continue
-            dwarning "Dependency $mod failed."
-            return 1
-        done
+        unset check depends install installkernel
+        return $ret
     fi
-    mods_to_load+=3D" $1 "
 }
=20
-should_source_module() {
-    local dep
-    local ret
-    if [[ $kernel_only =3D yes ]]; then
-        [[ -x $1/installkernel ]] && return 0
-        return 1
+module_depends() {
+    local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
+    [[ -d $moddir ]] || return 1
+    if [[ ! -f $moddir/module-info.sh ]]; then
+        # if we do not have a check script, we have no deps
+        [[ -x $moddir/check ]] || return 0
+        $moddir/check -d
+        return $?
+    else
+        unset check depends install installkernel
+        . $moddir/module-info.sh
+        is_func depends || return 0
+        depends
+        ret=3D$?
+        unset check depends install installkernel
+        return $ret
     fi
-    [[ -x $1/install || -x $1/installkernel ]] || return 1
-    [[ -x $1/check ]] || return 0
-    "$1/check" $hostonly || continue
-    for dep in $("$1/check" -d); do
-        check_module_deps "$dep" && continue
-        dwarning "Cannot load dracut module \"$mod\", dependencies fai=
led."
-        return 1
-    done
 }
=20
-check_modules() {
-    local modcheck;
-    local mod;
-    for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
-        local mod=3D${moddir##*/}; mod=3D${mod#[0-9][0-9]}
-        # If we are already scheduled to be loaded, no need to check a=
gain.
-        strstr " $mods_to_load " " $mod " && continue
-        # This should never happen, but...
-        [[ -d $moddir ]] || continue
-        strstr " $omit_dracutmodules " " $mod " && continue
-
-        if ! strstr " $dracutmodules $add_dracutmodules " " $mod "; th=
en
-            # module not in our list
-            if [[ $dracutmodules =3D all ]]; then
-                # check, if we can install this module
-                should_source_module "$moddir" || continue
-            else
-                # skip this module
-                continue
-            fi
+module_install() {
+    local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
+    [[ -d $moddir ]] || return 1
+    if [[ ! -f $moddir/module-info.sh ]]; then
+        [[ -x $moddir/install ]] && . "$moddir/install"
+        return $?
+    else
+        unset check depends install installkernel
+        . $moddir/module-info.sh
+        is_func install || return 0
+        install
+        ret=3D$?
+        unset check depends install installkernel
+        return $ret
+    fi
+}
+
+module_installkernel() {
+    local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
+    [[ -d $moddir ]] || return 1
+    if [[ ! -f $moddir/module-info.sh ]]; then
+        [[ -x $moddir/installkernel ]] && . "$moddir/installkernel"
+        return $?
+    else
+        unset check depends install installkernel
+        . $moddir/module-info.sh
+        is_func installkernel || return 0
+        installkernel
+        ret=3D$?
+        unset check depends install installkernel
+        return $ret
+    fi
+}
+
+check_module() {
+    local mod=3D$1;
+    local moddir=3D$(echo ${dracutbasedir}/modules.d/??${1})
+    local moddep;
+    # If we are already scheduled to be loaded, no need to check again=
=2E
+    strstr " $mods_to_load " " $mod " && return 0
+    strstr " $mods_checked_as_dep " " $mod " && return 1
+
+    # This should never happen, but...
+    [[ -d $moddir ]] || return 1
+
+    [[ $2 ]] || mods_checked_as_dep+=3D" $mod "
+
+    strstr " $omit_dracutmodules " " $mod " && return 1
+
+    if strstr " $dracutmodules $add_dracutmodules " " $mod "; then
+        module_check $mod; ret=3D$?
+        # explicit module, so also accept ret=3D255
+        [[ $ret =3D 0 || $ret =3D 255 ]] || return 1
+    else
+        # module not in our list
+        if [[ $dracutmodules =3D all ]]; then
+            # check, if we can and should install this module
+            module_check $mod || return 1
         else
-            if [ -x "$moddir/check" ] \
-                && "$moddir/check" -d > /dev/null 2>&1; then
-                check_module_deps "$mod" || {
-                    dwarning "Cannot load dracut module \"$mod\", depe=
ndencies failed."
-                    continue
-                }
-            fi
+            # skip this module
+            return 1
         fi
+    fi
=20
-        mods_to_load+=3D" $mod "
+    for moddep in $(module_depends $mod); do
+        # handle deps as if they were manually added
+        strstr " $add_dracutmodules " " $moddep " || \
+            add_dracutmodules+=3D" $moddep "
+        # if a module we depend on fail, fail also
+        check_module $moddep || return 1
     done
=20
-    modcheck=3D$add_dracutmodules
-    [[ $dracutmodules !=3D all ]] && modcheck=3D"$m $dracutmodules"
-    for mod in $modcheck; do
-        strstr " $mods_to_load " " $mod " && continue
-        strstr " $omit_dracutmodules " " $mod " && continue
-        dwarning "Dracut module \"$mod\" cannot be found."
+    strstr " $mods_to_load " " $mod " || \
+        mods_to_load+=3D" $mod "
+
+    return 0
+}
+
+check_module_dir() {
+    local modcheck;
+    local mod;
+    mods_to_load=3D""
+    for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
+        local mod=3D${moddir##*/}; mod=3D${mod#[0-9][0-9]}
+        check_module $mod 1
     done
 }
=20
diff --git a/dracut.xml b/dracut.xml
index d7ac1fc..089f8ee 100644
--- a/dracut.xml
+++ b/dracut.xml
@@ -1,9 +1,18 @@
 <?xml version=3D'1.0' encoding=3D'UTF-8'?>
+<!-- This document was created with Syntext Serna Free. -->
 <!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www=
=2Eoasis-open.org/docbook/xml/4.5/docbookx.dtd" []>
 <book>
-  <title>
-  <inlinemediaobject><imageobject><imagedata valign=3D"middle" fileref=
=3D"dracut.png" format=3D"PNG"/></imageobject><imageobject><imagedata v=
align=3D"middle" fileref=3D"dracut.svg" format=3D"SVG"/></imageobject><=
imageobject>
-      <xi:include xmlns:xi=3D"http://www.w3.org/2001/XInclude" href=3D=
"dracut.svg" encoding=3D"UTF-8" parse=3D"xml"/></imageobject></inlineme=
diaobject>dracut</title>
+  <title><inlinemediaobject>
+      <imageobject>
+        <imagedata valign=3D"middle" fileref=3D"dracut.png" format=3D"=
PNG"/>
+      </imageobject>
+      <imageobject>
+        <imagedata valign=3D"middle" fileref=3D"dracut.svg" format=3D"=
SVG"/>
+      </imageobject>
+      <imageobject>
+        <xi:include xmlns:xi=3D"http://www.w3.org/2001/XInclude" href=3D=
"dracut.svg" encoding=3D"UTF-8" parse=3D"xml"/>
+      </imageobject>
+    </inlinemediaobject>dracut</title>
   <bookinfo>
     <author>
       <firstname>Harald</firstname>
@@ -604,11 +613,12 @@ Common used functions are in <filename>dracut-lib=
=2Esh</filename>, which can be so
     <section>
       <title>Writing a Module</title>
       <para>A simple example module is <filename>96insmodpost</filenam=
e>, which modprobes a kernel module after udev has settled and the basi=
c device drivers have been loaded.</para>
-      <para>First we create a <filename>check</filename> script, which=
 just exits with <errorcode>0</errorcode> indicating that this module s=
hould be included by default.</para>
-      <para><filename>check</filename>:</para>
-      <programlisting>exit 0</programlisting>
-      <para>The we create the install script, which installs a cmdline=
 hook with priority number 20 called <filename>parse-insmodpost.sh</fil=
ename>. It also installs the <filename>insmodpost.sh</filename> script =
in <filename>/sbin</filename>.</para>
-      <para><filename>install</filename>:</para>
+      <para>All module installation information is in the file module-=
info.sh.</para>
+      <para>First we create a <function>check()</function> function, w=
hich just exits with <errorcode>0</errorcode> indicating that this modu=
le should be included by default.</para>
+      <para><function>check()</function>:</para>
+      <programlisting>return 0</programlisting>
+      <para>The we create the <function>install()</function> function,=
 which installs a cmdline hook with priority number 20 called <filename=
>parse-insmodpost.sh</filename>. It also installs the <filename>insmodp=
ost.sh</filename> script in <filename>/sbin</filename>.</para>
+      <para><function>install()</function>:</para>
       <programlisting>inst_hook cmdline 20 &quot;$moddir/parse-insmodp=
ost.sh&quot;
 inst_simple &quot;$moddir/insmodpost.sh&quot; /sbin/insmodpost.sh</pro=
gramlisting>
       <para>The <filename>pase-instmodpost.sh</filename> parses the ke=
rnel command line for a argument <envar>rd.driver.post</envar>, blackli=
sts the module from being autoloaded and installs the hook <filename>in=
smodpost.sh</filename> in the <filename>initqueue-settled</filename>.</=
para>
@@ -630,39 +640,34 @@ for p in $(getargs rd.driver.post=3D); do
 done
 </programlisting>
       <section>
-        <title>check</title>
-        <para><filename>check</filename> is called by dracut to evalua=
te the inclusion of a dracut module in the initramfs.</para>
-        <para><filename>check</filename> also can be called with argum=
ents, which are described in the following list.</para>
+        <title>check()</title>
+        <para><filename>
+            <function>check()</function>
+          </filename> is called by dracut to evaluate the inclusion of=
 a dracut module in the initramfs.</para>
         <variablelist>
           <varlistentry>
-            <term><filename>check</filename> -d</term>
+            <term> $hostonly</term>
             <listitem>
-              <para>If <filename>check</filename> is called with param=
eter <parameter>-d</parameter>, then the stdout output is taken as the =
dracut module names of the dependencies this module needs.</para>
-            </listitem>
-          </varlistentry>
-          <varlistentry>
-            <term><filename>check</filename> -h</term>
-            <listitem>
-              <para>If check is called with parameter <parameter>-h</p=
arameter>, then the module check should be in &quot;hostonly&quot; mode=
, which means, that the check should only return 0, if the module is re=
ally needed to boot this specific host.</para>
+              <para>If  the $hostonly variable is set, then the module=
 check() function  should be in &quot;hostonly&quot; mode, which means,=
 that the check() should only return 0, if the module is really needed =
to boot this specific host.</para>
             </listitem>
           </varlistentry>
         </variablelist>
-        <para>If <filename>check</filename> is called without paramete=
rs, it should return the following exit codes.</para>
+        <para><function>check()</function> should return with:</para>
         <variablelist>
           <varlistentry>
-            <term>exit 0</term>
+            <term>0</term>
             <listitem>
               <para>Include the dracut module in the initramfs.</para>
             </listitem>
           </varlistentry>
           <varlistentry>
-            <term>exit 1</term>
+            <term>1</term>
             <listitem>
               <para>Do not include the dracut module. The requirements=
 are not fullfilled (missing tools, etc.)</para>
             </listitem>
           </varlistentry>
           <varlistentry>
-            <term>exit 255</term>
+            <term>255</term>
             <listitem>
               <para>Only include the dracut module, if another module =
requires it or  if explicitly specified in the config file or on the ar=
gument list.</para>
             </listitem>
@@ -670,7 +675,11 @@ done
         </variablelist>
       </section>
       <section>
-        <title>Install</title>
+        <title>depends()</title>
+        <para>The function <function>depends()</function> should <func=
tion>echo</function> all other dracut module names the module depends o=
n.</para>
+      </section>
+      <section>
+        <title>install()</title>
         <para>dracut_install</para>
         <para>inst</para>
         <para>inst_hook</para>
@@ -678,7 +687,7 @@ done
         <para/>
       </section>
       <section>
-        <title>Installkernel</title>
+        <title>installkernel()</title>
         <para>instmods</para>
       </section>
       <section>
diff --git a/modules.d/00bootchart/check b/modules.d/00bootchart/check
deleted file mode 100755
index 1e2f863..0000000
--- a/modules.d/00bootchart/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-[ -x /sbin/bootchartd ] || exit 1
-
-# do not enable bootchartd by default
-exit 255
diff --git a/modules.d/00bootchart/install b/modules.d/00bootchart/inst=
all
deleted file mode 100755
index f06b097..0000000
--- a/modules.d/00bootchart/install
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst /sbin/bootchartd=20
-inst /bin/bash=20
-inst_symlink /init /sbin/init
-inst_dir /lib/bootchart/tmpfs
-inst /lib/bootchart/bootchart-collector=20
-inst /etc/bootchartd.conf=20
-inst /sbin/accton=20
-inst /usr/bin/pkill /bin/pkill
-inst /bin/echo
-inst /bin/grep=20
-inst /bin/usleep
-inst /usr/bin/[  /bin/[
-
-mknod -m 0666 "${initdir}/dev/null" c 1 3
diff --git a/modules.d/00bootchart/module-info.sh b/modules.d/00bootcha=
rt/module-info.sh
new file mode 100755
index 0000000..b58ce35
--- /dev/null
+++ b/modules.d/00bootchart/module-info.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    [ -x /sbin/bootchartd ] || return 1
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    inst /sbin/bootchartd=20
+    inst /bin/bash=20
+    inst_symlink /init /sbin/init
+    inst_dir /lib/bootchart/tmpfs
+    inst /lib/bootchart/bootchart-collector=20
+    inst /etc/bootchartd.conf=20
+    inst /sbin/accton=20
+    inst /usr/bin/pkill /bin/pkill
+    inst /bin/echo
+    inst /bin/grep=20
+    inst /bin/usleep
+    inst /usr/bin/[  /bin/[
+
+    mknod -m 0666 "${initdir}/dev/null" c 1 3
+}
+
diff --git a/modules.d/00dash/check b/modules.d/00dash/check
deleted file mode 100755
index d18c69c..0000000
--- a/modules.d/00dash/check
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-[ -x /bin/dash ]
\ No newline at end of file
diff --git a/modules.d/00dash/install b/modules.d/00dash/install
deleted file mode 100755
index 6203546..0000000
--- a/modules.d/00dash/install
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# If another shell is already installed, do not use dash
-[[ -x $initdir/bin/sh ]] && return
-
-# Prefer dash as /bin/sh if it is available.
-inst /bin/dash && ln -sf dash "${initdir}/bin/sh"
diff --git a/modules.d/00dash/module-info.sh b/modules.d/00dash/module-=
info.sh
new file mode 100755
index 0000000..dfd4d7b
--- /dev/null
+++ b/modules.d/00dash/module-info.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    [ -x /bin/dash ]
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    # If another shell is already installed, do not use dash
+    [[ -x $initdir/bin/sh ]] && return
+
+    # Prefer dash as /bin/sh if it is available.
+    inst /bin/dash && ln -sf dash "${initdir}/bin/sh"
+}
+
diff --git a/modules.d/01fips/check b/modules.d/01fips/check
deleted file mode 100755
index 7856e39..0000000
--- a/modules.d/01fips/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-[[ $1 =3D -d ]] && exit 0
-exit 255
-
diff --git a/modules.d/01fips/install b/modules.d/01fips/install
deleted file mode 100755
index 622ce21..0000000
--- a/modules.d/01fips/install
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_hook pre-trigger 01 "$moddir/fips.sh"
-dracut_install sha512hmac rmmod insmod mount uname umount
-
-for dir in "$usrlibdir" "$libdir"; do
-    [[ -e $dir/libsoftokn3.so ]] && \
-        dracut_install $dir/libsoftokn3.so $dir/libsoftokn3.chk \
-        $dir/libfreebl3.so $dir/libfreebl3.chk && \
-        break
-done
-
-dracut_install $usrlibdir/hmaccalc/sha512hmac.hmac
diff --git a/modules.d/01fips/installkernel b/modules.d/01fips/installk=
ernel
deleted file mode 100755
index daa248d..0000000
--- a/modules.d/01fips/installkernel
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-FIPSMODULES=3D"aead aes_generic aes-x86_64 ansi_cprng cbc ccm chainiv =
ctr"
-FIPSMODULES=3D"$FIPSMODULES des deflate ecb eseqiv hmac seqiv sha256 s=
ha512"
-FIPSMODULES=3D"$FIPSMODULES cryptomgr crypto_null tcrypt"=20
-
-mkdir -p "${initdir}/etc/modprobe.d"
-
-for mod in $FIPSMODULES; do=20
-    if instmods $mod; then
-        echo $mod >> "${initdir}/etc/fipsmodules"
-        echo "blacklist $mod" >> "${initdir}/etc/modprobe.d/fips.conf"
-    fi
-done
diff --git a/modules.d/01fips/module-info.sh b/modules.d/01fips/module-=
info.sh
new file mode 100755
index 0000000..78541c1
--- /dev/null
+++ b/modules.d/01fips/module-info.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    FIPSMODULES=3D"aead aes_generic aes-x86_64 ansi_cprng cbc ccm chai=
niv ctr"
+    FIPSMODULES=3D"$FIPSMODULES des deflate ecb eseqiv hmac seqiv sha2=
56 sha512"
+    FIPSMODULES=3D"$FIPSMODULES cryptomgr crypto_null tcrypt"=20
+
+    mkdir -p "${initdir}/etc/modprobe.d"
+
+    for mod in $FIPSMODULES; do=20
+        if instmods $mod; then
+            echo $mod >> "${initdir}/etc/fipsmodules"
+            echo "blacklist $mod" >> "${initdir}/etc/modprobe.d/fips.c=
onf"
+        fi
+    done
+}
+
+install() {
+    inst_hook pre-trigger 01 "$moddir/fips.sh"
+    dracut_install sha512hmac rmmod insmod mount uname umount
+
+    for dir in "$usrlibdir" "$libdir"; do
+        [[ -e $dir/libsoftokn3.so ]] && \
+            dracut_install $dir/libsoftokn3.so $dir/libsoftokn3.chk \
+            $dir/libfreebl3.so $dir/libfreebl3.chk && \
+            break
+    done
+
+    dracut_install $usrlibdir/hmaccalc/sha512hmac.hmac
+}
+
diff --git a/modules.d/05busybox/check b/modules.d/05busybox/check
deleted file mode 100755
index dc57cca..0000000
--- a/modules.d/05busybox/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-
-[[ $1 =3D -d ]] && exit 0
-
-type -P busybox >/dev/null || exit 1
-
-exit 255
diff --git a/modules.d/05busybox/install b/modules.d/05busybox/install
deleted file mode 100755
index 5252d03..0000000
--- a/modules.d/05busybox/install
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-
-inst busybox /sbin/busybox
-
-# List of shell programs that we use in other official dracut modules,=
 that
-# must be supported by the busybox installed on the host system
-progs=3D"echo grep usleep [ rmmod insmod mount uname umount setfont kb=
d_mode stty gzip bzip2 chvt readlink blkid dd losetup tr sed seq ps mor=
e cat rm free ping netstat vi ping6 fsck ip hostname basename mknod mkd=
ir pidof sleep chroot ls cp mv dmesg mkfifo less ln modprobe"
-
-# FIXME: switch_root should be in the above list, but busybox version =
hangs
-# (using busybox-1.15.1-7.fc14.i686 at the time of writing)
-
-for i in $progs; do
-	path=3D$(find_binary "$i")
-	ln -s /sbin/busybox "$initdir/$path"
-done
-
diff --git a/modules.d/05busybox/module-info.sh b/modules.d/05busybox/m=
odule-info.sh
new file mode 100755
index 0000000..031b335
--- /dev/null
+++ b/modules.d/05busybox/module-info.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    type -P busybox >/dev/null || return 1
+
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    inst busybox /sbin/busybox
+
+    # List of shell programs that we use in other official dracut modu=
les, that
+    # must be supported by the busybox installed on the host system
+    progs=3D"echo grep usleep [ rmmod insmod mount uname umount setfon=
t kbd_mode stty gzip bzip2 chvt readlink blkid dd losetup tr sed seq ps=
 more cat rm free ping netstat vi ping6 fsck ip hostname basename mknod=
 mkdir pidof sleep chroot ls cp mv dmesg mkfifo less ln modprobe"
+
+    # FIXME: switch_root should be in the above list, but busybox vers=
ion hangs
+    # (using busybox-1.15.1-7.fc14.i686 at the time of writing)
+
+    for i in $progs; do
+	path=3D$(find_binary "$i")
+	ln -s /sbin/busybox "$initdir/$path"
+    done
+
+}
+
diff --git a/modules.d/10i18n/check b/modules.d/10i18n/check
deleted file mode 100755
index e0292c8..0000000
--- a/modules.d/10i18n/check
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-exit 0
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
deleted file mode 100755
index 96d563d..0000000
--- a/modules.d/10i18n/install
+++ /dev/null
@@ -1,199 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-KBDSUBDIRS=3Dconsolefonts,consoletrans,keymaps,unimaps
-DEFAULT_FONT=3DLatArCyrHeb-16
-I18N_CONF=3D"/etc/locale.conf"
-VCONFIG_CONF=3D"/etc/vconsole.conf"
-
-# This is from 10redhat-i18n.
-findkeymap () {
-    local MAP=3D$1
-    [[ ! -f $MAP ]] && \
-        MAP=3D$(find ${kbddir}/keymaps -type f -name $MAP -o -name $MA=
P.\* | head -n1)
-    [[ " $KEYMAPS " =3D *" $MAP "* ]] && return
-    KEYMAPS=3D"$KEYMAPS $MAP"
-    case $MAP in
-        *.gz) cmd=3Dzgrep;;
-        *.bz2) cmd=3Dbzgrep;;
-        *) cmd=3Dgrep ;;
-    esac
-
-    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); =
do
-        for FN in $(find ${kbddir}/keymaps -type f -name $INCL\*); do
-            findkeymap $FN
-        done
-    done
-}
-
-# Function gathers variables from distributed files among the tree, ma=
ps to
-# specified names and prints the result in format "new-name=3Dvalue".
-#
-# $@ =3D list in format specified below (BNF notation)
-#
-# <list> ::=3D <element> | <element> " " <list>
-# <element> ::=3D <conf-file-name> ":" <map-list>
-# <map-list> ::=3D <mapping> | <mapping> "," <map-list>
-# <mapping> ::=3D <src-var> "-" <dst-var> | <src-var>
-#
-# We assume no whitespace are allowed between symbols.
-# <conf-file-name> is a file holding <src-var> in your system.
-# <src-var> is a variable holding value of meaning the same as <dst-va=
r>.
-# <dst-var> is a variable which will be set up inside initramfs.
-# If <dst-var> has the same name as <src-var> we can omit <dst-var>.
-#
-# Example:
-# /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
-# <list> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
-# <element> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAP=
S
-# <conf-file-name> =3D /etc/conf.d/keymaps
-# <map-list> =3D KEYMAP,extended_keymaps-EXT_KEYMAPS
-# <mapping> =3D KEYMAP
-# <src-var> =3D KEYMAP
-# <mapping> =3D extended_keymaps-EXT_KEYMAPS
-# <src-var> =3D extended_keymaps
-# <dst-var> =3D EXT_KEYMAPS
-gather_vars() {
-    local item map value
-
-    for item in $@
-    do
-        item=3D(${item/:/ })
-        for map in ${item[1]//,/ }
-        do
-            map=3D(${map//-/ })
-            value=3D$(grep "^${map[0]}=3D" "${item[0]}")
-            value=3D${value#*=3D}
-            echo "${map[1]:-${map[0]}}=3D${value}"
-        done
-    done
-}
-
-install_base() {
-    dracut_install setfont loadkeys kbd_mode stty
-
-    inst ${moddir}/console_init /lib/udev/console_init
-    inst_rules ${moddir}/10-console.rules
-    inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
-}
-
-install_all_kbd() {
-    local rel f
-
-    for f in $(eval find ${kbddir}/{${KBDSUBDIRS}} -type f -print)
-    do
-        inst $f
-    done
-
-    # remove unnecessary files
-    rm -f "${initdir}${kbddir}/consoletrans/utflist"
-    find "${initdir}${kbddir}/" -name README\* -delete
-
-    dracut_install gzip bzip2
-}
-
-install_local_i18n() {
-    local map
-
-    eval $(gather_vars ${i18n_vars})
-    [ -f $I18N_CONF ] && . $I18N_CONF
-    [ -f $VCONFIG_CONF ] && . $VCONFIG_CONF
-
-    # Gentoo user may have KEYMAP set to something like "-u pl2",
-    KEYMAP=3D${KEYMAP#-* }
-    # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They w=
ere in
-    # original redhat-i18n module.  Anyway it won't hurt.
-    EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
-
-    [[ ${KEYMAP} ]] || dwarning 'No KEYMAP.' || return 1
-    findkeymap ${KEYMAP}
-
-    for map in ${EXT_KEYMAPS}
-    do
-        dinfo "Adding extra map: ${map}"
-        findkeymap ${map}
-    done
-
-    inst_opt_decompress ${KEYMAPS}
-
-    inst_opt_decompress ${kbddir}/consolefonts/${DEFAULT_FONT}.*
-
-    if [[ ${FONT} ]]
-    then
-        FONT=3D${FONT%.psf*}
-        inst_opt_decompress ${kbddir}/consolefonts/${FONT}.*
-    fi
-
-    if [[ ${FONT_MAP} ]]
-    then
-        FONT_MAP=3D${FONT_MAP%.trans}
-        inst ${kbddir}/consoletrans/${FONT_MAP}.trans
-    fi
-
-    if [[ ${FONT_UNIMAP} ]]
-    then
-        FONT_UNIMAP=3D${FONT_UNIMAP%.uni}
-        inst ${kbddir}/unimaps/${FONT_UNIMAP}.uni
-    fi
-
-    if [[ ${UNICODE} ]]
-    then
-        if [[ ${UNICODE^^} =3D YES || ${UNICODE} =3D 1 ]]
-        then
-            UNICODE=3D1
-        elif [[ ${UNICODE^^} =3D NO || ${UNICODE} =3D 0 ]]
-        then
-            UNICODE=3D0
-        else
-            UNICODE=3D''
-        fi
-    fi
-    if [[ ! ${UNICODE} && ${LANG^^} =3D~ .*\.UTF-?8 ]]
-    then
-        UNICODE=3D1
-    fi
-
-    mksubdirs ${initdir}${I18N_CONF}
-    mksubdirs ${initdir}${VCONFIG_CONF}
-    print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
-    print_vars KEYMAP EXT_KEYMAPS UNICODE FONT FONT_MAP FONT_UNIMAP >>=
 ${initdir}${VCONFIG_CONF}
-    return 0
-}
-
-checks() {
-    for kbddir in ${kbddir} /usr/lib/kbd /lib/kbd /usr/share /usr/shar=
e/kbd
-    do
-        [[ -d "${kbddir}" ]] && \
-            for dir in ${KBDSUBDIRS//,/ }=20
-            do
-                [[ -d "${kbddir}/${dir}" ]] && continue
-                false
-            done && break
-        kbddir=3D''=20
-    done
-
-    [[ ${kbddir} ]] || {
-        derror "Directories ${KBDSUBDIRS//,/, } not found.  Please inf=
orm us about the issue including your OS name and version."
-        return 1
-    }
-
-    [[ -f $I18N_CONF && -f $VCONFIG_CONF ]] || \
-    [[ ! ${hostonly} || ${i18n_vars} ]] || {
-        dwarning 'Please set up i18n_vars in configuration file.'
-    }
-    return 0
-}
-
-
-if checks
-then
-    install_base
-
-    if [[ ${hostonly} ]]
-    then
-        install_local_i18n || install_all_kbd
-    else
-        install_all_kbd
-    fi
-fi
diff --git a/modules.d/10i18n/module-info.sh b/modules.d/10i18n/module-=
info.sh
new file mode 100755
index 0000000..a524d2d
--- /dev/null
+++ b/modules.d/10i18n/module-info.sh
@@ -0,0 +1,209 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    KBDSUBDIRS=3Dconsolefonts,consoletrans,keymaps,unimaps
+    DEFAULT_FONT=3DLatArCyrHeb-16
+    I18N_CONF=3D"/etc/locale.conf"
+    VCONFIG_CONF=3D"/etc/vconsole.conf"
+
+    # This is from 10redhat-i18n.
+    findkeymap () {
+        local MAP=3D$1
+        [[ ! -f $MAP ]] && \
+            MAP=3D$(find ${kbddir}/keymaps -type f -name $MAP -o -name=
 $MAP.\* | head -n1)
+        [[ " $KEYMAPS " =3D *" $MAP "* ]] && return
+        KEYMAPS=3D"$KEYMAPS $MAP"
+        case $MAP in
+            *.gz) cmd=3Dzgrep;;
+            *.bz2) cmd=3Dbzgrep;;
+            *) cmd=3Dgrep ;;
+        esac
+
+        for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"=
'); do
+            for FN in $(find ${kbddir}/keymaps -type f -name $INCL\*);=
 do
+                findkeymap $FN
+            done
+        done
+    }
+
+# Function gathers variables from distributed files among the tree, ma=
ps to
+# specified names and prints the result in format "new-name=3Dvalue".
+#
+# $@ =3D list in format specified below (BNF notation)
+#
+# <list> ::=3D <element> | <element> " " <list>
+# <element> ::=3D <conf-file-name> ":" <map-list>
+# <map-list> ::=3D <mapping> | <mapping> "," <map-list>
+# <mapping> ::=3D <src-var> "-" <dst-var> | <src-var>
+#
+# We assume no whitespace are allowed between symbols.
+# <conf-file-name> is a file holding <src-var> in your system.
+# <src-var> is a variable holding value of meaning the same as <dst-va=
r>.
+# <dst-var> is a variable which will be set up inside initramfs.
+# If <dst-var> has the same name as <src-var> we can omit <dst-var>.
+#
+# Example:
+# /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <list> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <element> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAP=
S
+# <conf-file-name> =3D /etc/conf.d/keymaps
+# <map-list> =3D KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <mapping> =3D KEYMAP
+# <src-var> =3D KEYMAP
+# <mapping> =3D extended_keymaps-EXT_KEYMAPS
+# <src-var> =3D extended_keymaps
+# <dst-var> =3D EXT_KEYMAPS
+    gather_vars() {
+        local item map value
+
+        for item in $@
+        do
+            item=3D${item/:/ }
+            for map in ${item[1]//,/ }
+            do
+                map=3D${map//-/ }
+                value=3D$(grep "^${map[0]}=3D" "${item[0]}")
+                value=3D${value#*=3D}
+                echo "${map[1]:-${map[0]}}=3D${value}"
+            done
+        done
+    }
+
+    install_base() {
+        dracut_install setfont loadkeys kbd_mode stty
+
+        inst ${moddir}/console_init /lib/udev/console_init
+        inst_rules ${moddir}/10-console.rules
+        inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
+    }
+
+    install_all_kbd() {
+        local rel f
+
+        for f in $(eval find ${kbddir}/{${KBDSUBDIRS}} -type f -print)
+        do
+            inst $f
+        done
+
+        # remove unnecessary files
+        rm -f "${initdir}${kbddir}/consoletrans/utflist"
+        find "${initdir}${kbddir}/" -name README\* -delete
+
+        dracut_install gzip bzip2
+    }
+
+    install_local_i18n() {
+        local map
+
+        eval $(gather_vars ${i18n_vars})
+        [ -f $I18N_CONF ] && . $I18N_CONF
+        [ -f $VCONFIG_CONF ] && . $VCONFIG_CONF
+
+        # Gentoo user may have KEYMAP set to something like "-u pl2",
+        KEYMAP=3D${KEYMAP#-* }
+        # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  Th=
ey were in
+        # original redhat-i18n module.  Anyway it won't hurt.
+        EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
+
+        [[ ${KEYMAP} ]] || dwarning 'No KEYMAP.' || return 1
+        findkeymap ${KEYMAP}
+
+        for map in ${EXT_KEYMAPS}
+        do
+            dinfo "Adding extra map: ${map}"
+            findkeymap ${map}
+        done
+
+        inst_opt_decompress ${KEYMAPS}
+
+        inst_opt_decompress ${kbddir}/consolefonts/${DEFAULT_FONT}.*
+
+        if [[ ${FONT} ]]
+        then
+            FONT=3D${FONT%.psf*}
+            inst_opt_decompress ${kbddir}/consolefonts/${FONT}.*
+        fi
+
+        if [[ ${FONT_MAP} ]]
+        then
+            FONT_MAP=3D${FONT_MAP%.trans}
+            inst ${kbddir}/consoletrans/${FONT_MAP}.trans
+        fi
+
+        if [[ ${FONT_UNIMAP} ]]
+        then
+            FONT_UNIMAP=3D${FONT_UNIMAP%.uni}
+            inst ${kbddir}/unimaps/${FONT_UNIMAP}.uni
+        fi
+
+        if [[ ${UNICODE} ]]
+        then
+            if [[ ${UNICODE^^} =3D YES || ${UNICODE} =3D 1 ]]
+            then
+                UNICODE=3D1
+            elif [[ ${UNICODE^^} =3D NO || ${UNICODE} =3D 0 ]]
+            then
+                UNICODE=3D0
+            else
+                UNICODE=3D''
+            fi
+        fi
+        if [[ ! ${UNICODE} && ${LANG^^} =3D~ .*\.UTF-?8 ]]
+        then
+            UNICODE=3D1
+        fi
+
+        mksubdirs ${initdir}${I18N_CONF}
+        mksubdirs ${initdir}${VCONFIG_CONF}
+        print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
+        print_vars KEYMAP EXT_KEYMAPS UNICODE FONT FONT_MAP FONT_UNIMA=
P >> ${initdir}${VCONFIG_CONF}
+        return 0
+    }
+
+    checks() {
+        for kbddir in ${kbddir} /usr/lib/kbd /lib/kbd /usr/share /usr/=
share/kbd
+        do
+            [[ -d "${kbddir}" ]] && \
+                for dir in ${KBDSUBDIRS//,/ }=20
+            do
+                [[ -d "${kbddir}/${dir}" ]] && continue
+                false
+            done && break
+            kbddir=3D''=20
+        done
+
+        [[ ${kbddir} ]] || {
+            derror "Directories ${KBDSUBDIRS//,/, } not found.  Please=
 inform us about the issue including your OS name and version."
+            return 1
+        }
+
+        [[ -f $I18N_CONF && -f $VCONFIG_CONF ]] || \
+            [[ ! ${hostonly} || ${i18n_vars} ]] || {
+            dwarning 'Please set up i18n_vars in configuration file.'
+        }
+        return 0
+    }
+
+    if checks
+    then
+        install_base
+
+        if [[ ${hostonly} ]]
+        then
+            install_local_i18n || install_all_kbd
+        else
+            install_all_kbd
+        fi
+    fi
+}
+
diff --git a/modules.d/10rpmversion/check b/modules.d/10rpmversion/chec=
k
deleted file mode 100755
index 4002ae4..0000000
--- a/modules.d/10rpmversion/check
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-[ -f /etc/redhat-release ]
-
diff --git a/modules.d/10rpmversion/install b/modules.d/10rpmversion/in=
stall
deleted file mode 100755
index 8fa9be0..0000000
--- a/modules.d/10rpmversion/install
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-if [ -e "$moddir/dracut-version" ]; then
-    dracut_rpm_version=3D$(cat "$moddir/dracut-version")
-    inst "$moddir/dracut-version" /$dracut_rpm_version
-else
-    if rpm -qf $(type -P $0) &>/dev/null; then
-        dracut_rpm_version=3D$(rpm -qf --qf '%{name}-%{version}-%{rele=
ase}\n' $(type -P $0) | { ver=3D"";while read line;do ver=3D$line;done;=
echo $ver;} )
-        echo $dracut_rpm_version > $initdir/$dracut_rpm_version
-    fi
-fi
-inst_hook cmdline 01 "$moddir/version.sh"
-
diff --git a/modules.d/10rpmversion/module-info.sh b/modules.d/10rpmver=
sion/module-info.sh
new file mode 100755
index 0000000..e26d785
--- /dev/null
+++ b/modules.d/10rpmversion/module-info.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    [ -f /etc/redhat-release ]
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    if [ -e "$moddir/dracut-version" ]; then
+        dracut_rpm_version=3D$(cat "$moddir/dracut-version")
+        inst "$moddir/dracut-version" /$dracut_rpm_version
+    else
+        if rpm -qf $(type -P $0) &>/dev/null; then
+            dracut_rpm_version=3D$(rpm -qf --qf '%{name}-%{version}-%{=
release}\n' $(type -P $0) | { ver=3D"";while read line;do ver=3D$line;d=
one;echo $ver;} )
+            echo $dracut_rpm_version > $initdir/$dracut_rpm_version
+        fi
+    fi
+    inst_hook cmdline 01 "$moddir/version.sh"
+
+}
+
diff --git a/modules.d/40network/check b/modules.d/40network/check
deleted file mode 100755
index f575bd9..0000000
--- a/modules.d/40network/check
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-if [[ $1 =3D -d ]]; then
-    [ -d /etc/sysconfig/network-scripts/ ] && echo ifcfg
-    exit 0
-fi
-
-. $dracutfunctions
-
-for program in ip arping; do=20
-    if ! type -P $program >/dev/null; then
-        dwarning "Could not find program \"$program\" required by netw=
ork."=20
-        exit 1
-    fi
-done
-for program in dhclient brctl ifenslave tr; do
-    if ! type -P $program >/dev/null; then
-        dwarning "Could not find program \"$program\" it might be requ=
ired by network."=20
-    fi
-done
-
-exit 255
diff --git a/modules.d/40network/install b/modules.d/40network/install
deleted file mode 100755
index b22cc96..0000000
--- a/modules.d/40network/install
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install ip dhclient brctl arping ifenslave tr
-inst "$moddir/ifup" "/sbin/ifup"
-inst "$moddir/netroot" "/sbin/netroot"
-inst "$moddir/dhclient-script" "/sbin/dhclient-script"
-inst "$moddir/dhclient.conf" "/etc/dhclient.conf"=20
-inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
-inst_hook pre-udev 60 "$moddir/net-genrules.sh"
-inst_hook cmdline 91 "$moddir/dhcp-root.sh"
-inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
-inst_hook cmdline 97 "$moddir/parse-bond.sh"
-inst_hook cmdline 98 "$moddir/parse-bridge.sh"
-inst_hook cmdline 99 "$moddir/parse-ifname.sh"
-inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
-
-arch=3D$(uname -m)
-
-for dir in "$usrlibdir/tls/$arch" "$usrlibdir/tls" "$usrlibdir/$arch" =
\
-    "$usrlibdir" "$libdir"; do
-    for i in "$dir"/libnss_dns.so.* "$dir"/libnss_mdns4_minimal.so.*; =
do
-        [ -e "$i" ] && dracut_install "$i"
-    done
-done
-
diff --git a/modules.d/40network/installkernel b/modules.d/40network/in=
stallkernel
deleted file mode 100755
index c5944ab..0000000
--- a/modules.d/40network/installkernel
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# Include wired net drivers, excluding wireless
-
-net_module_test() {
-    local net_drivers=3D'eth_type_trans|register_virtio_device'
-    local unwanted_drivers=3D'/(wireless|isdn|uwb)/'
-    egrep -q $net_drivers "$1" && \
-        egrep -qv 'iw_handler_get_spy' "$1" && \
-        [[ ! $1 =3D~ $unwanted_drivers ]]
-}
-
-instmods $(filter_kernel_modules net_module_test)
-
-instmods ecb arc4
-# bridge modules
-instmods bridge stp llc
-instmods ipv6
-# bonding
-instmods bonding
diff --git a/modules.d/40network/module-info.sh b/modules.d/40network/m=
odule-info.sh
new file mode 100755
index 0000000..cb8c5df
--- /dev/null
+++ b/modules.d/40network/module-info.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    . $dracutfunctions
+
+    for program in ip arping; do=20
+        if ! type -P $program >/dev/null; then
+            dwarning "Could not find program \"$program\" required by =
network."=20
+            return 1
+        fi
+    done
+    for program in dhclient brctl ifenslave tr; do
+        if ! type -P $program >/dev/null; then
+            dwarning "Could not find program \"$program\" it might be =
required by network."=20
+        fi
+    done
+
+    return 255
+}
+
+depends() {
+    [ -d /etc/sysconfig/network-scripts/ ] && echo ifcfg
+    return 0
+}
+
+installkernel() {
+    # Include wired net drivers, excluding wireless
+
+    net_module_test() {
+        local net_drivers=3D'eth_type_trans|register_virtio_device'
+        local unwanted_drivers=3D'/(wireless|isdn|uwb)/'
+        egrep -q $net_drivers "$1" && \
+            egrep -qv 'iw_handler_get_spy' "$1" && \
+            [[ ! $1 =3D~ $unwanted_drivers ]]
+    }
+
+    instmods $(filter_kernel_modules net_module_test)
+
+    instmods ecb arc4
+    # bridge modules
+    instmods bridge stp llc
+    instmods ipv6
+    # bonding
+    instmods bonding
+}
+
+install() {
+    dracut_install ip dhclient brctl arping ifenslave tr
+    inst "$moddir/ifup" "/sbin/ifup"
+    inst "$moddir/netroot" "/sbin/netroot"
+    inst "$moddir/dhclient-script" "/sbin/dhclient-script"
+    inst "$moddir/dhclient.conf" "/etc/dhclient.conf"=20
+    inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
+    inst_hook pre-udev 60 "$moddir/net-genrules.sh"
+    inst_hook cmdline 91 "$moddir/dhcp-root.sh"
+    inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
+    inst_hook cmdline 97 "$moddir/parse-bond.sh"
+    inst_hook cmdline 98 "$moddir/parse-bridge.sh"
+    inst_hook cmdline 99 "$moddir/parse-ifname.sh"
+    inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
+
+    arch=3D$(uname -m)
+
+    for dir in "$usrlibdir/tls/$arch" "$usrlibdir/tls" "$usrlibdir/$ar=
ch" \
+        "$usrlibdir" "$libdir"; do
+        for i in "$dir"/libnss_dns.so.* "$dir"/libnss_mdns4_minimal.so=
=2E*; do
+            [ -e "$i" ] && dracut_install "$i"
+        done
+    done
+
+}
+
diff --git a/modules.d/45ifcfg/check b/modules.d/45ifcfg/check
deleted file mode 100755
index 636df1d..0000000
--- a/modules.d/45ifcfg/check
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# ifcfg is required by network
-#[[ $1 =3D -d ]] && echo network
-
-exit 255
diff --git a/modules.d/45ifcfg/install b/modules.d/45ifcfg/install
deleted file mode 100755
index ba456c2..0000000
--- a/modules.d/45ifcfg/install
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst_hook pre-pivot 85 "$moddir/write-ifcfg.sh"
diff --git a/modules.d/98selinux/check b/modules.d/45ifcfg/module-info.=
sh
similarity index 51%
rename from modules.d/98selinux/check
rename to modules.d/45ifcfg/module-info.sh
index fa9ede2..3cd0c48 100755
--- a/modules.d/98selinux/check
+++ b/modules.d/45ifcfg/module-info.sh
@@ -2,10 +2,15 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
 # ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
=20
-[[ $1 =3D '-h' ]] && {
-    [ -x "/usr/sbin/load_policy" -o -x "/sbin/load_policy" ] || exit 1
-    exit 0
+check() {
+    return 255
 }
=20
-exit 0
+depends() {
+    return 0
+}
+
+install() {
+    inst_hook pre-pivot 85 "$moddir/write-ifcfg.sh"
+}
=20
diff --git a/modules.d/50gensplash/check b/modules.d/50gensplash/check
deleted file mode 100755
index eebce20..0000000
--- a/modules.d/50gensplash/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# TODO: splash_geninitramfs
-# TODO: /usr/share/splashutils/initrd.splash
-exit 255
diff --git a/modules.d/50gensplash/install b/modules.d/50gensplash/inst=
all
deleted file mode 100755
index 2f6dcc5..0000000
--- a/modules.d/50gensplash/install
+++ /dev/null
@@ -1,65 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-call_splash_geninitramfs() {
-    local out ret=20
-
-    out=3D$(splash_geninitramfs -c "$1" ${@:2} 2>&1)
-    ret=3D$?
-
-    if [[ ${out} ]]; then
-        local IFS=3D'
-'
-        for line in ${out}; do
-            if [[ ${line} =3D~ ^Warning ]]; then
-                dwarning "${line}"
-            else
-                derror "${line}"
-                (( ret =3D=3D 0 )) && ret=3D1
-            fi
-        done
-    fi
-
-    return ${ret}
-}
-
-
-type -P splash_geninitramfs >/dev/null || exit 1
-
-opts=3D''
-
-if [[ ${DRACUT_GENSPLASH_THEME} ]]; then
-    # Variables from the environment
-    # They're supposed to be set up by e.g. Genkernel in basis of cmdl=
ine args.
-    # If user set them he/she would expect to be included only given t=
heme
-    # rather then all even if we're building generic initramfs.
-    SPLASH_THEME=3D${DRACUT_GENSPLASH_THEME}
-    SPLASH_RES=3D${DRACUT_GENSPLASH_RES}
-elif [[ ${hostonly} ]]; then
-    # Settings from config only in hostonly
-    [[ -e /etc/conf.d/splash ]] && source /etc/conf.d/splash
-    [[ ! ${SPLASH_THEME} ]] && SPLASH_THEME=3Ddefault
-    [[ ${SPLASH_RES} ]] && opts+=3D" -r ${SPLASH_RES}"
-else
-    # generic
-    SPLASH_THEME=3D--all
-fi
-
-dinfo "Installing Gentoo Splash (using the ${SPLASH_THEME} theme)"
-
-pushd "${initdir}" >/dev/null
-mv dev dev.old
-call_splash_geninitramfs "${initdir}" ${opts} ${SPLASH_THEME} || {
-    derror "Could not build splash"
-    exit 1
-}
-rm -rf dev
-mv dev.old dev
-popd >/dev/null
-
-dracut_install chvt
-inst /usr/share/splashutils/initrd.splash /lib/gensplash-lib.sh
-inst_hook pre-pivot 90 "${moddir}"/gensplash-newroot.sh
-inst_hook pre-trigger 10 "${moddir}"/gensplash-pretrigger.sh
-inst_hook emergency 50 "${moddir}"/gensplash-emergency.sh
diff --git a/modules.d/50gensplash/module-info.sh b/modules.d/50genspla=
sh/module-info.sh
new file mode 100755
index 0000000..cdcdabd
--- /dev/null
+++ b/modules.d/50gensplash/module-info.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # TODO: splash_geninitramfs
+    # TODO: /usr/share/splashutils/initrd.splash
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    call_splash_geninitramfs() {
+        local out ret=20
+
+        out=3D$(splash_geninitramfs -c "$1" ${@:2} 2>&1)
+        ret=3D$?
+
+        if [[ ${out} ]]; then
+            local IFS=3D'
+'
+            for line in ${out}; do
+                if [[ ${line} =3D~ ^Warning ]]; then
+                    dwarning "${line}"
+                else
+                    derror "${line}"
+                    (( ret =3D=3D 0 )) && ret=3D1
+                fi
+            done
+        fi
+
+        return ${ret}
+    }
+
+
+    type -P splash_geninitramfs >/dev/null || return 1
+
+    opts=3D''
+
+    if [[ ${DRACUT_GENSPLASH_THEME} ]]; then
+        # Variables from the environment
+        # They're supposed to be set up by e.g. Genkernel in basis of =
cmdline args.
+        # If user set them he/she would expect to be included only giv=
en theme
+        # rather then all even if we're building generic initramfs.
+        SPLASH_THEME=3D${DRACUT_GENSPLASH_THEME}
+        SPLASH_RES=3D${DRACUT_GENSPLASH_RES}
+    elif [[ ${hostonly} ]]; then
+        # Settings from config only in hostonly
+        [[ -e /etc/conf.d/splash ]] && source /etc/conf.d/splash
+        [[ ! ${SPLASH_THEME} ]] && SPLASH_THEME=3Ddefault
+        [[ ${SPLASH_RES} ]] && opts+=3D" -r ${SPLASH_RES}"
+    else
+        # generic
+        SPLASH_THEME=3D--all
+    fi
+
+    dinfo "Installing Gentoo Splash (using the ${SPLASH_THEME} theme)"
+
+    pushd "${initdir}" >/dev/null
+    mv dev dev.old
+    call_splash_geninitramfs "${initdir}" ${opts} ${SPLASH_THEME} || {
+        derror "Could not build splash"
+        return 1
+    }
+    rm -rf dev
+    mv dev.old dev
+    popd >/dev/null
+
+    dracut_install chvt
+    inst /usr/share/splashutils/initrd.splash /lib/gensplash-lib.sh
+    inst_hook pre-pivot 90 "${moddir}"/gensplash-newroot.sh
+    inst_hook pre-trigger 10 "${moddir}"/gensplash-pretrigger.sh
+    inst_hook emergency 50 "${moddir}"/gensplash-emergency.sh
+}
diff --git a/modules.d/50plymouth/check b/modules.d/50plymouth/check
deleted file mode 100755
index f11c9fd..0000000
--- a/modules.d/50plymouth/check
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-[[ $1 =3D -d ]] && type -P cryptsetup >/dev/null && echo crypt
-[[ -x /sbin/plymouthd && -x /bin/plymouth && -x /usr/sbin/plymouth-set=
-default-theme ]]
diff --git a/modules.d/50plymouth/install b/modules.d/50plymouth/instal=
l
deleted file mode 100755
index 7a0c237..0000000
--- a/modules.d/50plymouth/install
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-if grep -q nash /usr/libexec/plymouth/plymouth-populate-initrd \
-    || ! grep -q PLYMOUTH_POPULATE_SOURCE_FUNCTIONS /usr/libexec/plymo=
uth/plymouth-populate-initrd \
-    || [ ! -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
-    . "$moddir"/plymouth-populate-initrd
-else
-    PLYMOUTH_POPULATE_SOURCE_FUNCTIONS=3D"$dracutfunctions" \
-        /usr/libexec/plymouth/plymouth-populate-initrd -t $initdir
-fi
-
-inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
-inst_hook pre-trigger 10 "$moddir"/plymouth-pretrigger.sh
-inst_hook emergency 50 "$moddir"/plymouth-emergency.sh
-inst readlink
diff --git a/modules.d/50plymouth/installkernel b/modules.d/50plymouth/=
installkernel
deleted file mode 100755
index 61a8dfb..0000000
--- a/modules.d/50plymouth/installkernel
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-# Include KMS capable drm drivers
-for modname in $(find "$srcmods/kernel/drivers/gpu/drm" "$srcmods/extr=
a" -name '*.ko' 2>/dev/null); do
-    grep -q drm_crtc_init  $modname && instmods $modname
-done
diff --git a/modules.d/50plymouth/module-info.sh b/modules.d/50plymouth=
/module-info.sh
new file mode 100755
index 0000000..9a62617
--- /dev/null
+++ b/modules.d/50plymouth/module-info.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    [[ -x /sbin/plymouthd && -x /bin/plymouth && -x /usr/sbin/plymouth=
-set-default-theme ]]
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    # Include KMS capable drm drivers
+    for modname in $(find "$srcmods/kernel/drivers/gpu/drm" "$srcmods/=
extra" -name '*.ko' 2>/dev/null); do
+        grep -q drm_crtc_init  $modname && instmods $modname
+    done
+}
+
+install() {
+    if grep -q nash /usr/libexec/plymouth/plymouth-populate-initrd \
+        || ! grep -q PLYMOUTH_POPULATE_SOURCE_FUNCTIONS /usr/libexec/p=
lymouth/plymouth-populate-initrd \
+        || [ ! -x /usr/libexec/plymouth/plymouth-populate-initrd ]; th=
en
+        . "$moddir"/plymouth-populate-initrd
+    else
+        PLYMOUTH_POPULATE_SOURCE_FUNCTIONS=3D"$dracutfunctions" \
+            /usr/libexec/plymouth/plymouth-populate-initrd -t $initdir
+    fi
+
+    inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
+    inst_hook pre-trigger 10 "$moddir"/plymouth-pretrigger.sh
+    inst_hook emergency 50 "$moddir"/plymouth-emergency.sh
+    inst readlink
+}
+
diff --git a/modules.d/60xen/check b/modules.d/60xen/check
deleted file mode 100755
index 55129ac..0000000
--- a/modules.d/60xen/check
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# No Xen-detect? Boo!!
-if ! hash xen-detect 2>/dev/null; then
-    [[ -d /usr/lib/xen-default ]] && \
-        hash -p /usr/lib/xen-default/bin/xen-detect xen-detect || exit=
 1
-fi
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-# Yes, we are under Xen PV env.
-xen-detect | grep -q -v PV || exit 0
-
-exit 1
diff --git a/modules.d/60xen/install b/modules.d/60xen/install
deleted file mode 100755
index 08f3f0a..0000000
--- a/modules.d/60xen/install
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-hash xen-detect 2>/dev/null || \
-    hash -p /usr/lib/xen-default/bin/xen-detect xen-detect
-inst "$(hash -t xen-detect)" /sbin/xen-detect
-inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
diff --git a/modules.d/60xen/installkernel b/modules.d/60xen/installker=
nel
deleted file mode 100755
index 7c1ffd5..0000000
--- a/modules.d/60xen/installkernel
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-for i in \
-    xenbus_probe_frontend xen-pcifront \
-    xen-fbfront xen-kbdfront xen-blkfront xen-netfront \
-    ; do
-    modinfo -k $kernel $i >/dev/null 2>&1 && instmods $i
-done
-
diff --git a/modules.d/60xen/module-info.sh b/modules.d/60xen/module-in=
fo.sh
new file mode 100755
index 0000000..52b2050
--- /dev/null
+++ b/modules.d/60xen/module-info.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # No Xen-detect? Boo!!
+    if ! hash xen-detect 2>/dev/null; then
+        [[ -d /usr/lib/xen-default ]] && \
+            hash -p /usr/lib/xen-default/bin/xen-detect xen-detect || =
return 1
+    fi
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    # Yes, we are under Xen PV env.
+    xen-detect | grep -q -v PV || return 0
+
+    return 1
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    for i in \
+        xenbus_probe_frontend xen-pcifront \
+        xen-fbfront xen-kbdfront xen-blkfront xen-netfront \
+        ; do
+        modinfo -k $kernel $i >/dev/null 2>&1 && instmods $i
+    done
+
+}
+
+install() {
+    hash xen-detect 2>/dev/null || \
+        hash -p /usr/lib/xen-default/bin/xen-detect xen-detect
+    inst "$(hash -t xen-detect)" /sbin/xen-detect
+    inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
+}
+
diff --git a/modules.d/90btrfs/check b/modules.d/90btrfs/check
deleted file mode 100755
index 03c5293..0000000
--- a/modules.d/90btrfs/check
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on udev-rules being loaded
-[[ "$1" =3D "-d" ]] && exit 0
-
-# if we don't have btrfs (btrfsctl) installed on the host system,
-# no point in trying to support it in the initramfs.
-type -P btrfsctl >/dev/null || exit 1
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-is_btrfs() { get_fs_type /dev/block/$1 |grep -q btrfs; }
-
-if [[ "$1" =3D "-h" ]]; then
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        is_btrfs "$rootdev" || exit 1
-    fi
-fi
-
-exit 0
diff --git a/modules.d/90btrfs/install b/modules.d/90btrfs/install
deleted file mode 100755
index e4858e2..0000000
--- a/modules.d/90btrfs/install
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_rules "$moddir/80-btrfs.rules"
-dracut_install btrfsctl
diff --git a/modules.d/90btrfs/module-info.sh b/modules.d/90btrfs/modul=
e-info.sh
new file mode 100755
index 0000000..0503e1d
--- /dev/null
+++ b/modules.d/90btrfs/module-info.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # if we don't have btrfs (btrfsctl) installed on the host system,
+    # no point in trying to support it in the initramfs.
+    type -P btrfsctl >/dev/null || return 1
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    is_btrfs() { get_fs_type /dev/block/$1 | grep -q btrfs; }
+
+    if [[ $hostonly ]]; then
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            is_btrfs "$rootdev" || return 1
+        fi
+    fi
+
+    return 0
+}
+
+depends() {
+    echo udev-rules
+    return 0
+}
+
+install() {
+    inst_rules "$moddir/80-btrfs.rules"
+    dracut_install btrfsctl
+}
+
diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
deleted file mode 100755
index 3ac8076..0000000
--- a/modules.d/90crypt/check
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# if cryptsetup is not installed, then we cannot support encrypted dev=
ices.
-type -P cryptsetup >/dev/null || exit 1
-
-[ "$1" =3D "-d" ] && echo dm
-
-. $dracutfunctions
-
-is_crypt() { [[ $(get_fs_type /dev/block/$1) =3D crypto_LUKS ]]; }
-
-[[ $1 =3D '-h' ]] && {
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        # root lives on a block device, so we can be more precise abou=
t=20
-        # hostonly checking
-        check_block_and_slaves is_crypt "$rootdev" || exit 1
-    else
-        # root is not on a block device, use the shotgun approach
-        blkid | grep -q crypto\?_LUKS || exit 1
-    fi
-}
-
-exit 0
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
deleted file mode 100755
index 12b3555..0000000
--- a/modules.d/90crypt/install
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst cryptsetup=20
-inst rmdir
-inst readlink
-inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
-inst "$moddir"/probe-keydev.sh /sbin/probe-keydev
-inst_hook cmdline 10 "$moddir/parse-keydev.sh"
-inst_hook cmdline 30 "$moddir/parse-crypt.sh"
-inst_hook pre-pivot 30 "$moddir/crypt-cleanup.sh"
-inst /etc/crypttab
-inst "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
diff --git a/modules.d/90crypt/installkernel b/modules.d/90crypt/instal=
lkernel
deleted file mode 100755
index f41e5ac..0000000
--- a/modules.d/90crypt/installkernel
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-instmods dm_crypt cbc sha256 xts aes aes_generic aesni-intel aes-x86_6=
4 fpu
-
diff --git a/modules.d/90crypt/module-info.sh b/modules.d/90crypt/modul=
e-info.sh
new file mode 100755
index 0000000..5b435e5
--- /dev/null
+++ b/modules.d/90crypt/module-info.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # if cryptsetup is not installed, then we cannot support encrypted=
 devices.
+    type -P cryptsetup >/dev/null || return 1
+
+    . $dracutfunctions
+
+    is_crypt() { [[ $(get_fs_type /dev/block/$1) =3D crypto_LUKS ]]; }
+
+    [[ $hostonly ]] && {
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            # root lives on a block device, so we can be more precise =
about=20
+            # hostonly checking
+            check_block_and_slaves is_crypt "$rootdev" || return 1
+        else
+            # root is not on a block device, use the shotgun approach
+            blkid | grep -q crypto\?_LUKS || return 1
+        fi
+    }
+
+    return 0
+}
+
+depends() {
+    echo dm rootfs-block
+    return 0
+}
+
+installkernel() {
+    instmods dm_crypt cbc sha256 xts aes aes_generic aesni-intel aes-x=
86_64 fpu
+
+}
+
+install() {
+    inst cryptsetup=20
+    inst rmdir
+    inst readlink
+    inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
+    inst "$moddir"/probe-keydev.sh /sbin/probe-keydev
+    inst_hook cmdline 10 "$moddir/parse-keydev.sh"
+    inst_hook cmdline 30 "$moddir/parse-crypt.sh"
+    inst_hook pre-pivot 30 "$moddir/crypt-cleanup.sh"
+    inst /etc/crypttab
+    inst "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
+}
+
diff --git a/modules.d/90dm/check b/modules.d/90dm/check
deleted file mode 100755
index 3a95d01..0000000
--- a/modules.d/90dm/check
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-exit 255
-
diff --git a/modules.d/90dm/install b/modules.d/90dm/install
deleted file mode 100755
index b2080e5..0000000
--- a/modules.d/90dm/install
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-modinfo -k $kernel dm_mod >/dev/null 2>&1 && \
-    inst_hook pre-udev 30 "$moddir/dm-pre-udev.sh"
-
-inst dmsetup
-
-type -P dmeventd >/dev/null && dracut_install dmeventd
-inst_rules 10-dm.rules 95-dm-notify.rules
diff --git a/modules.d/90dm/installkernel b/modules.d/90dm/installkerne=
l
deleted file mode 100755
index f9fdfcb..0000000
--- a/modules.d/90dm/installkernel
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-instmods =3Ddrivers/md
-
-
diff --git a/modules.d/90dm/module-info.sh b/modules.d/90dm/module-info=
=2Esh
new file mode 100755
index 0000000..11985fd
--- /dev/null
+++ b/modules.d/90dm/module-info.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    instmods =3Ddrivers/md
+}
+
+install() {
+    modinfo -k $kernel dm_mod >/dev/null 2>&1 && \
+        inst_hook pre-udev 30 "$moddir/dm-pre-udev.sh"
+
+    inst dmsetup
+
+    type -P dmeventd >/dev/null && dracut_install dmeventd
+    inst_rules 10-dm.rules 95-dm-notify.rules
+}
+
diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
deleted file mode 100755
index fd7dde7..0000000
--- a/modules.d/90dmraid/check
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on dm_mod being loaded
-[ "$1" =3D "-d" ] && echo dm
-
-# if we don't have dmraid installed on the host system, no point
-# in trying to support it in the initramfs.
-type -P dmraid >/dev/null || exit 1
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-is_dmraid() { get_fs_type /dev/block/$1 |grep -v linux_raid_member | \
-    grep -q _raid_member; }
-
-[[ $1 =3D '-h' ]] && {
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        # root lives on a block device, so we can be more precise abou=
t=20
-        # hostonly checking
-        check_block_and_slaves is_dmraid "$rootdev" || exit 1
-    else
-        # root is not on a block device, use the shotgun approach
-        dmraid -r | grep -q ok || exit 1
-    fi
-}
-
-exit 0
diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
deleted file mode 100755
index 7626bdc..0000000
--- a/modules.d/90dmraid/install
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install dmraid partx kpartx=20
-
-inst  dmeventd
-
-for i in {"$libdir","$usrlibdir"}/libdmraid-events*.so; do
-    [ -e "$i" ] && dracut_install "$i"
-done
-
-inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules=20
-
-inst "$moddir/dmraid.sh" /sbin/dmraid_scan
-
-if [ ! -x /lib/udev/vol_id ]; then
-    inst_rules 64-md-raid.rules
-fi
-
-inst_rules "$moddir/61-dmraid-imsm.rules"
-inst "$moddir/dmraid-cleanup.sh" /sbin/dmraid-cleanup
-inst_hook pre-trigger 30 "$moddir/parse-dm.sh"
-
diff --git a/modules.d/90dmraid/module-info.sh b/modules.d/90dmraid/mod=
ule-info.sh
new file mode 100755
index 0000000..f437712
--- /dev/null
+++ b/modules.d/90dmraid/module-info.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # if we don't have dmraid installed on the host system, no point
+    # in trying to support it in the initramfs.
+    type -P dmraid >/dev/null || return 1
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    is_dmraid() { get_fs_type /dev/block/$1 |grep -v linux_raid_member=
 | \
+        grep -q _raid_member; }
+
+    [[ $hostonly ]] && {
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+        # root lives on a block device, so we can be more precise abou=
t=20
+        # hostonly checking
+            check_block_and_slaves is_dmraid "$rootdev" || return 1
+        else
+        # root is not on a block device, use the shotgun approach
+            dmraid -r | grep -q ok || return 1
+        fi
+    }
+
+    return 0
+}
+
+depends() {
+    echo dm rootfs-block
+    return 0
+}
+
+install() {
+    dracut_install dmraid partx kpartx=20
+
+    inst  dmeventd
+
+    for i in {"$libdir","$usrlibdir"}/libdmraid-events*.so; do
+        [ -e "$i" ] && dracut_install "$i"
+    done
+
+    inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules=20
+
+    inst "$moddir/dmraid.sh" /sbin/dmraid_scan
+
+    if [ ! -x /lib/udev/vol_id ]; then
+        inst_rules 64-md-raid.rules
+    fi
+
+    inst_rules "$moddir/61-dmraid-imsm.rules"
+    inst "$moddir/dmraid-cleanup.sh" /sbin/dmraid-cleanup
+    inst_hook pre-trigger 30 "$moddir/parse-dm.sh"
+
+}
+
diff --git a/modules.d/90dmsquash-live/check b/modules.d/90dmsquash-liv=
e/check
deleted file mode 100755
index c25b2b8..0000000
--- a/modules.d/90dmsquash-live/check
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# if dmsetup is not installed, then we cannot support fedora/red hat=20
-# style live images
-if [ "$1" =3D "-d" ]; then
-    echo dm
-    exit 0
-fi
-
-# a live host-only image doesn't really make a lot of sense
-if [ "$1" =3D "-h" ] ; then
-    exit 1
-fi
-
-exit 0
diff --git a/modules.d/90dmsquash-live/install b/modules.d/90dmsquash-l=
ive/install
deleted file mode 100755
index ddbc90c..0000000
--- a/modules.d/90dmsquash-live/install
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install umount
-inst dmsetup
-inst blkid
-inst dd
-inst losetup
-inst grep
-
-# eject might be a symlink to consolehelper
-if [ -L /usr/bin/eject ]; then
-    dracut_install /usr/sbin/eject
-else
-    inst eject
-fi
-
-inst blockdev
-type -P checkisomd5 >/dev/null && inst checkisomd5
-inst_hook cmdline 30 "$moddir/parse-dmsquash-live.sh"
-inst_hook pre-udev 30 "$moddir/dmsquash-live-genrules.sh"
-inst_hook pre-udev 30 "$moddir/dmsquash-liveiso-genrules.sh"
-inst "$moddir/dmsquash-live-root" "/sbin/dmsquash-live-root"
-# should probably just be generally included
-inst_rules 60-cdrom_id.rules
diff --git a/modules.d/90dmsquash-live/module-info.sh b/modules.d/90dms=
quash-live/module-info.sh
new file mode 100755
index 0000000..2f46f67
--- /dev/null
+++ b/modules.d/90dmsquash-live/module-info.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # a live host-only image doesn't really make a lot of sense
+    [[ $hostonly ]] && return 1
+    return 0
+}
+
+depends() {
+    # if dmsetup is not installed, then we cannot support fedora/red h=
at=20
+    # style live images
+    echo dm rootfs-block
+    return 0
+}
+
+install() {
+    dracut_install umount
+    inst dmsetup
+    inst blkid
+    inst dd
+    inst losetup
+    inst grep
+
+    # eject might be a symlink to consolehelper
+    if [ -L /usr/bin/eject ]; then
+        dracut_install /usr/sbin/eject
+    else
+        inst eject
+    fi
+
+    inst blockdev
+    type -P checkisomd5 >/dev/null && inst checkisomd5
+    inst_hook cmdline 30 "$moddir/parse-dmsquash-live.sh"
+    inst_hook pre-udev 30 "$moddir/dmsquash-live-genrules.sh"
+    inst_hook pre-udev 30 "$moddir/dmsquash-liveiso-genrules.sh"
+    inst "$moddir/dmsquash-live-root" "/sbin/dmsquash-live-root"
+    # should probably just be generally included
+    inst_rules 60-cdrom_id.rules
+}
+
diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-mo=
dules/install
deleted file mode 100755
index b635216..0000000
--- a/modules.d/90kernel-modules/install
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-[ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
-dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
-inst_hook cmdline 01 "$moddir/parse-kernel.sh"
-inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.buil=
tin.bin"
diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90ker=
nel-modules/installkernel
deleted file mode 100755
index 4581668..0000000
--- a/modules.d/90kernel-modules/installkernel
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-if [[ -z $drivers ]]; then
-    block_module_test() {
-        local blockfuncs=3D'ahci_init_controller|ata_scsi_ioctl|scsi_a=
dd_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register=
_virtio_device'
-
-        egrep -q "$blockfuncs" "$1"
-    }
-    hostonly=3D'' instmods sr_mod sd_mod scsi_dh scsi_dh_rdac scsi_dh_=
emc
-    hostonly=3D'' instmods pcmcia firewire-ohci
-    hostonly=3D'' instmods usb_storage sdhci sdhci-pci
-
-    # install keyboard support
-    hostonly=3D'' instmods atkbd i8042 usbhid hid-apple hid-sunplus eh=
ci-hcd ohci-hcd uhci-hcd
-
-    instmods "=3Ddrivers/pcmcia" =3Dide "=3Ddrivers/usb/storage"
-    instmods $(filter_kernel_modules block_module_test)=20
-    # if not on hostonly mode, install all known filesystems if the re=
quired list is not set via the filesystems variable
-    if ! [[ $hostonly ]]; then
-        if [[ -z $filesystems ]]; then
-            instmods '=3Dfs'
-            # hardcoded list of exceptions
-            # to save a lot of space
-            rm -fr ${initdir}/lib/modules/*/kernel/fs/ocfs2
-        else
-            instmods $filesystems
-        fi
-    else
-        hostonly=3D'' instmods $(get_fs_type "/dev/block/$(find_root_b=
lock_device)")
-    fi
-else
-    hostonly=3D'' instmods $drivers $filesystems
-fi
-
-[[ $add_drivers ]] && hostonly=3D'' instmods $add_drivers
-
-# force install of scsi_wait_scan
-hostonly=3D'' instmods scsi_wait_scan
-
diff --git a/modules.d/90kernel-modules/module-info.sh b/modules.d/90ke=
rnel-modules/module-info.sh
new file mode 100755
index 0000000..342e650
--- /dev/null
+++ b/modules.d/90kernel-modules/module-info.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+installkernel() {
+    if [[ -z $drivers ]]; then
+        block_module_test() {
+            local blockfuncs=3D'ahci_init_controller|ata_scsi_ioctl|sc=
si_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|regi=
ster_virtio_device'
+
+            egrep -q "$blockfuncs" "$1"
+        }
+        hostonly=3D'' instmods sr_mod sd_mod scsi_dh scsi_dh_rdac scsi=
_dh_emc
+        hostonly=3D'' instmods pcmcia firewire-ohci
+        hostonly=3D'' instmods usb_storage sdhci sdhci-pci
+
+        # install keyboard support
+        hostonly=3D'' instmods atkbd i8042 usbhid hid-apple hid-sunplu=
s ehci-hcd ohci-hcd uhci-hcd
+
+        instmods "=3Ddrivers/pcmcia" =3Dide "=3Ddrivers/usb/storage"
+        instmods $(filter_kernel_modules block_module_test)=20
+        # if not on hostonly mode, install all known filesystems,
+        # if the required list is not set via the filesystems variable
+        if ! [[ $hostonly ]]; then
+            if [[ -z $filesystems ]]; then
+                instmods '=3Dfs'
+                # hardcoded list of exceptions
+                # to save a lot of space
+                rm -fr ${initdir}/lib/modules/*/kernel/fs/ocfs2
+            else
+                instmods $filesystems
+            fi
+        else
+            hostonly=3D'' instmods $(get_fs_type "/dev/block/$(find_ro=
ot_block_device)")
+        fi
+    else
+        hostonly=3D'' instmods $drivers $filesystems
+    fi
+
+    [[ $add_drivers ]] && hostonly=3D'' instmods $add_drivers
+
+    # force install of scsi_wait_scan
+    hostonly=3D'' instmods scsi_wait_scan
+}
+
+install() {
+    [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
+    dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
+    inst_hook cmdline 01 "$moddir/parse-kernel.sh"
+    inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.=
builtin.bin"
+}
diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
deleted file mode 100755
index c211064..0000000
--- a/modules.d/90lvm/check
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on dm_mod being loaded
-[ "$1" =3D "-d" ] && echo dm
-
-# No point trying to support lvm if the binaries are missing
-type -P lvm >/dev/null || exit 1
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-is_lvm() { [[ $(get_fs_type /dev/block/$1) =3D LVM2_member ]]; }
-
-[[ $1 =3D '-h' ]] && {
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        # root lives on a block device, so we can be more precise abou=
t=20
-        # hostonly checking
-        check_block_and_slaves is_lvm "$rootdev" || exit 1
-    else
-        # root is not on a block device, use the shotgun approach
-        blkid | grep -q LVM2_member || exit 1
-    fi
-}
-
-exit 0
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
deleted file mode 100755
index 8c40990..0000000
--- a/modules.d/90lvm/install
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst lvm
-
-inst_rules "$moddir/64-lvm.rules"=20
-
-if [[ $hostonly ]] || [[ $lvmconf =3D "yes" ]]; then=20
-    if [ -f /etc/lvm/lvm.conf ]; then
-        inst /etc/lvm/lvm.conf
-        # FIXME: near-term hack to establish read-only locking;
-        # use command-line lvm.conf editor once it is available
-        sed -i -e 's/\(^[[:space:]]*\)locking_type[[:space:]]*=3D[[:sp=
ace:]]*[[:digit:]]/\1locking_type =3D 4/' ${initdir}/etc/lvm/lvm.conf
-    fi
-fi
-
-inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules 11-dm-lvm.r=
ules
-
-inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
-inst_hook cmdline 30 "$moddir/parse-lvm.sh"
-
-for i in {"$libdir","$usrlibdir"}/libdevmapper-event-lvm*.so; do
-    [ -e "$i" ] && dracut_install "$i"
-done
diff --git a/modules.d/90lvm/module-info.sh b/modules.d/90lvm/module-in=
fo.sh
new file mode 100755
index 0000000..2555728
--- /dev/null
+++ b/modules.d/90lvm/module-info.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # No point trying to support lvm if the binaries are missing
+    type -P lvm >/dev/null || return 1
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    is_lvm() { [[ $(get_fs_type /dev/block/$1) =3D LVM2_member ]]; }
+
+    [[ $hostonly ]] && {
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            # root lives on a block device, so we can be more precise =
about=20
+            # hostonly checking
+            check_block_and_slaves is_lvm "$rootdev" || return 1
+        else
+            # root is not on a block device, use the shotgun approach
+            blkid | grep -q LVM2_member || return 1
+        fi
+    }
+
+    return 0
+}
+
+depends() {
+    # We depend on dm_mod being loaded
+    echo rootfs-block dm
+    return 0
+}
+
+install() {
+    inst lvm
+
+    inst_rules "$moddir/64-lvm.rules"=20
+
+    if [[ $hostonly ]] || [[ $lvmconf =3D "yes" ]]; then=20
+        if [ -f /etc/lvm/lvm.conf ]; then
+            inst /etc/lvm/lvm.conf
+            # FIXME: near-term hack to establish read-only locking;
+            # use command-line lvm.conf editor once it is available
+            sed -i -e 's/\(^[[:space:]]*\)locking_type[[:space:]]*=3D[=
[:space:]]*[[:digit:]]/\1locking_type =3D 4/' ${initdir}/etc/lvm/lvm.co=
nf
+        fi
+    fi
+
+    inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules 11-dm-l=
vm.rules
+
+    inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
+    inst_hook cmdline 30 "$moddir/parse-lvm.sh"
+
+    for i in {"$libdir","$usrlibdir"}/libdevmapper-event-lvm*.so; do
+        [ -e "$i" ] && dracut_install "$i"
+    done
+}
+
diff --git a/modules.d/90mdraid/check b/modules.d/90mdraid/check
deleted file mode 100755
index 6996d84..0000000
--- a/modules.d/90mdraid/check
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# No mdadm?  No mdraid support.
-type -P mdadm >/dev/null || exit 1
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-is_mdraid() { [[ -d "/sys/dev/block/$1/md" ]]; }
-
-[[ $1 =3D '-h' ]] && {
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        # root lives on a block device, so we can be more precise abou=
t=20
-        # hostonly checking
-        check_block_and_slaves is_mdraid "$rootdev" || exit 1
-    else
-        # root is not on a block device, use the shotgun approach
-        blkid | egrep -q '(linux|isw)_raid' || exit 1
-    fi
-}
-
-exit 0
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
deleted file mode 100755
index 80abda3..0000000
--- a/modules.d/90mdraid/install
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-dracut_install mdadm partx=20
-
-
-# XXX: mdmon really needs to run as non-root?
-#      If so, write only the user it needs in the initrd's /etc/passwd=
 (and maybe /etc/group)
-#      in a similar fashion to modules.d/95nfs.  Do not copy /etc/pass=
wd and /etc/group from=20
-#      the system into the initrd.
-#      dledford has hardware to test this, so he should be able to cle=
an this up.
-# inst /etc/passwd
-# inst /etc/group
-
-if [ ! -x /lib/udev/vol_id ]; then
-    inst_rules 64-md-raid.rules
-fi
-
-inst_rules "$moddir/65-md-incremental-imsm.rules"
-
-if ! mdadm -Q -e imsm /dev/null &> /dev/null; then   =20
-    inst_hook pre-trigger 30 "$moddir/md-noimsm.sh"
-fi
-
-if [[ $hostonly ]] || [[ $mdadmconf =3D "yes" ]]; then=20
-    if [ -f /etc/mdadm.conf ]; then
-        inst /etc/mdadm.conf
-    else
-        [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /et=
c/mdadm.conf
-    fi
-fi
-
-if [ -x  /sbin/mdmon ] ; then
-    dracut_install mdmon
-fi=20
-inst_hook pre-udev 30 "$moddir/mdmon-pre-udev.sh"
-
-inst "$moddir/mdraid_start.sh" /sbin/mdraid_start
-inst "$moddir/mdcontainer_start.sh" /sbin/mdcontainer_start
-inst "$moddir/mdadm_auto.sh" /sbin/mdadm_auto
-inst "$moddir/md_finished.sh" /sbin/md_finished.sh
-inst_hook pre-trigger 30 "$moddir/parse-md.sh"
-inst "$moddir/mdraid-cleanup.sh" /sbin/mdraid-cleanup
diff --git a/modules.d/90mdraid/installkernel b/modules.d/90mdraid/inst=
allkernel
deleted file mode 100755
index 679ac8e..0000000
--- a/modules.d/90mdraid/installkernel
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-instmods =3Ddrivers/md
-
diff --git a/modules.d/90mdraid/module-info.sh b/modules.d/90mdraid/mod=
ule-info.sh
new file mode 100755
index 0000000..8f69822
--- /dev/null
+++ b/modules.d/90mdraid/module-info.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # No mdadm?  No mdraid support.
+    type -P mdadm >/dev/null || return 1
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    is_mdraid() { [[ -d "/sys/dev/block/$1/md" ]]; }
+
+    [[ $hostonly ]] && {
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            # root lives on a block device, so we can be more precise =
about=20
+            # hostonly checking
+            check_block_and_slaves is_mdraid "$rootdev" || return 1
+        else
+            # root is not on a block device, use the shotgun approach
+            blkid | egrep -q '(linux|isw)_raid' || return 1
+        fi
+    }
+
+    return 0
+}
+
+depends() {
+    echo rootfs-block
+    return 0
+}
+
+installkernel() {
+    instmods =3Ddrivers/md
+}
+
+install() {
+    dracut_install mdadm partx=20
+
+
+     # XXX: mdmon really needs to run as non-root?
+     #      If so, write only the user it needs in the initrd's /etc/p=
asswd (and maybe /etc/group)
+     #      in a similar fashion to modules.d/95nfs.  Do not copy /etc=
/passwd and /etc/group from=20
+     #      the system into the initrd.
+     #      dledford has hardware to test this, so he should be able t=
o clean this up.
+     # inst /etc/passwd
+     # inst /etc/group
+
+    if [ ! -x /lib/udev/vol_id ]; then
+        inst_rules 64-md-raid.rules
+    fi
+
+    inst_rules "$moddir/65-md-incremental-imsm.rules"
+
+    if ! mdadm -Q -e imsm /dev/null &> /dev/null; then   =20
+        inst_hook pre-trigger 30 "$moddir/md-noimsm.sh"
+    fi
+
+    if [[ $hostonly ]] || [[ $mdadmconf =3D "yes" ]]; then=20
+        if [ -f /etc/mdadm.conf ]; then
+            inst /etc/mdadm.conf
+        else
+            [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf=
 /etc/mdadm.conf
+        fi
+    fi
+
+    if [ -x  /sbin/mdmon ] ; then
+        dracut_install mdmon
+    fi=20
+    inst_hook pre-udev 30 "$moddir/mdmon-pre-udev.sh"
+
+    inst "$moddir/mdraid_start.sh" /sbin/mdraid_start
+    inst "$moddir/mdcontainer_start.sh" /sbin/mdcontainer_start
+    inst "$moddir/mdadm_auto.sh" /sbin/mdadm_auto
+    inst "$moddir/md_finished.sh" /sbin/md_finished.sh
+    inst_hook pre-trigger 30 "$moddir/parse-md.sh"
+    inst "$moddir/mdraid-cleanup.sh" /sbin/mdraid-cleanup
+}
+
diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
deleted file mode 100755
index 39d1fd2..0000000
--- a/modules.d/90multipath/check
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# if there's no multipath binary, no go.
-type -P multipath >/dev/null || exit 1
-
-[[ $1 =3D -d ]] && exit 0
-
-. $dracutfunctions
-[[ $debug ]] && set -x
-
-is_mpath() {
-    [ -e /sys/dev/block/$1/dm/uuid ] || return 1
-    [[ $(cat /sys/dev/block/$1/dm/uuid) =3D~ ^mpath- ]] && return 0
-    return 1
-}
-
-if [[ $1 =3D -h ]]; then
-    rootdev=3D$(find_root_block_device)
-    if [[ $rootdev ]]; then
-        check_block_and_slaves is_mpath "$rootdev" && exit 0
-    fi
-    exit 1
-fi
-
-exit 0
diff --git a/modules.d/90multipath/install b/modules.d/90multipath/inst=
all
deleted file mode 100755
index 57ac690..0000000
--- a/modules.d/90multipath/install
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-for f in  \
-    /sbin/dmsetup \
-    /sbin/kpartx \
-    /sbin/mpath_wait \
-    /sbin/multipath  \
-    /sbin/multipathd \
-    /sbin/xdrgetuid \
-    /sbin/xdrgetprio \
-    /etc/xdrdevices.conf \
-    /etc/multipath.conf \
-    /etc/multipath/* \
-    "$libdir"/libmultipath* "$libdir"/multipath/*; do
-    [ -e "$f" ] && inst "$f"
-done
-
-inst_hook pre-trigger 02 "$moddir/multipathd.sh"
-inst_hook pre-pivot   02 "$moddir/multipathd-stop.sh"
-inst_rules 40-multipath.rules
diff --git a/modules.d/90multipath/installkernel b/modules.d/90multipat=
h/installkernel
deleted file mode 100755
index dbbbd27..0000000
--- a/modules.d/90multipath/installkernel
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-mp_mod_test() {
-    local mpfuncs=3D'scsi_register_device_handler|dm_dirty_log_type_re=
gister|dm_register_path_selector|dm_register_target'
-    egrep -q "$mpfuncs" "$1"
-}
-
-instmods $(filter_kernel_modules mp_mod_test)
diff --git a/modules.d/90multipath/module-info.sh b/modules.d/90multipa=
th/module-info.sh
new file mode 100755
index 0000000..f78517c
--- /dev/null
+++ b/modules.d/90multipath/module-info.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # if there's no multipath binary, no go.
+    type -P multipath >/dev/null || return 1
+
+    . $dracutfunctions
+    [[ $debug ]] && set -x
+
+    is_mpath() {
+        [ -e /sys/dev/block/$1/dm/uuid ] || return 1
+        [[ $(cat /sys/dev/block/$1/dm/uuid) =3D~ ^mpath- ]] && return =
0
+        return 1
+    }
+
+    if [[ $hostonly ]]; then
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            check_block_and_slaves is_mpath "$rootdev" && return 0
+        fi
+        return 1
+    fi
+
+    return 0
+}
+
+depends() {
+    echo rootfs-block
+    return 0
+}
+
+installkernel() {
+    mp_mod_test() {
+        local mpfuncs=3D'scsi_register_device_handler|dm_dirty_log_typ=
e_register|dm_register_path_selector|dm_register_target'
+        egrep -q "$mpfuncs" "$1"
+    }
+
+    instmods $(filter_kernel_modules mp_mod_test)
+}
+
+install() {
+    for f in  \
+        /sbin/dmsetup \
+        /sbin/kpartx \
+        /sbin/mpath_wait \
+        /sbin/multipath  \
+        /sbin/multipathd \
+        /sbin/xdrgetuid \
+        /sbin/xdrgetprio \
+        /etc/xdrdevices.conf \
+        /etc/multipath.conf \
+        /etc/multipath/* \
+        "$libdir"/libmultipath* "$libdir"/multipath/*; do
+        [ -e "$f" ] && inst "$f"
+    done
+
+    inst_hook pre-trigger 02 "$moddir/multipathd.sh"
+    inst_hook pre-pivot   02 "$moddir/multipathd-stop.sh"
+    inst_rules 40-multipath.rules
+}
+
diff --git a/modules.d/95dasd/check b/modules.d/95dasd/check
deleted file mode 100755
index d9b6117..0000000
--- a/modules.d/95dasd/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-arch=3D$(uname -m)
-[ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || exit 1
-
-exit 0
diff --git a/modules.d/95dasd/install b/modules.d/95dasd/install
deleted file mode 100755
index 54503db..0000000
--- a/modules.d/95dasd/install
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst_hook cmdline 30 "$moddir/parse-dasd.sh"
-dracut_install tr dasdinfo dasdconf.sh
-if [[ $hostonly ]]; then
-    inst /etc/dasd.conf
-fi
-inst_rules 56-dasd.rules
-inst_rules 59-dasd.rules
diff --git a/modules.d/95dasd/installkernel b/modules.d/95dasd/installk=
ernel
deleted file mode 100755
index 450f06e..0000000
--- a/modules.d/95dasd/installkernel
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
-
diff --git a/modules.d/95dasd/module-info.sh b/modules.d/95dasd/module-=
info.sh
new file mode 100755
index 0000000..0cfb7b9
--- /dev/null
+++ b/modules.d/95dasd/module-info.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    arch=3D$(uname -m)
+    [ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || return 1
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
+}
+
+install() {
+    inst_hook cmdline 30 "$moddir/parse-dasd.sh"
+    dracut_install tr dasdinfo dasdconf.sh
+    if [[ $hostonly ]]; then
+        inst /etc/dasd.conf
+    fi
+    inst_rules 56-dasd.rules
+    inst_rules 59-dasd.rules
+}
+
diff --git a/modules.d/95dasd_mod/check b/modules.d/95dasd_mod/check
deleted file mode 100755
index dcd2421..0000000
--- a/modules.d/95dasd_mod/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-arch=3D$(uname -m)
-[ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || exit 1=20
-
-exit 0
diff --git a/modules.d/95dasd_mod/install b/modules.d/95dasd_mod/instal=
l
deleted file mode 100755
index 3a74a7a..0000000
--- a/modules.d/95dasd_mod/install
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst_hook cmdline 31 "$moddir/parse-dasd-mod.sh"
-dracut_install dasd_cio_free grep sed seq
-
diff --git a/modules.d/95dasd_mod/installkernel b/modules.d/95dasd_mod/=
installkernel
deleted file mode 100755
index f8ba37a..0000000
--- a/modules.d/95dasd_mod/installkernel
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
-
-
diff --git a/modules.d/95dasd_mod/module-info.sh b/modules.d/95dasd_mod=
/module-info.sh
new file mode 100755
index 0000000..0f8700c
--- /dev/null
+++ b/modules.d/95dasd_mod/module-info.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    arch=3D$(uname -m)
+    [ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || return 1=20
+
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
+}
+
+install() {
+    inst_hook cmdline 31 "$moddir/parse-dasd-mod.sh"
+    dracut_install dasd_cio_free grep sed seq
+}
+
diff --git a/modules.d/95debug/check b/modules.d/95debug/check
deleted file mode 100755
index d61ec69..0000000
--- a/modules.d/95debug/check
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# do not add this module by default
-exit 1
diff --git a/modules.d/95debug/install b/modules.d/95debug/install
deleted file mode 100755
index 0112aac..0000000
--- a/modules.d/95debug/install
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install -o ps grep more cat rm strace free showmount=20
-dracut_install -o ping netstat rpcinfo vi scp ping6 ssh
-dracut_install -o fsck fsck.ext2 fsck.ext4 fsck.ext3 fsck.ext4dev fsck=
=2Evfat e2fsck
-
diff --git a/modules.d/95debug/module-info.sh b/modules.d/95debug/modul=
e-info.sh
new file mode 100755
index 0000000..0c17251
--- /dev/null
+++ b/modules.d/95debug/module-info.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # do not add this module by default
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    dracut_install -o ps grep more cat rm strace free showmount=20
+    dracut_install -o ping netstat rpcinfo vi scp ping6 ssh
+    dracut_install -o fsck fsck.ext2 fsck.ext4 fsck.ext3 fsck.ext4dev =
fsck.vfat e2fsck
+
+}
+
diff --git a/modules.d/95fcoe/check b/modules.d/95fcoe/check
deleted file mode 100755
index e3bd344..0000000
--- a/modules.d/95fcoe/check
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on network modules being loaded
-[ "$1" =3D "-d" ] && echo network
-
-# FIXME
-# If hostonly was requested, fail the check until we have some way of
-# knowing we are booting from FCoE
-[ "$1" =3D "-h" ] && exit 1
-
-exit 0
diff --git a/modules.d/95fcoe/install b/modules.d/95fcoe/install
deleted file mode 100755
index 53f8ca4..0000000
--- a/modules.d/95fcoe/install
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-dracut_install ip=20
-inst dcbtool=20
-inst fipvlan
-inst lldpad
-
-mkdir -p "$initdir/var/lib/lldpad"
-
-inst "$moddir/fcoe-up" "/sbin/fcoe-up"
-inst_hook pre-udev 60 "$moddir/fcoe-genrules.sh"
-inst_hook cmdline 99 "$moddir/parse-fcoe.sh"
diff --git a/modules.d/95fcoe/installkernel b/modules.d/95fcoe/installk=
ernel
deleted file mode 100755
index 4f1aec6..0000000
--- a/modules.d/95fcoe/installkernel
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-instmods fcoe 8021q
diff --git a/modules.d/95fcoe/module-info.sh b/modules.d/95fcoe/module-=
info.sh
new file mode 100755
index 0000000..d5500bb
--- /dev/null
+++ b/modules.d/95fcoe/module-info.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # FIXME
+    # If hostonly was requested, fail the check until we have some way=
 of
+    # knowing we are booting from FCoE
+    [[ $hostonly ]] && return 1
+
+    return 0
+}
+
+depends() {
+    echo network rootfs-block
+    return 0
+}
+
+installkernel() {
+    instmods fcoe 8021q
+}
+
+install() {
+    dracut_install ip=20
+    inst dcbtool=20
+    inst fipvlan
+    inst lldpad
+
+    mkdir -p "$initdir/var/lib/lldpad"
+
+    inst "$moddir/fcoe-up" "/sbin/fcoe-up"
+    inst_hook pre-udev 60 "$moddir/fcoe-genrules.sh"
+    inst_hook cmdline 99 "$moddir/parse-fcoe.sh"
+}
+
diff --git a/modules.d/95fstab-sys/check b/modules.d/95fstab-sys/check
deleted file mode 100755
index f5e2f55..0000000
--- a/modules.d/95fstab-sys/check
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-test -f /etc/fstab.sys
diff --git a/modules.d/95fstab-sys/install b/modules.d/95fstab-sys/inst=
all
deleted file mode 100755
index a42ee25..0000000
--- a/modules.d/95fstab-sys/install
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-dracut_install /etc/fstab.sys
-inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
diff --git a/modules.d/95fstab-sys/module-info.sh b/modules.d/95fstab-s=
ys/module-info.sh
new file mode 100755
index 0000000..f46c037
--- /dev/null
+++ b/modules.d/95fstab-sys/module-info.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    test -f /etc/fstab.sys
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    dracut_install /etc/fstab.sys
+    inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
+}
diff --git a/modules.d/95iscsi/check b/modules.d/95iscsi/check
deleted file mode 100755
index f943359..0000000
--- a/modules.d/95iscsi/check
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on network modules being loaded
-[ "$1" =3D "-d" ] && echo network
-
-# If our prerequisites are not met, fail anyways.
-type -P iscsistart hostname iscsi-iname >/dev/null || exit 1
-
-# If hostonly was requested, fail the check if we are not actually
-# booting from root.
-
-. $dracutfunctions
-
-[[ $debug ]] && set -x
-
-is_iscsi() (=20
-    [[ -L /sys/dev/block/$1 ]] || return
-    cd "$(readlink -f /sys/dev/block/$1)"
-    until [[ -d sys || -d iscsi_session ]]; do
-        cd ..
-    done
-    [[ -d iscsi_session ]]
-)
-
-case $1 in
-    -h) rootdev=3D$(find_root_block_device)
-        if [[ $rootdev ]]; then
-            # root lives on a block device, so we can be more precise =
about=20
-            # hostonly checking
-            check_block_and_slaves is_iscsi "$rootdev" || exit 1
-        else
-            exit 1
-        fi ;;
-esac
-
-exit 0
diff --git a/modules.d/95iscsi/install b/modules.d/95iscsi/install
deleted file mode 100755
index a0db7c5..0000000
--- a/modules.d/95iscsi/install
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install umount
-inst iscsistart=20
-inst hostname
-inst iscsi-iname
-inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
-inst "$moddir/iscsiroot" "/sbin/iscsiroot"
-inst "$moddir/mount-lun.sh" "/bin/mount-lun.sh"
diff --git a/modules.d/95iscsi/installkernel b/modules.d/95iscsi/instal=
lkernel
deleted file mode 100755
index 80dd639..0000000
--- a/modules.d/95iscsi/installkernel
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-instmods iscsi_tcp crc32c iscsi_ibft
diff --git a/modules.d/95iscsi/module-info.sh b/modules.d/95iscsi/modul=
e-info.sh
new file mode 100755
index 0000000..23c612a
--- /dev/null
+++ b/modules.d/95iscsi/module-info.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # If our prerequisites are not met, fail anyways.
+    type -P iscsistart hostname iscsi-iname >/dev/null || return 1
+
+    # If hostonly was requested, fail the check if we are not actually
+    # booting from root.
+
+    . $dracutfunctions
+
+    [[ $debug ]] && set -x
+
+    is_iscsi() (=20
+        [[ -L /sys/dev/block/$1 ]] || return
+        cd "$(readlink -f /sys/dev/block/$1)"
+        until [[ -d sys || -d iscsi_session ]]; do
+            cd ..
+        done
+        [[ -d iscsi_session ]]
+    )
+
+    [[ $hostonly ]] && {
+        rootdev=3D$(find_root_block_device)
+        if [[ $rootdev ]]; then
+            # root lives on a block device, so we can be more precise =
about=20
+            # hostonly checking
+            check_block_and_slaves is_iscsi "$rootdev" || return 1
+        else
+            return 1
+        fi
+    }
+    return 0
+}
+
+depends() {
+    echo network rootfs-block
+}
+
+installkernel() {
+    instmods iscsi_tcp crc32c iscsi_ibft
+}
+
+install() {
+    dracut_install umount
+    inst iscsistart=20
+    inst hostname
+    inst iscsi-iname
+    inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
+    inst "$moddir/iscsiroot" "/sbin/iscsiroot"
+    inst "$moddir/mount-lun.sh" "/bin/mount-lun.sh"
+}
diff --git a/modules.d/95nbd/check b/modules.d/95nbd/check
deleted file mode 100755
index adbeb7a..0000000
--- a/modules.d/95nbd/check
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-# We depend on network modules being loaded
-[ "$1" =3D "-d" ] && echo network
-
-# If our prerequisites are not met, fail.
-type -P nbd-client >/dev/null || exit 1
-
-# if an nbd device is not somewhere in the chain of devices root is mo=
unted on,
-# fail the hostonly check.
-[ "$1" =3D "-h" ] && {
-    is_nbd() { [[ -b /dev/block/$1 && $1 =3D=3D 43:* ]] ;}
-    . $dracutfunctions
-
-    rootdev=3D$(find_root_block_device)
-    [[ -b /dev/block/$rootdev ]] || exit 1
-    check_block_and_slaves is_nbd "$rootdev" || exit 1
-}
-
-exit 0
diff --git a/modules.d/95nbd/install b/modules.d/95nbd/install
deleted file mode 100755
index 1fcd952..0000000
--- a/modules.d/95nbd/install
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-inst nbd-client
-inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
-
-inst "$moddir/nbdroot" "/sbin/nbdroot"
diff --git a/modules.d/95nbd/installkernel b/modules.d/95nbd/installker=
nel
deleted file mode 100755
index 38d413d..0000000
--- a/modules.d/95nbd/installkernel
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-instmods nbd
diff --git a/modules.d/95nbd/module-info.sh b/modules.d/95nbd/module-in=
fo.sh
new file mode 100755
index 0000000..3cf14ef
--- /dev/null
+++ b/modules.d/95nbd/module-info.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # If our prerequisites are not met, fail.
+    type -P nbd-client >/dev/null || return 1
+
+    # if an nbd device is not somewhere in the chain of devices root i=
s=20
+    # mounted on, fail the hostonly check.
+    [[ $hostonly ]] && {
+        is_nbd() { [[ -b /dev/block/$1 && $1 =3D=3D 43:* ]] ;}
+        . $dracutfunctions
+
+        rootdev=3D$(find_root_block_device)
+        [[ -b /dev/block/$rootdev ]] || return 1
+        check_block_and_slaves is_nbd "$rootdev" || return 1
+    }
+
+    return 0
+}
+
+depends() {
+    # We depend on network modules being loaded
+    echo network rootfs-block
+}
+
+installkernel() {
+    instmods nbd
+}
+
+install() {
+    inst nbd-client
+    inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
+
+    inst "$moddir/nbdroot" "/sbin/nbdroot"
+}
+
diff --git a/modules.d/95nfs/check b/modules.d/95nfs/check
deleted file mode 100755
index 5eb2d6a..0000000
--- a/modules.d/95nfs/check
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# We depend on network modules being loaded
-[ "$1" =3D "-d" ] && echo network
-
-# If hostonly was requested, fail the check if we are not actually
-# booting from root.
-[ "$1" =3D "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
-
-# If our prerequisites are not met, fail anyways.
-type -P rpcbind >/dev/null || type -P portmap >/dev/null || exit 1
-type -P rpc.statd mount.nfs mount.nfs4 umount >/dev/null || exit 1
-exit 0
diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
deleted file mode 100755
index 455fbbf..0000000
--- a/modules.d/95nfs/install
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-type -P portmap >/dev/null && dracut_install portmap
-type -P rpcbind >/dev/null && dracut_install rpcbind
-
-dracut_install rpc.statd mount.nfs mount.nfs4 umount=20
-[ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
-dracut_install /etc/services=20
-dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
-dracut_install rpc.idmapd /etc/idmapd.conf
-dracut_install sed
-
-for i in {"$libdir","$usrlibdir"}/libnfsidmap_nsswitch.so* \
-    {"$libdir","$usrlibdir"}/libnfsidmap/*.so \
-    {"$libdir","$usrlibdir"}/libnfsidmap*.so*; do
-    [ -e "$i" ] && dracut_install "$i"
-done
-
-nsslibs=3D$(sed -e '/^#/d' -e 's/^.*://' -e 's/\[NOTFOUND=3Dreturn\]//=
' /etc/nsswitch.conf \
-    |  tr -s '[:space:]' '\n' | sort -u | tr -s '[:space:]' '|')
-nsslibs=3D${nsslibs#|}
-nsslibs=3D${nsslibs%|}
-
-dracut_install $(for i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/null);=
 do echo $i;done | egrep "$nsslibs")
-
-inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
-inst_hook pre-pivot 99 "$moddir/nfsroot-cleanup.sh"
-inst "$moddir/nfsroot" "/sbin/nfsroot"
-mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
-mkdir -p "$initdir/var/lib/rpcbind"
-mkdir -p "$initdir/var/lib/nfs/statd/sm"
-
-# Rather than copy the passwd file in, just set a user for rpcbind
-# We'll save the state and restart the daemon from the root anyway
-egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0:=
:/:/bin/sh' >> "$initdir/etc/passwd"
-egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
-egrep '^nfsnobody:' /etc/passwd >> "$initdir/etc/passwd"
-egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
-egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
-#type -P nologin >/dev/null && dracut_install nologin
-
-# rpc user needs to be able to write to this directory to save the war=
mstart
-# file
-chmod 777 "$initdir/var/lib/rpcbind"
diff --git a/modules.d/95nfs/installkernel b/modules.d/95nfs/installker=
nel
deleted file mode 100755
index b4f6d99..0000000
--- a/modules.d/95nfs/installkernel
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-instmods nfs sunrpc ipv6
diff --git a/modules.d/95nfs/module-info.sh b/modules.d/95nfs/module-in=
fo.sh
new file mode 100755
index 0000000..84673ab
--- /dev/null
+++ b/modules.d/95nfs/module-info.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # If hostonly was requested, fail the check if we are not actually
+    # booting from root.
+    [ $hostonly ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && return 1
+
+    # If our prerequisites are not met, fail anyways.
+    type -P rpcbind >/dev/null || type -P portmap >/dev/null || return=
 1
+    type -P rpc.statd mount.nfs mount.nfs4 umount >/dev/null || return=
 1
+    return 0
+}
+
+depends() {
+    # We depend on network modules being loaded
+    echo network
+}
+
+installkernel() {
+    instmods nfs sunrpc ipv6
+}
+
+install() {
+    type -P portmap >/dev/null && dracut_install portmap
+    type -P rpcbind >/dev/null && dracut_install rpcbind
+
+    dracut_install rpc.statd mount.nfs mount.nfs4 umount=20
+    [ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
+    dracut_install /etc/services=20
+    dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
+    dracut_install rpc.idmapd /etc/idmapd.conf
+    dracut_install sed
+
+    for i in {"$libdir","$usrlibdir"}/libnfsidmap_nsswitch.so* \
+        {"$libdir","$usrlibdir"}/libnfsidmap/*.so \
+        {"$libdir","$usrlibdir"}/libnfsidmap*.so*; do
+        [ -e "$i" ] && dracut_install "$i"
+    done
+
+    nsslibs=3D$(sed -e '/^#/d' -e 's/^.*://' -e 's/\[NOTFOUND=3Dreturn=
\]//' /etc/nsswitch.conf \
+        |  tr -s '[:space:]' '\n' | sort -u | tr -s '[:space:]' '|')
+    nsslibs=3D${nsslibs#|}
+    nsslibs=3D${nsslibs%|}
+
+    dracut_install $(for i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/nu=
ll); do echo $i;done | egrep "$nsslibs")
+
+    inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
+    inst_hook pre-pivot 99 "$moddir/nfsroot-cleanup.sh"
+    inst "$moddir/nfsroot" "/sbin/nfsroot"
+    mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
+    mkdir -p "$initdir/var/lib/rpcbind"
+    mkdir -p "$initdir/var/lib/nfs/statd/sm"
+
+    # Rather than copy the passwd file in, just set a user for rpcbind
+    # We'll save the state and restart the daemon from the root anyway
+    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:=
0:0::/:/bin/sh' >> "$initdir/etc/passwd"
+    egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
+    egrep '^nfsnobody:' /etc/passwd >> "$initdir/etc/passwd"
+    egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
+    egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
+    #type -P nologin >/dev/null && dracut_install nologin
+
+    # rpc user needs to be able to write to this directory to save the=
 warmstart
+    # file
+    chmod 777 "$initdir/var/lib/rpcbind"
+}
+
diff --git a/modules.d/95resume/install b/modules.d/95resume/install
deleted file mode 100755
index 330a3ea..0000000
--- a/modules.d/95resume/install
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# Optional uswsusp support
-for bin in /usr/sbin/resume /usr/lib/suspend/resume
-do
-    [[ -x "${bin}" ]] && {
-        inst "${bin}" /usr/sbin/resume
-        [[ -f /etc/suspend.conf ]] && inst /etc/suspend.conf
-        break=20
-    }
-done
-
-inst_hook cmdline 10 "$moddir/parse-resume.sh"
-inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
-inst_hook mount 10 "$moddir/resume.sh"
diff --git a/modules.d/95resume/module-info.sh b/modules.d/95resume/mod=
ule-info.sh
new file mode 100755
index 0000000..cde9fca
--- /dev/null
+++ b/modules.d/95resume/module-info.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+install() {
+    # Optional uswsusp support
+    for bin in /usr/sbin/resume /usr/lib/suspend/resume
+    do
+        [[ -x "${bin}" ]] && {
+            inst "${bin}" /usr/sbin/resume
+            [[ -f /etc/suspend.conf ]] && inst /etc/suspend.conf
+            break=20
+        }
+    done
+
+    inst_hook cmdline 10 "$moddir/parse-resume.sh"
+    inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
+    inst_hook mount 10 "$moddir/resume.sh"
+}
+
diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-bloc=
k/install
deleted file mode 100755
index 9e2c834..0000000
--- a/modules.d/95rootfs-block/install
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-dracut_install umount
-dracut_install /sbin/fsck*
-type -P e2fsck >/dev/null && dracut_install e2fsck
-inst_hook cmdline 95 "$moddir/parse-block.sh"
-inst_hook pre-udev 30 "$moddir/block-genrules.sh"
-inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/95rootfs-block/module-info.sh b/modules.d/95root=
fs-block/module-info.sh
new file mode 100755
index 0000000..419351b
--- /dev/null
+++ b/modules.d/95rootfs-block/module-info.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+install() {
+    dracut_install umount
+    dracut_install /sbin/fsck*
+    type -P e2fsck >/dev/null && dracut_install e2fsck
+    inst_hook cmdline 95 "$moddir/parse-block.sh"
+    inst_hook pre-udev 30 "$moddir/block-genrules.sh"
+    inst_hook mount 99 "$moddir/mount-root.sh"
+}
+
diff --git a/modules.d/95terminfo/install b/modules.d/95terminfo/instal=
l
deleted file mode 100755
index 0509645..0000000
--- a/modules.d/95terminfo/install
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# terminfo bits make things work better if you fall into interactive m=
ode
-for TERMINFODIR in /lib/terminfo /etc/terminfo /usr/share/terminfo; do
-    [ -d ${TERMINFODIR} ] && break
-done
-
-[ -d ${TERMINFODIR} ] && \
-    dracut_install $(find ${TERMINFODIR} -type f)
diff --git a/modules.d/95terminfo/module-info.sh b/modules.d/95terminfo=
/module-info.sh
new file mode 100755
index 0000000..8022db3
--- /dev/null
+++ b/modules.d/95terminfo/module-info.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+install() {
+    # terminfo bits make things work better if you fall into interacti=
ve mode
+    for TERMINFODIR in /lib/terminfo /etc/terminfo /usr/share/terminfo=
; do
+        [ -d ${TERMINFODIR} ] && break
+    done
+   =20
+    [ -d ${TERMINFODIR} ] && \
+        dracut_install $(find ${TERMINFODIR} -type f)
+}
+
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/in=
stall
deleted file mode 100755
index ee32b56..0000000
--- a/modules.d/95udev-rules/install
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# FIXME: would be nice if we didn't have to know which rules to grab..=
=2E.
-# ultimately, /lib/initramfs/rules.d or somesuch which includes links/=
copies
-# of the rules we want so that we just copy those in would be best
-dracut_install udevd udevadm /etc/udev/udev.conf /etc/group
-dracut_install basename
-inst_rules 50-udev-default.rules 60-persistent-storage.rules \
-    61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rule=
s \
-    60-pcmcia.rules=20
-#Some debian udev rules are named differently
-inst_rules 50-udev.rules 95-late.rules
-
-# ignore some devices in the initrd
-inst_rules "$moddir/01-ignore.rules"
-
-# for firmware loading
-inst_rules 50-firmware.rules
-dracut_install cat uname
-
-if [ ! -x /lib/udev/vol_id ]; then
-    dracut_install blkid
-    inst_rules "$moddir/59-persistent-storage.rules"
-else
-    inst_rules "$moddir/59-persistent-storage-volid.rules"
-fi
-inst_rules "$moddir/61-persistent-storage.rules"
-
-for i in \
-    ata_id \
-    cdrom_id \
-    create_floppy_devices \
-    edd_id \
-    firmware.sh \
-    firmware \
-    firmware.agent \
-    hotplug.functions \
-    fw_unit_symlinks.sh \
-    hid2hci \
-    path_id \
-    scsi_id \
-    usb_id \
-    vol_id \
-    pcmcia-socket-startup \
-    pcmcia-check-broken-cis \
-    ; do
-    [ -e /lib/udev/$i ] && dracut_install /lib/udev/$i
-done
-
-[ -f /etc/arch-release ] && inst "$moddir/load-modules.sh" /lib/udev/l=
oad-modules.sh
-
-for i in {"$libdir","$usrlibdir"}/libnss_files*; do
-    [ -e "$i" ] && dracut_install "$i"
-done
diff --git a/modules.d/95udev-rules/module-info.sh b/modules.d/95udev-r=
ules/module-info.sh
new file mode 100755
index 0000000..944bbc2
--- /dev/null
+++ b/modules.d/95udev-rules/module-info.sh
@@ -0,0 +1,60 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+install() {
+    # FIXME: would be nice if we didn't have to know which rules to gr=
ab....
+    # ultimately, /lib/initramfs/rules.d or somesuch which includes li=
nks/copies
+    # of the rules we want so that we just copy those in would be best
+    dracut_install udevd udevadm /etc/udev/udev.conf /etc/group
+    dracut_install basename
+    inst_rules 50-udev-default.rules 60-persistent-storage.rules \
+        61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.=
rules \
+        60-pcmcia.rules=20
+    #Some debian udev rules are named differently
+    inst_rules 50-udev.rules 95-late.rules
+
+    # ignore some devices in the initrd
+    inst_rules "$moddir/01-ignore.rules"
+
+    # for firmware loading
+    inst_rules 50-firmware.rules
+    dracut_install cat uname
+
+    if [ ! -x /lib/udev/vol_id ]; then
+        dracut_install blkid
+        inst_rules "$moddir/59-persistent-storage.rules"
+    else
+        inst_rules "$moddir/59-persistent-storage-volid.rules"
+    fi
+    inst_rules "$moddir/61-persistent-storage.rules"
+
+    for i in \
+        ata_id \
+        cdrom_id \
+        create_floppy_devices \
+        edd_id \
+        firmware.sh \
+        firmware \
+        firmware.agent \
+        hotplug.functions \
+        fw_unit_symlinks.sh \
+        hid2hci \
+        path_id \
+        scsi_id \
+        usb_id \
+        vol_id \
+        pcmcia-socket-startup \
+        pcmcia-check-broken-cis \
+        ; do
+        [ -e /lib/udev/$i ] && dracut_install /lib/udev/$i
+    done
+
+    [ -f /etc/arch-release ] && \
+        inst "$moddir/load-modules.sh" /lib/udev/load-modules.sh
+
+    for i in {"$libdir","$usrlibdir"}/libnss_files*; do
+        [ -e "$i" ] && dracut_install "$i"
+    done
+}
+
diff --git a/modules.d/95zfcp/check b/modules.d/95zfcp/check
deleted file mode 100755
index 3090f6d..0000000
--- a/modules.d/95zfcp/check
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-arch=3D$(uname -m)
-[ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || exit 1=20
-
-exit 0
diff --git a/modules.d/95zfcp/install b/modules.d/95zfcp/install
deleted file mode 100755
index 4169d9c..0000000
--- a/modules.d/95zfcp/install
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_hook cmdline 30 "$moddir/parse-zfcp.sh"
-dracut_install tr
-
-inst /sbin/zfcpconf.sh
-inst_rules 56-zfcp.rules
-
-if [[ $hostonly ]]; then
-    inst /etc/zfcp.conf
-fi
-dracut_install zfcp_cio_free grep sed seq
-
diff --git a/modules.d/95zfcp/installkernel b/modules.d/95zfcp/installk=
ernel
deleted file mode 100755
index 85694ce..0000000
--- a/modules.d/95zfcp/installkernel
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-instmods zfcp
-
-
diff --git a/modules.d/95zfcp/module-info.sh b/modules.d/95zfcp/module-=
info.sh
new file mode 100755
index 0000000..06c8d8f
--- /dev/null
+++ b/modules.d/95zfcp/module-info.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    arch=3D$(uname -m)
+    [ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || return 1=20
+
+    return 0
+}
+
+depends() {
+    arch=3D$(uname -m)
+    [ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || return 1=20
+
+    return 0
+}
+
+installkernel() {
+    instmods zfcp
+}
+
+install() {
+    inst_hook cmdline 30 "$moddir/parse-zfcp.sh"
+    dracut_install tr
+
+    inst /sbin/zfcpconf.sh
+    inst_rules 56-zfcp.rules
+
+    if [[ $hostonly ]]; then
+        inst /etc/zfcp.conf
+    fi
+    dracut_install zfcp_cio_free grep sed seq
+}
\ No newline at end of file
diff --git a/modules.d/95znet/check b/modules.d/95znet/check
deleted file mode 100755
index 3090f6d..0000000
--- a/modules.d/95znet/check
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-arch=3D$(uname -m)
-[ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || exit 1=20
-
-exit 0
diff --git a/modules.d/95znet/install b/modules.d/95znet/install
deleted file mode 100755
index ecf09c5..0000000
--- a/modules.d/95znet/install
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_hook cmdline 30 "$moddir/parse-ccw.sh"
-inst /lib/udev/ccw_init
-inst_rules 81-ccw.rules
-dracut_install znet_cio_free grep sed seq readlink
diff --git a/modules.d/95znet/module-info.sh b/modules.d/95znet/module-=
info.sh
new file mode 100755
index 0000000..0964761
--- /dev/null
+++ b/modules.d/95znet/module-info.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    arch=3D$(uname -m)
+    [ "$arch" =3D "s390" -o "$arch" =3D "s390x" ] || return 1=20
+
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    inst_hook cmdline 30 "$moddir/parse-ccw.sh"
+    inst /lib/udev/ccw_init
+    inst_rules 81-ccw.rules
+    dracut_install znet_cio_free grep sed seq readlink
+}
+
diff --git a/modules.d/96insmodpost/check b/modules.d/96insmodpost/chec=
k
deleted file mode 100755
index e0292c8..0000000
--- a/modules.d/96insmodpost/check
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-exit 0
diff --git a/modules.d/96insmodpost/install b/modules.d/96insmodpost/in=
stall
deleted file mode 100755
index 4509d1b..0000000
--- a/modules.d/96insmodpost/install
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_hook cmdline 20 "$moddir/parse-insmodpost.sh"
-inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
diff --git a/modules.d/96insmodpost/module-info.sh b/modules.d/96insmod=
post/module-info.sh
new file mode 100755
index 0000000..586765d
--- /dev/null
+++ b/modules.d/96insmodpost/module-info.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    inst_hook cmdline 20 "$moddir/parse-insmodpost.sh"
+    inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
+}
+
diff --git a/modules.d/97biosdevname/check b/modules.d/97biosdevname/ch=
eck
deleted file mode 100755
index f269c69..0000000
--- a/modules.d/97biosdevname/check
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-type -P biosdevname >/dev/null || exit 1
-
-# do not enable bootchartd by default
-exit 0
diff --git a/modules.d/97biosdevname/install b/modules.d/97biosdevname/=
install
deleted file mode 100755
index a108d46..0000000
--- a/modules.d/97biosdevname/install
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-dracut_install biosdevname
-inst_rules 71-biosdevname.rules
-inst_hook pre-trigger 30 "$moddir/parse-biosdevname.sh"
-
-# set the default state according to the config
-if [[ -e /etc/sysconfig/network ]]; then
-    . /etc/sysconfig/network
-fi
-
-if [[ "$BIOSDEVNAME" =3D "no" ]]; then
-    echo "biosdevname=3D0" >> ${initdir}/etc/cmdline
-fi
diff --git a/modules.d/97biosdevname/module-info.sh b/modules.d/97biosd=
evname/module-info.sh
new file mode 100755
index 0000000..834831f
--- /dev/null
+++ b/modules.d/97biosdevname/module-info.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    type -P biosdevname >/dev/null || return 1
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    dracut_install biosdevname
+    inst_rules 71-biosdevname.rules
+}
+
diff --git a/modules.d/98selinux/install b/modules.d/98selinux/install
deleted file mode 100755
index 6d64048..0000000
--- a/modules.d/98selinux/install
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
diff --git a/modules.d/98selinux/module-info.sh b/modules.d/98selinux/m=
odule-info.sh
new file mode 100755
index 0000000..483e42f
--- /dev/null
+++ b/modules.d/98selinux/module-info.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    [[ $hostonly ]] && {
+        [ -x "/usr/sbin/load_policy" -o -x "/sbin/load_policy" ] || re=
turn 1
+        return 0
+    }
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
+}
+
diff --git a/modules.d/98syslog/check b/modules.d/98syslog/check
deleted file mode 100755
index 8ee8098..0000000
--- a/modules.d/98syslog/check
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-# do not add this module by default
-exit 255
diff --git a/modules.d/98syslog/install b/modules.d/98syslog/install
deleted file mode 100755
index cca088d..0000000
--- a/modules.d/98syslog/install
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-if type -P rsyslogd >/dev/null; then
-    installs=3D"rsyslogd"
-    for i in {"$libdir","$usrlibdir"}/rsyslog/lmnet.so \
-            {"$libdir","$usrlibdir"}/rsyslog/imklog.so \
-            {"$libdir","$usrlibdir"}/rsyslog/imuxsock.so ; do
-        [ -e "$i" ] && installs=3D"$installs $i"
-    done
-elif type -P syslogd >/dev/null; then
-    installs=3D"syslogd"
-elif type -P syslog-ng >/dev/null; then
-    installs=3D"syslog-ng"
-else
-    dwarn "Could not find any syslog binary although the syslogmodule =
is selected to be installed. Please check."
-fi
-if [ -n "$installs" ]; then
-    dracut_install cat
-    dracut_install $installs
-    inst_hook cmdline  90 "$moddir/parse-syslog-opts.sh"
-    inst_hook pre-udev 61 "$moddir/syslog-genrules.sh"
-    inst_hook pre-pivot 99 "$moddir/syslog-cleanup.sh"
-    inst_simple "$moddir/rsyslogd-start.sh" /sbin/rsyslogd-start
-    inst_simple "$moddir/rsyslogd-stop.sh" /sbin/rsyslogd-stop
-    mkdir -p ${initdir}/etc/templates
-    inst_simple "${moddir}/rsyslog.conf" /etc/templates
-fi
diff --git a/modules.d/98syslog/module-info.sh b/modules.d/98syslog/mod=
ule-info.sh
new file mode 100755
index 0000000..968fba0
--- /dev/null
+++ b/modules.d/98syslog/module-info.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    # do not add this module by default
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    if type -P rsyslogd >/dev/null; then
+        installs=3D"rsyslogd"
+        for i in {"$libdir","$usrlibdir"}/rsyslog/lmnet.so \
+            {"$libdir","$usrlibdir"}/rsyslog/imklog.so \
+            {"$libdir","$usrlibdir"}/rsyslog/imuxsock.so ; do
+            [ -e "$i" ] && installs=3D"$installs $i"
+        done
+    elif type -P syslogd >/dev/null; then
+        installs=3D"syslogd"
+    elif type -P syslog-ng >/dev/null; then
+        installs=3D"syslog-ng"
+    else
+        dwarn "Could not find any syslog binary although the syslogmod=
ule is selected to be installed. Please check."
+    fi
+    if [ -n "$installs" ]; then
+        dracut_install cat
+        dracut_install $installs
+        inst_hook cmdline  90 "$moddir/parse-syslog-opts.sh"
+        inst_hook pre-udev 61 "$moddir/syslog-genrules.sh"
+        inst_hook pre-pivot 99 "$moddir/syslog-cleanup.sh"
+        inst_simple "$moddir/rsyslogd-start.sh" /sbin/rsyslogd-start
+        inst_simple "$moddir/rsyslogd-stop.sh" /sbin/rsyslogd-stop
+        mkdir -p ${initdir}/etc/templates
+        inst_simple "${moddir}/rsyslog.conf" /etc/templates
+    fi
+}
+
diff --git a/modules.d/99base/check b/modules.d/99base/check
deleted file mode 100755
index b7ba12c..0000000
--- a/modules.d/99base/check
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-[[ $1 =3D -d ]] && echo udev-rules=20
-exit 0
diff --git a/modules.d/99base/install b/modules.d/99base/install
deleted file mode 100755
index 95d60bb..0000000
--- a/modules.d/99base/install
+++ /dev/null
@@ -1,32 +0,0 @@
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
-# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
-
-dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo=20
-dracut_install -o less=20
-if [ ! -e "${initdir}/bin/sh" ]; then
-    dracut_install bash
-    (ln -s bash "${initdir}/bin/sh" || :)
-fi
-# install our scripts and hooks
-inst "$moddir/init" "/init"
-inst "$moddir/initqueue" "/sbin/initqueue"
-inst "$moddir/loginit" "/sbin/loginit"
-mkdir -p ${initdir}/initqueue
-mkdir -p ${initdir}/emergency
-mkdir -p ${initdir}/initqueue-finished
-mkdir -p ${initdir}/initqueue-settled
-mkdir -p ${initdir}/tmp
-# Bail out if switch_root does not exist
-if type -P switch_root >/dev/null; then
-    inst $(type -P switch_root) /sbin/switch_root \
-        || derror "Failed to install switch_root"
-else
-    inst "$moddir/switch_root" "/sbin/switch_root" \
-        || derror "Failed to install switch_root"
-fi
-inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
-inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
-inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
-mkdir -p "${initdir}/var/run"
-[ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd-tim=
estamp
diff --git a/modules.d/99base/module-info.sh b/modules.d/99base/module-=
info.sh
new file mode 100755
index 0000000..a55cdc4
--- /dev/null
+++ b/modules.d/99base/module-info.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+check() {
+    return 0
+}
+
+depends() {
+    echo udev-rules=20
+    return 0
+}
+
+install() {
+    dracut_install mount mknod mkdir modprobe pidof sleep chroot \
+        sed ls flock cp mv dmesg rm ln rmmod mkfifo=20
+    dracut_install -o less=20
+    if [ ! -e "${initdir}/bin/sh" ]; then
+        dracut_install bash
+        (ln -s bash "${initdir}/bin/sh" || :)
+    fi
+    # install our scripts and hooks
+    inst "$moddir/init" "/init"
+    inst "$moddir/initqueue" "/sbin/initqueue"
+    inst "$moddir/loginit" "/sbin/loginit"
+    mkdir -p ${initdir}/initqueue
+    mkdir -p ${initdir}/emergency
+    mkdir -p ${initdir}/initqueue-finished
+    mkdir -p ${initdir}/initqueue-settled
+    mkdir -p ${initdir}/tmp
+    # Bail out if switch_root does not exist
+    if type -P switch_root >/dev/null; then
+        inst $(type -P switch_root) /sbin/switch_root \
+            || derror "Failed to install switch_root"
+    else
+        inst "$moddir/switch_root" "/sbin/switch_root" \
+            || derror "Failed to install switch_root"
+    fi
+    inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
+    inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
+    inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
+    mkdir -p "${initdir}/var/run"
+    [ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd=
-timestamp
+}
+
-----------------------------------------------------------------------

Summary of changes:
 AUTHORS                                            |    3 +
 NEWS                                               |   15 ++
 dracut                                             |   24 ++--
 dracut-functions                                   |  182 +++++++++++-=
------
 dracut.conf.d/fedora.conf.example                  |    1 +
 dracut.spec                                        |    7 +-
 dracut.xml                                         |   59 ++++---
 modules.d/00bootchart/check                        |    7 -
 modules.d/00bootchart/install                      |   18 --
 modules.d/00bootchart/module-setup.sh              |   30 +++
 modules.d/00dash/check                             |    4 -
 modules.d/00dash/install                           |    9 -
 modules.d/00dash/module-setup.sh                   |   20 ++
 modules.d/01fips/check                             |    7 -
 modules.d/01fips/install                           |   15 --
 modules.d/01fips/installkernel                     |   16 --
 modules.d/01fips/module-setup.sh                   |   41 ++++
 modules.d/05busybox/check                          |    7 -
 modules.d/05busybox/install                        |   16 --
 modules.d/05busybox/module-setup.sh                |   31 +++
 modules.d/10i18n/check                             |    5 -
 modules.d/10i18n/install                           |  199 ------------=
-------
 modules.d/10i18n/module-setup.sh                   |  209 ++++++++++++=
++++++++
 modules.d/10rpmversion/check                       |    5 -
 modules.d/10rpmversion/install                     |   15 --
 modules.d/10rpmversion/module-setup.sh             |   26 +++
 modules.d/40network/check                          |   24 ---
 modules.d/40network/install                        |   26 ---
 modules.d/40network/installkernel                  |   22 --
 modules.d/40network/module-setup.sh                |   74 +++++++
 modules.d/45ifcfg/check                            |    8 -
 modules.d/45ifcfg/install                          |    4 -
 .../{98selinux/check =3D> 45ifcfg/module-setup.sh}   |   13 +-
 modules.d/50gensplash/check                        |    7 -
 modules.d/50gensplash/install                      |   65 ------
 modules.d/50gensplash/module-setup.sh              |   77 +++++++
 modules.d/50plymouth/check                         |    5 -
 modules.d/50plymouth/install                       |   17 --
 modules.d/50plymouth/installkernel                 |    7 -
 modules.d/50plymouth/module-setup.sh               |   35 ++++
 modules.d/60xen/check                              |   17 --
 modules.d/60xen/install                            |    7 -
 modules.d/60xen/installkernel                      |   11 -
 modules.d/60xen/module-setup.sh                    |   41 ++++
 modules.d/90btrfs/check                            |   24 ---
 modules.d/90btrfs/install                          |    6 -
 modules.d/90btrfs/module-setup.sh                  |   34 ++++
 modules.d/90crypt/check                            |   26 ---
 modules.d/90crypt/install                          |   13 --
 modules.d/90crypt/installkernel                    |    5 -
 modules.d/90crypt/module-setup.sh                  |   50 +++++
 modules.d/90dm/check                               |    6 -
 modules.d/90dm/install                             |   11 -
 modules.d/90dm/installkernel                       |    7 -
 modules.d/90dm/module-setup.sh                     |   26 +++
 modules.d/90dmraid/check                           |   30 ---
 modules.d/90dmraid/install                         |   23 ---
 modules.d/90dmraid/module-setup.sh                 |   58 ++++++
 modules.d/90dmsquash-live/check                    |   17 --
 modules.d/90dmsquash-live/install                  |   25 ---
 modules.d/90dmsquash-live/module-setup.sh          |   42 ++++
 modules.d/90kernel-modules/install                 |    7 -
 modules.d/90kernel-modules/installkernel           |   40 ----
 modules.d/90kernel-modules/module-setup.sh         |   50 +++++
 modules.d/90lvm/check                              |   28 ---
 modules.d/90lvm/install                            |   24 ---
 modules.d/90lvm/module-setup.sh                    |   58 ++++++
 modules.d/90mdraid/check                           |   25 ---
 modules.d/90mdraid/install                         |   44 ----
 modules.d/90mdraid/installkernel                   |    5 -
 modules.d/90mdraid/module-setup.sh                 |   80 ++++++++
 modules.d/90multipath/check                        |   27 ---
 modules.d/90multipath/install                      |   22 --
 modules.d/90multipath/installkernel                |   10 -
 modules.d/90multipath/module-setup.sh              |   63 ++++++
 modules.d/90multipath/multipathd.sh                |    4 +-
 modules.d/95dasd/check                             |    7 -
 modules.d/95dasd/install                           |   10 -
 modules.d/95dasd/installkernel                     |    6 -
 modules.d/95dasd/module-setup.sh                   |   28 +++
 modules.d/95dasd_mod/check                         |    7 -
 modules.d/95dasd_mod/install                       |    6 -
 modules.d/95dasd_mod/installkernel                 |    7 -
 modules.d/95dasd_mod/module-setup.sh               |   24 +++
 modules.d/95debug/check                            |    6 -
 modules.d/95debug/install                          |    7 -
 modules.d/95debug/module-setup.sh                  |   20 ++
 modules.d/95fcoe/check                             |   13 --
 modules.d/95fcoe/install                           |   14 --
 modules.d/95fcoe/installkernel                     |    4 -
 modules.d/95fcoe/module-setup.sh                   |   35 ++++
 modules.d/95fstab-sys/check                        |    2 -
 modules.d/95fstab-sys/install                      |    3 -
 modules.d/95fstab-sys/module-setup.sh              |   16 ++
 modules.d/95iscsi/check                            |   38 ----
 modules.d/95iscsi/install                          |   10 -
 modules.d/95iscsi/installkernel                    |    4 -
 modules.d/95iscsi/module-setup.sh                  |   54 +++++
 modules.d/95nbd/check                              |   21 --
 modules.d/95nbd/install                            |    7 -
 modules.d/95nbd/installkernel                      |    4 -
 modules.d/95nbd/module-setup.sh                    |   38 ++++
 modules.d/95nfs/check                              |   15 --
 modules.d/95nfs/install                            |   46 -----
 modules.d/95nfs/installkernel                      |    5 -
 modules.d/95nfs/module-setup.sh                    |   69 +++++++
 modules.d/95resume/install                         |   17 --
 modules.d/95resume/module-setup.sh                 |   20 ++
 modules.d/95rootfs-block/install                   |   10 -
 modules.d/95rootfs-block/module-setup.sh           |   13 ++
 modules.d/95terminfo/install                       |   11 -
 modules.d/95terminfo/module-setup.sh               |   14 ++
 modules.d/95udev-rules/install                     |   56 ------
 modules.d/95udev-rules/module-setup.sh             |   60 ++++++
 modules.d/95zfcp/check                             |    8 -
 modules.d/95zfcp/install                           |   15 --
 modules.d/95zfcp/installkernel                     |    7 -
 modules.d/95zfcp/module-setup.sh                   |   34 ++++
 modules.d/95znet/check                             |    8 -
 modules.d/95znet/install                           |    8 -
 modules.d/95znet/module-setup.sh                   |   22 ++
 modules.d/96insmodpost/check                       |    5 -
 modules.d/96insmodpost/install                     |    6 -
 modules.d/96insmodpost/module-setup.sh             |   17 ++
 modules.d/97biosdevname/check                      |    7 -
 modules.d/97biosdevname/install                    |   14 --
 modules.d/97biosdevname/module-setup.sh            |   18 ++
 modules.d/98selinux/install                        |    5 -
 modules.d/98selinux/module-setup.sh                |   20 ++
 modules.d/98selinux/selinux-loadpolicy.sh          |    4 +-
 modules.d/98syslog/check                           |    6 -
 modules.d/98syslog/install                         |   29 ---
 modules.d/98syslog/module-setup.sh                 |   41 ++++
 modules.d/99base/check                             |    6 -
 modules.d/99base/init                              |   16 +-
 modules.d/99base/install                           |   32 ---
 modules.d/99base/module-setup.sh                   |   45 +++++
 137 files changed, 1838 insertions(+), 1583 deletions(-)
 delete mode 100755 modules.d/00bootchart/check
 delete mode 100755 modules.d/00bootchart/install
 create mode 100755 modules.d/00bootchart/module-setup.sh
 delete mode 100755 modules.d/00dash/check
 delete mode 100755 modules.d/00dash/install
 create mode 100755 modules.d/00dash/module-setup.sh
 delete mode 100755 modules.d/01fips/check
 delete mode 100755 modules.d/01fips/install
 delete mode 100755 modules.d/01fips/installkernel
 create mode 100755 modules.d/01fips/module-setup.sh
 delete mode 100755 modules.d/05busybox/check
 delete mode 100755 modules.d/05busybox/install
 create mode 100755 modules.d/05busybox/module-setup.sh
 delete mode 100755 modules.d/10i18n/check
 delete mode 100755 modules.d/10i18n/install
 create mode 100755 modules.d/10i18n/module-setup.sh
 delete mode 100755 modules.d/10rpmversion/check
 delete mode 100755 modules.d/10rpmversion/install
 create mode 100755 modules.d/10rpmversion/module-setup.sh
 delete mode 100755 modules.d/40network/check
 delete mode 100755 modules.d/40network/install
 delete mode 100755 modules.d/40network/installkernel
 create mode 100755 modules.d/40network/module-setup.sh
 delete mode 100755 modules.d/45ifcfg/check
 delete mode 100755 modules.d/45ifcfg/install
 rename modules.d/{98selinux/check =3D> 45ifcfg/module-setup.sh} (51%)
 delete mode 100755 modules.d/50gensplash/check
 delete mode 100755 modules.d/50gensplash/install
 create mode 100755 modules.d/50gensplash/module-setup.sh
 delete mode 100755 modules.d/50plymouth/check
 delete mode 100755 modules.d/50plymouth/install
 delete mode 100755 modules.d/50plymouth/installkernel
 create mode 100755 modules.d/50plymouth/module-setup.sh
 delete mode 100755 modules.d/60xen/check
 delete mode 100755 modules.d/60xen/install
 delete mode 100755 modules.d/60xen/installkernel
 create mode 100755 modules.d/60xen/module-setup.sh
 delete mode 100755 modules.d/90btrfs/check
 delete mode 100755 modules.d/90btrfs/install
 create mode 100755 modules.d/90btrfs/module-setup.sh
 delete mode 100755 modules.d/90crypt/check
 delete mode 100755 modules.d/90crypt/install
 delete mode 100755 modules.d/90crypt/installkernel
 create mode 100755 modules.d/90crypt/module-setup.sh
 delete mode 100755 modules.d/90dm/check
 delete mode 100755 modules.d/90dm/install
 delete mode 100755 modules.d/90dm/installkernel
 create mode 100755 modules.d/90dm/module-setup.sh
 delete mode 100755 modules.d/90dmraid/check
 delete mode 100755 modules.d/90dmraid/install
 create mode 100755 modules.d/90dmraid/module-setup.sh
 delete mode 100755 modules.d/90dmsquash-live/check
 delete mode 100755 modules.d/90dmsquash-live/install
 create mode 100755 modules.d/90dmsquash-live/module-setup.sh
 delete mode 100755 modules.d/90kernel-modules/install
 delete mode 100755 modules.d/90kernel-modules/installkernel
 create mode 100755 modules.d/90kernel-modules/module-setup.sh
 delete mode 100755 modules.d/90lvm/check
 delete mode 100755 modules.d/90lvm/install
 create mode 100755 modules.d/90lvm/module-setup.sh
 delete mode 100755 modules.d/90mdraid/check
 delete mode 100755 modules.d/90mdraid/install
 delete mode 100755 modules.d/90mdraid/installkernel
 create mode 100755 modules.d/90mdraid/module-setup.sh
 delete mode 100755 modules.d/90multipath/check
 delete mode 100755 modules.d/90multipath/install
 delete mode 100755 modules.d/90multipath/installkernel
 create mode 100755 modules.d/90multipath/module-setup.sh
 delete mode 100755 modules.d/95dasd/check
 delete mode 100755 modules.d/95dasd/install
 delete mode 100755 modules.d/95dasd/installkernel
 create mode 100755 modules.d/95dasd/module-setup.sh
 delete mode 100755 modules.d/95dasd_mod/check
 delete mode 100755 modules.d/95dasd_mod/install
 delete mode 100755 modules.d/95dasd_mod/installkernel
 create mode 100755 modules.d/95dasd_mod/module-setup.sh
 delete mode 100755 modules.d/95debug/check
 delete mode 100755 modules.d/95debug/install
 create mode 100755 modules.d/95debug/module-setup.sh
 delete mode 100755 modules.d/95fcoe/check
 delete mode 100755 modules.d/95fcoe/install
 delete mode 100755 modules.d/95fcoe/installkernel
 create mode 100755 modules.d/95fcoe/module-setup.sh
 delete mode 100755 modules.d/95fstab-sys/check
 delete mode 100755 modules.d/95fstab-sys/install
 create mode 100755 modules.d/95fstab-sys/module-setup.sh
 delete mode 100755 modules.d/95iscsi/check
 delete mode 100755 modules.d/95iscsi/install
 delete mode 100755 modules.d/95iscsi/installkernel
 create mode 100755 modules.d/95iscsi/module-setup.sh
 delete mode 100755 modules.d/95nbd/check
 delete mode 100755 modules.d/95nbd/install
 delete mode 100755 modules.d/95nbd/installkernel
 create mode 100755 modules.d/95nbd/module-setup.sh
 delete mode 100755 modules.d/95nfs/check
 delete mode 100755 modules.d/95nfs/install
 delete mode 100755 modules.d/95nfs/installkernel
 create mode 100755 modules.d/95nfs/module-setup.sh
 delete mode 100755 modules.d/95resume/install
 create mode 100755 modules.d/95resume/module-setup.sh
 delete mode 100755 modules.d/95rootfs-block/install
 create mode 100755 modules.d/95rootfs-block/module-setup.sh
 delete mode 100755 modules.d/95terminfo/install
 create mode 100755 modules.d/95terminfo/module-setup.sh
 delete mode 100755 modules.d/95udev-rules/install
 create mode 100755 modules.d/95udev-rules/module-setup.sh
 delete mode 100755 modules.d/95zfcp/check
 delete mode 100755 modules.d/95zfcp/install
 delete mode 100755 modules.d/95zfcp/installkernel
 create mode 100755 modules.d/95zfcp/module-setup.sh
 delete mode 100755 modules.d/95znet/check
 delete mode 100755 modules.d/95znet/install
 create mode 100755 modules.d/95znet/module-setup.sh
 delete mode 100755 modules.d/96insmodpost/check
 delete mode 100755 modules.d/96insmodpost/install
 create mode 100755 modules.d/96insmodpost/module-setup.sh
 delete mode 100755 modules.d/97biosdevname/check
 delete mode 100755 modules.d/97biosdevname/install
 create mode 100755 modules.d/97biosdevname/module-setup.sh
 delete mode 100755 modules.d/98selinux/install
 create mode 100755 modules.d/98selinux/module-setup.sh
 delete mode 100755 modules.d/98syslog/check
 delete mode 100755 modules.d/98syslog/install
 create mode 100755 modules.d/98syslog/module-setup.sh
 delete mode 100755 modules.d/99base/check
 delete mode 100755 modules.d/99base/install
 create mode 100755 modules.d/99base/module-setup.sh


--=20
dracut - Initramfs generator using udev
