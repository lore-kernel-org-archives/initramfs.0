From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add readonly overlay support for dmsquash
Date: Thu, 04 Mar 2010 14:07:33 +0100
Message-ID: <4B8FB095.8090005@redhat.com>
References: <1267195469-32522-1-git-send-email-jboggs@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267195469-32522-1-git-send-email-jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/26/2010 03:44 PM, Joey Boggs wrote:
> Adds the readonly_overlay karg for cases where the dm snapshot should be set to readonly. Use case would be a livecd that is configured to have a readonly root where filling up the dm snapshot would cause a problem.
>
> ---
>   modules.d/90dmsquash-live/dmsquash-live-root |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
> index acec91d..f40e048 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root
> @@ -20,6 +20,7 @@ live_dir=$(getarg live_dir)
>   [ -z "$live_dir" ]&&  live_dir="LiveOS"
>   getarg live_ram&&  live_ram="yes"
>   getarg reset_overlay&&  reset_overlay="yes"
> +getarg readonly_overlay&&  readonly_overlay="--readonly" || readonly_overlay=""
>   overlay=$(getarg overlay)
>
>   # FIXME: we need to be able to hide the plymouth splash for the check really
> @@ -95,7 +96,7 @@ do_live_overlay() {
>       fi
>
>       # set up the snapshot
> -    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create live-rw
> +    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-rw
>   }
>
>   # live cd helper function

pushed
