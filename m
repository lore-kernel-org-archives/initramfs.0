From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH] udev: install distro specific firmware handler
Date: Fri, 26 Feb 2010 19:35:10 +0300
Message-ID: <201002261935.10311.arvidjaar@mail.ru>
References: <1267195175-15554-1-git-send-email-philippe.seewer@bfh.ch> <201002261818.37491.arvidjaar@mail.ru> <4B87EBA2.20206@bfh.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2195205.yiA5sntsr0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B87EBA2.20206-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart2195205.yiA5sntsr0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Friday 26 of February 2010 18:41:22 Seewer Philippe wrote:
> Andrey Borzenkov wrote:
> > On Friday 26 of February 2010 17:39:29 Philippe Seewer wrote:
> >> Debian Unstable still calls its firmware handling script
> >> 'firmware.agent' instead of 'firmware.sh'. This patch ensures that
> >> either the .agent or the .sh gets installed.
> >> ---
> >>=20
> >>  modules.d/95udev-rules/install |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/modules.d/95udev-rules/install
> >> b/modules.d/95udev-rules/install index b903a41..287cc03 100755
> >> --- a/modules.d/95udev-rules/install
> >> +++ b/modules.d/95udev-rules/install
> >> @@ -15,7 +15,9 @@ inst_rules "$moddir/01-ignore.rules"
> >>=20
> >>  # for firmware loading
> >>  inst_rules 50-firmware.rules
> >>=20
> >> -dracut_install /lib/udev/firmware.sh
> >=20
> > Your patch seems to be against old codebase. This has changed in
> > current GIT (and 004 actually) already to account for binary
> > /lib/udev/firmware shipped with new udev.
>=20
> Now I'm confused... according to git's history there's only been two
> changes to 95udev-rules/install in the last 4-5 months.
>

Oh, sorry - I was sure it was applied but it is not.

Could you please add /lib/udev/firmware to your patch then? Thank you!

--nextPart2195205.yiA5sntsr0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuH+D4ACgkQR6LMutpd94wlkwCg02p8mfr2jMVLASRYz1+bP6bV
9MYAn0JdyZFdxfrLPuAcjpwOSFD3QFOc
=S0HD
-----END PGP SIGNATURE-----

--nextPart2195205.yiA5sntsr0--
