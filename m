From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v7] dracut: add support for custom locale definitions
Date: Thu, 21 Apr 2016 17:03:37 +0200
Message-ID: <1461251017.10934.67.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
	 <1460837622.3201.14.camel@trentalancia.net>
	 <1460838269.3201.18.camel@trentalancia.net>
	 <1461026208.2262.1.camel@trentalancia.net>
	 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
	 <1461241841.10934.12.camel@trentalancia.net> <5718D074.70507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5718D074.70507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 21/04/2016 at 15.07 +0200, Harald Hoyer wrote:
> On 21.04.2016 14:30, Guido Trentalancia wrote:
> > Hello Harald !
> >=20
> > On Thu, 21/04/2016 Guido Trentalancia wrote:
> > > > Compile and install locale definitions using localedef from GNU
> > > > libc or,
> > > > if locale definitions cannot be compiled but are available on
> > > > the
> > > > system
> > > > as split definitions, just install them.

[...]

> > > > diff -pruN dracut-git-orig/modules.d/10i18n/module-setup.sh
> > > > dracut-
> > > > git-10i18n-add-support-for-custom-locale-
> > > > definitions/modules.d/10i18n/module-setup.sh
> > > > --- dracut-git-orig/modules.d/10i18n/module-setup.sh	201
> > > > 6-
> > > > 04-20 14:11:02.825944933 +0200
> > > > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > > > definitions/modules.d/10i18n/module-setup.sh	2016-04-20
> > > > 14:44:39.610119250 +0200
> > > > @@ -1,10 +1,15 @@
> > > > =C2=A0#!/bin/bash
> > > > =C2=A0
> > > > +# Updated: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > > > +#
> > > > +#=C2=A0=C2=A0Added full localisation support (including messag=
e-based
> > > > +#=C2=A0=C2=A0program localisation and support for non-latin ch=
arsets)
> > >=20
> > > git history should be enough, we don't mention it in the
> > > individual
> > > files

I just realised this goes in NEWS...

Regards,

Guido
