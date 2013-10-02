From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] mkinitrd-dracut.sh: Build host images for default_kernel_images
 and -i/-k paths
Date: Wed, 02 Oct 2013 12:25:17 +0200
Message-ID: <524BF48D.2030803@redhat.com>
References: <1380305940-64410-1-git-send-email-trenn@suse.de> <1380305940-64410-7-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380305940-64410-7-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/27/2013 08:19 PM, Thomas Renninger wrote:
> default_kernel_images and -i/-k paths are new (SuSE) code paths and
> would have resulted in usage errors before.
> 
> There we want to build host only images for faster building and
> smaller images.
> Also force creation (overriding) of initrd images in these code paths.
> 
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  mkinitrd-dracut.sh |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
> index f7b53f1..a1519ea 100755
> --- a/mkinitrd-dracut.sh
> +++ b/mkinitrd-dracut.sh
> @@ -3,6 +3,8 @@ kver=$(uname -r)
>  
>  boot_dir="/boot"
>  quiet=0
> +host_only=0
> +force=0
>  
>  error() { echo "$@" >&2; }
>  
> @@ -104,7 +106,8 @@ default_kernel_images() {
>      for initrd_image in $initrd_images;do
>  	targets="$targets $initrd_image"
>      done
> -
> +    host_only=1
> +    force=1
>  }
>  
>  while (($# > 0)); do
> @@ -119,8 +122,8 @@ while (($# > 0)); do
>          --version)
>              echo "mkinitrd: dracut compatibility wrapper"
>              exit 0;;
> -        -v|--verbose) dracut_args="${dracut_args} -v";;
> -        -f|--force) dracut_args="${dracut_args} -f";;
> +        -v|--verbose) dracut_args="${dracut_args} -v --keep";;

do you really want to keep the entire files in /var/tmp/<tmpdir>  for --verbose?
