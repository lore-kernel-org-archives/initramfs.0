From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/3] 99base: add memtrace-ko.sh to debug kernel module
 large memory consumption
Date: Wed, 9 Nov 2016 10:48:53 +0800
Message-ID: <58228E95.5090702@redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
 <beac687a-872a-6b8e-a4da-7dfa54e036c5@redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <beac687a-872a-6b8e-a4da-7dfa54e036c5-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2016/11/09 at 10:26, Pratyush Anand wrote:
>
>
> On Monday 07 November 2016 11:04 AM, Xunlei Pang wrote:
>> +        # Once we get here, the task is being tracked(is loading a module).
>> +        # Get the module name.
>> +        module_name=${current_module[$pid]}
>> +
>> +        if [[ $function = module_put* ]]; then
>
> Also need to check for refcnt=1.
> module_put can also be called by many other places.

We only care about the first one right after module_load was made, for other module_put events, will be skipped by
        if ! [[ ${current_module[$pid]} ]]; then
            continue
        fi
because we will unset current_module[$pid](untrack the task) when parsing the first module_put() after "module_load"
where current_module[$pid](track the task loading module) is set.

>
> Moreover, do we really need to trace module_put? You have filter for module loading applications, and pids for different module load instances would be different, so even if module_put is not tracked, it should work, no?

We need to keep it, lets take an example to illustrate, "insmod mymodule" will hit "module_load" then "module_put"
(even for insert failed cases),  then other possible alloc_pages events, init function of the module is called between
"module_load" and the following "module_put" trace point, we only care about alloc_pages events captured in between.

Regards,
Xunlei

>
>> +            # Mark the module as loaded when the first module_put event happens after module_load.
>> +            echo "${nr_alloc_pages[$module_name]} pages consumed by \"$module_name\""
>> +            module_loaded[$module_name]=1
>> +            # Module loading finished, so untrack the task.
>> +            unset current_module[$pid]
>> +            continue
>> +        fi
>
> ~Pratyush
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
