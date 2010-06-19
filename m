From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] dracut: setup English locales for Dracut build script
Date: Sat, 19 Jun 2010 13:25:52 +0200
Message-ID: <20100619132552.2b2f3a21@etiriah.ds.pg.gda.pl>
References: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
	<201006181428.09276.adam@spra.gg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/a4aM_ptz7gfcBtvYJkvf/qv"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006181428.09276.adam-2iSS7ArDF14@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/a4aM_ptz7gfcBtvYJkvf/qv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you all for comments.  Right, C is better. :-)

I reviewed the code and it looks that only ldd is =E2=80=9Caffected=E2=80=
=9D by locales,
although there some other commands the output is parsed, but it's not
localized.  Should we prefix them anyway =E2=80=9Cjust for sure=E2=80=9D or=
 leave as is?


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/a4aM_ptz7gfcBtvYJkvf/qv
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwcqUAACgkQ+hU8EsKEdQ19BACgl/JrvTWugoPbJZYdz+PvntzV
BXkAoJLhMJKeIS85dUOmqC9DoHQSPtYD
=t9i8
-----END PGP SIGNATURE-----

--Sig_/a4aM_ptz7gfcBtvYJkvf/qv--
