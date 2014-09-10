From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Support spaces in mount_nfs (#1109933)
Date: Wed, 10 Sep 2014 11:08:27 +0200
Message-ID: <5410150B.6000008@redhat.com>
References: <1408645911-3268-1-git-send-email-bcl@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408645911-3268-1-git-send-email-bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.08.2014 20:31, Brian C. Lane wrote:
> nfs paths may contain spaces, make sure they are preserved when passed
> to nfs_to_var and mount.
> 
> Related: rhbz#1109933
> ---
>  modules.d/95nfs/nfs-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/95nfs/nfs-lib.sh b/modules.d/95nfs/nfs-lib.sh
> index d5377fe..94d05b8 100755
> --- a/modules.d/95nfs/nfs-lib.sh
> +++ b/modules.d/95nfs/nfs-lib.sh
> @@ -125,7 +125,7 @@ munge_nfs_options() {
>  mount_nfs() {
>      local nfsroot="$1" mntdir="$2" netif="$3"
>      local nfs="" server="" path="" options=""
> -    nfs_to_var $nfsroot $netif
> +    nfs_to_var "$nfsroot" $netif
>      munge_nfs_options
>      if [ "$nfs" = "nfs4" ]; then
>          options=$options${nfslock:+,$nfslock}
> @@ -136,5 +136,5 @@ mount_nfs() {
>              && warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
>          options=$options,nolock
>      fi
> -    mount -t $nfs -o$options $server:$path $mntdir
> +    mount -t $nfs -o$options "$server:$path" "$mntdir"
>  }
> 

Thanks! pushed
