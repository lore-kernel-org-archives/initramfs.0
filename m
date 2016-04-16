From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] dracut: 10i18n: add support for custom locale
 definitions
Date: Sat, 16 Apr 2016 20:52:09 +0300
Message-ID: <57127BC9.70103@gmail.com>
References: <1460758050.3211.2.camel@trentalancia.net>
 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=5rxPx9LZ/+DcZNOFIU23evTmVKay2zAyFYzZP9RFG+U=;
        b=fl8p9/v9P2clJ/ItNAcTEWtlD4xTd4R80eY9dcgShAjU8pLtkuz2eHjJ3NxCYWMvU1
         OtXEP1MLsa2chVJh7U/JePxlvRs1Dal0IocL+Mo9ZZRfmYb0RG+K7YnpvcSMAECBTgPx
         00t8Qg1m7sqhpe9f8lIMq8FTJmDQk1n7reUym/4WNYIdxCn6j8eTA0fWojSxB9tuZLYB
         Ry/VcmpAYPDsQRIyvlHb/QPFTHrrllg5M0Cn6leLyWU6gAGz5Se9ZWbhgrajLq0te7g0
         MLG2/zmflUkKUgPUoYz0k2io/nHAmulmP7o29cWpkHRJtNRJ7fDSEEDMHLtpgHZ7TmgP
         oGyw==
In-Reply-To: <1460815966.4296.13.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

16.04.2016 17:12, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hello Andrei.
>=20
> Thanks very for much for reviewing the patch...
>=20
> On Sat, 16/04/2016 at 09.00 +0300, Andrei Borzenkov wrote:
>> 16.04.2016 01:07, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Compile and install locale definitions using localedef from GNU
>>> libc. The
>>> resulting locale definitions archive contains at most two different
>>> locale
>>> definitions, therefore its size is relatively small.
>>>
>>
>> On many distributions sources for locale definitions are in separate
>> packages that are not installed by default. You need at least error
>> checks and some alternative way to gather the same information.
>=20
> Good point, I have now included a check to make sure that the localed=
ef
> executable is available on the system (please see the new patch versi=
on
> reported below)...
>=20

It is not about localedef itself (which is likely to be present) but
about sources for locale definitions that you assume to be always avail=
able.

> I don't know exactly what you mean by "some alternative way to gather
> the same information", however if you mean copying the locale archive
> from the one installed on the system, I am against that, as it is
> usually very large, while the one we generate here is rather small an=
d
> should be usually compatible with the initram filesystem size
> constraint.
>=20

Locale archive is not used universally. Other systems use split
definitions in /usr/lib/locale/$LOCALE. Just copy them directly if pres=
ent.

> /usr/lib/locale-archive (system-wide): 101,997,312 bytes
> average locale-archive generated ad-hoc by localedef for initramfs:
> 1,629,568
>=20
> ... there is a size factor of about 63 !
> ---
> Compile and install locale definitions using localedef from GNU libc.=
 The
> resulting locale definitions archive contains at most two different l=
ocale
> definitions, therefore its size is relatively small.
>=20
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/10i18n/module-setup.sh |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> --- dracut-git/modules.d/10i18n/module-setup.sh	2016-04-12 15:59:43.1=
74765608 +0200
> +++ dracut-044-10i18n-add-support-for-custom-locale-definitions/modul=
es.d/10i18n/module-setup.sh	2016-04-16 15:59:51.254099707 +0200
> @@ -212,6 +219,16 @@ install() {
>              print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
>          fi
> =20
> +        [[ $LC_ALL || $LANG ]] && inst_dir /usr/lib/locale
> +
> +        # Generate locale definitions for LC_ALL
> +        [ $LC_ALL ] && LC_ALL_LOCALE=3D`echo $LC_ALL | awk -F. '{ pr=
int $1 }'` && LC_ALL_CHARMAP=3D`echo $LC_ALL | awk -F. '{ print $2 }'`
> +        [[ $LC_ALL && $LC_ALL_LOCALE && $LC_ALL_CHARMAP ]] && comman=
d -v localedef > /dev/null && localedef --prefix=3D"${initdir}" -i $LC_=
ALL_LOCALE -f $LC_ALL_CHARMAP $LC_ALL
> +
> +        # Generate locale definitions for LANG
> +        [ $LANG ] && LANG_LOCALE=3D`echo $LANG | awk -F. '{ print $1=
 }'` && LANG_CHARMAP=3D`echo $LANG | awk -F. '{ print $2 }'`
> +        [[ $LANG && $LANG_LOCALE && $LANG_CHARMAP ]] && command -v l=
ocaledef > /dev/null && localedef --prefix=3D"${initdir}" -i $LANG_LOCA=
LE -f $LANG_CHARMAP $LANG
> +
>          if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF}=
 ]]; then
>              inst_simple ${VCONFIG_CONF}
>          else
>=20
>=20
