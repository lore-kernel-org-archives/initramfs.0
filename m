From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 3/3] Add memdebug at different points in 99base/init.sh
Date: Wed, 13 Mar 2013 15:59:26 +0800
Message-ID: <20130313080319.316253869@redhat.com>
References: <20130313075923.845431353@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=mem-improve-2.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Previously I added several trace point to the begin of several
init hooks of systemd, old init script also need this debug info.

Doing same here as what's added in the systemd service scripts:
At cmdline hooks adding trace of "1+:mem 1+:iomem 3+:slab"
For other hooks adding trace of "1:shortmem 2+:mem 3+:slab"

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/init.sh |    7 +++++++
 1 file changed, 7 insertions(+)

--- dracut.orig/modules.d/99base/init.sh
+++ dracut/modules.d/99base/init.sh
@@ -109,6 +109,7 @@ fi
 source_conf /etc/conf.d
 
 # run scriptlets to parse the command line
+make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
 getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
 source_hook cmdline
 
@@ -118,6 +119,7 @@ source_hook cmdline
 export root rflags fstype netroot NEWROOT
 
 # pre-udev scripts run before udev starts, and are run only once.
+make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=pre-udev' -d 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break before pre-udev"
 source_hook pre-udev
 
@@ -136,6 +138,7 @@ getargbool 0 rd.udev.info -d -y rdudevin
 getargbool 0 rd.udev.debug -d -y rdudevdebug && udevadm control "$UDEV_LOG_PRIO_ARG=debug"
 udevproperty "hookdir=$hookdir"
 
+make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=pre-trigger' -d 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
 source_hook pre-trigger
 
@@ -144,6 +147,7 @@ udevadm control --reload >/dev/null 2>&1
 udevadm trigger --type=subsystems --action=add >/dev/null 2>&1
 udevadm trigger --type=devices --action=add >/dev/null 2>&1
 
+make_trace_mem "hook initqueue" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=initqueue' -d 'rdbreak=initqueue' && emergency_shell -n initqueue "Break before initqueue"
 
 RDRETRY=$(getarg rd.retry -d 'rd_retry=')
@@ -204,6 +208,7 @@ unset RDRETRY
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
+make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=pre-mount' -d 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
 source_hook pre-mount
 
@@ -239,9 +244,11 @@ done
 
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
+make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=pre-pivot' -d 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
 source_hook pre-pivot
 
+make_trace_mem "hook cleanup" '1:shortmem' '2+:mem' '3+:slab'
 # pre pivot cleanup scripts are sourced just before we switch over to the new root.
 getarg 'rd.break=cleanup' -d 'rdbreak=cleanup' && emergency_shell -n cleanup "Break cleanup"
 source_hook cleanup
