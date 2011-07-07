From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initramfs building
Date: Thu, 07 Jul 2011 10:28:15 +0200
Message-ID: <4E156E1F.7080704@redhat.com>
References: <B97B134FACB2024DB45F524AB0A7B7F203BBD010@XMB-BGL-419.cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B97B134FACB2024DB45F524AB0A7B7F203BBD010-rRFx+brps5guW2sxTbe+i6BKnGwkPULj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Prashant Batra (prbatra)" <prbatra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05.07.2011 10:05, Prashant Batra (prbatra) wrote:
> Hi, 
> 
> To build a initramfs image as part of kenel, the path to the build image
> is needed. 
> But if you start of a fresh kernel, you can not have the ramfs image
> built for that kernel.
> 
> So, the way is to build the kernel, install all the modules into
> /lib/modules/version folder, then build the initramfs image, include the
> path in kernel config and again build kernel image.
> 
> Is this correct or there is a better procedure?
> 
> Regards, 
> Prashant Batra

I do it the same way...
