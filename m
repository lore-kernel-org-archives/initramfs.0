From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fail to boot if mediacheck fails (#817419)
Date: Thu, 10 May 2012 11:24:54 +0200
Message-ID: <4FAB8966.70600@redhat.com>
References: <1336587303-3778-1-git-send-email-bcl@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336587303-3778-1-git-send-email-bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 09.05.2012 20:15, schrieb Brian C. Lane:
> From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> The return value of checkisomd5 was being ignored.
> ---
>  modules.d/90dmsquash-live/dmsquash-live-root.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index 2aaec28..fdbd6f5 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -33,7 +33,7 @@ fi
>  getarg rd.live.check check || check=""
>  if [ -n "$check" ]; then
>      [ -x /bin/plymouth ] && /bin/plymouth --hide-splash
> -    checkisomd5 --verbose $livedev || :
> +    checkisomd5 --verbose $livedev
>      if [ $? -ne 0 ]; then
>          die "CD check failed!"
>          exit 1


So, it was wrong from the beginning on... rofl..


commit c56b63d1bd06e3eaf149502d7c46c59a5978fd44
Author: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Jul 22 16:06:29 2009 -0400

    Support checking the iso

    Support checking the iso image with checkisomd5 if available
