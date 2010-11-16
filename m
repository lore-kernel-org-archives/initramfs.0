From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-lib.sh: splitsep fix
Date: Tue, 16 Nov 2010 10:30:49 +0100
Message-ID: <4CE24F49.8090705@redhat.com>
References: <1289838876-18432-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289838876-18432-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 15.11.2010 17:34, schrieb Amadeusz =C5=BBo=C5=82nowski:
> ---
>   modules.d/99base/dracut-lib.sh |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut=
-lib.sh
> index f0c030b..37659fe 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -183,10 +183,10 @@ splitsep() {
>       local tmp
>
>       while [ -n "$str" -a -n "$*" ]; do
> -        tmp=3D"${str%%:*}"
> +        tmp=3D"${str%%$sep*}"
>           eval "$1=3D${tmp}"
>           str=3D"${str#$tmp}"
> -        str=3D"${str#:}"
> +        str=3D"${str#$sep}"
>           shift
>       done
>

pushed
