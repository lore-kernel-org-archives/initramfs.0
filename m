From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] 10i18n: exit if console already initialized
Date: Wed, 04 Aug 2010 18:31:46 +0200
Message-ID: <4C5995F2.3000708@redhat.com>
References: <20100726101540.37af47d8@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100726101540.37af47d8-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed

On 07/26/2010 10:15 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
>
> ---
>   modules.d/10i18n/console_init |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console=
_init
> index fa74595..0d4fa8f 100755
> --- a/modules.d/10i18n/console_init
> +++ b/modules.d/10i18n/console_init
> @@ -63,12 +63,15 @@ dev_open() {
>
>
>   dev=3D/dev/${1#/dev/}
> +devname=3D${dev#/dev/}
>
>   [ -c "${dev}" ] || {
>       echo "Usage: $0 device">&2
>       exit 1
>   }
>
> +[ -e /tmp/console_init.${devname} ]&&  exit 0
> +
>   dev_open ${dev}
>
>   for fd in 6 7; do
> @@ -85,3 +88,4 @@ set_font ${dev}
>   set_keymap
>
>   dev_close
> +>/tmp/console_init.${devname}
