From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v7] dracut: add support for custom locale definitions
Date: Thu, 21 Apr 2016 14:57:28 +0200
Message-ID: <1461243448.10934.25.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
	 <1460837622.3201.14.camel@trentalancia.net>
	 <1460838269.3201.18.camel@trentalancia.net>
	 <1461026208.2262.1.camel@trentalancia.net>
	 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
	 <1461241841.10934.12.camel@trentalancia.net>
	 <CAA91j0U0XaJBaWNzBmRE3hs0zV7UKMEvO-6nBx_jaxkwhEHckg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAA91j0U0XaJBaWNzBmRE3hs0zV7UKMEvO-6nBx_jaxkwhEHckg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello Andrei !

On Thu, 21/04/2016 at 15.41 +0300, Andrei Borzenkov wrote:
> > On Thu, 21/04/2016 Guido Trentalancia wrote:

[...]

> > > > Add support for localised messages from core packages
> > > > (LC_MESSAGES).
> > > 
> > > Do we really need this in the initramfs?
> > 
> > It's a killer functionality !!! And it requires very little extra
> > disk
> > space compared to the actual initramfs. You know, we tend not to
> > use
> > the floppy disk anymore nowadays !...
> > 
> 
> Hmm ... how do you determine which message catalogs need to be
> included? It obviously depends on modules and there is no 1-to-1
> correspondence between programs and message catalogs.

A variable first defines the core packages to include (the very
minimum, such as e2fsprogs, coreutils and so on). Consider that's very
important information and not everybody speaks English. So you don't
really want to put at risk of corruption someone else filesystem or
similar things.

The above does not depend on installed modules, as core packages are
always present.

What do you mean exactly for 1-to-1 match between programs and message
catalogs ? Of course, a dracut module doesn't install all programs from
a given package, then you still need to install the message-based
localisation for the whole package. But we are talking about kilobytes:
e.g. 181522 /usr/share/locale/it/LC_MESSAGES/coreutils.mo

> Do you have actual results how much space message catalogs for all
> components in typical initrd consume?


For the italian locale, I have the following figures:

initramfs with full locale support: 32668248
initramfs with only the keyboard support (virtually useless to non-
English speaking users): 29624027

The difference is 3 Megabytes. Nothing compared to today's removable
mass storage capabilities.

Regards,

Guido
