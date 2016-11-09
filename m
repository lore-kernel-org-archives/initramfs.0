From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/3] 99base: add memtrace-ko.sh to debug kernel module
 large memory consumption
Date: Wed, 9 Nov 2016 07:56:16 +0530
Message-ID: <beac687a-872a-6b8e-a4da-7dfa54e036c5@redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478496876-17580-1-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Monday 07 November 2016 11:04 AM, Xunlei Pang wrote:
> +        # Once we get here, the task is being tracked(is loading a module).
> +        # Get the module name.
> +        module_name=${current_module[$pid]}
> +
> +        if [[ $function = module_put* ]]; then

Also need to check for refcnt=1.
module_put can also be called by many other places.

Moreover, do we really need to trace module_put? You have filter for 
module loading applications, and pids for different module load 
instances would be different, so even if module_put is not tracked, it 
should work, no?

> +            # Mark the module as loaded when the first module_put event happens after module_load.
> +            echo "${nr_alloc_pages[$module_name]} pages consumed by \"$module_name\""
> +            module_loaded[$module_name]=1
> +            # Module loading finished, so untrack the task.
> +            unset current_module[$pid]
> +            continue
> +        fi

~Pratyush
