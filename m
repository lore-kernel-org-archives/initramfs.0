From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] Fix autodetection of UNICODE keymap
Date: Thu, 12 Aug 2010 13:52:50 +0200
Message-ID: <20100812135250.43e7bc3d@etiriah>
References: <20100811174757.15606.72777.stgit@cooker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/KFJ4BYGZADzo=woL2J2Dljs"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100811174757.15606.72777.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/KFJ4BYGZADzo=woL2J2Dljs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Andrey,

Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>:
> Original console_init from RH initscripts supports KEYTABLE variable
> which dynamically determines whether to load UNICODE keymap depending
> on current LANG value.
>=20
> Scripts from 10i18n are more simplistic and assume the right keymap is
> statically defined in configuration files.

10i18n install script determines UTF-8 mode in basis of UNICODE
variable value or LANG value.  console_init doesn't have to perform any
auto-detection again, although it might be useful to check LANG again
instead of or additionally to checking UNICODE kernel cmdline arg.
Maybe I'll add sth like this.


> Add support for KEYTABLE to dynamically determine whether to install
> UNICODE or non-UNICODE keymap version. This should probably go into
> run-time 10i18n/console_init instead to be fully compatible.

-- CUT --

> +    KEYTABLE - base name for keyboard translation table; if UNICODE
> is
> +	true, Unicode version will be loaded. Overrides KEYMAP.

-- CUT --

> +    # KEYTABLE is a bit special - it defines base keymap name and
> UNICODE
> +    # determines whether non-UNICODE or UNICODE version is used
> +
> +    if [[ ${KEYTABLE} ]]; then
> +	if [[ ${UNICODE} =3D=3D 1 ]]; then
> +	    [[ ${KEYTABLE} =3D~ .*\.uni.* ]] ||
> KEYTABLE=3D${KEYTABLE%.map*}.uni
> +	fi
> +
> +	KEYMAP=3D${KEYTABLE}
> +    fi
> +

What does *.uni* have to do with KEYMAP? Maybe I misunderstand it, but
we set up keyboard with two things:
  1) loadkeys to which we provide map from keymaps directory
     (where are no *.uni* files) and optionally '-u' which is UTF-8
     switch;
  2) kbd_mode to which we provide '-u' (UTF-8) or '-a' (ASCII).

*.uni* files are in unimaps directory. Those files are used by setfont.

Please explain me what is really the KEYTABLE variable and please check
out if you can achieve what you want with mappings in config file. Have
you read the README file?

If you have to resist with KEYTABLE, please publish archive with
configs where those vars are set up in your system, kbd dirs and init
scripts which set up those things.


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/KFJ4BYGZADzo=woL2J2Dljs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkxj4JYACgkQ+hU8EsKEdQ3NjACglJJKhtzw15O31rSo9EfY19pO
su0An2SlG/QKSJF582W1ViQdmrPJQOvW
=pnIc
-----END PGP SIGNATURE-----

--Sig_/KFJ4BYGZADzo=woL2J2Dljs--
