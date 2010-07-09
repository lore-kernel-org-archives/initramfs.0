From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i18n: loading additional keymaps declared in EXT_KEYMAPS
Date: Fri, 09 Jul 2010 15:50:56 +0200
Message-ID: <4C372940.9060308@redhat.com>
References: <20100702103218.3ac4fb9e@etiriah> <20100702103721.3884c924@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100702103721.3884c924@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/02/2010 10:37 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
>
> ---
>   modules.d/10i18n/console_init |    2 +-
>   modules.d/10i18n/install      |    1 -
>   2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console=
_init
> index 146cd26..fa74595 100755
> --- a/modules.d/10i18n/console_init
> +++ b/modules.d/10i18n/console_init
> @@ -36,7 +36,7 @@ set_keymap() {
>
>       [ "${UNICODE}" =3D 1 ]&&  utf_switch=3D-u
>
> -    loadkeys ${utf_switch} ${KEYMAP}.map
> +    loadkeys ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
>   }
>
>   set_font() {
> diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
> index 05de54a..caa3fac 100755
> --- a/modules.d/10i18n/install
> +++ b/modules.d/10i18n/install
> @@ -98,7 +98,6 @@ install_local_keyboard() {
>
>       # Gentoo user may have KEYMAP set to something like "-u pl2",
>       KEYMAP=3D${KEYMAP#-* }
> -    EXT_KEYMAPS=3D${EXT_KEYMAPS:-backspace}
>       # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  The=
y were in
>       # original redhat-i18n module.  Anyway it won't hurt.
>       EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}

pushed (merged)
