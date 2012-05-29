From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] don't wait_for_loginit in emergency_shell()
Date: Tue, 29 May 2012 11:41:52 +0200
Message-ID: <4FC499E0.2050108@redhat.com>
References: <1337724972-6545-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337724972-6545-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 23.05.2012 00:16, schrieb Will Woods:
> wait_for_loginit ends the log; this is unhelpful if you're using
> emergency_shell to do debugging.
> 
> Just leave loginit running. It doesn't hurt anything.
> ---
>  modules.d/99base/dracut-lib.sh |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index b6168df..19aceb8 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -825,7 +825,6 @@ emergency_shell()
>      warn $@
>      source_hook "$hook"
>      echo
> -    wait_for_loginit
>      [ -e /run/initramfs/.die ] && exit 1
>      if getargbool 1 rd.shell -y rdshell || getarg rd.break rdbreak; then
>          echo "Dropping to debug shell."


pushed
