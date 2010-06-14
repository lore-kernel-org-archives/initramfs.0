From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [RFC] console_init.c in i18n module
Date: Mon, 14 Jun 2010 08:31:02 +0200
Message-ID: <20100614083102.16f35a59@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/5ASGSGf=600CetoADszU6Cw"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/5ASGSGf=600CetoADszU6Cw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm trying to find a way to make i18n distro independent or at least
more flexible.

Module 10redhat-i18n depends on two programs from RH initscripts
package: console_init and console_check.  Those tools are called by udev
and if we deliver just keymaps and few things like loadkey we're fine.
But=E2=80=A6 console_* are RH specific stuff (included in initscript packag=
e).
I see two easy approaches:

    * Putting its sources into Dracut tree beside switch_root.c.
      They don't depend on any library, so it should be easy.
    * Rewrite as a shell script (but it's redundant work if the first
      way is OK).

Moreover console_check isn't installed by Dracut at all, but it's in
default =E2=80=9C10-console.rules=E2=80=9D rule.  This tool just setup spee=
d for serial
console which we do by kernel params, so I guess we can skip it.  In
that case modified 10-console.rules should be delivered inside i18n
module.

What do you think about it?


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/5ASGSGf=600CetoADszU6Cw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwVzKYACgkQ+hU8EsKEdQ2oNgCfbjIXlr59x5RZy2HcVD836w7I
qH0An0FWVPm1fqST8nUnxGGwuX0Eoc2w
=7o3J
-----END PGP SIGNATURE-----

--Sig_/5ASGSGf=600CetoADszU6Cw--
