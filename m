From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Hooks and modules have a .sh extension
Date: Tue, 24 Feb 2009 05:00:01 GMT
Message-ID: <200902240500.n1O501ev010038@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=3f9c86ab865dfb8b33eb746729133c685c916b68
Commit:     3f9c86ab865dfb8b33eb746729133c685c916b68
Parent:     1c25acaac4f0a4a7360d61ccc76174f44aee6d60
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 20 09:24:18 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    Hooks and modules have a .sh extension
    
    This makes it trivial to filter out temporary files, editor backups,
    package management leftovers, etc.  Thanks, Kay for the idea.
---
 Makefile                                           |    4 ++--
 README                                             |    1 +
 dracut                                             |    6 +++---
 hooks/{cryptroot => cryptroot.sh}                  |    0
 hooks/{resume => resume.sh}                        |    0
 .../{selinux-loadpolicy => selinux-loadpolicy.sh}  |    0
 init                                               |    2 +-
 modules/{00dash => 00dash.sh}                      |    0
 modules/{10redhat-i18n => 10redhat-i18n.sh}        |    0
 modules/{90crypt => 90crypt.sh}                    |    2 +-
 modules/{90kernel-modules => 90kernel-modules.sh}  |    0
 modules/{90lvm => 90lvm.sh}                        |    0
 modules/{95debug => 95debug.sh}                    |    0
 modules/{95terminfo => 95terminfo.sh}              |    0
 modules/{95udev-rules => 95udev-rules.sh}          |    0
 modules/{99base => 99base.sh}                      |    4 ++--
 16 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 70d6782..dbc2a7d 100644
--- a/Makefile
+++ b/Makefile
@@ -12,8 +12,8 @@ install:
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
-	for hook in hooks/* ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
-	for module in modules/*; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
+	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
+	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 clean:
 	rm -f *~
 
diff --git a/README b/README
index abc282a..1c377b4 100644
--- a/README
+++ b/README
@@ -37,6 +37,7 @@ Some general rules for writing modules:
  * Generator modules should have a two digit numeric prefix -- they run in
    ascending sort order. Anything in the 90-99 range is stuff that dracut
    relies on, so try not to break those hooks.
+ * Generator modules and hooks must have a .sh extension. 
 
 Also, there is an attempt to keep things as distribution-agnostic as
 possible.  Every distribution has their own tool here and it's not
diff --git a/dracut b/dracut
index 1378268..c00944e 100755
--- a/dracut
+++ b/dracut
@@ -44,7 +44,7 @@ hookdirs="pre-udev pre-mount pre-pivot"
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
-export initdir hookdirs rulesdir dsrc dracutmodules kmodules
+export initdir hookdirs rulesdir dsrc dracutmodules modules
 
 # Create some directory structure first
 for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
@@ -52,8 +52,8 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
 done
 
 # source all our modules
-for f in "$dsrc/modules"/*[^~]; do
-    mod=${f##*/}; mod=${mod#[0-9][0-9]}
+for f in "$dsrc/modules"/*.sh; do
+    mod=${f##*/}; mod=${mod#[0-9][0-9]}; mod=${mod%.sh}
     if [[ $dracutmodules = all ]] || strstr "$dracutmodules" "$mod"; then 
 	[[ -x $f ]] && . "$f"
     fi
diff --git a/hooks/cryptroot b/hooks/cryptroot.sh
similarity index 100%
rename from hooks/cryptroot
rename to hooks/cryptroot.sh
diff --git a/hooks/resume b/hooks/resume.sh
similarity index 100%
rename from hooks/resume
rename to hooks/resume.sh
diff --git a/hooks/selinux-loadpolicy b/hooks/selinux-loadpolicy.sh
similarity index 100%
rename from hooks/selinux-loadpolicy
rename to hooks/selinux-loadpolicy.sh
diff --git a/init b/init
index ad6c06f..06689a6 100755
--- a/init
+++ b/init
@@ -24,7 +24,7 @@ getarg() {
 source_all() {
     local f
     [ "$1" ] && [  -d "/$1" ] || return
-    for f in "/$1"/*; do [ -f "$f" ] && . "$f"; done
+    for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
 }
 
 echo "Starting initrd..."
diff --git a/modules/00dash b/modules/00dash.sh
similarity index 100%
rename from modules/00dash
rename to modules/00dash.sh
diff --git a/modules/10redhat-i18n b/modules/10redhat-i18n.sh
similarity index 100%
rename from modules/10redhat-i18n
rename to modules/10redhat-i18n.sh
diff --git a/modules/90crypt b/modules/90crypt.sh
similarity index 58%
rename from modules/90crypt
rename to modules/90crypt.sh
index 66d7e70..9793a4f 100755
--- a/modules/90crypt
+++ b/modules/90crypt.sh
@@ -1,4 +1,4 @@
 #!/bin/bash
 inst cryptsetup
 inst_rules "$dsrc/rules.d/63-luks.rules"
-inst_hook pre-mount 50 "$dsrc/hooks/cryptroot"
\ No newline at end of file
+inst_hook pre-mount 50 "$dsrc/hooks/cryptroot.sh"
\ No newline at end of file
diff --git a/modules/90kernel-modules b/modules/90kernel-modules.sh
similarity index 100%
rename from modules/90kernel-modules
rename to modules/90kernel-modules.sh
diff --git a/modules/90lvm b/modules/90lvm.sh
similarity index 100%
rename from modules/90lvm
rename to modules/90lvm.sh
diff --git a/modules/95debug b/modules/95debug.sh
similarity index 100%
rename from modules/95debug
rename to modules/95debug.sh
diff --git a/modules/95terminfo b/modules/95terminfo.sh
similarity index 100%
rename from modules/95terminfo
rename to modules/95terminfo.sh
diff --git a/modules/95udev-rules b/modules/95udev-rules.sh
similarity index 100%
rename from modules/95udev-rules
rename to modules/95udev-rules.sh
diff --git a/modules/99base b/modules/99base.sh
similarity index 63%
rename from modules/99base
rename to modules/99base.sh
index 4963beb..1d9f86e 100755
--- a/modules/99base
+++ b/modules/99base.sh
@@ -3,6 +3,6 @@ dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
 # install our scripts and hooks
 inst "$initfile" "/init"
 inst "$switchroot" "/sbin/switch_root"
-inst_hook pre-pivot 50 "$dsrc/hooks/selinux-loadpolicy"
-inst_hook pre-mount 99 "$dsrc/hooks/resume"
+inst_hook pre-pivot 50 "$dsrc/hooks/selinux-loadpolicy.sh"
+inst_hook pre-mount 99 "$dsrc/hooks/resume.sh"
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
