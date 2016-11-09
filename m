From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] 99base: apply kernel module memory debug support
Date: Wed, 9 Nov 2016 16:33:51 +0800
Message-ID: <20161109083351.GA5663@dhcp-128-65.nay.redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
 <1478496876-17580-2-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478496876-17580-2-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratush Panand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi, Xunlei
On 11/07/16 at 01:34pm, Xunlei Pang wrote:
> Extend "rd.memdebug" to "4", and "make_trace_mem" to "4+:komem".
> Add new "cleanup_trace_mem" to cleanup the trace if active.
> 
> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/98dracut-systemd/dracut-cmdline.sh     |  2 +-
>  modules.d/98dracut-systemd/dracut-pre-mount.sh   |  2 +-
>  modules.d/98dracut-systemd/dracut-pre-pivot.sh   |  3 ++-
>  modules.d/98dracut-systemd/dracut-pre-trigger.sh |  2 +-
>  modules.d/99base/dracut-lib.sh                   | 13 ++++++++++++-
>  modules.d/99base/init.sh                         |  9 +++++----
>  modules.d/99base/module-setup.sh                 |  1 +
>  7 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/modules.d/98dracut-systemd/dracut-cmdline.sh b/modules.d/98dracut-systemd/dracut-cmdline.sh
> index 6c6ee02..bff9435 100755
> --- a/modules.d/98dracut-systemd/dracut-cmdline.sh
> +++ b/modules.d/98dracut-systemd/dracut-cmdline.sh
> @@ -42,7 +42,7 @@ export root
>  export rflags
>  export fstype
>  
> -make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
> +make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>  # run scriptlets to parse the command line
>  getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
>  source_hook cmdline
> diff --git a/modules.d/98dracut-systemd/dracut-pre-mount.sh b/modules.d/98dracut-systemd/dracut-pre-mount.sh
> index ae51128..a3b9d29 100755
> --- a/modules.d/98dracut-systemd/dracut-pre-mount.sh
> +++ b/modules.d/98dracut-systemd/dracut-pre-mount.sh
> @@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>  
>  source_conf /etc/conf.d
>  
> -make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
> +make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>  # to the new root.
>  getarg 'rd.break=pre-mount' 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
> diff --git a/modules.d/98dracut-systemd/dracut-pre-pivot.sh b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
> index cc70e3c..dc9a250 100755
> --- a/modules.d/98dracut-systemd/dracut-pre-pivot.sh
> +++ b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
> @@ -8,12 +8,13 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>  
>  source_conf /etc/conf.d
>  
> -make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
> +make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>  # to the new root.
>  getarg 'rd.break=pre-pivot' 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
>  source_hook pre-pivot
>  
> +cleanup_trace_mem
>  # pre pivot cleanup scripts are sourced just before we switch over to the new root.
>  getarg 'rd.break=cleanup' 'rdbreak=cleanup' && emergency_shell -n cleanup "Break cleanup"
>  source_hook cleanup
> diff --git a/modules.d/98dracut-systemd/dracut-pre-trigger.sh b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
> index ac1ec36..7cd821e 100755
> --- a/modules.d/98dracut-systemd/dracut-pre-trigger.sh
> +++ b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
> @@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>  
>  source_conf /etc/conf.d
>  
> -make_trace_mem "hook pre-trigger" "1:shortmem" "2+:mem" "3+:slab"
> +make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  
>  source_hook pre-trigger
>  
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 060b3fe..2a29bbc 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -1206,12 +1206,20 @@ are_lists_eq() {
>  
>  setmemdebug() {
>      if [ -z "$DEBUG_MEM_LEVEL" ]; then
> -        export DEBUG_MEM_LEVEL=$(getargnum 0 0 3 rd.memdebug)
> +        export DEBUG_MEM_LEVEL=$(getargnum 0 0 4 rd.memdebug)
>      fi
>  }
>  
>  setmemdebug
>  
> +cleanup_trace_mem()
> +{
> +    # tracekomem based on kernel trace needs cleanup after use.
> +    if [[ $DEBUG_MEM_LEVEL -eq 4 ]]; then

It does not work if out of tree modules add it to DEBUG_MEM_LEVEL <
4, sounds bad to hard code it. It seems good to do the cleanup without
the check.

There is another concern, if someone manually enables tracing in kernel
cmdline then we should not cleanup, maybe we can print a warning msg
and do not do our tracing at all.

For cleanup and prepare ideally we can do something like make_trace_mem,
like prepare_trace_mem and cleanup_trace_mem, for each facility if there
is a prepare/cleanup function then call it. But for the time being it
may not worth to add the complexity. What do you think? 

> +        tracekomem --cleanup
> +    fi
> +}
> +
>  # parameters: msg [trace_level:trace]...
>  make_trace_mem()
>  {
> @@ -1296,6 +1304,9 @@ show_memstats()
>          iomem)
>              cat /proc/iomem
>              ;;
> +        komem)
> +            tracekomem
> +            ;;
>      esac
>  }
>  
> diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
> index a563393..e4f7cff 100755
> --- a/modules.d/99base/init.sh
> +++ b/modules.d/99base/init.sh
> @@ -131,7 +131,7 @@ if ! getargbool 1 'rd.hostonly'; then
>  fi
>  
>  # run scriptlets to parse the command line
> -make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
> +make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>  getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
>  source_hook cmdline
>  
> @@ -160,7 +160,7 @@ fi
>  
>  udevproperty "hookdir=$hookdir"
>  
> -make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab'
> +make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  getarg 'rd.break=pre-trigger' -d 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
>  source_hook pre-trigger
>  
> @@ -230,7 +230,7 @@ unset RDRETRY
>  
>  # pre-mount happens before we try to mount the root filesystem,
>  # and happens once.
> -make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
> +make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  getarg 'rd.break=pre-mount' -d 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
>  source_hook pre-mount
>  
> @@ -266,11 +266,12 @@ done
>  
>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>  # to the new root.
> -make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
> +make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>  getarg 'rd.break=pre-pivot' -d 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
>  source_hook pre-pivot
>  
>  make_trace_mem "hook cleanup" '1:shortmem' '2+:mem' '3+:slab'
> +cleanup_trace_mem
>  # pre pivot cleanup scripts are sourced just before we switch over to the new root.
>  getarg 'rd.break=cleanup' -d 'rdbreak=cleanup' && emergency_shell -n cleanup "Break cleanup"
>  source_hook cleanup
> diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
> index b03772e..a1569b1 100755
> --- a/modules.d/99base/module-setup.sh
> +++ b/modules.d/99base/module-setup.sh
> @@ -35,6 +35,7 @@ install() {
>      inst_script "$moddir/initqueue.sh" "/sbin/initqueue"
>      inst_script "$moddir/loginit.sh" "/sbin/loginit"
>      inst_script "$moddir/rdsosreport.sh" "/sbin/rdsosreport"
> +    inst_script "$moddir/memtrace-ko.sh" "/sbin/tracekomem"
>  
>      [ -e "${initdir}/lib" ] || mkdir -m 0755 -p ${initdir}/lib
>      mkdir -m 0755 -p ${initdir}/lib/dracut
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Dave
