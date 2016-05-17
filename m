From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v9] dracut: add support for custom locale definitions
Date: Tue, 17 May 2016 14:36:58 +0200
Message-ID: <1463488618.8390.6.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5718AA77.8090600@redhat.com> <1461241841.10934.12.camel@trentalancia.net>
	 <243916044.BPCk0gu2Sz@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <243916044.BPCk0gu2Sz@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-9"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Thomas !

Sorry for my late reply...

On Thu, 17/05/2016 at 12.12 +0200, Thomas Renninger wrote:
> On Thursday, April 21, 2016 02:30:41 PM Guido Trentalancia wrote:
> > Hello Harald !
> >=20
> > On Thu, 21/04/2016 Guido Trentalancia wrote:
> > > > Compile and install locale definitions using localedef from GNU
> > > > libc or,
> > > > if locale definitions cannot be compiled but are available on
> > > > the
> > > > system
> > > > as split definitions, just install them.
> > > >=20
> > > > The resulting locale definitions archive contains at most two
> > > > different
> > > > locale definitions, therefore its size is relatively small.
> > > >=20
> > > > Add support for localised messages from core packages
> > > > (LC_MESSAGES).
> > >=20
> > > Do we really need this in the initramfs?
> >=20
> > It's a killer functionality !!! And it requires very little extra
> > disk
> > space compared to the actual initramfs. You know, we tend not to
> > use
> > the floppy disk anymore nowadays !...
>=20
> Linux runs on platforms you cannot lift, but it may run on platforms
> you
> can hardly see. Dracut is meant to be platform independent and may
> also
> run on platforms which memory/storage devices are very expensive or
> just
> very small.
>=20
> In general initramfs is precious.

I agree with you.

> Without having a closer look at the whole patchset.., but if this
> gets
> in, it should certainly be configurable or a separate module
> (10i18n_full?) if this is possible.

It is already configurable (and enabled by default, as we cannot
predict the user knows the English language).

Please use --msg-localisation and --no-msg-localisation to enable and
disable the feature.

> How much would the initrd about grow in a real number?

The difference between a 4.5.4 kernel initramfs fully localised with
the Italian language and a 4.5.4 kernel initramfs without full
localisation support (English-only messages) is 810 kilobytes.

>=20
> =C2=A0=C2=A0=C2=A0Thomas
>=20


Best regards,

Guido
