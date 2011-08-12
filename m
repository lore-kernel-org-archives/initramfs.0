From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90kernel-modules: fixed handling rd.driver.post=
Date: Fri, 12 Aug 2011 08:20:33 +0200
Message-ID: <4E44C631.8060603@redhat.com>
References: <1309466724-4972-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1309466724-4972-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 30.06.2011 22:45, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>  modules.d/90kernel-modules/insmodpost.sh |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/modules.d/90kernel-modules/insmodpost.sh b/modules.d/90k=
ernel-modules/insmodpost.sh
> index 1b8ccfa..168a907 100755
> --- a/modules.d/90kernel-modules/insmodpost.sh
> +++ b/modules.d/90kernel-modules/insmodpost.sh
> @@ -2,11 +2,13 @@
>  # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4;=
 -*-
>  # ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
> =20
> -for p in $(getargs rd.driver.post rdinsmodpost=3D); do
> +. /lib/dracut-lib.sh
> +
> +for modlist in $(getargs rd.driver.post rdinsmodpost=3D); do
>      (
>          IFS=3D,
> -        for p in $i; do
> -            modprobe $p
> +        for m in $modlist; do
> +            modprobe $m
>          done
>      )
>  done

pushed
