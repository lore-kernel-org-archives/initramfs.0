From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 07caee2662c97d302cde244a1f7b22f9a089fd3f
Date: Wed, 26 Jan 2011 12:55:58 +0000
Message-ID: <E1Pi4uo-0000vj-Ap@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  07caee2662c97d302cde244a1f7b22f9a089fd3f (commit)
      from  b43f4df540b28976526476d439017dd7f5211d00 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 07caee2662c97d302cde244a1f7b22f9a089fd3f
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Jan 26 12:58:52 2011 +0100

    add 97biosdevname dracut module

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 35cf255..21cfecd 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -439,6 +439,14 @@ Required if multiple ip= lines are used.</para>
             <para>specify nameserver(s) to use</para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>biosdevname=</envar><replaceable>{0|1}</replaceable>
+          </term>
+          <listitem>
+            <para>turn on/off biosdevname network interface renaming</para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2>
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
index 0000000..a108d46
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
+if [[ "$BIOSDEVNAME" = "no" ]]; then
+    echo "biosdevname=0" >> ${initdir}/etc/cmdline
+fi
diff --git a/modules.d/97biosdevname/parse-biosdevname.sh b/modules.d/97biosdevname/parse-biosdevname.sh
new file mode 100755
index 0000000..5ba0698
--- /dev/null
+++ b/modules.d/97biosdevname/parse-biosdevname.sh
@@ -0,0 +1,10 @@
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+if ! getargbool 1 biosdevname; then
+    info "biosdevname=0: removing biosdevname network renaming"
+    udevproperty UDEV_BIOSDEVNAME=
+    rm -f /etc/udev/rules.d/71-biosdevname.rules
+else
+    udevproperty UDEV_BIOSDEVNAME=1
+fi
+
-----------------------------------------------------------------------

Summary of changes:
 dracut.kernel.7.xml                            |    8 ++++++++
 modules.d/{00bootchart => 97biosdevname}/check |    4 ++--
 modules.d/97biosdevname/install                |   14 ++++++++++++++
 modules.d/97biosdevname/parse-biosdevname.sh   |   10 ++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)
 copy modules.d/{00bootchart => 97biosdevname}/check (76%)
 create mode 100755 modules.d/97biosdevname/install
 create mode 100755 modules.d/97biosdevname/parse-biosdevname.sh


-- 
dracut - Initramfs generator using udev
