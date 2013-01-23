From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Out of tree drivers missing from initramfs
Date: Wed, 23 Jan 2013 16:19:47 +0100
Message-ID: <50FFFF93.2080209@redhat.com>
References: <alpine.DEB.2.02.1301221612280.31163@jlaw-desktop.mno.stratus.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1301221612280.31163-ceYW5R1vr2hcrvxNGtJwk767FWEIOpWeVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 22.01.2013 23:04, schrieb Joe Lawrence:
> Hello Harold / list,    
> 
> I'm trying to build an initramfs that includes an out-of-tree kernel 
> module for the mpt2sas driver without much success (by default).
> 
> The modified driver in question resides at:
> 
>   /lib/modules/3.8.0-rc4.sra+/updates/lsb-ft/extra/mpt2sas/mpt2sas.ko
>  
> and recent versions of dracut exclude this driver from the generated
> initramfs.  This is on a F18 install, 3.8.0-rc4 kernel and a newly
> recompiled out-of-tree mpt2sas ko file.
> 
> Using git bisect, I found dracut *would* include the updated .ko until...
> 
> d8aeb3a72afe03e426f4ea9f07c857c9a499144f is the first bad commit
> commit d8aeb3a72afe03e426f4ea9f07c857c9a499144f
> Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date:   Wed Jun 27 09:35:39 2012 +0200
> 
>     dracut.sh, dracut-functions.sh: do lazy kernel module dep resolving
>     
>     First, we just install the kernel module and keep track, what we
>     installed. At the very end, call modprobe and modinfo for firmwares to
>     resolve all kernel module dependencies. This speeds up image creation,
>     because we can call modprobe and modinfo with many modules.
> 
> I notice that find_kernel_modules_by_path() filters out any string that 
> does not start with 'kernel' as well as the given path, ie 'drivers/scsi' 
> (by design I would assume).
> 
> If the in-tree mpt2sas driver is loaded, then 
> find_kernel_modules_by_path() would echo the driver since:
> 
>   $1 = drivers/scsi
>   $a = kernel/drivers/scsi/mpt2sas/mpt2sas.ko
> 
> but when the out-of-tree driver is used, then
> 
>   $1 = drivers/scsi
>   $a = updates/lsb-ft/extra/mpt2sas/mpt2sas.ko
> 
> fails this check.
> 
> 1 - Should Dracut be checking the /lib/modules/ver/{updates,extras}
>     directories as well as the in-tree kernel directory for drivers?

yes

> 
> 2 - Do modules underneath /lib/modules/ver/{updates,extras} need to 
>     include their respective directory structure (ie, 'drivers/scsi'). 

yes

> 
> I can avoid this by forcing dracut to include out-of-tree drivers using 
> the add_drivers directive, but I defer to the dracut coders here on how I  
> can best include them by default.  
> 
> Regards,
> 
> -- Joe

Thanks for reporting this, will fix this bug!
