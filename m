From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add live_readonly karg to mount /dev/mapper/live-rw as
 readonly
Date: Fri, 05 Mar 2010 11:50:42 +0100
Message-ID: <4B90E202.7080106@redhat.com>
References: <1267733352-15845-1-git-send-email-jboggs@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267733352-15845-1-git-send-email-jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/04/2010 09:09 PM, Joey Boggs wrote:
> This will allow live cd based images to utilize a readonly root file system.
>
> ---
>   modules.d/90dmsquash-live/dmsquash-live-root |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
> index e2e3ef8..7457e2c 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root
> @@ -21,6 +21,7 @@ live_dir=$(getarg live_dir)
>   getarg live_ram&&  live_ram="yes"
>   getarg reset_overlay&&  reset_overlay="yes"
>   getarg readonly_overlay&&  readonly_overlay="--readonly" || readonly_overlay=""
> +getarg live_readonly&&  live_readonly="-o ro" || live_readonly=""
>   overlay=$(getarg overlay)
>
>   # FIXME: we need to be able to hide the plymouth splash for the check really
> @@ -173,6 +174,6 @@ if [ -b "$OSMIN_LOOPDEV" ]; then
>   fi
>
>   ln -s /dev/mapper/live-rw /dev/root
> -printf '/bin/mount /dev/mapper/live-rw %s\n' "$NEWROOT">  /mount/01-$$-live.sh
> +printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$live_readonly" "$NEWROOT">  /mount/01-$$-live.sh
>
>   exit 0

maybe we should teach dmsquash-live to use already defined parameters, like 
"rootflags" "rootfstype" and such.
