From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] lsinitrd: support symlinks
Date: Thu, 19 Apr 2012 12:16:20 +0200
Message-ID: <4F8FE5F4.1070704@redhat.com>
References: <1334655087-16937-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334655087-16937-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikoli <nikoli-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org>

Am 17.04.2012 11:31, schrieb Amadeusz =C5=BBo=C5=82nowski:
> From: Nikoli <nikoli-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org>
>=20
> ---
>  lsinitrd.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/lsinitrd.sh b/lsinitrd.sh
> index 1eaa37d..e6767dc 100755
> --- a/lsinitrd.sh
> +++ b/lsinitrd.sh
> @@ -34,7 +34,7 @@ image=3D"${1:-/boot/initramfs-$(uname -r).img}"
>  [[ -f "$image" ]]    || { echo "$image does not exist" ; exit 1 ; }
> =20
>  CAT=3Dzcat
> -FILE_T=3D$(file "$image")
> +FILE_T=3D$(file --dereference "$image")
> =20
>  if echo "test"|xz|xz -dc --single-stream >/dev/null 2>&1; then
>      XZ_SINGLE_STREAM=3D"--single-stream"

pushed
