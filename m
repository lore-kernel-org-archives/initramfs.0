From: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Subject: Re: [PATCH] dracut: setup English locales for Dracut build script
Date: Fri, 18 Jun 2010 14:28:08 +0100
Message-ID: <201006181428.09276.adam@spra.gg>
References: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100618133841.61845f0d-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: Amadeusz =?utf-8?q?=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Friday 18 Jun 2010 12:38:41 Amadeusz =C5=BBo=C5=82nowski wrote:
> Dracut rely upon programs' output like ldd's "not a dynamic executabl=
e".
> Assume user sets up Polish locales and then ldd prints
> "nie jest dynamicznym programem wykonywalnym".  The patch prevents th=
is.
> ---
>  dracut |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>=20
> diff --git a/dracut b/dracut
> index 3be4989..1437625 100755
> --- a/dracut
> +++ b/dracut
> @@ -107,6 +118,10 @@ done
>=20
>  PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
>  export PATH
> +# We rely upon programs' output like ldd's "not found", so we have t=
o
> +# set up English locales.
> +change_locales en_US
> +
>=20
>  [[ $debug ]] && {
>      export PS4=3D'${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';

I don't have any en_US locales installed on my system. Not sure why a P=
ole=20
would either. You'd probably be better off with the "C" locale, IMHO.

Adam
