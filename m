From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] add 99memdebug-ko dracut module
Date: Fri, 4 Nov 2016 15:06:29 +0800
Message-ID: <20161104070629.GA17145@dhcp-128-65.nay.redhat.com>
References: <1478077386-30039-1-git-send-email-xlpang@redhat.com>
 <20161103030142.GA3201@dhcp-128-65.nay.redhat.com>
 <581AB9D7.2010905@redhat.com>
 <581AE707.9050606@redhat.com>
 <20161103083826.GA15431@dhcp-128-65.nay.redhat.com>
 <581B2518.6060503@redhat.com>
 <20161104055026.GB2889@dhcp-128-65.nay.redhat.com>
 <581C2C30.8070403@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <581C2C30.8070403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/04/16 at 02:35pm, Xunlei Pang wrote:
> On 2016/11/04 at 13:50, Dave Young wrote:
> > On 11/03/16 at 07:52pm, Xunlei Pang wrote:
> >> On 2016/11/03 at 16:38, Dave Young wrote:
> >>> On 11/03/16 at 03:28pm, Xunlei Pang wrote:
> >>> [snip]
> >>>>> For large trace data(tested on rhel7, the filter doesn't work on rhel7, and will produce huge trace data),
> >>>>> the time consumption is huge, I am afraid in minutes because I once suspected the script was in some
> >>>>> dead loop when parsing "tracing/trace" directly. It is the same situation when turning off tracing_on and
> >>>>> try again.
> >>>> Although I don't know why, after I replaced the following scripts
> >>>> 1)
> >>>> while read pid cpu flags ts function
> >>>> do
> >>>>     ... ...
> >>>> done < "$TRACE_BASE/tracing/trace"
> >>>>
> >>>> with
> >>>>
> >>>> 2)
> >>>> cat "$TRACE_BASE/tracing/trace" | while read pid cpu flags ts function
> >>>> do
> >>>>     ... ...
> >>>> done
> >>>>
> >>>> 2) became not time-consuming just like parsing the copied filename in 1) ...
> >>> Maybe 1) read the sysfs file a lot of times, but 2) only once then
> >>> parsing them in pipe which is quiker.
> >>>
> >>> It should be fine if 2) is acceptable, but if the data is very large it
> >>> may worth to use some external program like awk which will be faster.
> >> Hi Dave,
> >>
> >> What do you think the following approach?
> >>
> >> ============== [PATCH 1/2] ================
> >> ---
> >>  modules.d/99base/memdebug-ko.sh | 119 ++++++++++++++++++++++++++++++++++++++++
> > memtrace-ko.sh sounds better
> 
> I choose this because of "rd.memdebug", anyway will rename :-)
> 
> >
> >>  1 file changed, 119 insertions(+)
> >>  create mode 100755 modules.d/99base/memdebug-ko.sh
> >>
> >> diff --git a/modules.d/99base/memdebug-ko.sh b/modules.d/99base/memdebug-ko.sh
> >> new file mode 100755
> >> index 0000000..2839966
> >> --- /dev/null
> >> +++ b/modules.d/99base/memdebug-ko.sh
> >> @@ -0,0 +1,119 @@
> >> +# Try to find out kernel modules with large total memory allocation during loading.
> >> +# For large slab allocation, it will fall into buddy, thus tracing "mm_page_alloc"
> >> +# alone should be enough for the purpose.
> >> +
> >> +# "sys/kernel/tracing" has the priority if exists.
> >> +get_trace_base() {
> >> +    # trace access through debugfs would be obsolete if "/sys/kernel/tracing" is available.
> >> +    if [[ -d "/sys/kernel/tracing" ]]; then
> >> +        echo "/sys/kernel"
> >> +    else
> >> +        echo "/sys/kernel/debug"
> >> +    fi
> >> +}
> >> +
> >> +is_trace_data_prepared() {
> >> +    local trace_base
> >> +
> >> +    trace_base=$(get_trace_base)
> >> +    # old debugfs interface case.
> >> +    if ! [[ -d "$trace_base/tracing" ]]; then
> >> +        mount none -t debugfs $trace_base
> >> +    # new tracefs interface case.
> >> +    elif ! [[ -f "$trace_base/tracing/trace" ]]; then
> >> +        mount none -t tracefs "$trace_base/tracing"
> >> +    fi
> >> +
> >> +    if ! [[ -f "$trace_base/tracing/trace" ]]; then
> >> +        echo "WARN: Mount trace failed for kernel module memory analyzing."
> >> +        return 1
> >> +    fi
> >> +
> >> +    MATCH_EVENTS="module:module_put module:module_load kmem:mm_page_alloc"
> >> +    SET_EVENTS=$(echo $(cat $trace_base/tracing/set_event))
> >> +    # Check if trace was properly setup, prepare it if not.
> >> +    if [[ $(cat $trace_base/tracing/tracing_on) != 1 ]] || \
> > How about return in case tracing_on == 1, then no need indent later.
> 
> We still better to make sure the events are the ones we really need, as others may utilize tracing
> to do things they want to.
> 

Yes, I missed it.. So like below?

if traccing == on && events-matched; then
    return 0;
fi

[...]


> >
> >> +        [[ "$SET_EVENTS" != "$MATCH_EVENTS" ]]; then
> >> +        # Set our trace events.
> >> +        echo $MATCH_EVENTS > $trace_base/tracing/set_event
> >> +
> >> +        # There are three kinds of known applications for module loading:
> >> +        # "systemd-udevd", "modprobe" and "insmod".
> >> +        # Set them to the mm_page_alloc event filter.
> >> +        # NOTE: Some kernel may not support this format of filter, anyway
> >> +        #       the operation will fail and it doesn't matter.
> >> +        page_alloc_filter="comm == systemd-udevd || comm == modprobe || comm == insmod"
> >> +        echo $page_alloc_filter > $trace_base/tracing/events/kmem/mm_page_alloc/filter
> >> +
> >> +        # Set the number of comm-pid if supported.
> >> +        if [[ -f "$trace_base/tracing/saved_cmdlines_size" ]]; then
> >> +            # Thanks to filters, 4096 is big enough(also well supported).
> >> +            echo 4096 > $trace_base/tracing/saved_cmdlines_size
> >> +        fi
> >> +
> >> +        # Enable and clear trace data for the first time.
> >> +        echo 1 > $trace_base/tracing/tracing_on
> >> +        echo > $trace_base/tracing/trace
> >> +        echo "Prepare trace success."
> >> +        return 1
> > Should return 0?
> 
> This is the first time we turn off trace and the trace data is cleared, so return 1 on purpose.

It is not easy to get and conflicts with the fuction name ;)

