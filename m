From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v7] dracut: add support for custom locale definitions
Date: Tue, 17 May 2016 12:12:19 +0200
Message-ID: <243916044.BPCk0gu2Sz@skinner>
References: <1460758050.3211.2.camel@trentalancia.net> <5718AA77.8090600@redhat.com> <1461241841.10934.12.camel@trentalancia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461241841.10934.12.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thursday, April 21, 2016 02:30:41 PM Guido Trentalancia wrote:
> Hello Harald !
> 
> On Thu, 21/04/2016 Guido Trentalancia wrote:
> > > Compile and install locale definitions using localedef from GNU
> > > libc or,
> > > if locale definitions cannot be compiled but are available on the
> > > system
> > > as split definitions, just install them.
> > > 
> > > The resulting locale definitions archive contains at most two
> > > different
> > > locale definitions, therefore its size is relatively small.
> > > 
> > > Add support for localised messages from core packages
> > > (LC_MESSAGES).
> > 
> > Do we really need this in the initramfs?
> 
> It's a killer functionality !!! And it requires very little extra disk
> space compared to the actual initramfs. You know, we tend not to use
> the floppy disk anymore nowadays !...

Linux runs on platforms you cannot lift, but it may run on platforms you
can hardly see. Dracut is meant to be platform independent and may also
run on platforms which memory/storage devices are very expensive or just
very small.

In general initramfs is precious.

Without having a closer look at the whole patchset.., but if this gets
in, it should certainly be configurable or a separate module
(10i18n_full?) if this is possible.

How much would the initrd about grow in a real number?

   Thomas
