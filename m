From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RFC 1/3] Create a self-contained structure for dracut modules
Date: Thu, 26 Feb 2009 16:02:47 -0800 (PST)
Message-ID: <fe553fde63ff13111aa00375b11923904c584326.1235692799.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=lXYdjjYJd4VXtSltwxART3V4rbuotuIaXXWE3lAvl7s=;
        b=d/Ef5L+dPnNdbMcFFPhsVZYRrfzvT5EtOcwisLEYeJNQBMGNy7A+Pdopg+TGuKKiNx
         c7s5s/mXU+KQ0GfQksS2RnKkBwjdprczocPKmeibu8p6yxSc58xNvYdENcTUdZ0RJGuX
         i0RCvqlyyXWamXmABXUl7qCd4CuxnunEiivpo=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

All modules now live in a subdirectory /modules.d.  Each module is
self-contained -- it should contain everything that it will install
on the initrd.  All modules must include a script named install, which
will be sourced by dracut.  This script should do the actual file installation
using inst methods.  The moddir variable will point to the full path to the
module dracut is currently working on.

As usual, this patch series applies on top of my previous patch series,
and is available as normalize-modules from http://git.fnordovax.org/dracut.
---
 dracut                                             |    8 +++++---
 modules/00dash.sh => modules.d/00dash/install      |    0
 .../10redhat-i18n/install                          |    0
 {rules.d => modules.d/40network}/60-net.rules      |    0
 .../40network/dhclient-script                      |    0
 ifup => modules.d/40network/ifup                   |    0
 modules.d/40network/install                        |    8 ++++++++
 {hooks => modules.d/40network}/kill-dhclient.sh    |    0
 {hooks => modules.d/40network}/run-dhclient.sh     |    0
 {rules.d => modules.d/90crypt}/63-luks.rules       |    0
 {hooks => modules.d/90crypt}/cryptroot.sh          |    0
 modules.d/90crypt/install                          |    4 ++++
 .../90kernel-modules/install                       |    0
 {rules.d => modules.d/90lvm}/64-lvm.rules          |    0
 modules.d/90lvm/install                            |    3 +++
 modules/95debug.sh => modules.d/95debug/install    |    0
 .../95terminfo.sh => modules.d/95terminfo/install  |    0
 .../95udev-rules/install                           |    0
 init => modules.d/99base/init                      |    0
 modules.d/99base/install                           |    8 ++++++++
 {hooks => modules.d/99base}/mount-partition.sh     |    0
 {hooks => modules.d/99base}/resume.sh              |    0
 {hooks => modules.d/99base}/selinux-loadpolicy.sh  |    0
 switch_root => modules.d/99base/switch_root        |    0
 modules/40network.sh                               |    8 --------
 modules/90crypt.sh                                 |    4 ----
 modules/90lvm.sh                                   |    3 ---
 modules/99base.sh                                  |    8 --------
 28 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/dracut b/dracut
index c00944e..3078241 100755
--- a/dracut
+++ b/dracut
@@ -52,12 +52,14 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
 done
 
 # source all our modules
