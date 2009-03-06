From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Fri, 6 Mar 2009 16:36:24 +0100
Message-ID: <20090306153624.GA27713@stro.at>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com> <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com> <20090304002535.GB96609@redhat.com> <1236129369.6500.18.camel@sentry-no.fnordovax.org> <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com> <1236166408.6500.37.camel@sentry-no.fnordovax.org> <ac3eb2510903040408w299b349aj791a2f9e0d154b9a@mail.gmail.com> <82ecf08e0903040418v23e68261le6c2a05f032a9b31@mail.gmail.com> <20090306093301.GB3301@nb.net.home> <ac3eb2510903060217l1866919ag17b778e58cadb58a@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac3eb2510903060217l1866919ag17b778e58cadb58a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Fri, 06 Mar 2009, Kay Sievers wrote:

> On Fri, Mar 6, 2009 at 10:33, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Wed, Mar 04, 2009 at 09:18:35AM -0300, Thiago Galesi wrote:
> >> I remember seeing something in dracut mentioning pages: "The code =
for
> >> the replacement of this currently lives at
> >> http://pjones.fedorapeople.org/mkstart/usr/lib/mkstart/switchroot.=
c "
> >>
> >> I'm not sure this could be used, but it would be good to have
> >> something merged to hack already ;)
> >
> > From my INBOX (private discussion between DaveJ and PJones, CC to m=
e):
> >
> > =A0On Mon, Feb 02, 2009 at 04:31:48PM -0500, Peter Jones wrote:
> > =A0I think http://pjones.fedorapeople.org/switchroot.c is actually =
the latest version.
> > =A0As a warning, I haven't actually tested past building it.
> >
> > Maybe we can start to use this version and improve it.
>=20
> This one, or the one in Harald's dracut repo, or the one from busybox=
,
> or the one from klibc, they should work fine. I guess the binary
> should live in the dracut repo, and should be installed in
> /usr/lib/dracut/*, as it is not useful for anything else, I expect. O=
r
> is there any possible other user?

run-init.c from klibc sees realworld usage:
git clone git://git.kernel.org/pub/scm/libs/klibc/klibc.git
cd klibc/usr/kinit/run-init/


--=20
maks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
