From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] 99base: add memtrace-ko.sh to debug kernel module
 large memory consumption
Date: Wed, 16 Nov 2016 10:30:34 +0800
Message-ID: <20161116023034.GA3026@dhcp-128-65.nay.redhat.com>
References: <1479103886-24568-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479103886-24568-1-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/14/16 at 02:11pm, Xunlei Pang wrote:
> The current method for memory debug is to use "rd.memdebug=[0-3]",
> it is not enough for debugging kernel modules. For example, when we
> want to find out which kernel module consumes a large amount of memory,
> "rd.memdebug=[0-3]" won't help too much.
> 
> A better way is needed to achieve this requirement, this is useful for
> kdump OOM debugging.
> 
> The principle of this patch is to use kernel trace to track slab and
> buddy allocation calls during kernel module loading(module_init), thus
> we can analyze all the trace data and get the total memory consumption.
> As for large slab allocation, it will probably fall into buddy allocation,
> thus tracing "mm_page_alloc" alone should be enough for the purpose(this
> saves quite some trace buffer memory, also large free is quite unlikey
> during module loading, we neglect those memory free events).
> 
> The trace events include memory calls under "tracing/events/":
>   kmem/mm_page_alloc
> 
> We also inpect the following events to detect the module loading:
>   module/module_load
>   module/module_put
> 
> Since we use filters to trace events, the final trace data size won't
> be too big. Users can adjust the trace buffer size via "trace_buf_size"
> kernel boot command line as needed.
> 
> We can get the module name and task pid from "module_load" event which
> also mark the beginning of the loading, and module_put called by the
> same task pid implies the end of the loading. So the memory events
> recorded in between by the same task pid are consumed by this module
> during loading(i.e. modprobe or module_init()).
> 
> With these information, we can record the rough total memory(the larger,
> the more precise the result will be) consumption involved by each kernel
> module loading.
> 
> Thus we introduce this shell script to find out which kernel module
> consumes a large amount of memory during loading. Use "rd.memdebug=4"
> as the tigger.
> 
> After applying this patch and specifying "rd.memdebug=4", during booting
> it will print out something extra like below:
> 0 pages consumed by "pata_acpi"
> 0 pages consumed by "ata_generic"
> 1 pages consumed by "drm"
> 0 pages consumed by "ttm"
> 0 pages consumed by "drm_kms_helper"
> 835 pages consumed by "qxl"
> 0 pages consumed by "mii"
> 6 pages consumed by "8139cp"
> 0 pages consumed by "virtio"
> 0 pages consumed by "virtio_ring"
> 9 pages consumed by "virtio_pci"
> 1 pages consumed by "8139too"
> 0 pages consumed by "serio_raw"
> 0 pages consumed by "crc32c_intel"
> 199 pages consumed by "virtio_console"
> 0 pages consumed by "libcrc32c"
> 9 pages consumed by "xfs"
> 
> From the print, we see clearly that "qxl" consumed the most memory.
> 
> This file will be installed as a separate executable named "tracekomem"
> in the following patch.
> 
> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Series change from v2:
> Improved documentation, no functional change.
> 
>  modules.d/99base/memtrace-ko.sh | 169 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100755 modules.d/99base/memtrace-ko.sh
> 
> diff --git a/modules.d/99base/memtrace-ko.sh b/modules.d/99base/memtrace-ko.sh
> new file mode 100755
> index 0000000..f4720bf
> --- /dev/null
> +++ b/modules.d/99base/memtrace-ko.sh
> @@ -0,0 +1,169 @@
> +# Try to find out kernel modules with large total memory allocation during loading.
> +# For large slab allocation, it will fall into buddy, thus tracing "mm_page_alloc"
> +# alone should be enough for the purpose.
> +
> +# "sys/kernel/tracing" has the priority if exists.
> +get_trace_base() {
> +    # trace access through debugfs would be obsolete if "/sys/kernel/tracing" is available.
> +    if [[ -d "/sys/kernel/tracing" ]]; then
> +        echo "/sys/kernel"
> +    else
> +        echo "/sys/kernel/debug"
> +    fi
> +}
> +
> +# We want to enable these trace events.
> +get_want_events() {
> +    echo "module:module_put module:module_load kmem:mm_page_alloc"
> +}
> +
> +get_event_filter() {
> +    echo "comm == systemd-udevd || comm == modprobe || comm == insmod"
> +}
> +
> +is_trace_ready() {
> +    local trace_base want_events current_events
> +
> +    trace_base=$(get_trace_base)
> +    ! [[ -f "$trace_base/tracing/trace" ]] && return 1
> +
> +    [[ $(cat $trace_base/tracing/tracing_on) = 0 ]] && return 1
> +
> +    # Also check if trace events were properly setup.
> +    want_events=$(get_want_events)
> +    current_events=$(echo $(cat $trace_base/tracing/set_event))
> +    [[ "$current_events" != "$want_events" ]] && return 1
> +
> +    return 0
> +}
> +
> +prepare_trace() {
> +    local trace_base
> +
> +    trace_base=$(get_trace_base)
> +    # old debugfs interface case.
> +    if ! [[ -d "$trace_base/tracing" ]]; then
> +        mount none -t debugfs $trace_base
> +    # new tracefs interface case.
> +    elif ! [[ -f "$trace_base/tracing/trace" ]]; then
> +        mount none -t tracefs "$trace_base/tracing"
> +    fi
> +
> +    if ! [[ -f "$trace_base/tracing/trace" ]]; then
> +        echo "WARN: Mount trace failed for kernel module memory analyzing."
> +        return
> +    fi
> +
> +    # Active all the wanted trace events.
> +    echo "$(get_want_events)" > $trace_base/tracing/set_event
> +
> +    # There are three kinds of known applications for module loading:
> +    # "systemd-udevd", "modprobe" and "insmod".
> +    # Set them as the global events filter.
> +    # NOTE: Some kernel may not support this format of filter, anyway
> +    #       the operation will fail and it doesn't matter.
> +    echo "$(get_event_filter)" > $trace_base/tracing/events/kmem/filter
> +    echo "$(get_event_filter)" > $trace_base/tracing/events/module/filter
> +
> +    # Set the number of comm-pid if supported.
> +    if [[ -f "$trace_base/tracing/saved_cmdlines_size" ]]; then
> +        # Thanks to filters, 4096 is big enough(also well supported).
> +        echo 4096 > $trace_base/tracing/saved_cmdlines_size
> +    fi
> +
> +    # Enable and clear trace data for the first time.
> +    echo 1 > $trace_base/tracing/tracing_on
> +    echo > $trace_base/tracing/trace
> +    echo "Prepare trace success."
> +}
> +
> +parse_trace_data() {
> +    local module_name
> +    # Indexed by task pid.
> +    local -A current_module
> +    # Indexed by module name.
> +    local -A module_loaded
> +    local -A nr_alloc_pages
> +
> +    cat "$(get_trace_base)/tracing/trace" | while read pid cpu flags ts function
> +    do
> +        # Skip comment lines
> +        if [[ $pid = "#" ]]; then
> +            continue
> +        fi
> +
> +        if [[ $function = module_load* ]]; then
> +            # One module is being loaded, save the task pid for tracking.
> +            module_name=${function#*: }
> +            # Remove the trailing after whitespace, there may be the module flags.
> +            module_name=${module_name%% *}
> +            # Mark current_module to track the task.
> +            current_module[$pid]="$module_name"
> +            [[ ${module_loaded[$module_name]} ]] && echo "WARN: \"$module_name\" was loaded multiple times!"
> +            unset module_loaded[$module_name]
> +            nr_alloc_pages[$module_name]=0
> +            continue
> +        fi
> +
> +        if ! [[ ${current_module[$pid]} ]]; then
> +            continue
> +        fi
> +
> +        # Once we get here, the task is being tracked(is loading a module).
> +        # Get the module name.
> +        module_name=${current_module[$pid]}
> +
> +        if [[ $function = module_put* ]]; then
> +            # Mark the module as loaded when the first module_put event happens after module_load.
> +            echo "${nr_alloc_pages[$module_name]} pages consumed by \"$module_name\""
> +            module_loaded[$module_name]=1
> +            # Module loading finished, so untrack the task.
> +            unset current_module[$pid]
> +            continue
> +        fi
> +
> +        if [[ $function = mm_page_alloc* ]]; then
> +            order=$(echo $function | sed -e 's/.*order=\([0-9]*\) .*/\1/')
> +            nr_alloc_pages[$module_name]=$((${nr_alloc_pages[$module_name]}+$((2 ** $order))))
> +        fi
> +    done
> +}
> +
> +cleanup_trace() {
> +    local trace_base
> +
> +    if is_trace_ready; then
> +        trace_base=$(get_trace_base)
> +        echo 0 > $trace_base/tracing/tracing_on
> +        echo > $trace_base/tracing/trace
> +        echo > $trace_base/tracing/set_event
> +        echo 0 > $trace_base/tracing/events/kmem/filter
> +        echo 0 > $trace_base/tracing/events/module/filter
> +    fi
> +}
> +
> +show_usage() {
> +    echo "Find out kernel modules with large memory consumption during loading based on trace."
> +    echo "Usage:"
> +    echo "1) run it first to setup trace."
> +    echo "2) run again to parse the trace data if any."
> +    echo "3) run with \"--cleanup\" option to cleanup trace after use."
> +}
> +
> +if [[ $1 = "--help" ]]; then
> +    show_usage
> +    exit 0
> +fi
> +
> +
> +if [[ $1 = "--cleanup" ]]; then
> +    cleanup_trace
> +    exit 0
> +fi
> +
> +if is_trace_ready ; then
> +    echo "tracekomem - Rough memory consumption by loading kernel modules (larger value with better accuracy)"
> +    parse_trace_data
> +else
> +    prepare_trace
> +fi
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

The series looks good to me.

Reviewed-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks
Dave
