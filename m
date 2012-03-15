From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Make sure 'set -x' gets turned back on in wait_for_loginit
Date: Thu, 15 Mar 2012 11:23:23 +0100
Message-ID: <4F61C31B.1000305@redhat.com>
References: <1331759389-23864-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331759389-23864-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 14.03.2012 22:09, schrieb Will Woods:
> wait_for_loginit does set +x (to turn off debugging temporarily), but
> sometimes it would return before turning it back on. Move the set +x
> line to fix that, then use 'setdebug' to make sure we don't turn it back
> on unless it was needed.
> ---
>  modules.d/99base/dracut-lib.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index f0d426c..6f506b6 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -756,9 +756,9 @@ need_shutdown() {
>  
>  wait_for_loginit()
>  {
> -    set +x
>      [ "$RD_DEBUG" = "yes" ] || return
>      [ -e /run/initramfs/loginit.pipe ] || return
> +    set +x
>      echo "DRACUT_LOG_END"
>      exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
>          # wait for loginit
> @@ -778,7 +778,7 @@ wait_for_loginit()
>          kill $(while read line;do echo $line;done</run/initramfs/loginit.pid)
>      fi
>  
> -    set -x
> +    setdebug
>      rm -f /run/initramfs/loginit.pipe /run/initramfs/loginit.pid
>  }
>  

pushed
