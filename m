From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2 v2] Add memory usage trace to diffrent hook points
Date: Wed, 28 Nov 2012 16:45:24 +0800
Message-ID: <50B5CF24.6090006@redhat.com>
References: <20121126023852.GA6886@localhost.localdomain> <20121127223330.GG6964@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121127223330.GG6964-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org



Port mkdumprd memory trace functions wrote by jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
For kdump, memory usage tracing is important because there's limited
memory in kdump 2nd kernel.

Add a rd.memdebug cmdline for this. set rd.memdebug=<X> will set the
debug level to X which is the debug verbose level.

the format of cmdline is like below:
<level>[+]:<type>
<level> is the debug level
[+] means debug level >= <level>
<type> is the debug info type, as for this patch I added mem, iomem, slab
mem is for /proc/meminfo, iomem is for /proc/iomem, slab is for /proc/slabinfo
Also shortmem is the stripped /proc/meminfo which only includes 3 lines of
Memfree, Cached and Slab, for example:
MemFree:         6327176 kB
Cached:           741916 kB
Slab:              77284 kB

I added several trace point to the begin of several init hooks
At cmdline hooks I'm adding trace of "1+:mem 1+:iomem 3+:slab"
For other hooks I'm adding trace of "1:shortmem 2+:mem 3+:slab"

This means:
rd.memdebug=1)
  cmdline hook: print mem and iomem
  other hooks: print shortmem
rd.memdebug=2)
  cmdline hook: print mem and iomem
  other hooks: print mem
rd.memdebug=3):
  cmdline hook: print mem iomem, and slabinfo
  other hooks: print mem and slabinfo
*):
  do not print any mem debug info

[v1->v2]: update to use getargnum with <minval> as argument
          print iomem info at cmdline hook as well

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc                      |    4 +
 modules.d/98systemd/dracut-cmdline.sh     |    1 
 modules.d/98systemd/dracut-initqueue.sh   |    1 
 modules.d/98systemd/dracut-pre-pivot.sh   |    1 
 modules.d/98systemd/dracut-pre-trigger.sh |    1 
 modules.d/98systemd/dracut-pre-udev.sh    |    1 
 modules.d/99base/dracut-lib.sh            |   90 ++++++++++++++++++++++++++++++
 7 files changed, 99 insertions(+)

--- dracut.orig/modules.d/98systemd/dracut-cmdline.sh
+++ dracut/modules.d/98systemd/dracut-cmdline.sh
@@ -18,6 +18,7 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 
 source_conf /etc/conf.d
 
+make_trace_mem "hook cmdline" 1+:mem 1+:iomem 3+:slab
 # run scriptlets to parse the command line
 getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
 source_hook cmdline
--- dracut.orig/modules.d/98systemd/dracut-initqueue.sh
+++ dracut/modules.d/98systemd/dracut-initqueue.sh
@@ -10,6 +10,7 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 
 source_conf /etc/conf.d
 
+make_trace_mem "hook initqueue" 1:shortmem 2+:mem 3+:slab
 getarg 'rd.break=initqueue' -d 'rdbreak=initqueue' && emergency_shell -n initqueue "Break before initqueue"
 
 RDRETRY=$(getarg rd.retry -d 'rd_retry=')
--- dracut.orig/modules.d/98systemd/dracut-pre-pivot.sh
+++ dracut/modules.d/98systemd/dracut-pre-pivot.sh
@@ -10,6 +10,7 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 
 source_conf /etc/conf.d
 
+make_trace_mem "hook pre-pivot" 1:shortmem 2+:mem 3+:slab
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
 getarg 'rd.break=pre-pivot' 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
--- dracut.orig/modules.d/98systemd/dracut-pre-trigger.sh
+++ dracut/modules.d/98systemd/dracut-pre-trigger.sh
@@ -10,6 +10,7 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 
 source_conf /etc/conf.d
 
+make_trace_mem "hook pre-trigger" 1:shortmem 2+:mem 3+:slab
 getargbool 0 rd.udev.info -n -y rdudevinfo && udevadm control --log-priority=info
 getargbool 0 rd.udev.debug -n -y rdudevdebug && udevadm control --log-priority=debug
 udevproperty "hookdir=$hookdir"
--- dracut.orig/modules.d/98systemd/dracut-pre-udev.sh
+++ dracut/modules.d/98systemd/dracut-pre-udev.sh
@@ -9,6 +9,7 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 
 source_conf /etc/conf.d
 
+make_trace_mem "hook pre-udev" 1:shortmem 2+:mem 3+:slab
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
 getarg 'rd.break=pre-udev' 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break pre-udev"
--- dracut.orig/dracut.cmdline.7.asc
+++ dracut/dracut.cmdline.7.asc
@@ -134,6 +134,10 @@ Debug
     set -x for the dracut shell and logs to dmesg, console and
     _/run/initramfs/init.log_
 
+**rd.memdebug=[0-3]**::
+    print memory usage debug info, set the verbose level from 1 to 3
+    print nothing when set rd.memdebug=0
+
 **rd.break**::
     drop to a shell at the end
 
--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -998,3 +998,93 @@ listlist() {
 are_lists_eq() {
     listlist "$1" "$2" "$3" "$4" && listlist "$1" "$3" "$2" "$4"
 }
+
+setmemdebug() {
+    if [ -z "$DEBUG_MEM_LEVEL" ]; then
+        export DEBUG_MEM_LEVEL=$(getargnum 0 0 3 rd.memdebug)
+    fi
+}
+
+setmemdebug
+
+# parameters: msg [trace_level:trace]...
+function make_trace_mem()
+{
+    msg=$1
+    shift
+    if [ "$DEBUG_MEM_LEVEL" -gt 0 ]; then
+        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@"
+    fi
+}
+
+# parameters: func log_level prefix msg [trace_level:trace]...
+function make_trace()
+{
+    func=$1
+    shift
+
+    log_level=`echo "$1" | grep -o '^[0-9]\+'`
+    shift
+
+    prefix=$1
+    shift
+
+    msg=$1
+    shift
+
+    if [ -z "$log_level" ]; then
+        return
+    fi
+
+    msg=`echo "$msg" | sed 's/^\s\+//'`
+
+    msg_printed=0
+    while [ $# -gt 0 ]; do
+        trace_level=`echo "$1" | grep -o '^[0-9]\+'`
+        trace_in_higher_levels=`echo "$1" | grep -o '+'`
+        trace=`echo $1 | sed "s/^.*://"`
+
+        if [ -z "$trace_level" ]; then
+            trace_level=0
+        fi
+
+        insert_trace=0
+        if [ -n "$trace_in_higher_levels" ]; then
+            if [ "$log_level" -ge "$trace_level" ]; then
+                insert_trace=1
+            fi
+        else
+            if [ "$log_level" -eq "$trace_level" ]; then
+                insert_trace=1
+            fi
+        fi
+
+        if [ $insert_trace -eq 1 ]; then
+            if [ $msg_printed -eq 0 ]; then
+                echo "$prefix $msg"
+                msg_printed=1
+            fi
+            $func $trace
+        fi
+        shift
+    done
+}
+
+# parameters: type
+show_memstats()
+{
+    case $1 in
+        shortmem)
+            cat /proc/meminfo  | grep -e "^MemFree" -e "^Cached" -e "^Slab"
+            ;;
+        mem)
+            cat /proc/meminfo
+            ;;
+        slab)
+            cat /proc/slabinfo
+            ;;
+        iomem)
+            cat /proc/iomem
+            ;;
+    esac
+}
