From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] add 99memdebug-ko dracut module
Date: Thu, 3 Nov 2016 12:15:19 +0800
Message-ID: <581AB9D7.2010905@redhat.com>
References: <1478077386-30039-1-git-send-email-xlpang@redhat.com>
 <20161103030142.GA3201@dhcp-128-65.nay.redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161103030142.GA3201-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2016/11/03 at 11:01, Dave Young wrote:
> Hi Xunlei,
> On 11/02/16 at 05:03pm, Xunlei Pang wrote:
>> The current method for memory debug is to use "rd.memdebug=[0-3]",
>> it is not enough for debugging kernel modules. For example, when we
>> want to find out which kernel module consumes a large amount of memory,
>> "rd.memdebug=[0-3]" won't help too much.
>>
>> A better way is needed to achieve this requirement, this is useful for
>> kdump OOM debugging.
>>
>> The principle of this patch is to use kernel trace to track slab and
>> buddy allocation calls during kernel module loading(module_init), thus
>> we can analyze all the trace data and get the total memory consumption.
>> As for large slab allocation, it will probably fall into buddy allocation,
>> thus tracing "mm_page_alloc" alone should be enough for the purpose(this
>> saves quite some trace buffer memory, also large free is quite unlikey
>> during module loading, we neglect those memory free events).
>>
>> The trace events include memory calls under "tracing/events/":
>>   kmem/mm_page_alloc
>>
>> We also inpect the following events to detect the module loading:
>>   module/module_load
>>   module/module_put
>>
>> Since we use filters to trace events, the final trace data size won't
>> be too big. Users can adjust the trace buffer size via "trace_buf_size"
>> kernel boot command line as needed.
>>
>> We can get the module name and task pid from "module_load" event which
>> also mark the beginning of the loading, and module_put called by the
>> same task pid implies the end of the loading. So the memory events
>> recorded in between by the same task pid are consumed by this module
>> during loading(i.e. modprobe or module_init()).
>>
>> With these information, we can record the total memory(the larger, the
>> more precise the result will be) consumption involved by each kernel
>> module loading.
>>
>> Thus we introduce this dracut module to find out which kernel module
>> consumes a large amount of memory during loading. It uses "rd.memdebug=4"
>> as the tigger.
>>
>> After applying is patch and specifying "rd.memdebug=4", during booting
>> it will print out something below:
>> == debug_mem for kernel modules during loading begin ==
>> 0 pages consumed by "pata_acpi"
>> 0 pages consumed by "ata_generic"
>> 1 pages consumed by "drm"
>> 0 pages consumed by "ttm"
>> 0 pages consumed by "drm_kms_helper"
>> 835 pages consumed by "qxl"
>> 0 pages consumed by "mii"
>> 6 pages consumed by "8139cp"
>> 0 pages consumed by "virtio"
>> 0 pages consumed by "virtio_ring"
>> 9 pages consumed by "virtio_pci"
>> 1 pages consumed by "8139too"
>> 0 pages consumed by "serio_raw"
>> 0 pages consumed by "crc32c_intel"
>> 199 pages consumed by "virtio_console"
>> 0 pages consumed by "libcrc32c"
>> 9 pages consumed by "xfs"
>> == debug_mem for kernel modules during loading end ==
>>
>> From the print, we see clearly that "qxl" consumed lots of memory.
>>
>> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  dracut.spec                                    |  1 +
>>  modules.d/99memdebug-ko/memdebug-ko-parse.sh   | 93 ++++++++++++++++++++++++++
>>  modules.d/99memdebug-ko/memdebug-ko-prepare.sh | 60 +++++++++++++++++
>>  modules.d/99memdebug-ko/module-setup.sh        | 25 +++++++
>>  4 files changed, 179 insertions(+)
>>  create mode 100755 modules.d/99memdebug-ko/memdebug-ko-parse.sh
>>  create mode 100755 modules.d/99memdebug-ko/memdebug-ko-prepare.sh
>>  create mode 100755 modules.d/99memdebug-ko/module-setup.sh
>>
>> diff --git a/dracut.spec b/dracut.spec
>> index 7b9d675..3907b17 100644
>> --- a/dracut.spec
>> +++ b/dracut.spec
>> @@ -407,6 +407,7 @@ rm -rf -- $RPM_BUILD_ROOT
>>  %{dracutlibdir}/modules.d/98usrmount
>>  %{dracutlibdir}/modules.d/99base
>>  %{dracutlibdir}/modules.d/99fs-lib
>> +%{dracutlibdir}/modules.d/99memdebug-ko
>>  %{dracutlibdir}/modules.d/99shutdown
>>  %attr(0644,root,root) %ghost %config(missingok,noreplace) %{_localstatedir}/log/dracut.log
>>  %dir %{_sharedstatedir}/initramfs
>> diff --git a/modules.d/99memdebug-ko/memdebug-ko-parse.sh b/modules.d/99memdebug-ko/memdebug-ko-parse.sh
>> new file mode 100755
>> index 0000000..1542658
>> --- /dev/null
>> +++ b/modules.d/99memdebug-ko/memdebug-ko-parse.sh
>> @@ -0,0 +1,93 @@
>> +# Parse the trace data to find out the modules consuming large amount of memory.
>> +
>> +is_trace_data_available() {
>> +    # Only "rd.memdebug=4" is for the purpose.
>> +    if [[ $(getargnum 0 0 4 rd.memdebug) != 4 ]]; then
>> +        return 1
>> +    fi

Hi Dave,

Firstly, thanks for your valuable comments.

> The usage of rd.memdebug is different in other place, can we integrate
> it to the original rd.memdbug code?
>
> One concern it in this patch only parse the trace data at pre-pivot
> hook, so if oom happens earlier than that we will get nothing.
>
> Original rd.memdebug being added to several different point, if we
> integrate this to the framework then we can get the out put early.

Yes, they can be integrated together. My original thought is that to
just output the memory information for all the modules at one stage
where all modules are supposed to be loaded, as such can avoid printing
redundant/partial information if at multiple stages(hooks).

If OOM happens (mainly for kdump cases), we can enlarge the reserved
crash memory and try again, because this feature itself might consume
large trace buffer memory.

But I can do in that way if you think it is fine.

>> +
>> +    TRACE_BASE="/sys/kernel/debug"
>> +    # trace access through debugfs would be obsolete if "/sys/kernel/tracing" is available.
>> +    if [[ -d "/sys/kernel/tracing" ]]; then
>> +        TRACE_BASE="/sys/kernel"
>> +    fi
>> +
>> +    if ! [[ -f "$TRACE_BASE/tracing/trace" ]]; then
>> +        warn "Trace inactive, skipping kernel module memory analyzing."
>> +        return 1
>> +    fi
> This function is only for checking if tracing is needed by checking
> cmdline, so getting the TRACE_BASE logic can be moved to
> parse_trace_data so that it can be a local variable..

It is actually in a function, will change it to be a local definition.

>
>> +
>> +    return 0
>> +}
>> +
>> +parse_trace_data() {
>> +    # Indexed by task pid.
>> +    declare -A current_module
>> +    # Indexed by module name.
>> +    declare -A module_loaded
>> +    declare -A nr_alloc_pages
>> +
>> +    # For large trace data, parsing "tracing/trace" directly turns out to be time-consuming,
>> +    # hence copy it out first, then parse the copy file instead.
> Have you get any data about the time used via traceing/trace parsing, if
> the time is still acceptable then it will be better to avoid the tmp
> file.

For large trace data(tested on rhel7, the filter doesn't work on rhel7, and will produce huge trace data),
the time consumption is huge, I am afraid in minutes because I once suspected the script was in some
dead loop when parsing "tracing/trace" directly. It is the same situation when turning off tracing_on and
try again.

>
>> +    TMPFILE=/tmp/kdump.trace.tmp.$$$$
>> +    cp $TRACE_BASE/tracing/trace $TMPFILE -f
>> +    while read pid cpu flags ts function ;
>> +    do
>> +        # Skip comment lines
>> +        if [[ $pid = "#" ]]; then
>> +            continue
>> +        fi
>> +
>> +        if [[ $function = module_load* ]]; then
>> +            # One module is being loaded, save the task pid for tracking.
>> +            module_name=${function#*: }
>> +            # Remove the trailing after whitespace, there may be the module flags.
>> +            module_name=${module_name%% *}
>> +            module_names+=" $module_name"
>> +            current_module[$pid]="$module_name"
>> +            [[ ${module_loaded[$module_name]} ]] && warn "\"$module_name\" was loaded multiple times!"
>> +            unset module_loaded[$module_name]
>> +            nr_alloc_pages[$module_name]=0
>> +        fi
>> +    
>> +        if ! [[ ${current_module[$pid]} ]]; then
>> +            continue
>> +        fi
>> +
>> +        if [[ $function = module_put* ]]; then
>> +            # Mark the module as loaded when the first module_put event happens after module_load.
>> +            module_loaded[${current_module[$pid]}]=1
>> +            # Module has been loaded when module_put is called, untrack the task
>> +            unset current_module[$pid]
>> +            continue
>> +        fi
>> +    
>> +        # Once we get here, the task is being tracked(is loading a module).
>> +        # Get the module name.
>> +        module_name=${current_module[$pid]}
>> +    
>> +        if [[ $function = mm_page_alloc* ]]; then
>> +            order=$(echo $function | sed -e 's/.*order=\([0-9]*\) .*/\1/')
>> +            nr_alloc_pages[$module_name]=$((${nr_alloc_pages[$module_name]}+$((2 ** $order))))
>> +        fi
>> +    done < $TMPFILE
>> +    
>> +    # Print the result out.
>> +    echo "== debug_mem for kernel modules during loading begin ==" >&2
>> +    for i in $module_names; do
>> +        status=""
>> +        if ! [[ ${module_loaded[$i]} ]]; then
>> +            status="[still loading]"
>> +        fi
>> +        echo "${nr_alloc_pages[$i]} pages consumed by \"$i\" $status" >&2
>> +    done
>> +    echo "== debug_mem for kernel modules during loading end ==" >&2
>> +    
>> +    unset module_names
>> +    unset module_loaded
> unset nr_alloc_pages?

nr_alloc_pages will be set to be 0 when module_load hits, but I will update or try to change them to be local.


>
>> +    rm $TMPFILE -f
>> +}
>> +
>> +if is_trace_data_available ; then
>> +    parse_trace_data
>> +fi
>> diff --git a/modules.d/99memdebug-ko/memdebug-ko-prepare.sh b/modules.d/99memdebug-ko/memdebug-ko-prepare.sh
>> new file mode 100755
>> index 0000000..134821a
>> --- /dev/null
>> +++ b/modules.d/99memdebug-ko/memdebug-ko-prepare.sh
>> @@ -0,0 +1,60 @@
>> +# Try to find out kernel modules with large total memory allocation during loading.
>> +# For large slab allocation, it will fall into buddy, thus tracing "mm_page_alloc"
>> +# alone should be enough for the purpose.
>> +#
>> +# Prepare for the trace setup.
>> +
>> +prepare_trace() {
>> +    # Only "rd.memdebug=4" is for the purpose.
>> +    if [[ $(getargnum 0 0 4 rd.memdebug) != 4 ]]; then
>> +        return 0
>> +    fi
>> +
>> +    TRACE_BASE="/sys/kernel/debug"
>> +    # trace access through debugfs would be obsolete if "/sys/kernel/tracing" is available.
>> +    if [[ -d "/sys/kernel/tracing" ]]; then
>> +        TRACE_BASE="/sys/kernel"
>> +    fi
> Move TRACE_BASE as a local variable, maybe a function..

It is in a function, will change it to be local.

>
>> +    
>> +    # old debugfs case.
>> +    if ! [[ -d "$TRACE_BASE/tracing" ]]; then
>> +        mount none -t debugfs $TRACE_BASE
>> +    # new tracefs case.
>> +    elif ! [[ -f "$TRACE_BASE/tracing/trace" ]]; then
>> +        mount none -t tracefs "$TRACE_BASE/tracing"
>> +    fi
>> +    
>> +    if ! [[ -f "$TRACE_BASE/tracing/trace" ]]; then
>> +        warn "Mount trace failed for kernel module memory analyzing."
>> +        return 1
>> +    fi
>> +    
>> +    MATCH_EVENTS="module:module_put module:module_load kmem:mm_page_alloc"
> Do we have module_init event? what is the difference between module_load
> and module_init?

module_load event is in some path of finit_module/init_module syscall, quite similar to
module_init, after the event there is do_init_module()->do_one_initcall() to invoke the
module init function, then module_put() immediately once finished which produces
module_put event. So between the two events, there are all the needed page allocation
events for us. I haven't see other better events.

Regards,
Xunlei

>
>> +    SET_EVENTS=$(echo $(cat $TRACE_BASE/tracing/set_event))
>> +    # Check if trace was properly setup, prepare it if not.
>> +    if [[ $(cat $TRACE_BASE/tracing/tracing_on) != 1 ]] || \
>> +        [[ "$SET_EVENTS" != "$MATCH_EVENTS" ]]; then
>> +        # Set our trace events.
>> +        echo $MATCH_EVENTS > $TRACE_BASE/tracing/set_event
>> +    
>> +        # There are three kinds of known applications for module loading:
>> +        # "systemd-udevd", "modprobe" and "insmod".
>> +        # Set them to the mm_page_alloc event filter.
>> +        # NOTE: Some kernel may not support this format of filter, anyway
>> +        #       the operation will fail and it doesn't matter.
>> +        page_alloc_filter="comm == systemd-udevd || comm == modprobe || comm == insmod"
>> +        echo $page_alloc_filter > $TRACE_BASE/tracing/events/kmem/mm_page_alloc/filter
>> +        
>> +        # Set the number of comm-pid.
>> +        # Thanks to filters, 4096 is big enough(also well supported).
>> +        echo 4096 > $TRACE_BASE/tracing/saved_cmdlines_size
>> +
>> +        # Enable and clear trace data for the first time.
>> +        echo 1 > $TRACE_BASE/tracing/tracing_on
>> +        echo > $TRACE_BASE/tracing/trace
>> +    fi
>> +
>> +    return 0
>> +}
>> +
>> +prepare_trace
>> diff --git a/modules.d/99memdebug-ko/module-setup.sh b/modules.d/99memdebug-ko/module-setup.sh
>> new file mode 100755
>> index 0000000..d6a7f0c
>> --- /dev/null
>> +++ b/modules.d/99memdebug-ko/module-setup.sh
>> @@ -0,0 +1,25 @@
>> +#!/bin/bash
>> +
>> +# called by dracut
>> +check() {
>> +    # this is very small, always add it.
>> +    # It has no effect if no "rd.memdebug=4" is specified, also
>> +    # this stays consistent with "rd.memdebug=[0-3]".
>> +    return 0
>> +}
>> +
>> +# called by dracut
>> +depends() {
>> +    return 0
>> +}
>> +
>> +# called by dracut
>> +install() {
>> +    # Prepare trace at the early stage before any ko modules is loaded.
>> +    inst_hook cmdline 00 "$moddir/memdebug-ko-prepare.sh"
>> +
>> +    # Before switching root to the real root, rootfs should be mounted
>> +    # and all dependent ko modules are expected to be loaded.
>> +    # We can parse trace data at this stage.
>> +    inst_hook pre-pivot 99 "$moddir/memdebug-ko-parse.sh"
>> +}
>> -- 
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
