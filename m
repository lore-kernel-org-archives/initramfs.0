From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4] /usr/lib/dracut -> /usr/share/dracut
Date: Fri, 19 Jun 2009 14:01:16 +0200
Message-ID: <1245412879-4418-2-git-send-email-harald@redhat.com>
References: <1245412879-4418-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245412879-4418-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 Makefile         |    4 ++--
 dracut           |    6 +++---
 dracut-functions |    2 +-
 dracut.8         |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index f693ace..e70f309 100644
--- a/Makefile
+++ b/Makefile
@@ -2,8 +2,8 @@ VERSION=0.1
 GITVERSION=$(shell [ -d .git ] && git rev-list  --abbrev-commit  -n 1 HEAD  |cut -b 1-8)
 
 prefix = /usr
-libdir = ${prefix}/lib
-pkglibdir = ${libdir}/dracut
+datadir = ${prefix}/share
+pkglibdir = ${datadir}/dracut
 sysconfdir = ${prefix}/etc
 sbindir = ${prefix}/sbin
 mandir = ${prefix}/share/man
diff --git a/dracut b/dracut
index 16eae1a..f10af83 100755
--- a/dracut
+++ b/dracut
@@ -17,7 +17,7 @@ Creates initial ramdisk images for preloading modules
   -f, --force           Overwrite existing initramfs file.
   -m, --modules [LIST]  Specify a space-separated list of dracut modules to
                          call when building the initramfs. Modules are located
-                         in /usr/lib/dracut/modules.d.
+                         in /usr/share/dracut/modules.d.
   -o, --omit [LIST]     Omit a space-separated list of dracut modules.
   -d, --drivers [LIST]  Specify a space-separated list of kernel modules to
                          include in the initramfs.
@@ -28,7 +28,7 @@ Creates initial ramdisk images for preloading modules
                          Default: /etc/dracut.conf
   -l, --local           Local mode. Use modules from the current working
                          directory instead of the system-wide installed in
-                         /usr/lib/dracut/modules.d.
+                         /usr/share/dracut/modules.d.
                          Useful when running dracut from a git checkout.
   -H, --hostonly          Host-Only mode: Install only what is needed for
                          booting the local host instead of a generic host.
@@ -74,7 +74,7 @@ done
 [[ $dracutmodules_l ]] && dracutmodules=$dracutmodules_l
 [[ $omit_dracutmodules_l ]] && omit_dracutmodules=$omit_dracutmodules_l
 [[ $drivers_l ]] && drivers=$drivers_l
-[[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
+[[ $dracutbasedir ]] || dracutbasedir=/usr/share/dracut
 
 [[ $allowlocal && -f "$(dirname $0)/dracut-functions" ]] && dsrc="$(dirname $0)" || dsrc=$dracutbasedir
 
diff --git a/dracut-functions b/dracut-functions
index 501cf2a..d1c161d 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -30,7 +30,7 @@ strstr() { [[ ! ${1#*$2*} = $1 ]]; }
 
 # Log initrd creation.
 if ! [[ $dracutlogfile ]]; then
-    [[ $dsrc = /usr/lib/dracut ]] && \
+    [[ $dsrc = /usr/share/dracut ]] && \
        dracutlogfile=/var/log/dracut.log || \
        dracutlogfile=/tmp/dracut.log
     [[ -w "$dracutlogfile" ]] || dracutlogfile=/tmp/dracut.log
diff --git a/dracut.8 b/dracut.8
index 0ceccff..b83a3e0 100644
--- a/dracut.8
+++ b/dracut.8
@@ -19,7 +19,7 @@ overwrite existing initramfs file.
 specify a space-separated list of dracut modules to call 
 when building the initramfs. 
 Modules are located in 
-.IR /usr/lib/dracut/modules.d .
+.IR /usr/share/dracut/modules.d .
 .TP
 .BR \-o ", " \-\-omit " \fILIST\fR"
 omit a space-separated list of dracut modules.
@@ -44,7 +44,7 @@ Default:
 .BR \-l ", " \-\-local
 local mode. Use modules from the current working
 directory instead of the system-wide installed in
-.IR /usr/lib/dracut/modules.d .
+.IR /usr/share/dracut/modules.d .
 Useful when running dracut from a git checkout.
 .TP
 .BR \-H ", " \-\-hostonly
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
