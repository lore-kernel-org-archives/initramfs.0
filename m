From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fix c0a82e271e2730159f042ee7d7fc4aca2e08d28a
Date: Mon, 21 Feb 2011 09:24:38 +0100
Message-ID: <4D622146.5090305@redhat.com>
References: <1298098675-24424-1-git-send-email-arvidjaar@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298098675-24424-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 19.02.2011 07:57, schrieb Andrey Borzenkov:
> Let inst_key_val usage agree with above patch :)
> 
> Also UNICODE is rather global console property, not font specific
> (and if anything, is rather keyboard specific). Let it be just
> vconsole.unicode
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> ---
>  modules.d/10i18n/parse-i18n.sh |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/modules.d/10i18n/parse-i18n.sh b/modules.d/10i18n/parse-i18n.sh
> index 61280c0..73dff6e 100755
> --- a/modules.d/10i18n/parse-i18n.sh
> +++ b/modules.d/10i18n/parse-i18n.sh
> @@ -19,15 +19,15 @@ inst_key_val() {
>      unset _value
>  }
>  
> -inst_key_val /etc/vconsole.conf '' KEYMAP      vconsole.keymap      KEYTABLE
> -inst_key_val /etc/vconsole.conf '' FONT        vconsole.font        SYSFONT 
> -inst_key_val /etc/vconsole.conf '' FONT_MAP    vconsole.font.map    CONTRANS 
> -inst_key_val /etc/vconsole.conf '' FONT_UNIMAP vconsole.font.unimap UNIMAP 
> -inst_key_val /etc/vconsole.conf 1  UNICODE     vconsole.font.unicode
> -inst_key_val /etc/vconsole.conf '' EXT_KEYMAP  vconsole.keymap.ext
> +inst_key_val '' /etc/vconsole.conf KEYMAP      vconsole.keymap      KEYTABLE
> +inst_key_val '' /etc/vconsole.conf FONT        vconsole.font        SYSFONT 
> +inst_key_val '' /etc/vconsole.conf FONT_MAP    vconsole.font.map    CONTRANS 
> +inst_key_val '' /etc/vconsole.conf FONT_UNIMAP vconsole.font.unimap UNIMAP 
> +inst_key_val 1  /etc/vconsole.conf UNICODE     vconsole.unicode
> +inst_key_val '' /etc/vconsole.conf EXT_KEYMAP  vconsole.keymap.ext
>  
> -inst_key_val /etc/locale.conf   LANG   locale.LANG
> -inst_key_val /etc/locale.conf   LC_ALL locale.LC_ALL
> +inst_key_val '' /etc/locale.conf   LANG        locale.LANG
> +inst_key_val '' /etc/locale.conf   LC_ALL      locale.LC_ALL
>  
>  if [ -f /etc/locale.conf ]; then
>      . /etc/locale.conf

Thanks! Always good to have someone who double checks :-))
