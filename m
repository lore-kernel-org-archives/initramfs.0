From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 3/9] dracut: add cmdline hook
Date: Sun, 31 May 2009 23:33:56 -0400
Message-ID: <e450281431d31fb9d542c6f89692c861e07469bc.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This hook is where each module should parse kernel command line
options and perform any legacy translation.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 dracut                           |    2 +-
 modules.d/95resume/install       |    2 +-
 modules.d/95rootfs-block/install |    2 +-
 modules.d/99base/init            |    4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index f25cf85..84c194e 100755
--- a/dracut
+++ b/dracut
@@ -96,7 +96,7 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-hookdirs="pre-udev pre-mount pre-pivot mount emergency"
+hookdirs="cmdline pre-udev pre-mount pre-pivot mount emergency"
 
 readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
diff --git a/modules.d/95resume/install b/modules.d/95resume/install
index e656d53..945611e 100755
--- a/modules.d/95resume/install
+++ b/modules.d/95resume/install
@@ -1,5 +1,5 @@
 #!/bin/bash
 dracut_install echo
-inst_hook pre-udev 10 "$moddir/parse-resume.sh"
+inst_hook cmdline 10 "$moddir/parse-resume.sh"
 inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
 inst_hook mount 90 "$moddir/resume.sh"
diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-block/install
index 9d53855..722e47b 100755
--- a/modules.d/95rootfs-block/install
+++ b/modules.d/95rootfs-block/install
@@ -1,5 +1,5 @@
 #!/bin/sh
 dracut_install echo
-inst_hook pre-udev 20 "$moddir/parse-root-opts.sh"
+inst_hook cmdline 20 "$moddir/parse-root-opts.sh"
 inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 9ff2ff4..9ea4747 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -43,6 +43,10 @@ mknod /dev/console c 5 1
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 
+# run scriptlets to parse the command line
+getarg 'rdbreak=cmdline' && emergency_shell
+source_all cmdline
+
 # pre-udev scripts run before udev starts, and are run only once.
 getarg 'rdbreak=pre-udev' && emergency_shell
 source_all pre-udev
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
