From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] dracut: info which module is sourced; updated dracut
 usage
Date: Fri, 09 Jul 2010 15:47:02 +0200
Message-ID: <4C372856.4010306@redhat.com>
References: <20100705090647.30b3c2bc@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705090647.30b3c2bc@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/05/2010 09:06 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Added description for --confdir.
> ---
>   dracut |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/dracut b/dracut
> index 3be4989..6b590f5 100755
> --- a/dracut
> +++ b/dracut
> @@ -57,6 +57,8 @@ Creates initial ramdisk images for preloading modul=
es
>     -v, --verbose         Verbose output during the build process
>     -c, --conf [FILE]     Specify configuration file to use.
>                            Default: /etc/dracut.conf
> +  --confdir [DIR]       Specify configuration directory to use *.con=
f files from.
> +                         Default: /etc/dracut.conf.d
>     -l, --local           Local mode. Use modules from the current wo=
rking
>                            directory instead of the system-wide insta=
lled in
>                            /usr/share/dracut/modules.d.
> @@ -243,6 +245,7 @@ check_modules
>   for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
>       mod=3D${moddir##*/}; mod=3D${mod#[0-9][0-9]}
>       if strstr "$mods_to_load" " $mod "; then
> +	dinfo "*** Sourcing module $mod"
>   	if [[ $kernel_only =3D yes ]]; then
>   	    [[ -x $moddir/installkernel ]]&&  . "$moddir/installkernel"
>   	else

pushed
