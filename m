From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/8] Install /etc/sysconfig/console to see specific
 fonts
Date: Sat, 27 Jun 2015 08:29:51 +0300
Message-ID: <20150627082951.2111a099@opensuse.site>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
	<1435330557-17685-7-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nkx7dKLsikyXEdzkyB8mil0XWfferdWjgx9kXPK7nvw=;
        b=t/sL3x8N3kuEjBDmzHHl/z620ZQ6ZwWZd1SBHm5TXAWH/vmR+zdL6BoGUmV5rKvYu7
         ZWuZMtp2d+qPm2+5P/86JwahIgWRbpT2XyqYOderBLffojAzmJlJJmVizZhMFvalPw/f
         uFHnw2BmnwxsVTiG4EshKZz8wEbGmCYhKay+gTh+PJmhWY3QrdddaeNjSBUMCyJXvCrV
         1kK1hxnxn+lFxs79p5zq6W9t3+pIUYY/hbKi8F4riF0jop/uIzkzoUZfWXQVqjx+xVHv
         qCO8IRM9DxakRq6JVZScQ2bHCrYb5tVS2QtGmNj+qmkNED/xCjnoEL9A6GCMZUaytf0F
         hR7g==
In-Reply-To: <1435330557-17685-7-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Werner Fink <werner-l3A5Bk7waGM@public.gmane.org>

=D0=92 Fri, 26 Jun 2015 16:55:55 +0200
Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Werner Fink <werner-l3A5Bk7waGM@public.gmane.org>
>=20
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/10i18n/module-setup.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/modu=
le-setup.sh
> index 9439875..398d02b 100755
> --- a/modules.d/10i18n/module-setup.sh
> +++ b/modules.d/10i18n/module-setup.sh
> @@ -219,6 +219,10 @@ install() {
>              print_vars KEYMAP EXT_KEYMAPS UNICODE FONT FONT_MAP FONT=
_UNIMAP >> ${initdir}${VCONFIG_CONF}
>          fi
> =20
> +        if dracut_module_included "systemd" && [[ -f /etc/sysconfig/=
console ]]; then
> +            inst_simple /etc/sysconfig/console
> +        fi
> +
>          return 0
>      }
> =20

Upstream systemd does not even look at this file. Could you explain
what problem is fixed here and why presence of this file fixes it?
