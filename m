From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] dracut: install ld.so.conf* with dracut_install instead
 of cp
Date: Wed, 16 Mar 2011 21:46:57 +0100
Message-ID: <4D8121C1.1050802@redhat.com>
References: <1300307070-10087-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300307070-10087-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 16.03.2011 21:24, schrieb Amadeusz =C5=BBo=C5=82nowski:
> ---
>  dracut |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/dracut b/dracut
> index 2ae7f8c..4d50472 100755
> --- a/dracut
> +++ b/dracut
> @@ -494,7 +494,7 @@ done
>  unset item
> =20
>  # make sure that library links are correct and up to date
> -cp -ar /etc/ld.so.conf* "$initdir"/etc
> +dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
>  ldconfig -r "$initdir" || [[ $UID !=3D "0" ]] && \
>      dinfo "ldconfig might need uid=3D0 (root) for chroot()"
> =20


pushed all three
