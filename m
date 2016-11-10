From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] 99base: apply kernel module memory debug support
Date: Thu, 10 Nov 2016 14:57:00 +0800
Message-ID: <58241A3C.9000008@redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
 <1478496876-17580-2-git-send-email-xlpang@redhat.com>
 <20161109083351.GA5663@dhcp-128-65.nay.redhat.com>
 <5822FBA1.40105@redhat.com>
 <20161110024505.GA3815@dhcp-128-65.nay.redhat.com>
 <58240BF6.3020207@redhat.com>
 <20161110062526.GA5206@dhcp-128-65.nay.redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161110062526.GA5206-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratush Panand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 2016/11/10 at 14:25, Dave Young wrote:
> On 11/10/16 at 01:56pm, Xunlei Pang wrote:
>> On 2016/11/10 at 10:45, Dave Young wrote:
>>> On 11/09/16 at 06:34pm, Xunlei Pang wrote:
>>>> On 2016/11/09 at 16:33, Dave Young wrote:
>>>>> Hi, Xunlei
>>>>> On 11/07/16 at 01:34pm, Xunlei Pang wrote:
>>>>>> Extend "rd.memdebug" to "4", and "make_trace_mem" to "4+:komem".
>>>>>> Add new "cleanup_trace_mem" to cleanup the trace if active.
>>>>>>
>>>>>> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>>> ---
>>>>>>  modules.d/98dracut-systemd/dracut-cmdline.sh     |  2 +-
>>>>>>  modules.d/98dracut-systemd/dracut-pre-mount.sh   |  2 +-
>>>>>>  modules.d/98dracut-systemd/dracut-pre-pivot.sh   |  3 ++-
>>>>>>  modules.d/98dracut-systemd/dracut-pre-trigger.sh |  2 +-
>>>>>>  modules.d/99base/dracut-lib.sh                   | 13 ++++++++++++-
>>>>>>  modules.d/99base/init.sh                         |  9 +++++----
>>>>>>  modules.d/99base/module-setup.sh                 |  1 +
>>>>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/modules.d/98dracut-systemd/dracut-cmdline.sh b/modules.d/98dracut-systemd/dracut-cmdline.sh
>>>>>> index 6c6ee02..bff9435 100755
>>>>>> --- a/modules.d/98dracut-systemd/dracut-cmdline.sh
>>>>>> +++ b/modules.d/98dracut-systemd/dracut-cmdline.sh
>>>>>> @@ -42,7 +42,7 @@ export root
>>>>>>  export rflags
>>>>>>  export fstype
>>>>>>  
>>>>>> -make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
>>>>>> +make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>>>>>>  # run scriptlets to parse the command line
>>>>>>  getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
>>>>>>  source_hook cmdline
>>>>>> diff --git a/modules.d/98dracut-systemd/dracut-pre-mount.sh b/modules.d/98dracut-systemd/dracut-pre-mount.sh
>>>>>> index ae51128..a3b9d29 100755
>>>>>> --- a/modules.d/98dracut-systemd/dracut-pre-mount.sh
>>>>>> +++ b/modules.d/98dracut-systemd/dracut-pre-mount.sh
>>>>>> @@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>>>>>>  
>>>>>>  source_conf /etc/conf.d
>>>>>>  
>>>>>> -make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>>>>>>  # to the new root.
>>>>>>  getarg 'rd.break=pre-mount' 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
>>>>>> diff --git a/modules.d/98dracut-systemd/dracut-pre-pivot.sh b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
>>>>>> index cc70e3c..dc9a250 100755
>>>>>> --- a/modules.d/98dracut-systemd/dracut-pre-pivot.sh
>>>>>> +++ b/modules.d/98dracut-systemd/dracut-pre-pivot.sh
>>>>>> @@ -8,12 +8,13 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>>>>>>  
>>>>>>  source_conf /etc/conf.d
>>>>>>  
>>>>>> -make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>>>>>>  # to the new root.
>>>>>>  getarg 'rd.break=pre-pivot' 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
>>>>>>  source_hook pre-pivot
>>>>>>  
>>>>>> +cleanup_trace_mem
>>>>>>  # pre pivot cleanup scripts are sourced just before we switch over to the new root.
>>>>>>  getarg 'rd.break=cleanup' 'rdbreak=cleanup' && emergency_shell -n cleanup "Break cleanup"
>>>>>>  source_hook cleanup
>>>>>> diff --git a/modules.d/98dracut-systemd/dracut-pre-trigger.sh b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
>>>>>> index ac1ec36..7cd821e 100755
>>>>>> --- a/modules.d/98dracut-systemd/dracut-pre-trigger.sh
>>>>>> +++ b/modules.d/98dracut-systemd/dracut-pre-trigger.sh
>>>>>> @@ -8,7 +8,7 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>>>>>>  
>>>>>>  source_conf /etc/conf.d
>>>>>>  
>>>>>> -make_trace_mem "hook pre-trigger" "1:shortmem" "2+:mem" "3+:slab"
>>>>>> +make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  
>>>>>>  source_hook pre-trigger
>>>>>>  
>>>>>> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
>>>>>> index 060b3fe..2a29bbc 100755
>>>>>> --- a/modules.d/99base/dracut-lib.sh
>>>>>> +++ b/modules.d/99base/dracut-lib.sh
>>>>>> @@ -1206,12 +1206,20 @@ are_lists_eq() {
>>>>>>  
>>>>>>  setmemdebug() {
>>>>>>      if [ -z "$DEBUG_MEM_LEVEL" ]; then
>>>>>> -        export DEBUG_MEM_LEVEL=$(getargnum 0 0 3 rd.memdebug)
>>>>>> +        export DEBUG_MEM_LEVEL=$(getargnum 0 0 4 rd.memdebug)
>>>>>>      fi
>>>>>>  }
>>>>>>  
>>>>>>  setmemdebug
>>>>>>  
>>>>>> +cleanup_trace_mem()
>>>>>> +{
>>>>>> +    # tracekomem based on kernel trace needs cleanup after use.
>>>>>> +    if [[ $DEBUG_MEM_LEVEL -eq 4 ]]; then
>>>>> It does not work if out of tree modules add it to DEBUG_MEM_LEVEL <
>>>>> 4, sounds bad to hard code it. It seems good to do the cleanup without
>>>>> the check.
>>>> Hi Dave,
>>>>
>>>> I can't understand why out of tree modules would do this, however we can't
>>>> guarantee that even after removing the hard code condition. Let's say, out of
>>>> tree modules use it at the very beginning and disable it quite after pre-pivot
>>>> with no "rd.memdebug", then the trace will be disabled at pre-pivot which will
>>>> cause confusion(or unnoticed data loss) for the out of tree modules.
>>> It should be a corner case, but use a fixed DEBUG_MEM_LEVEL sounds
>>> still not good, we designed the DEBUG_MEM_LEVEL but the design does not
>>> limit each facility to force connect to one of the levels. 
>> Hi Dave,
>>
>> Maybe I didn't quite catch what you meant.
>>
>> The current implementation only uses level 4 for komem using '4+:komem', do you mean
>> some out of tree module adds something like: make_trace_mem '2+: komem'? If so, it contradicts
>> the "rd.memdebug" manpage described in PATCH3/3.
> Yes, it is what I thought about.

OK, but the current design of "rd.memdebug" does use the hard-coded make_trace_mem,
for example, you can't output slab information below level 3.

In order to stay consistent with previous behavior described in "man dracut.cmdline",
better not add something like make_trace_mem '2:slab' for "rd.memdebug" unless use
it as your private debugging and be aware of all the details.

Thus I prefer to keep the hard-coded DEBUG_MEM_LEVEL.

>
>>> But I have no strong opinion, I can live with it.. 
>>>
>>>>> There is another concern, if someone manually enables tracing in kernel
>>>>> cmdline then we should not cleanup, maybe we can print a warning msg
>>>>> and do not do our tracing at all.
>>>>>
>>>>> For cleanup and prepare ideally we can do something like make_trace_mem,
>>>>> like prepare_trace_mem and cleanup_trace_mem, for each facility if there
>>>>> is a prepare/cleanup function then call it. But for the time being it
>>>>> may not worth to add the complexity. What do you think? 
>>>> Because the script does cleanup iff is_trace_ready() returns true when
>>>> both tracing is on and the events match, I think it is safe enough that
>>>> we don't need to worry about the wrong cleanup if we really want to do this:
>>>>   is_trace_ready() {
>>>>       local trace_base want_events current_events
>>>>
>>>>       trace_base=$(get_trace_base)
>>>>       ! [[ -f "$trace_base/tracing/trace" ]] && return 1
>>>>
>>>>       [[ $(cat $trace_base/tracing/tracing_on) = 0 ]] && return 1
>>>>
>>>>       # Also check if trace events were properly setup.
>>>>       want_events=$(get_want_events)
>>>>       current_events=$(echo $(cat $trace_base/tracing/set_event))
>>>>       [[ "$current_events" != "$want_events" ]] && return 1
>>>>
>>>>       return 0
>>>>   }
>>> Dracut is used more in normal boot than kdump, if one enabled trace in
>>> grub and the events happen to be same, but we disabled it user will be
>>> not happy.
>> Yes, as long as they don't specify "rd.memdebug=4", the current implementation
>> isn't problematic.
>>
>> If people use "rd.memdebug=4", they should be aware what they are doing to trace,
>> also enabling the same events (module_load, module_put and alloc_pages) only is rare.
> Yes, they should be aware but still need some documentation..

OK, then I'd like to improve [PATCH v2 3/3] to add trace awareness.

Regards,
Xunlei

>> Regards,
>> Xunlei
>>
>>>> Regards,
>>>> Xunlei
>>>>
>>>>>> +        tracekomem --cleanup
>>>>>> +    fi
>>>>>> +}
>>>>>> +
>>>>>>  # parameters: msg [trace_level:trace]...
>>>>>>  make_trace_mem()
>>>>>>  {
>>>>>> @@ -1296,6 +1304,9 @@ show_memstats()
>>>>>>          iomem)
>>>>>>              cat /proc/iomem
>>>>>>              ;;
>>>>>> +        komem)
>>>>>> +            tracekomem
>>>>>> +            ;;
>>>>>>      esac
>>>>>>  }
>>>>>>  
>>>>>> diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
>>>>>> index a563393..e4f7cff 100755
>>>>>> --- a/modules.d/99base/init.sh
>>>>>> +++ b/modules.d/99base/init.sh
>>>>>> @@ -131,7 +131,7 @@ if ! getargbool 1 'rd.hostonly'; then
>>>>>>  fi
>>>>>>  
>>>>>>  # run scriptlets to parse the command line
>>>>>> -make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab'
>>>>>> +make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>>>>>>  getarg 'rd.break=cmdline' -d 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
>>>>>>  source_hook cmdline
>>>>>>  
>>>>>> @@ -160,7 +160,7 @@ fi
>>>>>>  
>>>>>>  udevproperty "hookdir=$hookdir"
>>>>>>  
>>>>>> -make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  getarg 'rd.break=pre-trigger' -d 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
>>>>>>  source_hook pre-trigger
>>>>>>  
>>>>>> @@ -230,7 +230,7 @@ unset RDRETRY
>>>>>>  
>>>>>>  # pre-mount happens before we try to mount the root filesystem,
>>>>>>  # and happens once.
>>>>>> -make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +make_trace_mem "hook pre-mount" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  getarg 'rd.break=pre-mount' -d 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
>>>>>>  source_hook pre-mount
>>>>>>  
>>>>>> @@ -266,11 +266,12 @@ done
>>>>>>  
>>>>>>  # pre pivot scripts are sourced just before we doing cleanup and switch over
>>>>>>  # to the new root.
>>>>>> -make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +make_trace_mem "hook pre-pivot" '1:shortmem' '2+:mem' '3+:slab' '4+:komem'
>>>>>>  getarg 'rd.break=pre-pivot' -d 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
>>>>>>  source_hook pre-pivot
>>>>>>  
>>>>>>  make_trace_mem "hook cleanup" '1:shortmem' '2+:mem' '3+:slab'
>>>>>> +cleanup_trace_mem
>>>>>>  # pre pivot cleanup scripts are sourced just before we switch over to the new root.
>>>>>>  getarg 'rd.break=cleanup' -d 'rdbreak=cleanup' && emergency_shell -n cleanup "Break cleanup"
>>>>>>  source_hook cleanup
>>>>>> diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
>>>>>> index b03772e..a1569b1 100755
>>>>>> --- a/modules.d/99base/module-setup.sh
>>>>>> +++ b/modules.d/99base/module-setup.sh
>>>>>> @@ -35,6 +35,7 @@ install() {
>>>>>>      inst_script "$moddir/initqueue.sh" "/sbin/initqueue"
>>>>>>      inst_script "$moddir/loginit.sh" "/sbin/loginit"
>>>>>>      inst_script "$moddir/rdsosreport.sh" "/sbin/rdsosreport"
>>>>>> +    inst_script "$moddir/memtrace-ko.sh" "/sbin/tracekomem"
>>>>>>  
>>>>>>      [ -e "${initdir}/lib" ] || mkdir -m 0755 -p ${initdir}/lib
>>>>>>      mkdir -m 0755 -p ${initdir}/lib/dracut
>>>>>> -- 
>>>>>> 1.8.3.1
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> Thanks
>>>>> Dave
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Thanks
>>> Dave
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
