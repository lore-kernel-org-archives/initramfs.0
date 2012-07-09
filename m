From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fix readonly prefix
Date: Mon, 09 Jul 2012 08:45:24 +0200
Message-ID: <4FFA7E04.1010903@redhat.com>
References: <1341768989-50296-1-git-send-email-hamzy@us.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341768989-50296-1-git-send-email-hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mark Hamzy <hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.07.2012 19:36, schrieb Mark Hamzy:
> If no prefix is specified on the command line, then the following is seen:
> /sbin/dracut: line 548: unset: prefix: cannot unset: readonly variable
> 
> ---
>  dracut.conf.d/fedora.conf.example |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut.conf.d/fedora.conf.example b/dracut.conf.d/fedora.conf.example
> index ee53844..4cb1890 100644
> --- a/dracut.conf.d/fedora.conf.example
> +++ b/dracut.conf.d/fedora.conf.example
> @@ -5,7 +5,7 @@ i18n_vars="/etc/sysconfig/keyboard:KEYTABLE-KEYMAP /etc/sysconfig/i18n:SYSFONT-F
>  omit_drivers+=" .*/fs/ocfs/.* "
>  stdloglvl=3
>  install_items+=" vi /etc/virc ps grep cat rm "
> -readonly prefix="/"
> +prefix="/"
>  systemdutildir=/usr/lib/systemd
>  systemdsystemunitdir=/usr/lib/systemd/system
>  udevdir=/usr/lib/udev
> 

yeah, sorry, forgot to remove this one, before pushing
