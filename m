From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] add pre-pivot-cleanup hook
Date: Thu, 19 Apr 2012 12:01:36 +0800
Message-ID: <20120419040136.GA17472@localhost.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Sometimes some hook script will need to be before the cleanup hook scripts
For example dhclient killing, nfs cleanup, etc. must not happen before kdump
because it will use their fuctionalities.

So here introduce a new hook pre-pivot-cleanup, all cleanup scripts will go there.
that means pre-pivot hook is splited to two hooks pre-pivot and pre-pivot-cleanup

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 README.modules           |    3 +++
 dracut-functions.sh      |    2 +-
 dracut.asc               |    7 ++++++-
 dracut.cmdline.7.asc     |    2 +-
 modules.d/99base/init.sh |    7 ++++++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/README.modules b/README.modules
index 21461de..188d011 100644
--- a/README.modules
+++ b/README.modules
@@ -103,6 +103,9 @@ init has the following hook points to inject scripts:
    a timeout.
 
 /lib/dracut/hooks/pre-pivot/*.sh
+   scripts to run before latter initramfs cleanups
+
+/lib/dracut/hooks/pre-pivot-cleanup/*.sh
    scripts to run before the real init is executed and the initramfs
    disappears
    All processes started before should be killed here.
diff --git a/dracut-functions.sh b/dracut-functions.sh
index 910f2d8..8ea5464 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -36,7 +36,7 @@ fi
 [[ $hookdirs ]] || {
     hookdirs="cmdline pre-udev pre-trigger netroot "
     hookdirs+="initqueue initqueue/settled initqueue/online initqueue/finished initqueue/timeout "
-    hookdirs+="pre-mount pre-pivot mount "
+    hookdirs+="pre-mount pre-pivot pre-pivot-cleanup mount "
     hookdirs+="emergency shutdown-emergency shutdown cleanup "
     export hookdirs
 }
diff --git a/dracut.asc b/dracut.asc
index 1a0e3d2..1f81d12 100644
--- a/dracut.asc
+++ b/dracut.asc
@@ -854,12 +854,17 @@ This hook is mainly to mount the real root device.
 
 === Hook: pre-pivot
 
+This hook is called before pre-pivot-cleanup hook, This is a good place for
+actions other than cleanups which need to be called before pivot.
+
+
+=== Hook: pre-pivot-cleanup
+
 This hook is the last hook and is called before init finally switches root to
 the real root device. This is a good place to clean up and kill processes not
 needed anymore.
 
 
-
 === Cleanup and switch_root
 
 Init kills all udev processes, cleans up the environment, sets up the arguments
diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index a1e06dd..fa4f0e1 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -94,7 +94,7 @@ Debug
 **rd.break**::
     drop to a shell at the end
 
-**rd.break=**_{cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot}_::
+**rd.break=**_{cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot|pre-pivot-cleanup}_::
     drop to a shell on defined breakpoint
 
 **rd.udev.info**::
diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 2f87a20..3fc0082 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -224,10 +224,15 @@ done
     while read dev mp rest; do [ "$mp" = "$NEWROOT" ] && echo $dev; done < /proc/mounts
 } | vinfo
 
-# pre pivot scripts are sourced just before we switch over to the new root.
+# pre pivot scripts are sourced just before we doing cleanup and switch over
+# to the new root.
 getarg 'rd.break=pre-pivot' 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
 source_hook pre-pivot
 
+# pre pivot cleanup scripts are sourced just before we switch over to the new root.
+getarg 'rd.break=pre-pivot-cleanup' 'rdbreak=pre-pivot-cleanup' && emergency_shell -n pre-pivot-cleanup "Break pre-pivot-cleanup"
+source_hook pre-pivot-cleanup
+
 # By the time we get here, the root filesystem should be mounted.
 # Try to find init. 
 for i in "$(getarg real_init=)" "$(getarg init=)" $(getargs rd.distroinit=) /sbin/init; do
--
1.7.1
