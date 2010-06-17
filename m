From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut, dracut-functions: better vercmp; credits go to
 V. Lowther
Date: Thu, 17 Jun 2010 09:44:52 +0200
Message-ID: <4C19D274.6020100@redhat.com>
References: <20100611211034.609135f8@etiriah.ds.pg.gda.pl> <20100611214721.58062841@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100611214721.58062841-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/11/2010 09:47 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Left incorrect module-init-tools version in the patch, here's the fix=
:
> ---
>   dracut |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/dracut b/dracut
> index 3b1e7e8..3be4989 100755
> --- a/dracut
> +++ b/dracut
> @@ -184,7 +184,7 @@ abs_outfile=3D$(readlink -f "$outfile")&&  outfil=
e=3D"$abs_outfile"
>
>   srcmods=3D"/lib/modules/$kernel/"
>   [[ $drivers_dir ]]&&  {
> -    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.5; then
> +    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.7; then
>           derror 'To use --kmoddir option module-init-tools>=3D 3.7 i=
s required.'
>           exit 1
>       fi

pushed
