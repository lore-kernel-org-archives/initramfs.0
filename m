From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Out of tree drivers missing from initramfs
Date: Fri, 25 Jan 2013 13:08:52 +0100
Message-ID: <510275D4.7080401@redhat.com>
References: <alpine.DEB.2.02.1301221612280.31163@jlaw-desktop.mno.stratus.com> <50FFFF93.2080209@redhat.com> <alpine.DEB.2.02.1301241718240.31163@jlaw-desktop.mno.stratus.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1301241718240.31163-ceYW5R1vr2hcrvxNGtJwk767FWEIOpWeVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 24.01.2013 23:26, schrieb Joe Lawrence:
> On Wed, 23 Jan 2013, Harald Hoyer wrote:
> 
>> Am 22.01.2013 23:04, schrieb Joe Lawrence:
>>
>>> 2 - Do modules underneath /lib/modules/ver/{updates,extras} need to 
>>>     include their respective directory structure (ie, 'drivers/scsi'). 
>>
>> yes
> 
> Is this a dracut requirement, general convention, etc?  I tried to search 
> google for a definitive document on updates/extra modules and couldn't 
> find much aside from Documentation/kbuild/modules.txt in the kernel tree.
> 
> This change is easy enough to make, but I'd like to get it right. :)
>  
>> Thanks for reporting this, will fix this bug!
> 
> See below for one possible solution.  It may be more correct to filter on 
> kernel* and updates* and extra*, but as proof of concept, it 
> successfully built a initramfs with a driver located at:
> 
>   /updates/lsb-ft/drivers/scsi/mpt2sas/mpt2sas.ko
> 
> Regards,
> 
> -- Joe

perfekt. patch merged
