From: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [dracut GIT] branch, master, updated. 1e64e4939f785a93fbb79ca814cf35023f264f2b
Date: Thu, 17 Mar 2011 11:14:04 GMT
Message-ID: <201103171114.p2HBE48O015203@hera.kernel.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  1e64e4939f785a93fbb79ca814cf35023f264f2b (commit)
       via  da22a021301d38500098a5c02fe0afacfb31cec4 (commit)
      from  432196aef8002572e0a512f2d45344e181050177 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 1e64e4939f785a93fbb79ca814cf35023f264f2b
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Mar 17 12:13:44 2011 +0100

    dracut-logger: turn off xtrace for log messages
    
    Turn off xtrace for log messages and turn it back on, if $debug is set.

diff --git a/dracut b/dracut
index 649637d..0c1cc14 100755
--- a/dracut
+++ b/dracut
@@ -433,7 +433,8 @@ export initdir hookdirs dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir \
-    stdloglvl sysloglvl fileloglvl kmsgloglvl logfile
+    stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
+    debug
 
 if [[ $kernel_only != yes ]]; then
     # Create some directory structure first
diff --git a/dracut-logger b/dracut-logger
index 830ce1c..f0c3eec 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -294,6 +294,7 @@ dlog() {
             _do_dlog "$1" "$line"
         done
     fi
+    [ -n "$debug" ] && set -x
     return 0
 }
 
@@ -302,6 +303,7 @@ dlog() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 dtrace() {
+    set +x
     dlog 6 "$@"
 }
 
@@ -310,6 +312,7 @@ dtrace() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 ddebug() {
+    set +x
     dlog 5 "$@"
 }
 
@@ -318,6 +321,7 @@ ddebug() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 dinfo() {
+    set +x
     dlog 4 "$@"
 }
 
@@ -326,6 +330,7 @@ dinfo() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 dwarn() {
+    set +x
     dlog 3 "$@"
 }
 
@@ -334,6 +339,7 @@ dwarn() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 dwarning() {
+    set +x
     dwarn "$@"
 }
 
@@ -342,6 +348,7 @@ dwarning() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 derror() {
+    set +x
     dlog 2 "$@"
 }
 
@@ -350,5 +357,6 @@ derror() {
 # @param msg Message.
 # @retval 0 It's always returned, even if logging failed.
 dfatal() {
+    set +x
     dlog 1 "$@"
 }
commit da22a021301d38500098a5c02fe0afacfb31cec4
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Mar 17 12:12:48 2011 +0100

    Makefile: split syntax check from target "check" to "syncheck"
    
    also add syntax check for the bash scripts

diff --git a/Makefile b/Makefile
index 1733c23..2d0c395 100644
--- a/Makefile
+++ b/Makefile
@@ -94,11 +94,17 @@ gitrpm: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 	mv dracut.spec.bak dracut.spec
 	rm -fr BUILD BUILDROOT
 
-check: all
-	@ret=0;for i in modules.d/99base/init modules.d/*/*.sh; do \
+syncheck:
+	@ret=0;for i in dracut-logger modules.d/99base/init modules.d/*/*.sh; do \
                 [ "$${i##*/}" = "module-setup.sh" ] && continue; \
+                [ "$${i##*/}" = "caps.sh" ] && continue; \
 		dash -n "$$i" ; ret=$$(($$ret+$$?)); \
 	done;exit $$ret
+	@ret=0;for i in dracut modules.d/02caps/caps.sh modules.d/*/module-setup.sh; do \
+		bash -n "$$i" ; ret=$$(($$ret+$$?)); \
+	done;exit $$ret
+
+check: all syncheck
 	$(MAKE) -C test check
 
 testimage: all
-----------------------------------------------------------------------

Summary of changes:
 Makefile      |   10 ++++++++--
 dracut        |    3 ++-
 dracut-logger |    8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


-- 
dracut - Initramfs generator using udev
