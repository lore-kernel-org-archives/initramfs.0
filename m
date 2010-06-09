From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-functions: fun. vercmp optimized; credits go to
 Victor Lowther
Date: Wed, 09 Jun 2010 17:40:43 +0200
Message-ID: <4C0FB5FB.8000309@redhat.com>
References: <20100609172936.752221c5@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609172936.752221c5-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/09/2010 05:29 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>   dracut-functions |   23 ++++++++++++-----------
>   1 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index fbac282..500e3ae 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -27,19 +27,20 @@ strstr() { [[ $1 =3D~ $2 ]]; }
>   # Version comparision function.  Returns result similar to C strcmp=
,
>   # but instead of -1 is 2.  Function assumes version scheme like doe=
s
>   # Linux kernel.
> +# $1<  $2 ->  2
> +# $1 =3D $2 ->  0
> +# $1>  $2 ->  1
> +# To remember it easy, ask the question: Which argument is greater? =
;-)
>   vercmp() {
> -    local n1 n2 i=3D1
> -
> -    while true
> -    do
> -        n1=3D$(echo $1 | cut -d'.' -f$i)
> -        n2=3D$(echo $2 | cut -d'.' -f$i)
> -
> -        [[ ! $n1&&  ! $n2 ]]&&  return 0
> -        [[ $n1 -lt $n2 ]]&&  return 2
> -        [[ $n1 -gt $n2 ]]&&  return 1
> -
> -        ((i++))
> +    local i n1=3D(${1//./ }) n2=3D(${2//./ })
> +
> +    for ((i=3D0; ; i++))
> +    do
> +        [[ ${n1[i]}&&  ! ${n2[i]} ]]&&  return 1
> +        [[ ! ${n1[i]}&&  ${n2[i]} ]]&&  return 2
> +        [[ ${n1[i]}&&  ${n2[i]} ]] || return 0
> +        ((${n1[i]}>  ${n2[i]}))&&  return 1
> +        ((${n1[i]}<  ${n2[i]}))&&  return 2
>       done
>   }
>

pushed