If change the logic a bit, it will be clear:

is_trace_prepared()
{
    this function only check if tracing is enabled and events matched.
}

prepare_trace()
{
    enable and prepare trace
}

parse_trace_data()
{

}

if is_trace_prepared == true; then
    parse_trace_data
else
    prepare_trace
fi

So in cmdline hook is_trace_prepared is false so the script only prepare
trace and enable tracing, in latter hooks it will parse trace data.

But there should be another function to disable trace before pivot root.

> 
> >
> >> +    fi
> >> +
> >> +    return 0
> >> +}
> >> +
> >> +parse_trace_data() {
> >> +    local module_name
> >> +    # Indexed by task pid.
> >> +    local -A current_module
> >> +    # Indexed by module name.
> >> +    local -A module_loaded
> >> +    local -A nr_alloc_pages
> >> +
> >> +    cat "$(get_trace_base)/tracing/trace" | while read pid cpu flags ts function
> >> +    do
> >> +        # Skip comment lines
> >> +        if [[ $pid = "#" ]]; then
> >> +            continue
> >> +        fi
> >> +
> >> +        if [[ $function = module_load* ]]; then
> >> +            # One module is being loaded, save the task pid for tracking.
> >> +            module_name=${function#*: }
> >> +            # Remove the trailing after whitespace, there may be the module flags.
> >> +            module_name=${module_name%% *}
> >> +            # Mark current_module to track the task.
> >> +            current_module[$pid]="$module_name"
> >> +            [[ ${module_loaded[$module_name]} ]] && echo "WARN: \"$module_name\" was loaded multiple times!"
> >> +            unset module_loaded[$module_name]
> >> +            nr_alloc_pages[$module_name]=0
> >> +            continue
> >> +        fi
> >> +
> >> +        if ! [[ ${current_module[$pid]} ]]; then
> >> +            continue
> >> +        fi
> >> +
> >> +        # Once we get here, the task is being tracked(is loading a module).
> >> +        # Get the module name.
> >> +        module_name=${current_module[$pid]}
> >> +
> >> +        if [[ $function = module_put* ]]; then
> >> +            # Mark the module as loaded when the first module_put event happens after module_load.
> >> +            echo "${nr_alloc_pages[$module_name]} pages consumed by \"$module_name\""
> >> +            module_loaded[$module_name]=1
> >> +            # Module loading finished, so untrack the task.
> >> +            unset current_module[$pid]
> >> +            continue
> >> +        fi
> >> +
> >> +        if [[ $function = mm_page_alloc* ]]; then
> >> +            order=$(echo $function | sed -e 's/.*order=\([0-9]*\) .*/\1/')
> >> +            nr_alloc_pages[$module_name]=$((${nr_alloc_pages[$module_name]}+$((2 ** $order))))
> >> +        fi
> >> +    done
> >> +}
> >> +
> >> +if is_trace_data_prepared ; then
> >> +    echo "showkomem - memory consumption of loading kernel modules(the larger, the more precise)"
> >> +    parse_trace_data
> >> +fi
> > I feel the original design is better, prepare and enalbe trace at the
> > very early of cmdline hook. But below will be useless for komem trace:
> > +make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
> >
> > So in cmdline hook we can just prepare and enable tracing without
> > parsing.
> >
> > Later when we parse it just check if the trace is on or off, if it is
> > off then just do nothing. 
> 
> I can think of one advantage of the design, that is it doesn't rely on "rd.memdebug", therefore
> "/sbin/showkomem" can be used as a independent binary(command) to debug your own modules,
> just run it two times if tracing is not prepared: the first time performs setup, then show the result.

I did not notice it, agreed current way in this patch is better...

> 
> Do you mean the way below?
> 1) Split the script into two parts like before in a new dracut module. Install the preparing part
>     as one cmdline hook in case of "rd.memdebug=4", then the parsing part as "/sbin/showkomem".
> 
> 2) Then use it in 99base show_memstats() and make_trace_mem() like the way in this approach.
> 
> But in the way above-mentioned, "/sbin/showkomem" only works if there is "rd.memdebug=4" or
> require some manual trace configuration before using.
> 
> >
> > And we should disable tracing before pivot root..
> 
> I think we can just leave the trace there, it does little harm.
> 
> Also others may still utilize "showkomem" to show extra information, for example if there is some
> script (like pre-kdump script) modprobe some special modules, we can simply call showkomem to
> show them out.

Yes, it makes sense for user like kdump, in Fedora kdump add a pre-pivot
hook to capture vmcore. But we can still disable trace after all hooks
finishing (include kdump though it will never return) in dracut code.

Thanks
Dave
