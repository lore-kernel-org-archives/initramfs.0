From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/3] 99base: add memtrace-ko.sh to debug kernel module
 large memory consumption
Date: Wed, 9 Nov 2016 11:17:08 +0800
Message-ID: <58229534.2070403@redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
 <beac687a-872a-6b8e-a4da-7dfa54e036c5@redhat.com>
 <58228E95.5090702@redhat.com>
 <c6c32731-9278-67a5-4419-201a6edf3f78@redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c6c32731-9278-67a5-4419-201a6edf3f78-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2016/11/09 at 11:06, Pratyush Anand wrote:
>
>
> On Wednesday 09 November 2016 08:18 AM, Xunlei Pang wrote:
>>> > Moreover, do we really need to trace module_put? You have filter for module loading applications, and pids for different module load instances would be different, so even if module_put is not tracked, it should work, no?
>> We need to keep it, lets take an example to illustrate, "insmod mymodule" will hit "module_load" then "module_put"
>> (even for insert failed cases),  then other possible alloc_pages events, init function of the module is called between
>> "module_load" and the following "module_put" trace point, we only care about alloc_pages events captured in between.
>
> I do not have any strong feeling, so I am oK with what is there currently implemented in this patch.
>
> It was just to make it a bit more simple.
> - We will have trace event generated only for the module insertion process.
> - There would be a different PID for each insertion

This may not be true, AFAIK "systemd-udevd" can load multiple modules in the same task(same pid).
So we need to know when the process will finish for each loading.

Regards,
Xunlei

> - "The other possible alloc_pages events" described above would still belong to same insmod operation (from userspace). And we will not have any new page allocation until a new insmod or siblings start  (so a new PID). Therefore, why to set/unset.Just track with PID.
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
