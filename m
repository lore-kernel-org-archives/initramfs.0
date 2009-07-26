From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCEMENT] dracut-0.5
Date: Sat, 25 Jul 2009 22:17:57 -0400
Message-ID: <20090726021757.GA65377@redhat.com>
References: <4A608CD3.7070107@redhat.com> <20090720020150.GA50193@redhat.com> <20090725225944.GC27655@nb.net.home>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090725225944.GC27655-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sunday, July 26 2009, Karel Zak said:
> On Sun, Jul 19, 2009 at 10:01:51PM -0400, Jeremy Katz wrote:
> > On Friday, July 17 2009, Harald Hoyer said:
> > > - more kernel command line parameters (see also man dracut(8))
> > > - a helper tool, which generates the kernel command line (dracut-gencmdline)
> > [snip]
> > > rd_DM_UUID, rd_LUKS_UUID, rd_MD_UUID help you, if dracut does more than 
> > > you want in its automatic mode. So if you want to be more specific on 
> > > what dracut is allowed to assemble, uncrypt etc. just specify the exact 
> > > parameters.
> > 
> > Hmmm, requiring/expecting this much in the way of kernel parameters in
> > the default case feels like it has a likelihood of hitting
> > architecture-specific limits on command line size.  I know that's been a
> > problem in a lot of cases on s390 in the past.
> 
>  Is it still valid problem? http://lkml.org/lkml/2007/1/18/55

Boot loaders still have limits

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
