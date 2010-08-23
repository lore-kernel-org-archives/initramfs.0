From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] bootchart module cleanup
Date: Mon, 23 Aug 2010 12:44:11 +0200
Message-ID: <4C7250FB.4030404@redhat.com>
References: <20100811174656.15568.98666.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100811174656.15568.98666.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed
On 08/11/2010 07:46 PM, Andrey Borzenkov wrote:
> - create /lib/bootchart in initramfs, not in live filesystem
> - use proper dracut API to install files
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   modules.d/00bootchart/install |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/00bootchart/install b/modules.d/00bootchart/install
> index ff29de0..8738815 100644
> --- a/modules.d/00bootchart/install
> +++ b/modules.d/00bootchart/install
> @@ -2,8 +2,8 @@
>
>   inst /sbin/bootchartd
>   inst /bin/bash
> -ln -s /init "${initdir}/sbin/init"
> -mkdir -p /lib/bootchart/
> +inst_symlink /init /sbin/init
> +inst_dir /lib/bootchart/
>   inst /lib/bootchart/bootchart-collector
>   inst /etc/bootchartd.conf
>   inst /sbin/accton
> @@ -12,4 +12,5 @@ inst /bin/echo
>   inst /bin/grep
>   inst /bin/usleep
>   inst /usr/bin/[  /bin/[
> +
>   mknod -m 0666 "${initdir}/dev/null" c 1 3
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
