From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] add 99memdebug-ko dracut module
Date: Thu, 3 Nov 2016 19:52:56 +0800
Message-ID: <581B2518.6060503@redhat.com>
References: <1478077386-30039-1-git-send-email-xlpang@redhat.com>
 <20161103030142.GA3201@dhcp-128-65.nay.redhat.com>
 <581AB9D7.2010905@redhat.com> <581AE707.9050606@redhat.com>
 <20161103083826.GA15431@dhcp-128-65.nay.redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161103083826.GA15431-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 2016/11/03 at 16:38, Dave Young wrote:
> On 11/03/16 at 03:28pm, Xunlei Pang wrote:
> [snip]
>>> For large trace data(tested on rhel7, the filter doesn't work on rhel7, and will produce huge trace data),
>>> the time consumption is huge, I am afraid in minutes because I once suspected the script was in some
>>> dead loop when parsing "tracing/trace" directly. It is the same situation when turning off tracing_on and
>>> try again.
>> Although I don't know why, after I replaced the following scripts
>> 1)
>> while read pid cpu flags ts function
>> do
>>     ... ...
>> done < "$TRACE_BASE/tracing/trace"
>>
>> with
>>
>> 2)
>> cat "$TRACE_BASE/tracing/trace" | while read pid cpu flags ts function
>> do
>>     ... ...
>> done
>>
>> 2) became not time-consuming just like parsing the copied filename in 1) ...
> Maybe 1) read the sysfs file a lot of times, but 2) only once then
> parsing them in pipe which is quiker.
>
> It should be fine if 2) is acceptable, but if the data is very large it
> may worth to use some external program like awk which will be faster.

Hi Dave,

What do you think the following approach?

============== [PATCH 1/2] ================
---
 modules.d/99base/memdebug-ko.sh | 119 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100755 modules.d/99base/memdebug-ko.sh

