From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut generation modes
Date: Fri, 29 May 2009 16:21:05 +0200
Message-ID: <4A1FEF51.1020004@redhat.com>
References: <4A1EDEBF.4080009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1EDEBF.4080009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

doh... sent it to warren only..

On 05/28/2009 08:58 PM, Warren Togami wrote:
> So this might not have been clear earlier, but stating it on the list to
> be sure everyone is on the same page.
>
> * Default Dracut
> Dracut without any parameters should generate an initrd image capable of
> booting a generic machine. This means it must not detect anything of the
> current running system to determine what to install in the image. This
> includes stuff in /proc, /sys, lsmod, /proc/mounts and possibly more.
>
> By necessity, stuff in the filesystem are usable to dracut in
> determining what to install in the image.

The default dracut image could be delivered as an rpm along with the kernel.
Configuration files could be injected via "gunzip|cpio -A|gzip", though 
modifying the md5 hash sum.

>
> * --hostonly mode
> Host only mode is permitted to use runtime detection to generate an
> image capable of booting the current system. What exactly does this
> mean? Is this primarily for smaller sizes by avoiding irrelevant modules?

yes

>
> * (Some other generation mode)
> Perhaps we need more generation modes for other purposes. One likely
> case is where you need to generate a machine specific image for a
> non-local system. A combination of command line options and/or .conf
> file would define the dracut image for a non-local system. This might be
> necessary for cases like:
>
> - netboot initrd needs to be as small as possible for resource
> constraint reasons
> - embedded systems with resource constraints

use dracutmodules=""

> - certificates or passwords for iscsi or kerberized nfs

inject configuration files in the standard "Default Dracut" image via 
"gunzip|cpio -A|gzip"

>
> How should this mode be specified from the command line?
>


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
