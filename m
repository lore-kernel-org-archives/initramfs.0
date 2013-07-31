From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] LatArCyrHeb-16 as a default i18n font for Gentoo
Date: Wed, 31 Jul 2013 16:02:41 +0200
Message-ID: <51F91901.6060802@redhat.com>
References: <1374776696-28016-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374776696-28016-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/25/2013 08:24 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>  dracut.conf.d/gentoo.conf.example | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo=
=2Econf.example
> index b78e5c6..f9617f0 100644
> --- a/dracut.conf.d/gentoo.conf.example
> +++ b/dracut.conf.d/gentoo.conf.example
> @@ -11,5 +11,6 @@ ro_mnt=3Dyes
> =20
>  # i18n
>  i18n_vars=3D"/etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_=
KEYMAPS /etc/conf.d/consolefont:consolefont-FONT,consoletranslation-FON=
T_MAP /etc/rc.conf:unicode-UNICODE"
> +i18n_default_font=3D"LatArCyrHeb-16"
> =20
>  omit_drivers+=3D" i2o_scsi"
>=20

pushed, thanks!
