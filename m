From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 024
Date: Tue, 16 Oct 2012 17:33:07 +0200
Message-ID: <507D7E33.2050503@redhat.com>
References: <507D7648.3040108@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507D7648.3040108-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 16.10.2012 16:59, schrieb Harald Hoyer:
> Here comes a new dracut version. Thanks to all who have contributed to
> this release.
> 
> The tarball can be found here:
> 	http://www.kernel.org/pub/linux/utils/boot/dracut/
> 	ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
> 
> Git:
> 	git://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 	http://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 	https://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 
> Git Web:
> 	http://git.kernel.org/?p=boot/dracut/dracut.git
> 
> Git Web RSS Feed:
> 	http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss
> 
> Project Page:
> 	http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
> 
> Project Wiki:
> 	http://dracut.wiki.kernel.org
> 
> The ChangeLog can be found here:
>         http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS
> 
> dracut-024
> ==========
> - new dracut option "--device"
> - new dracut kernel command line options "rd.auto"
> - new dracut kernel command line options "rd.noverifyssl"
> - new dracut option "--kernel-cmdline" and "kernel_cmdline" option for default
> parameters
> - fixes for systemd and crypto
> - fix for kexec in shutdown, if not included in initramfs
> - create the initramfs non-world readable
> - prelink/preunlink in the initramfs
> - strip binaries in the initramfs by default now
> - various FIPS fixes
> - various dracut-install fixes
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I should add a little comment about "rd.auto", which is off by default.

So, the default behavior for the dracut initramfs is now, not to automatically
assemble the devices it finds, unless "rd.auto=1" is given on the kernel command
line.

The old behavior can be turned on by shipping a .conf file in /etc/dracut.conf.d
with:

kernelcmdline+=" rd.auto=1 "

Which adds "rd.auto=1" to the default parameter.
