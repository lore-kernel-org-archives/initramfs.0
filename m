From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] Add memory usage trace to diffrent hook points
Date: Thu, 17 Jan 2013 14:43:14 +0100
Message-ID: <50F7FFF2.4020309@redhat.com>
References: <20130117085549.207542806@redhat.com> <20130117085724.212324334@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130117085724.212324334-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 17.01.2013 09:55, schrieb dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org:
> Port mkdumprd memory trace functions wrote by jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> For kdump, memory usage tracing is important because there's limited
> memory in kdump 2nd kernel.
> 
> Add a rd.memdebug cmdline for this. set rd.memdebug=<X> will set the
> debug level to X which is the debug verbose level.
> 
> the format of cmdline is like below:
> <level>[+]:<type>
> <level> is the debug level
> [+] means debug level >= <level>
> <type> is the debug info type, as for this patch I added mem, iomem, slab
> mem is for /proc/meminfo, iomem is for /proc/iomem, slab is for /proc/slabinfo
> Also shortmem is the stripped /proc/meminfo which only includes 3 lines of
> Memfree, Cached and Slab, for example:
> MemFree:         6327176 kB
> Cached:           741916 kB
> Slab:              77284 kB
> 
> I added several trace point to the begin of several init hooks
> At cmdline hooks I'm adding trace of "1+:mem 1+:iomem 3+:slab"
> For other hooks I'm adding trace of "1:shortmem 2+:mem 3+:slab"
> 
> This means:
> rd.memdebug=1)
>   cmdline hook: print mem and iomem
>   other hooks: print shortmem
> rd.memdebug=2)
>   cmdline hook: print mem and iomem
>   other hooks: print mem
> rd.memdebug=3):
>   cmdline hook: print mem iomem, and slabinfo
>   other hooks: print mem and slabinfo
> *):
>   do not print any mem debug info
> 
> [v1->v2]: update to use getargnum with <minval> as argument
>           print iomem info at cmdline hook as well
> [v2->v3]: harald: use $() instead of ``
>                   use bash string match instead of grep and pipe.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.cmdline.7.asc                      |    4 +
>  modules.d/98systemd/dracut-cmdline.sh     |    1 
>  modules.d/98systemd/dracut-initqueue.sh   |    1 
>  modules.d/98systemd/dracut-pre-pivot.sh   |    1 
>  modules.d/98systemd/dracut-pre-trigger.sh |    1 
>  modules.d/98systemd/dracut-pre-udev.sh    |    1 
>  modules.d/99base/dracut-lib.sh            |   91 ++++++++++++++++++++++++++++++
>  7 files changed, 100 insertions(+)
> 
...
> --- dracut.orig/modules.d/99base/dracut-lib.sh
> +++ dracut/modules.d/99base/dracut-lib.sh
...

> +# parameters: msg [trace_level:trace]...
> +function make_trace_mem()
> +{

local msg

> +    msg=$1
> +    shift
> +    if [ "$DEBUG_MEM_LEVEL" -gt 0 ]; then
> +        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@"
> +    fi
> +}
> +
> +# parameters: func log_level prefix msg [trace_level:trace]...
> +function make_trace()
> +{

local func
local log_level
local prefix
.....


> +    func=$1
> +    shift
> +
> +    log_level=$1
> +    shift
> +
> +    prefix=$1
> +    shift
> +
> +    msg=$1
> +    shift
> +
> +    if [ -z "$log_level" ]; then
> +        return
> +    fi
> +
> +    msg=$(echo $msg)
> +
> +    msg_printed=0
> +    while [ $# -gt 0 ]; do
> +        trace=${1%%:*}
> +        trace_level=${trace%%+}
> +        [ "$trace" != "$trace_level" ] && trace_in_higher_levels="yes"
> +        trace=${1##*:}
> +
> +        if [ -z "$trace_level" ]; then
> +            trace_level=0
> +        fi
> +
> +        insert_trace=0
> +        if [ -n "$trace_in_higher_levels" ]; then
> +            if [ "$log_level" -ge "$trace_level" ]; then
> +                insert_trace=1
> +            fi
> +        else
> +            if [ "$log_level" -eq "$trace_level" ]; then
> +                insert_trace=1
> +            fi
> +        fi
> +
> +        if [ $insert_trace -eq 1 ]; then
> +            if [ $msg_printed -eq 0 ]; then
> +                echo "$prefix $msg"
> +                msg_printed=1
> +            fi
> +            $func $trace
> +        fi
> +        shift
> +    done
> +}
> +
