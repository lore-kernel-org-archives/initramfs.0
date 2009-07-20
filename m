From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCEMENT] dracut-0.5
Date: Sun, 19 Jul 2009 22:01:51 -0400
Message-ID: <20090720020150.GA50193@redhat.com>
References: <4A608CD3.7070107@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A608CD3.7070107-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Friday, July 17 2009, Harald Hoyer said:

> - more kernel command line parameters (see also man dracut(8))
> - a helper tool, which generates the kernel command line (dracut-gencmdline)
[snip]
> rd_DM_UUID, rd_LUKS_UUID, rd_MD_UUID help you, if dracut does more than 
> you want in its automatic mode. So if you want to be more specific on 
> what dracut is allowed to assemble, uncrypt etc. just specify the exact 
> parameters.

Hmmm, requiring/expecting this much in the way of kernel parameters in
the default case feels like it has a likelihood of hitting
architecture-specific limits on command line size.  I know that's been a
problem in a lot of cases on s390 in the past.

I wonder if its worth supporting reading these first from a file "in the
initramfs"[1] and then letting /proc/cmdline act as overrides of that
ala the way the s390 people have historically done .parm files[2].

Jeremy

[1] It doesn't actually need to be in the packaged initramfs -- we could
generate a host-specific file that's added as a second initramfs via the
bootloader config.  dracut doesn't need to know its from a second file
but that seems like it would be straight-forward enough and help the
problem.  It also could be used for things like keeping passwords out of
the kernel command line
[2] I can't believe I'm actually suggesting following something s390 has
done :-)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
