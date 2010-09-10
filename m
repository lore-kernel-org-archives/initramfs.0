From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Re: Re: [PATCH] 98syslog: try to dynamically check for rsyslog moddir
Date: Fri, 10 Sep 2010 18:33:56 +0400
Message-ID: <E1Ou4kw-0005pA-00.arvidjaar-mail-ru@smtp11.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1920293.zmu8ip1n0B"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:Cc:To:From; bh=5Q8Q04t+vJifTK2wTil3MHEl+ctRTFD/XSc63pTObLg=;
	b=1regO8Kr2zDF69jhQsLTBVOubksTg7LwO55Vzkxkl/o5eDq3SB5XwDuQ3PZ7iN8UQCTW8WaK7W3x1Lt4JyftSBxGgLuoTZiJABJoGD9/I2c5tFBP6I1KOVd/ZB8RcYlC;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tomasz =?UTF-8?B?UGF3ZcWC?= Gajc <phenomenal-5tc4TXWwyLM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rsyslog-4gKAAF5ltrKNkp5+ER1W/AC/G2K4zDHf@public.gmane.org, tpg-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org


--nextPart1920293.zmu8ip1n0B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-2"

On Friday 10 of September 2010 15:48:22 Harald Hoyer wrote:
> On 09/08/2010 06:48 PM, Tomasz Pawe=B3 Gajc wrote:
> > Dnia 2010-09-08, o godz. 18:52:13
> >=20
> > Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>  napisa=B3(a):
> >> Thomas pointed out that default module path may not be correct
> >> (Mandriva installs modules under architecture dependent path).
> >> Unfortunately rsyslog does not seem to offer any way to query
> >> for
> >> default configuration values. Here is rather hack - try to load
> >> non-existing module and fetch path from error message.
> >>=20
> >> Example of error message from version 4.6.4:
> >>=20
> >> rsyslogd: could not load module
> >> '/lib64/rsyslog/_No_sUcH_MOduLe.so', dlopen:
> >> /lib64/rsyslog/_No_sUcH_MOduLe.so: cannot open shared object
> >> file: No such file or directory
> >>=20
> >> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
> >>=20
> >> ---
> >>=20
> >>   modules.d/98syslog/install |   17 ++++++++++++++++-
> >>   1 files changed, 16 insertions(+), 1 deletions(-)
> >>=20
> >> diff --git a/modules.d/98syslog/install
> >> b/modules.d/98syslog/install index 1fd1b6f..e3d02bf 100755
> >> --- a/modules.d/98syslog/install
> >> +++ b/modules.d/98syslog/install
> >> @@ -1,6 +1,21 @@
> >>=20
> >>   #!/bin/sh
> >>   if type -P rsyslogd>/dev/null; then
> >>=20
> >> -
> >> installs=3D"rsyslogd /lib/rsyslog/lmnet.so /lib/rsyslog/imklog.so
> >> /lib/rsyslog/imuxsock.so" +=09# module path can be changed during
> >> build and currently rsyslog
> >> +=09# does not provide any means to query for it. Use hack - try
> >> to
> >> +=09# load non-existent module and look at error message
> >> +=09R_CONF=3D/tmp/dracut.rsyslog.conf.$$
> >> +=09R_ERR=3D/tmp/dracut.rsyslog.err.$$
> >> +=09R_MODDIR=3D
> >> +=09echo '$ModLoad _No_sUcH_MOduLe'>  $R_CONF
> >> +=09if [ -s $R_CONF ]; then
> >> +=09=09rsyslogd -N 1 -f $R_CONF 2>  $R_ERR>  /dev/null
> >> +=09=09R_MODDIR=3D$(grep ' could not load
> >> module .*_No_sUcH_MOduLe' $R_ERR)
> >> +=09=09R_MODDIR=3D${R_MODDIR#*could not load module \'}
> >> +=09=09R_MODDIR=3D${R_MODDIR%\', *}
> >> +=09=09R_MODDIR=3D${R_MODDIR%/*}
> >> +=09fi
> >> +=09[ -n "$R_MODDIR" ] || R_MODDIR=3D/lib/rsyslog
> >> +=09installs=3D"rsyslogd $R_MODDIR/lmnet.so $R_MODDIR/imklog.so
> >> $R_MODDIR/imuxsock.so" elif type -P syslogd>/dev/null; then
> >>=20
> >>       installs=3D"syslogd"
> >>  =20
> >>   elif type -P syslog-ng>/dev/null; then
> >=20
> > Indeed this patch is more precise than my simplified one ;)
>=20
> ugly hack :-/ plus you want mktemp to prevent attacks..

Just to make sure - it was NAK? :)
--nextPart1920293.zmu8ip1n0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyKQdQACgkQR6LMutpd94z1HACdF0q+ttmvUn60HQC1wAVCWOtA
sVoAn0T9VUM4Hymj9i4DdqjMPtvFrbEk
=7yQe
-----END PGP SIGNATURE-----

--nextPart1920293.zmu8ip1n0B--
