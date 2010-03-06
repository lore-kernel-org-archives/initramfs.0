From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: relative order of /etc/dracut.conf and /etc/dracut.conf.d
Date: Sat, 6 Mar 2010 07:54:08 +0300
Message-ID: <201003060754.08574.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1801179.3FKuL734I4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart1801179.3FKuL734I4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Currently dracut.conf is sourced after dracut.conf.d. Is it intentional?=20

I'd actually expect the opposite - dracut.conf used for distribution defaul=
ts,=20
dracut.conf.d for local system adjustments with command line options overru=
ling=20
them all.

=2D-

Subject: [PATCH] Source dracut.conf.d/* after dracut.conf
=46rom: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

This provides the natural way to ship defalts in dracut.conf while
allow local system customization in dracut.conf.d.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

=2D--

 dracut |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index b16e205..3f3c3e6 100755
=2D-- a/dracut
+++ b/dracut
@@ -123,11 +123,15 @@ if [[ ! -f $conffile ]]; then
     [[ $allowlocal ]] && conffile=3D"$dracutbasedir/dracut.conf"
 fi
=20
+# if we were not passed a config dir, try the default one
 if [[ ! -d $confdir ]]; then
     [[ $allowlocal ]] || confdir=3D"/etc/dracut.conf.d"
     [[ $allowlocal ]] && confdir=3D"$dracutbasedir/dracut.conf.d"
 fi
=20
+# source our config file
+[[ -f $conffile ]] && . "$conffile"
+
 # source our config dir
 if [ "$confdir" ] && [  -d "$confdir" ]; then
     for f in "$confdir"/*.conf; do=20
@@ -135,9 +139,6 @@ if [ "$confdir" ] && [  -d "$confdir" ]; then
     done
 fi
=20
=2D# source our config file
=2D[[ -f $conffile ]] && . "$conffile"
=2D
 # these options override the stuff in the config file
 [[ $dracutmodules_l ]] && dracutmodules=3D$dracutmodules_l
 [[ $omit_dracutmodules_l ]] && omit_dracutmodules=3D$omit_dracutmodules_l

--nextPart1801179.3FKuL734I4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuR3/AACgkQR6LMutpd94yHHQCgrjEc66U1NZYVLJGZfp7/2RJ7
T3UAniok2Z6g/kXq86gWdkwdvtAw4bDT
=bfow
-----END PGP SIGNATURE-----

--nextPart1801179.3FKuL734I4--
