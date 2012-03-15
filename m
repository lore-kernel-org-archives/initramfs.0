From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fix "execvp: No such file or directory" in emergency_shell
Date: Thu, 15 Mar 2012 11:23:30 +0100
Message-ID: <4F61C322.3080403@redhat.com>
References: <1331759380-23807-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331759380-23807-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 14.03.2012 22:09, schrieb Will Woods:
> Older versions of setsid emit this message on stderr if you try to run
> "setsid --help". Redirect it to /dev/null.
> ---
>  modules.d/99base/dracut-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index a6c4e24..f0d426c 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -814,7 +814,7 @@ emergency_shell()
>              _ctty=/dev/$_ctty
>          fi
>          [ -c "$_ctty" ] || _ctty=/dev/tty1
> -        strstr "$(setsid --help)" "control" && CTTY="-c"
> +        strstr "$(setsid --help 2>/dev/null)" "control" && CTTY="-c"
>          setsid $CTTY /bin/sh -i -l 0<$_ctty 1>$_ctty 2>&1
>      else
>          warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."

pushed
