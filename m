From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [RFC] Generic I18N module
Date: Tue, 29 Jun 2010 23:00:56 +0200
Message-ID: <20100629230056.71589ed1@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/6sj4U5H1kePR0Q9/C5bi+z7"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/6sj4U5H1kePR0Q9/C5bi+z7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'd like to present new I18N module.  It works or at least should
work. ;-)  It's composed of few files, so I'm giving a link to my
repo [0] for your convenience.

I've written installation script and rewritten console_init from
RedHat initscripts package (which was written in C) to bash and
customized parse-i18n.sh. console_init is run by udev as in
10redhat-i18n.

Any comments appreciated.


[0] http://github.com/aidecoe/dracut/tree/i18n/modules.d/10i18n/


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/6sj4U5H1kePR0Q9/C5bi+z7
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwqXwgACgkQ+hU8EsKEdQ0OyACgtL2ZzmqQpeeTswcdyEiIvFc8
N24AoJn5UmO81gAamhAcVmSVlDul+tiL
=h3+u
-----END PGP SIGNATURE-----

--Sig_/6sj4U5H1kePR0Q9/C5bi+z7--
