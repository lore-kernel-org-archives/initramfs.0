From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 07 May 2014 13:32:39 +0200
Message-ID: <536A19D7.2010405@redhat.com>
References: <2263850.UM9clb02rz@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2263850.UM9clb02rz@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 13:12, Thomas Renninger wrote:
> Hi,
> 
> I wonder for what this one is exactly for?
> 
> commit ab9457efd78ff74c654b4123956cdbd131935066
> Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date:   Tue Feb 25 12:35:32 2014 +0100
> 
>     Add flag to toggle hostonly cmdline storing in the initramfs
>     
>     --hostonly-cmdline:
>         Store kernel command line arguments needed in the initramfs
>     
>     --no-hostonly-cmdline:
>         Do not store kernel command line arguments needed in the initramfs
> 
> 
> 
> Wouldn't it be enough to simply add hostonly command line parameters
> only in hostonly case like:
> +    if [[ $hostonly == "yes" ]]; then
> +        cmdline  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
> +        echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
> +    fi
> 
> why is a hostonly-cmdline extra parameter needed?
> 
> Thanks,
> 
>   Thomas
> 

hostonly stores config files like mdadm.conf and only installs those kernel
modules, which are specific to the machine.

hostonly-cmdline also stores dracut specific kernel cmdline parameters to boot
the system in the initramfs, so that basically you could boot the system by
only specifying "root=" on the kernel cmdline.

The advantage of hostonly-cmdline is that the kernel cmdline does not need
complex rd.md.uuid=... or rd.luks.uuid=... parameters.

The disadvantage is that in case of uuid or disk changes, you cannot alter the
parameters which are in the initramfs.

I suggest to use the output of:

# dracut --print-cmdline

and add it to the kernel command line.

hostonly-cmdline should only be used, when e.g. the maximum char limit of the
kernel command line would be reached or when the user has a generic rescue
image, to be used when the disk layout changed and the user has not generated a
new initramfs with it.

Maybe we could let hostonly-cmdline be the default and add a parameter
"rd.cmdline.conf=0", which turns of parsing $initrd/etc/cmdline.d/*.conf.

Thoughts?
