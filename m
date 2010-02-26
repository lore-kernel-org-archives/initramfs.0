From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH] udev: install distro specific firmware handler
Date: Fri, 26 Feb 2010 18:18:33 +0300
Message-ID: <201002261818.37491.arvidjaar@mail.ru>
References: <1267195175-15554-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart50694501.FIXZT73uI7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267195175-15554-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

--nextPart50694501.FIXZT73uI7
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Friday 26 of February 2010 17:39:29 Philippe Seewer wrote:
> Debian Unstable still calls its firmware handling script
> 'firmware.agent' instead of 'firmware.sh'. This patch ensures that
> either the .agent or the .sh gets installed.
> ---
>  modules.d/95udev-rules/install |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/modules.d/95udev-rules/install
> b/modules.d/95udev-rules/install index b903a41..287cc03 100755
> --- a/modules.d/95udev-rules/install
> +++ b/modules.d/95udev-rules/install
> @@ -15,7 +15,9 @@ inst_rules "$moddir/01-ignore.rules"
>=20
>  # for firmware loading
>  inst_rules 50-firmware.rules
> -dracut_install /lib/udev/firmware.sh

Your patch seems to be against old codebase. This has changed in current=20
GIT (and 004 actually) already to account for binary /lib/udev/firmware=20
shipped with new udev.

> +for i in firmware.sh firmware.agent hotplug.functions ; do

If you redo the patch please do not forget about /lib/udev/firmware too.

--nextPart50694501.FIXZT73uI7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuH5koACgkQR6LMutpd94w96ACfUWRv+3rr7zw7aqSSsPUd/29F
H4AAniyvNfGyPJBgJwEO1iMGw9/npdd+
=gstS
-----END PGP SIGNATURE-----

--nextPart50694501.FIXZT73uI7--
