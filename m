From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Adding ramdisk/initramfs data to kernel post build
Date: Wed, 22 Jul 2009 22:04:13 -0400
Message-ID: <4A67C51D.40102@redhat.com>
References: <110c8b2e0907221029u1d0f2ad5jeadbf017cc2d2f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <110c8b2e0907221029u1d0f2ad5jeadbf017cc2d2f7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Subodh Nijsure <nijsure.subodh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/22/2009 01:29 PM, Subodh Nijsure wrote:
> Hello,
>
> I am exploring ways to add combine kernel and ramdisk into single
> image on X86 platform.
>
> (Unfortunately) the way build system is working kernel is built before
> the modules that need to go into the ramdisk.
>
> I have been looking at addRmdisk.c found in  arch/powerpc/boot/
> directory and see if I can use it.
>
> Within the initramfs infrastructure is there way to patch in the
> initrd/initramfs into kernel that has already been built?

For what purpose?

Tools like wraplinux will wrap a kernel and initrd image (like generated 
by dracut) into a single image file, either NBI or ELF format.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
