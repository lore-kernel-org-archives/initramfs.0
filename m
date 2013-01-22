From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2 V4] Add memory usage trace to diffrent hook points
Date: Tue, 22 Jan 2013 15:32:53 +0100
Message-ID: <50FEA315.7080008@redhat.com>
References: <20130117085549.207542806@redhat.com> <20130117085724.212324334@redhat.com> <50F7FFF2.4020309@redhat.com> <50F8AC98.1060308@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F8AC98.1060308-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 18.01.2013 02:59, schrieb Dave Young:
> 
> Hi, Here is an update of this patch, fixed the local variable issue.
> ---
> 
> Add memory usage trace to diffrent hook points
> 
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
> [v3->v4]: harald: use local variables in function.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

merged
