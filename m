From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] dracut: setup English locales for Dracut build script
Date: Fri, 18 Jun 2010 15:30:44 +0200
Message-ID: <20100618153044.6b3bd2a6@etiriah.ds.pg.gda.pl>
References: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
	<AANLkTil85GmgtdZieaCwu93axSYZnlpVDpMX2kSRQiUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/MfWf.TAZ/XMGNKfG4Qfk9qJ"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTil85GmgtdZieaCwu93axSYZnlpVDpMX2kSRQiUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/MfWf.TAZ/XMGNKfG4Qfk9qJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hmmm... The usual way to do this is to run the program in the C locale
> by setting
> LC_ALL=3DC

You mean we should prefix every call which output we rely or just setup:
export LC_ALL=3DC in place I pointed?  Hm=E2=80=A6 to think about it the fi=
rst
option would be more elgant.


--=20
PGP key: 1024D/C284750D

--Sig_/MfWf.TAZ/XMGNKfG4Qfk9qJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwbdQQACgkQ+hU8EsKEdQ3e/gCg3azH2jFJSfOg/83bvtv0ac3R
uzUAnjMMPIjQ4kgJ0pE1cT7CyHPWYtKK
=6BN1
-----END PGP SIGNATURE-----

--Sig_/MfWf.TAZ/XMGNKfG4Qfk9qJ--
