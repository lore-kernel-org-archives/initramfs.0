From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i18n: fixup
Date: Fri, 09 Jul 2010 15:46:45 +0200
Message-ID: <4C372845.90600@redhat.com>
References: <20100701211737.45d8a803@etiriah> <20100701223934.5329a489@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100701223934.5329a489@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/01/2010 10:39 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> dracut-functions: fixed typos in inst_decompress
>
> i18n: use inst_opt_decompress for installing fonts instead of inst
> ---
>   dracut-functions         |    2 +-
>   modules.d/10i18n/install |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index 4212c5f..9c2999a 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -408,7 +408,7 @@ inst_decompress() {
>       for src in $@
>       do
>           case ${src} in
> -            *.gi) cmd=3D'gzip rd' ;;
> +            *.gz) cmd=3D'gzip -d' ;;
>               *.bz2) cmd=3D'bzip2 -d' ;;
>               *) return 1 ;;
>           esac
> diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
> index a335260..05de54a 100755
> --- a/modules.d/10i18n/install
> +++ b/modules.d/10i18n/install
> @@ -123,7 +123,7 @@ install_local_i18n() {
>
>       [[ ${SYSFONT} ]] || SYSFONT=3D${DEFAULT_SYSFONT}
>       SYSFONT=3D${SYSFONT%.psf*}
> -    inst ${kbddir}/consolefonts/${SYSFONT}.*
> +    inst_opt_decompress ${kbddir}/consolefonts/${SYSFONT}.*
>
>       if [[ ${CONTRANS} ]]
>       then

pushed
