From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Added missing quotes
Date: Wed, 26 Feb 2014 15:04:44 +0100
Message-ID: <530DF47C.1010601@redhat.com>
References: <1393173888-10122-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393173888-10122-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/23/2014 05:44 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> See bug report at https://bugs.gentoo.org/show_bug.cgi?id=3D502064
> ---
>  dracut.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dracut.sh b/dracut.sh
> index 5267af5..1e35e09 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -551,7 +551,7 @@ done
>  # the old fashioned way
> =20
>  while (($# > 0)); do
> -    if [ ${1%%=3D*} =3D=3D "++include" ]; then
> +    if [ "${1%%=3D*}" =3D=3D "++include" ]; then
>          push include_src "$2"
>          push include_target "$3"
>          PARMS_TO_STORE+=3D" --include '$2' '$3'"
>=20

Thanks! Pushed
