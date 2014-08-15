From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Adding support for read/write filesystem images
Date: Fri, 15 Aug 2014 16:07:05 +0200
Message-ID: <53EE1409.1040404@redhat.com>
References: <53DFAB14.1020201@mhtx.net> <53EDE06B.80900@redhat.com> <53EE099D.2070402@mhtx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53EE099D.2070402-rCS72UCksqc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Major Hayden <major-rCS72UCksqc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 15.08.2014 15:22, Major Hayden wrote:
>> Can you add documentation to the man pages? And if you are really nice add
>> documentation about the other dmsquash parameters, too. :)
> 
> Absolutely! :)
> 
> The patch has grown a bit.  If it's too difficult to process, I added
> the same changes on the GitHub pull request here:
> 
>   https://github.com/haraldh/dracut/pull/25
> 
> Thanks!
> 
> 
> From 9a9fc958a874867cad34dd3dc072a52353fbffd7 Mon Sep 17 00:00:00 2001
> From: Major Hayden <major-rCS72UCksqc@public.gmane.org>
> Date: Mon, 4 Aug 2014 10:27:36 -0500
> Subject: [PATCH] Adding support for read/write filesystem images
> 
> A user can provide a filesystem image (rootfs.img) inside a compressed
> tarball and that filesystem image will be mounted read/write.  This provides
> some benefits over a device mapper snapshot overlay, especially when the
> live system becomes full.  The boot command line simple needs
> "rd.writable.fsimg" added to utilize this feature.
> 
> Additional documentation for this option as well as other live boot
> options is included.
> 
> Signed-off-by: Major Hayden <major-rCS72UCksqc@public.gmane.org>

pushed! Thanks!
