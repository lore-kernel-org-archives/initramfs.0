From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 10i18n: README corrected
Date: Wed, 21 Jul 2010 13:40:11 +0200
Message-ID: <4C46DC9B.80105@redhat.com>
References: <20100713095847.3506a128@etiriah> <20100713101355.26a2ecb8@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100713101355.26a2ecb8@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed both

On 07/13/2010 10:13 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>   modules.d/10i18n/README |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
> index dd84881..09cb642 100644
> --- a/modules.d/10i18n/README
> +++ b/modules.d/10i18n/README
> @@ -53,7 +53,7 @@ runtime:
>       CONTRANS - see description of '-m' parameter in setfont manual
>       UNIMAP - see description of '-u' parameter in setfont manual
>
> -The following are appended to EXT_KEYMAPS:
> +The following are appended to EXT_KEYMAPS only during build time:
>
>       UNIKEYMAP
>       GRP_TOGGLE
> @@ -120,5 +120,5 @@ file (the same where you put mappings).
>   3. Kernel parameters
>
>   If you create generic initramfs you can set up i18n by kernel
> -parameters using variables listed in 2.1.  The recommended minimum i=
s:
> -SYSFONT, KEYMAP and UNICODE.
> +parameters using variables listed in 2.1. (expect of UNIKEYMAP
> +and GRP_TOGGLE) The recommended minimum is: SYSFONT, KEYMAP and UNIC=
ODE.
