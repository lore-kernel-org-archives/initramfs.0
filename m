From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v2] dracut: 10i18n: add support for custom locale definitions
Date: Sat, 16 Apr 2016 16:12:46 +0200
Message-ID: <1460815966.4296.13.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5711D4E7.9070705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Andrei.

Thanks very for much for reviewing the patch...

On Sat, 16/04/2016 at 09.00 +0300, Andrei Borzenkov wrote:
> 16.04.2016 01:07, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Compile and install locale definitions using localedef from GNU
> > libc. The
> > resulting locale definitions archive contains at most two different
> > locale
> > definitions, therefore its size is relatively small.
> >=20
>=20
> On many distributions sources for locale definitions are in separate
> packages that are not installed by default. You need at least error
> checks and some alternative way to gather the same information.

Good point, I have now included a check to make sure that the localedef
executable is available on the system (please see the new patch version
reported below)...

I don't know exactly what you mean by "some alternative way to gather
the same information", however if you mean copying the locale archive
from the one installed on the system, I am against that, as it is
usually very large, while the one we generate here is rather small and
should be usually compatible with the initram filesystem size
constraint.

/usr/lib/locale-archive (system-wide):=C2=A0101,997,312 bytes
average locale-archive generated ad-hoc by localedef for initramfs:
1,629,568

=2E.. there is a size factor of about 63 !
---
Compile and install locale definitions using localedef from GNU libc. T=
he
resulting locale definitions archive contains at most two different loc=
ale
definitions, therefore its size is relatively small.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- dracut-git/modules.d/10i18n/module-setup.sh	2016-04-12 15:59:43.174=
765608 +0200
+++ dracut-044-10i18n-add-support-for-custom-locale-definitions/modules=
=2Ed/10i18n/module-setup.sh	2016-04-16 15:59:51.254099707 +0200
@@ -212,6 +219,16 @@ install() {
             print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
         fi
=20
+        [[ $LC_ALL || $LANG ]] && inst_dir /usr/lib/locale
+
+        # Generate locale definitions for LC_ALL
+        [ $LC_ALL ] && LC_ALL_LOCALE=3D`echo $LC_ALL | awk -F. '{ prin=
t $1 }'` && LC_ALL_CHARMAP=3D`echo $LC_ALL | awk -F. '{ print $2 }'`
+        [[ $LC_ALL && $LC_ALL_LOCALE && $LC_ALL_CHARMAP ]] && command =
-v localedef > /dev/null && localedef --prefix=3D"${initdir}" -i $LC_AL=
L_LOCALE -f $LC_ALL_CHARMAP $LC_ALL
+
+        # Generate locale definitions for LANG
+        [ $LANG ] && LANG_LOCALE=3D`echo $LANG | awk -F. '{ print $1 }=
'` && LANG_CHARMAP=3D`echo $LANG | awk -F. '{ print $2 }'`
+        [[ $LANG && $LANG_LOCALE && $LANG_CHARMAP ]] && command -v loc=
aledef > /dev/null && localedef --prefix=3D"${initdir}" -i $LANG_LOCALE=
 -f $LANG_CHARMAP $LANG
+
         if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF} ]=
]; then
             inst_simple ${VCONFIG_CONF}
         else

