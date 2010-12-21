From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] include biosdevname calls in dracut
Date: Tue, 21 Dec 2010 17:16:17 +0100
Message-ID: <1292947718-sup-548@ittemni>
References: <20101206005229.GA687@auslistsprd01.us.dell.com> <20101214195807.GB31714@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1292948177-885444-20961-7014-14-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20101214195807.GB31714-fZmvIyTar7vbK7CpiBUVEGyRm/Zj/t/4AL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1292948177-885444-20961-7014-14-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Matt Domsch's message of Tue Dec 14 20:58:07 +0100 2010:
> On Sun, Dec 05, 2010 at 06:52:29PM -0600, Matt Domsch wrote:
> > For your consideration.  This allows biosdevname to be called from
> > network-using functions in dracut.  biosdevname is included in
> > Fedora 15, and there are tickets open to include it in other
> > distros.
> =

> Any thoughts on this patch?

I think that better would be to include your patch with first its usage.
Having additional dependencies without a real use brings mess.  But it's
just my opinion and I'm not in charge. :-)


Cheers,
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1292948177-885444-20961-7014-14-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJNENLRAAoJEPATRTHh2/q1cPQH/1G/A/fZsMOGXcQZ9GpJUVvB
94PaPoAEezTM9pQQbXwyYfzWbEy4aTy45bayYxyMmVk7aCl6JL+1KWdFqppWQkyz
nhuX9Rl8HeW1w9bMiDN36oq2Haq7PJDQzQE1DkHCwqt2BQcQn8p3DjgrQlRbN1Zj
bA631t8JtErmAVFjU3W0TQKLzjQHegV5GMN9DpyrhoAxKXiCVa4djVG97M7GabrR
O94Ak2VdacqsQJIZGx6AD1DxFLWwMCeRvJilYkOYBpgXNyeoMCnL/mILosUaD3mf
NvBnkHUw9emw0IL1zUtw6ihwyG+8bqO01+Ooo20dbtclKlMeVk3ByuD+0XlQnyc=
=Sz+r
-----END PGP SIGNATURE-----

--=-1292948177-885444-20961-7014-14-=--
