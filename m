From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dracut: add support for custom locale definitions
Date: Sat, 16 Apr 2016 09:00:07 +0300
Message-ID: <5711D4E7.9070705@gmail.com>
References: <1460758050.3211.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=RTulUVy+hq+XjjJqotZCfnzPd02irqsl7h/m0QplOOE=;
        b=PiIYeEZ8nVZN2CNrLk2oNgNvJMzztDMpw3MwkFfRmzdRl/zVAc+6L07BhtP1YITtGa
         4KyWoRiMlLP9UitNQeugXxXoS2+TaYQTfCurjoDs29IcfYQxKdv0LqxcJShcLVgQRZpd
         bNjMlU24hZ+idgXie1rGXtngiSurRl9nfdzoo1iJjhWTnUCYZMKitrPAFgKWC1tGJdgi
         XYnMAe/Mzg/vY5WoCgntl3UXw9fLtr8laAwa/bhCADjlZ3iQyBGoD4FQFVKH5ra+B2KQ
         VX67orBk29WJusNOjU1MA7wUI2cX5QkiFSWWEfBVP0q3gE4MtfpG3sZpa/v25UVz2NfN
         v8pQ==
In-Reply-To: <1460758050.3211.2.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

16.04.2016 01:07, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Compile and install locale definitions using localedef from GNU libc.=
 The
> resulting locale definitions archive contains at most two different l=
ocale
> definitions, therefore its size is relatively small.
>=20

On many distributions sources for locale definitions are in separate
packages that are not installed by default. You need at least error
checks and some alternative way to gather the same information.

> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/10i18n/module-setup.sh |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> --- dracut-044/modules.d/10i18n/module-setup.sh	2016-04-15 23:34:44.0=
11398268 +0200
> +++ dracut-044-10i18n-add-support-for-custom-locale-definitions/modul=
es.d/10i18n/module-setup.sh	2016-04-15 23:32:05.292860621 +0200
> @@ -219,6 +219,16 @@ install() {
>              print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
>          fi
> =20
> +        [[ $LC_ALL || $LANG ]] && inst_dir /usr/lib/locale
> +
> +        # Generate locale definitions for LC_ALL
> +        [ $LC_ALL ] && LC_ALL_LOCALE=3D`echo $LC_ALL | awk -F. '{ pr=
int $1 }'` && LC_ALL_CHARMAP=3D`echo $LC_ALL | awk -F. '{ print $2 }'`
> +        [[ $LC_ALL && $LC_ALL_LOCALE && $LC_ALL_CHARMAP ]] && locale=
def --prefix=3D"${initdir}" -i $LC_ALL_LOCALE -f $LC_ALL_CHARMAP $LC_AL=
L
> +
> +        # Generate locale definitions for LANG
> +        [ $LANG ] && LANG_LOCALE=3D`echo $LANG | awk -F. '{ print $1=
 }'` && LANG_CHARMAP=3D`echo $LANG | awk -F. '{ print $2 }'`
> +        [[ $LANG && $LANG_LOCALE && $LANG_CHARMAP ]] && localedef --=
prefix=3D"${initdir}" -i $LANG_LOCALE -f $LANG_CHARMAP $LANG
> +
>          if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF}=
 ]]; then
>              inst_simple ${VCONFIG_CONF}
>          else
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
