From: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Subject: Re: [PATCH] dracut, dracut-functions: better vercmp; credits go to V. Lowther
Date: Fri, 11 Jun 2010 20:23:01 +0100
Message-ID: <201006112023.01475.adam@spra.gg>
References: <20100611211034.609135f8@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100611211034.609135f8-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Amadeusz =?utf-8?q?=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

On Friday 11 Jun 2010 20:10:34 Amadeusz =C5=BBo=C5=82nowski wrote:
> diff --git a/dracut b/dracut
> index 139d0e0..3b1e7e8 100755
> --- a/dracut
> +++ b/dracut
> @@ -184,7 +184,7 @@ abs_outfile=3D$(readlink -f "$outfile") &&
> outfile=3D"$abs_outfile"
>=20
>  srcmods=3D"/lib/modules/$kernel/"
>  [[ $drivers_dir ]] && {
> -    if verlt $(modprobe --version | cut -d' ' -f3) 3.7; then
> +    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.5; then
>          derror 'To use --kmoddir option module-init-tools >=3D 3.7 i=
s
> required.' exit 1
>      fi

Which version? 3.7? Or 3.5
