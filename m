From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut modules
Date: Thu, 24 Jun 2010 15:06:47 +0200
Message-ID: <20100624150647.15e9288c@etiriah.ds.pg.gda.pl>
References: <loom.20100624T143213-57@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/IOSZ4dgj80yBsQiDAW01tCm"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20100624T143213-57-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/IOSZ4dgj80yBsQiDAW01tCm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dave Stone <fsck1234-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>:
> Hi everyone.  Are there any documents describing how to add new
> modules to /usr/share/dracut/modules.d?  I have looked at what is
> available with RHEL6 Beta 1 version.  I would need to insert my own
> drivers before lvm. Thanks in advance for your help. =20

Yes, there's README.modules in the root of sources directory [0]
(or inside /usr/share/doc/dracut-$version$ if your package manger puts
docs there). Functions like inst are well documented in comments in
dracut-functions script which should be placed in /usr/share/dracut/.

[0] http://sourceforge.net/projects/dracut/


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/IOSZ4dgj80yBsQiDAW01tCm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwjWGcACgkQ+hU8EsKEdQ0ZgQCgp5skzulNIfXuVP3raYjMMhmu
loAAoIHQOUZykLnzRrQbBc/cT8F2xEZW
=nEgl
-----END PGP SIGNATURE-----

--Sig_/IOSZ4dgj80yBsQiDAW01tCm--
