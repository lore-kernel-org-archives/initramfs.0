From: Tomasz =?ISO-8859-2?B?UGF3ZbM=?= Gajc <phenomenal-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH] 98syslog: try to dynamically check for rsyslog moddir
Date: Fri, 10 Sep 2010 20:25:43 +0200
Message-ID: <20100910202543.3e78e603@wp.pl>
References: <E1Ou4kw-0005pA-00.arvidjaar-mail-ru@smtp11.mail.ru>
	<4C8A4B91.20905@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=HFQIIW=I9d_mIMICsj6ItN"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C8A4B91.20905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rsyslog-4gKAAF5ltrKNkp5+ER1W/AC/G2K4zDHf@public.gmane.org

--Sig_/=HFQIIW=I9d_mIMICsj6ItN
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Dnia 2010-09-10, o godz. 11:15:29
Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> napisa=B3(a):

> On 09/10/2010 10:33 AM, Andrey Borzenkov wrote:
> > On Friday 10 of September 2010 15:48:22 Harald Hoyer wrote:
> >> On 09/08/2010 06:48 PM, Tomasz Pawe=B3 Gajc wrote:
> >>> Dnia 2010-09-08, o godz. 18:52:13
> >>>
> >>> Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>   napisa=B3(a):
> >>>> Thomas pointed out that default module path may not be correct
> >>>> (Mandriva installs modules under architecture dependent path).
> >>>> Unfortunately rsyslog does not seem to offer any way to query
> >>>> for
> >>>> default configuration values. Here is rather hack - try to load
> >>>> non-existing module and fetch path from error message.
> >>>>
> >>>> Example of error message from version 4.6.4:
> >>>>
> >>>> rsyslogd: could not load module
> >>>> '/lib64/rsyslog/_No_sUcH_MOduLe.so', dlopen:
> >>>> /lib64/rsyslog/_No_sUcH_MOduLe.so: cannot open shared object
> >>>> file: No such file or directory
> >>>>
> >>>> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
> >>>>
> >>>> ---
> >>>>
> >>>>    modules.d/98syslog/install |   17 ++++++++++++++++-
> >>>>    1 files changed, 16 insertions(+), 1 deletions(-)
> >>>>
> >>>> diff --git a/modules.d/98syslog/install
> >>>> b/modules.d/98syslog/install index 1fd1b6f..e3d02bf 100755
> >>>> --- a/modules.d/98syslog/install
> >>>> +++ b/modules.d/98syslog/install
> >>>> @@ -1,6 +1,21 @@
> >>>>
> >>>>    #!/bin/sh
> >>>>    if type -P rsyslogd>/dev/null; then
> >>>>
> >>>> -
> >>>> installs=3D"rsyslogd /lib/rsyslog/lmnet.so /lib/rsyslog/imklog.so
> >>>> /lib/rsyslog/imuxsock.so" +	# module path can be changed
> >>>> during build and currently rsyslog
> >>>> +	# does not provide any means to query for it. Use hack
> >>>> - try to
> >>>> +	# load non-existent module and look at error message
> >>>> +	R_CONF=3D/tmp/dracut.rsyslog.conf.$$
> >>>> +	R_ERR=3D/tmp/dracut.rsyslog.err.$$
> >>>> +	R_MODDIR=3D
> >>>> +	echo '$ModLoad _No_sUcH_MOduLe'>   $R_CONF
> >>>> +	if [ -s $R_CONF ]; then
> >>>> +		rsyslogd -N 1 -f $R_CONF 2>
> >>>> $R_ERR>   /dev/null
> >>>> +		R_MODDIR=3D$(grep ' could not load
> >>>> module .*_No_sUcH_MOduLe' $R_ERR)
> >>>> +		R_MODDIR=3D${R_MODDIR#*could not load module \'}
> >>>> +		R_MODDIR=3D${R_MODDIR%\', *}
> >>>> +		R_MODDIR=3D${R_MODDIR%/*}
> >>>> +	fi
> >>>> +	[ -n "$R_MODDIR" ] || R_MODDIR=3D/lib/rsyslog
> >>>> +	installs=3D"rsyslogd $R_MODDIR/lmnet.so
> >>>> $R_MODDIR/imklog.so $R_MODDIR/imuxsock.so" elif type -P
> >>>> syslogd>/dev/null; then
> >>>>
> >>>>        installs=3D"syslogd"
> >>>>
> >>>>    elif type -P syslog-ng>/dev/null; then
> >>>
> >>> Indeed this patch is more precise than my simplified one ;)
> >>
> >> ugly hack :-/ plus you want mktemp to prevent attacks..
> >=20
> > Just to make sure - it was NAK? :)
>=20
> Is there some reason to do something this complex instead of simply
> replacing /lib/rsyslog/ with /lib*/rsyslog/ on that one line?
>=20

Well you can always try my simple solution:

diff -Naur dracut-007//modules.d/98syslog/install
dracut-007.tpg//modules.d/98syslog/install ---
dracut-007//modules.d/98syslog/install	2010-08-09
14:13:51.000000000 +0000 +++
dracut-007.tpg//modules.d/98syslog/install	2010-09-04
23:00:12.000000000 +0000 @@ -1,6 +1,13 @@ #!/bin/sh +
+if ldd /sbin/rsyslogd | grep -q lib64; then
+    LIBDIR=3D"/lib64"
+else
+    LIBDIR=3D"/lib"
+fi
+
 if which rsyslogd >/dev/null; then
-
installs=3D"rsyslogd /usr/lib/rsyslog/lmnet.so /usr/lib/rsyslog/imklog.so /=
usr/lib/rsyslog/imuxsock.so"
+	installs=3D"rsyslogd ${LIBDIR}/rsyslog/lmnet.so
${LIBDIR}/rsyslog/imklog.so ${LIBDIR}/rsyslog/imuxsock.so" elif which
syslogd >/dev/null; then installs=3D"syslogd"
 elif which syslog-ng >/dev/null; then

http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/dracut/current/S=
OURCES/dracut-007-add-rsyslog-library-patch-check.patch



--=20
Regards
TPG

http://cia.vc/stats/author/tpg
---

--Sig_/=HFQIIW=I9d_mIMICsj6ItN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyKeCcACgkQXdLYfhsJ+rjScACfeBs/t4VV9QzADqxXwQuLWVwR
YSMAnRocKZ0eQZ9fSbRDGzTiEJWv2h+g
=EmfW
-----END PGP SIGNATURE-----

--Sig_/=HFQIIW=I9d_mIMICsj6ItN--