-for f in "$dsrc/modules"/*.sh; do
-    mod=${f##*/}; mod=${mod#[0-9][0-9]}; mod=${mod%.sh}
+for moddir in "$dsrc/modules.d"/*; do
+    [[ -d $moddir || -L $moddir ]] || continue
+    mod=${moddir##*/}; mod=${mod#[0-9][0-9]};
     if [[ $dracutmodules = all ]] || strstr "$dracutmodules" "$mod"; then 
-	[[ -x $f ]] && . "$f"
+	[[ -x $moddir/install ]] && . "$moddir/install"
     fi
 done
+unset moddir
 
 ## final stuff that has to happen
 
diff --git a/modules/00dash.sh b/modules.d/00dash/install
similarity index 100%
rename from modules/00dash.sh
rename to modules.d/00dash/install
diff --git a/modules/10redhat-i18n.sh b/modules.d/10redhat-i18n/install
similarity index 100%
rename from modules/10redhat-i18n.sh
rename to modules.d/10redhat-i18n/install
diff --git a/rules.d/60-net.rules b/modules.d/40network/60-net.rules
similarity index 100%
rename from rules.d/60-net.rules
rename to modules.d/40network/60-net.rules
diff --git a/dhclient-script b/modules.d/40network/dhclient-script
similarity index 100%
rename from dhclient-script
rename to modules.d/40network/dhclient-script
diff --git a/ifup b/modules.d/40network/ifup
similarity index 100%
rename from ifup
rename to modules.d/40network/ifup
diff --git a/modules.d/40network/install b/modules.d/40network/install
new file mode 100755
index 0000000..3152f0d
--- /dev/null
+++ b/modules.d/40network/install
@@ -0,0 +1,8 @@
+#!/bin/bash
+dracut_install ip dhclient
+inst "$moddir/ifup" "/sbin/ifup"
+inst "$moddir/dhclient-script" "/sbin/dhclient-script"
+instmods =networking ecb arc4
+inst_rules "$moddir/60-net.rules"
+inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
+inst_hook pre-mount 70 "$moddir/run-dhclient.sh"
diff --git a/hooks/kill-dhclient.sh b/modules.d/40network/kill-dhclient.sh
similarity index 100%
rename from hooks/kill-dhclient.sh
rename to modules.d/40network/kill-dhclient.sh
diff --git a/hooks/run-dhclient.sh b/modules.d/40network/run-dhclient.sh
similarity index 100%
rename from hooks/run-dhclient.sh
rename to modules.d/40network/run-dhclient.sh
diff --git a/rules.d/63-luks.rules b/modules.d/90crypt/63-luks.rules
similarity index 100%
rename from rules.d/63-luks.rules
rename to modules.d/90crypt/63-luks.rules
diff --git a/hooks/cryptroot.sh b/modules.d/90crypt/cryptroot.sh
similarity index 100%
rename from hooks/cryptroot.sh
rename to modules.d/90crypt/cryptroot.sh
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
new file mode 100755
index 0000000..92b5169
--- /dev/null
+++ b/modules.d/90crypt/install
@@ -0,0 +1,4 @@
+#!/bin/bash
+inst cryptsetup
+inst_rules "$moddir/63-luks.rules"
+inst_hook mount 10 "$moddir/cryptroot.sh"
\ No newline at end of file
diff --git a/modules/90kernel-modules.sh b/modules.d/90kernel-modules/install
similarity index 100%
rename from modules/90kernel-modules.sh
rename to modules.d/90kernel-modules/install
diff --git a/rules.d/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
similarity index 100%
rename from rules.d/64-lvm.rules
rename to modules.d/90lvm/64-lvm.rules
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
new file mode 100755
index 0000000..68e0056
--- /dev/null
+++ b/modules.d/90lvm/install
@@ -0,0 +1,3 @@
+#!/bin/bash
+inst lvm
+inst_rules "$moddir/64-lvm.rules"
\ No newline at end of file
diff --git a/modules/95debug.sh b/modules.d/95debug/install
similarity index 100%
rename from modules/95debug.sh
rename to modules.d/95debug/install
diff --git a/modules/95terminfo.sh b/modules.d/95terminfo/install
similarity index 100%
rename from modules/95terminfo.sh
rename to modules.d/95terminfo/install
diff --git a/modules/95udev-rules.sh b/modules.d/95udev-rules/install
similarity index 100%
rename from modules/95udev-rules.sh
rename to modules.d/95udev-rules/install
diff --git a/init b/modules.d/99base/init
similarity index 100%
rename from init
rename to modules.d/99base/init
diff --git a/modules.d/99base/install b/modules.d/99base/install
new file mode 100755
index 0000000..f59bc43
--- /dev/null
+++ b/modules.d/99base/install
@@ -0,0 +1,8 @@
+#!/bin/bash
+dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
+# install our scripts and hooks
+inst "$moddir/init" "/init"
+inst "$moddir/switch_root" "/sbin/switch_root"
+inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
+inst_hook mount 90 "$moddir/resume.sh"
+inst_hook mount 99 "$moddir/mount-partition.sh"
diff --git a/hooks/mount-partition.sh b/modules.d/99base/mount-partition.sh
similarity index 100%
rename from hooks/mount-partition.sh
rename to modules.d/99base/mount-partition.sh
diff --git a/hooks/resume.sh b/modules.d/99base/resume.sh
similarity index 100%
rename from hooks/resume.sh
rename to modules.d/99base/resume.sh
diff --git a/hooks/selinux-loadpolicy.sh b/modules.d/99base/selinux-loadpolicy.sh
similarity index 100%
rename from hooks/selinux-loadpolicy.sh
rename to modules.d/99base/selinux-loadpolicy.sh
diff --git a/switch_root b/modules.d/99base/switch_root
similarity index 100%
rename from switch_root
rename to modules.d/99base/switch_root
diff --git a/modules/40network.sh b/modules/40network.sh
deleted file mode 100755
index b477a9c..0000000
--- a/modules/40network.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-dracut_install ip dhclient
-inst "$dsrc/ifup" "/sbin/ifup"
-inst "$dsrc/dhclient-script" "/sbin/dhclient-script"
-instmods =networking ecb arc4
-inst_rules "$dsrc/rules.d/60-net.rules"
-inst_hook pre-pivot 10 "$dsrc/hooks/kill-dhclient.sh"
-inst_hook pre-mount 70 "$dsrc/hooks/run-dhclient.sh"
diff --git a/modules/90crypt.sh b/modules/90crypt.sh
deleted file mode 100755
index 5e8f4cb..0000000
--- a/modules/90crypt.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-inst cryptsetup
-inst_rules "$dsrc/rules.d/63-luks.rules"
-inst_hook mount 10 "$dsrc/hooks/cryptroot.sh"
\ No newline at end of file
diff --git a/modules/90lvm.sh b/modules/90lvm.sh
deleted file mode 100755
index 315fbb8..0000000
--- a/modules/90lvm.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-inst lvm
-inst_rules "$dsrc/rules.d/64-lvm.rules"
\ No newline at end of file
diff --git a/modules/99base.sh b/modules/99base.sh
deleted file mode 100755
index 580fb03..0000000
--- a/modules/99base.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
-# install our scripts and hooks
-inst "$initfile" "/init"
-inst "$switchroot" "/sbin/switch_root"
-inst_hook pre-pivot 50 "$dsrc/hooks/selinux-loadpolicy.sh"
-inst_hook mount 90 "$dsrc/hooks/resume.sh"
-inst_hook mount 99 "$dsrc/hooks/mount-partition.sh"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
