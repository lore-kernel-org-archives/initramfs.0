From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: setup English locales for Dracut build script
Date: Fri, 18 Jun 2010 18:56:24 +0200
Message-ID: <4C1BA538.7010304@redhat.com>
References: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100618133841.61845f0d-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/18/2010 01:38 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Dracut rely upon programs' output like ldd's "not a dynamic executabl=
e".
> Assume user sets up Polish locales and then ldd prints
> "nie jest dynamicznym programem wykonywalnym".  The patch prevents th=
is.
> ---
>   dracut |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/dracut b/dracut
> index 3be4989..1437625 100755
> --- a/dracut
> +++ b/dracut
> @@ -71,6 +71,17 @@ Creates initial ramdisk images for preloading modu=
les
>   "
>   }
>
> +# Change locales and language leaving existing suffix (.utf8 or simi=
lar).
> +# $1 =3D language (e.g. en_US)
> +change_locales() {
> +    local lang=3D(${LANG/./ })
> +    lang[0]=3D$1
> +    lang=3D${lang[@]}
> +    LANG=3D${lang/ /.}
> +    LC_ALL=3D${LANG}
> +    export LANG LC_ALL
> +}
> +
>   while (($#>  0)); do
>       case $1 in
>   	-f|--force) force=3Dyes;;
> @@ -107,6 +118,10 @@ done
>
>   PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
>   export PATH
> +# We rely upon programs' output like ldd's "not found", so we have t=
o
> +# set up English locales.
> +change_locales en_US
> +
>
>   [[ $debug ]]&&  {
>       export PS4=3D'${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';

Hmm, we probably should prefix every call to an app, where we parse the=
 output=20
with LANG=3DC like this:

LANG=3DC ldd $file | grep -q "not found"
