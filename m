From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i18n: mention {vconsole,locale}.conf in README
Date: Wed, 10 Nov 2010 15:50:15 +0100
Message-ID: <4CDAB127.4060000@redhat.com>
References: <1289053568-6959-1-git-send-email-arvidjaar@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289053568-6959-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/06/2010 03:26 PM, Andrey Borzenkov wrote:
> i18n does not use /etc/sysconfig/{i18n,keyboard} anymore
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> ---
>   modules.d/10i18n/README |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
> index db84d02..b2204cd 100644
> --- a/modules.d/10i18n/README
> +++ b/modules.d/10i18n/README
> @@ -31,8 +31,8 @@ with us, so we can include it in source package.
>   If you invoke dracut with '-H' option, i18n module install script will
>   gather variables values from your configuration files using mappings
>   provided in "/etc/dracut.conf.d/<foo>.conf".  Those variables will be
> -put in "etc/sysconfig/{i18n,keyboard}" files inside initramfs image.
> -Next it will install only declared font, keymaps and so.
> +put in "etc/vconsole.conf" and "etc/locale.conf" files inside initramfs
> +image. Next it will install only declared font, keymaps and so.
>
>   When building generic image (dracut without '-H' option), install script
>   copies all content of directories: consolefonts, consoletrans, unimaps


pushed
