From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] add 99memdebug-ko dracut module
Date: Fri, 4 Nov 2016 17:12:34 +0800
Message-ID: <581C5102.60700@redhat.com>
References: <1478077386-30039-1-git-send-email-xlpang@redhat.com>
 <20161103030142.GA3201@dhcp-128-65.nay.redhat.com>
 <581AB9D7.2010905@redhat.com> <581AE707.9050606@redhat.com>
 <20161103083826.GA15431@dhcp-128-65.nay.redhat.com>
 <581B2518.6060503@redhat.com>
 <20161104055026.GB2889@dhcp-128-65.nay.redhat.com>
 <581C2C30.8070403@redhat.com>
 <20161104070629.GA17145@dhcp-128-65.nay.redhat.com>
 <581C3EDE.9080601@redhat.com>
 <20161104082328.GA19275@dhcp-128-65.nay.redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161104082328.GA19275-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 2016/11/04 at 16:23, Dave Young wrote:
> Hi Xunlei,
>
>>> If change the logic a bit, it will be clear:
>>>
>>> is_trace_prepared()
>>> {
>>>     this function only check if tracing is enabled and events matched.
>>> }
>>>
>>> prepare_trace()
>>> {
>>>     enable and prepare trace
>>> }
>>>
>>> parse_trace_data()
>>> {
>>>
>>> }
>>>
>>> if is_trace_prepared == true; then
>>>     parse_trace_data
>>> else
>>>     prepare_trace
>>> fi
>>>
>>> So in cmdline hook is_trace_prepared is false so the script only prepare
>>> trace and enable tracing, in latter hooks it will parse trace data.
>>>
>>> But there should be another function to disable trace before pivot root.
>> OK
>>
>> We should find a neat way to disable the trace function, what do you think the following way?
>> Change show_memstats() and make_trace_mem() as follows:
>>     make_trace_mem "hook cmdline" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>>     ... ...
>>     make_trace_mem "hook pre-pivot" '1+:mem' '1+:iomem' '3+:slab' '4+:komem'
>>     make_trace_mem "hook pre-pivot" '4+:komemfinish' # cleanup trace used by showkomem after use.
>>
>>    show_memstats()
>>            ... ...
>>
>> +        komem)
>> +            showkomem
>> +            ;;
>> +        komemfinish)
>> +            # disable trace after use.
>> +            showkomem finish
>> +            ;;
>>      esac
>>
> Hmm, I'm not sure it is worth, maybe add a function like
> cleanup_trace_mem() is enough and we can add it just before cleanup
> hook which is designed for cleanup purpose, cleanup hook is sourced
> after pre-pivot so that it will still work for adding trace in any
> pre-pivot scripts.

OK

I'll send v2 later, thanks for all the valuable suggestions.

Regards,
Xunlei
