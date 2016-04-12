From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Tue, 12 Apr 2016 16:24:51 +0200
Message-ID: <570D0533.6070704@redhat.com>
References: <1460470060.3152.3.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460470060.3152.3.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 12.04.2016 um 16:07 schrieb Guido Trentalancia:
> Do not mount the /run directory with the "noexec" option, otherwise the
> system bootup fails (no binary can be executed, everything fails with
> permission denied errors).
> 
> The bug was introduced in version 042 (11 Jun 2015) and affects all
> versions up to 044 (latest) and including git checked out on 12 Apr 2016.
> 
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/99base/init.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- dracut-044/modules.d/99base/init.sh	2015-11-25 14:22:28.000000000 +0100
> +++ dracut-044-99base-init-should-mount-newrun-as-exec/modules.d/99base/init.sh	2016-04-12 15:37:44.163185387 +0200
> @@ -64,7 +64,7 @@ fi
>  
>  if ! ismounted /run; then
>      mkdir -m 0755 /newrun
> -    mount -t tmpfs -o mode=0755,noexec,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
> +    mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
>      cp -a /run/* /newrun >/dev/null 2>&1
>      mount --move /newrun /run
>      rm -fr -- /newrun
> 

Which binary resides in /run ??
