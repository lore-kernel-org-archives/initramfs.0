From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. cbea975b987fb994c0911c94ea6c83743dead60e
Date: Wed, 26 Jan 2011 12:55:45 +0000
Message-ID: <E1Pi4ue-0000uQ-T9@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  cbea975b987fb994c0911c94ea6c83743dead60e (commit)
       via  26c4321fa981b14d6c07badf6dbbb0f12dc9634a (commit)
      from  2f25c3f4a563063684f0cecdaa87790dfcf9c1f6 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit cbea975b987fb994c0911c94ea6c83743dead60e
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Jan 26 13:53:43 2011 +0100

    fips: install .hmac files for cryptsetup and libs

diff --git a/modules.d/01fips/install b/modules.d/01fips/install
index 53f54de..31253cb 100755
--- a/modules.d/01fips/install
+++ b/modules.d/01fips/install
@@ -18,6 +18,13 @@ else
         /$libdir/libfreebl3.so /$libdir/libfreebl3.chk 
 fi
 
+if [ -e /sbin/.cryptsetup.hmac ]; then
+    for i in /sbin/.cryptsetup.hmac /$libdir/.libcryptsetup.so*.hmac; do
+        [ -e $i ] || continue
+        dracut_install $i
+    done
+fi
+
 dracut_install /usr/$libdir/hmaccalc/sha512hmac.hmac
 
 # vim:ts=8:sw=4:sts=4:et
commit 26c4321fa981b14d6c07badf6dbbb0f12dc9634a
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Jan 26 12:58:52 2011 +0100

    add 97biosdevname dracut module

diff --git a/dracut.8 b/dracut.8
index ce39061..f7bb9ce 100644
--- a/dracut.8
+++ b/dracut.8
@@ -284,7 +284,9 @@ Required if multiple ip= lines are used.
 .TP
 .BR nameserver= "<IP> [nameserver=<IP> ...]"
 specify nameserver(s) to use
-
+.TP
+.BR biosdevname={0|1]}
+turn off/on biosdevname network interface renaming
 .SS NFS
 .TP
 .BR root= "[<server-ip>:]<root-dir>[:<nfs-options>]"
diff --git a/modules.d/97biosdevname/check b/modules.d/97biosdevname/check
new file mode 100755
index 0000000..f269c69
--- /dev/null
+++ b/modules.d/97biosdevname/check
@@ -0,0 +1,7 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+type -P biosdevname >/dev/null || exit 1
+
+# do not enable bootchartd by default
+exit 0
diff --git a/modules.d/97biosdevname/install b/modules.d/97biosdevname/install
new file mode 100755
index 0000000..ba45e91
--- /dev/null
+++ b/modules.d/97biosdevname/install
@@ -0,0 +1,14 @@
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+dracut_install biosdevname
+inst_rules 71-biosdevname.rules
+inst_hook pre-trigger 30 "$moddir/parse-biosdevname.sh"
+
+# set the default state according to the config
+if [[ -e /etc/sysconfig/network ]]; then
+    . /etc/sysconfig/network
+fi
+
+if [[ "$BIOSDEVNAME" = "yes" ]]; then
+    echo "biosdevname=1" >> ${initdir}/etc/cmdline
+fi
diff --git a/modules.d/97biosdevname/parse-biosdevname.sh b/modules.d/97biosdevname/parse-biosdevname.sh
new file mode 100755
index 0000000..9b18d15
--- /dev/null
+++ b/modules.d/97biosdevname/parse-biosdevname.sh
@@ -0,0 +1,11 @@
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+USE_BIOSDEVNAME=$(getarg biosdevname)
+if [[ $USE_BIOSDEVNAME != "1" ]]; then
+    udevproperty UDEV_BIOSDEVNAME=
+    rm -f /etc/udev/rules.d/71-biosdevname.rules
+else
+    info "biosdevname=1: activating biosdevname network renaming"
+    udevproperty UDEV_BIOSDEVNAME=1
+fi
+
-----------------------------------------------------------------------

Summary of changes:
 dracut.8                                           |    4 +++-
 modules.d/01fips/install                           |    7 +++++++
 .../insmodpost.sh => 97biosdevname/check}          |    7 +++----
 modules.d/97biosdevname/install                    |   14 ++++++++++++++
 modules.d/97biosdevname/parse-biosdevname.sh       |   11 +++++++++++
 5 files changed, 38 insertions(+), 5 deletions(-)
 copy modules.d/{96insmodpost/insmodpost.sh => 97biosdevname/check} (58%)
 create mode 100755 modules.d/97biosdevname/install
 create mode 100755 modules.d/97biosdevname/parse-biosdevname.sh


-- 
dracut - Initramfs generator using udev