diff --git a/modules.d/99base/memdebug-ko.sh b/modules.d/99base/memdebug-ko.sh
new file mode 100755
index 0000000..2839966
--- /dev/null
+++ b/modules.d/99base/memdebug-ko.sh
@@ -0,0 +1,119 @@
+# Try to find out kernel modules with large total memory allocation during loading.
+# For large slab allocation, it will fall into buddy, thus tracing "mm_page_alloc"
+# alone should be enough for the purpose.
+
+# "sys/kernel/tracing" has the priority if exists.
+get_trace_base() {
+    # trace access through debugfs would be obsolete if "/sys/kernel/tracing" is available.
+    if [[ -d "/sys/kernel/tracing" ]]; then
+        echo "/sys/kernel"
+    else
+        echo "/sys/kernel/debug"
+    fi
+}
+
+is_trace_data_prepared() {
+    local trace_base
+
+    trace_base=$(get_trace_base)
+    # old debugfs interface case.
+    if ! [[ -d "$trace_base/tracing" ]]; then
+        mount none -t debugfs $trace_base
+    # new tracefs interface case.
+    elif ! [[ -f "$trace_base/tracing/trace" ]]; then
+        mount none -t tracefs "$trace_base/tracing"
+    fi
+
+    if ! [[ -f "$trace_base/tracing/trace" ]]; then
+        echo "WARN: Mount trace failed for kernel module memory analyzing."
+        return 1
+    fi
+
+    MATCH_EVENTS="module:module_put module:module_load kmem:mm_page_alloc"
+    SET_EVENTS=$(echo $(cat $trace_base/tracing/set_event))
+    # Check if trace was properly setup, prepare it if not.
+    if [[ $(cat $trace_base/tracing/tracing_on) != 1 ]] || \
+        [[ "$SET_EVENTS" != "$MATCH_EVENTS" ]]; then
+        # Set our trace events.
+        echo $MATCH_EVENTS > $trace_base/tracing/set_event
+
+        # There are three kinds of known applications for module loading:
+        # "systemd-udevd", "modprobe" and "insmod".
+        # Set them to the mm_page_alloc event filter.
+        # NOTE: Some kernel may not support this format of filter, anyway
+        #       the operation will fail and it doesn't matter.
+        page_alloc_filter="comm == systemd-udevd || comm == modprobe || comm == insmod"
+        echo $page_alloc_filter > $trace_base/tracing/events/kmem/mm_page_alloc/filter
+
+        # Set the number of comm-pid if supported.
+        if [[ -f "$trace_base/tracing/saved_cmdlines_size" ]]; then
+            # Thanks to filters, 4096 is big enough(also well supported).
+            echo 4096 > $trace_base/tracing/saved_cmdlines_size
+        fi
+
+        # Enable and clear trace data for the first time.
+        echo 1 > $trace_base/tracing/tracing_on
+        echo > $trace_base/tracing/trace
+        echo "Prepare trace success."
+        return 1
+    fi
+
+    return 0
+}
+
+parse_trace_data() {
+    local module_name
+    # Indexed by task pid.
+    local -A current_module
+    # Indexed by module name.
+    local -A module_loaded
+    local -A nr_alloc_pages
+
+    cat "$(get_trace_base)/tracing/trace" | while read pid cpu flags ts function
+    do
+        # Skip comment lines
+        if [[ $pid = "#" ]]; then
+            continue
+        fi
+
+        if [[ $function = module_load* ]]; then
+            # One module is being loaded, save the task pid for tracking.
+            module_name=${function#*: }
+            # Remove the trailing after whitespace, there may be the module flags.
+            module_name=${module_name%% *}
+            # Mark current_module to track the task.
+            current_module[$pid]="$module_name"
+            [[ ${module_loaded[$module_name]} ]] && echo "WARN: \"$module_name\" was loaded multiple times!"
+            unset module_loaded[$module_name]
+            nr_alloc_pages[$module_name]=0
+            continue
+        fi
+
+        if ! [[ ${current_module[$pid]} ]]; then
+            continue
+        fi
+
+        # Once we get here, the task is being tracked(is loading a module).
+        # Get the module name.
+        module_name=${current_module[$pid]}
+
+        if [[ $function = module_put* ]]; then
+            # Mark the module as loaded when the first module_put event happens after module_load.
+            echo "${nr_alloc_pages[$module_name]} pages consumed by \"$module_name\""
+            module_loaded[$module_name]=1
+            # Module loading finished, so untrack the task.
+            unset current_module[$pid]
+            continue
+        fi
+
+        if [[ $function = mm_page_alloc* ]]; then
+            order=$(echo $function | sed -e 's/.*order=\([0-9]*\) .*/\1/')
+            nr_alloc_pages[$module_name]=$((${nr_alloc_pages[$module_name]}+$((2 ** $order))))
+        fi
+    done
+}
+
+if is_trace_data_prepared ; then
+    echo "showkomem - memory consumption of loading kernel modules(the larger, the more precise)"
+    parse_trace_data
+fi
-- 
1.8.3.1

============== [PATCH 2/2] ================
---
 modules.d/98dracut-systemd/dracut-cmdline.sh     |  2 +-
 modules.d/98dracut-systemd/dracut-mount.sh       |  2 +-
 modules.d/98dracut-systemd/dracut-pre-mount.sh   |  2 +-
 modules.d/98dracut-systemd/dracut-pre-pivot.sh   |  2 +-
 modules.d/98dracut-systemd/dracut-pre-trigger.sh |  2 +-
 modules.d/98dracut-systemd/dracut-pre-udev.sh    |  2 +-
 modules.d/99base/dracut-lib.sh                   |  5 ++++-
 modules.d/99base/init.sh                         | 10 +++++-----
 modules.d/99base/module-setup.sh                 |  1 +
 9 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/modules.d/98dracut-systemd/dracut-cmdline.sh b/modules.d/98dracut-systemd/dracut-cmdline.sh
index 6c6ee02..bff9435 100755
--- a/modules.d/98dracut-systemd/dracut-cmdline.sh
+++ b/modules.d/98dracut-systemd/dracut-cmdline.sh
@@ -42,7 +42,7 @@ export root
 export rflags
 export fstype
 
-make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
+make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
 # run scriptlets to parse the command line
 getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
 source_hook cmdline
diff --git a/modules.d/98dracut-systemd/dracut-mount.sh b/modules.d/98dracut-systemd/dracut-mount.sh
index c4febfe..89ebc31 100755
--- a/modules.d/98dracut-systemd/dracut-mount.sh
+++ b/modules.d/98dracut-systemd/dracut-mount.sh
@@ -7,7 +7,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 source_conf /etc/conf.d
 
-make_trace_mem "hook mount" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 
 getarg 'rd.break=mount' -d 'rdbreak=mount' && emergency_shell -n mount "Break mount"
 # mount scripts actually try to mount the root filesystem, and may
diff --git a/modules.d/98dracut-systemd/dracut-pre-mount.sh b/modules.d/98dracut-systemd/dracut-pre-mount.sh
index ae51128..a3b9d29 100755
--- a/modules.d/98dracut-systemd/dracut-pre-mount.sh
+++ b/modules.d/98dracut-systemd/dracut-pre-mount.sh
@@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 source_conf /etc/conf.d
 
-make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
 getarg 'rd.break=pre-mount' 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
diff --git a/modules.d/98dracut-systemd/dracut-pre-pivot.sh b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
index cc70e3c..dfd328c 100755
--- a/modules.d/98dracut-systemd/dracut-pre-pivot.sh
+++ b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
@@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 source_conf /etc/conf.d
 
-make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
 getarg 'rd.break=pre-pivot' 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
diff --git a/modules.d/98dracut-systemd/dracut-pre-trigger.sh b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
index ac1ec36..7cd821e 100755
--- a/modules.d/98dracut-systemd/dracut-pre-trigger.sh
+++ b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
@@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 source_conf /etc/conf.d
 
-make_trace_mem "hook pre-trigger" "1:shortmem" "2+:mem" "3+:slab"
+make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 
 source_hook pre-trigger
 
diff --git a/modules.d/98dracut-systemd/dracut-pre-udev.sh b/modules.d/98dracut-systemd/dracut-pre-udev.sh
index ca13048..17268a1 100755
--- a/modules.d/98dracut-systemd/dracut-pre-udev.sh
+++ b/modules.d/98dracut-systemd/dracut-pre-udev.sh
@@ -7,7 +7,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 source_conf /etc/conf.d
 
-make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
 getarg 'rd.break=pre-udev' 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break pre-udev"
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 060b3fe..833ed5f 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -1206,7 +1206,7 @@ are_lists_eq() {
 
 setmemdebug() {
     if [ -z "$DEBUG_MEM_LEVEL" ]; then
-        export DEBUG_MEM_LEVEL=$(getargnum 0 0 3 rd.memdebug)
+        export DEBUG_MEM_LEVEL=$(getargnum 0 0 4 rd.memdebug)
     fi
 }
 
@@ -1296,6 +1296,9 @@ show_memstats()
         iomem)
             cat /proc/iomem
             ;;
+        komem)
+            showkomem
+            ;;
     esac
 }
 
diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index a563393..f0195d8 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -131,7 +131,7 @@ if ! getargbool 1 'rd.hostonly'; then
 fi
 
 # run scriptlets to parse the command line
-make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
+make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
 getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
 source_hook cmdline
 
@@ -141,7 +141,7 @@ source_hook cmdline
 export root rflags fstype netroot NEWROOT
 
 # pre-udev scripts run before udev starts, and are run only once.
-make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 getarg 'rd.break=pre-udev' -d 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break before pre-udev"
 source_hook pre-udev
 
@@ -160,7 +160,7 @@ fi
 
 udevproperty "hookdir=$hookdir"
 
-make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 getarg 'rd.break=pre-trigger' -d 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
 source_hook pre-trigger
 
@@ -230,7 +230,7 @@ unset RDRETRY
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
-make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 getarg 'rd.break=pre-mount' -d 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
 source_hook pre-mount
 
@@ -266,7 +266,7 @@ done
 
 # pre pivot scripts are sourced just before we doing cleanup and switch over
 # to the new root.
-make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
+make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
 getarg 'rd.break=pre-pivot' -d 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
 source_hook pre-pivot
 
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index b03772e..13019f0 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -35,6 +35,7 @@ install() {
     inst_script "$moddir/initqueue.sh" "/sbin/initqueue"
     inst_script "$moddir/loginit.sh" "/sbin/loginit"
     inst_script "$moddir/rdsosreport.sh" "/sbin/rdsosreport"
+    inst_script "$moddir/memdebug-ko.sh" "/sbin/showkomem"
 
     [ -e "${initdir}/lib" ] || mkdir -m 0755 -p ${initdir}/lib
     mkdir -m 0755 -p ${initdir}/lib/dracut
-- 
1.8.3.1

