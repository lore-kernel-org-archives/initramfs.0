From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] switch_root: a better approach to subroots
Date: Wed, 18 Nov 2009 19:47:06 +0100
Message-ID: <20091118184706.GB23977@nb.net.home>
References: <20091118153312.16E989D404F@zog.reactivated.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091118153312.16E989D404F-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: util-linux-ng-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


 I think dracut guys should be in CC. Any objection against this change? 
 
On Wed, Nov 18, 2009 at 03:33:12PM +0000, Daniel Drake wrote:
> This reverts commit a692a8745941a192528c5e2a05de97155ba586f9.
> Booting into a system this way just leads to problems because
> you cannot remount the root read-only at shutdown (leading to unclean
> shutdowns).
> 
> Miklos Szeredi pointed out a trick to turn any directory into a
> mount point which avoids this problem. Therefore we can simplify
> switch_root again and simply document that its users should set
> up the root as a mount point beforehand.
> ---
>  sys-utils/switch_root.8 |   13 +++++++
>  sys-utils/switch_root.c |   81 +++--------------------------------------------
>  2 files changed, 18 insertions(+), 76 deletions(-)
> 
> diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
> index 4fdc8e9..b6712ec 100644
> --- a/sys-utils/switch_root.8
> +++ b/sys-utils/switch_root.8
> @@ -32,6 +32,19 @@ show version number and exit
>  .B switch_root
>  returns 0 on success and 1 on failure.
>  
> +.SH NOTES
> +switch_root will fail to function if
> +.B newroot
> +is not the root of a mount. If you want to switch root into a directory that
> +does not meet this requirement then you can first use a bind-mounting trick to
> +turn any directory into a mount point:
> +.sp
> +.nf
> +.RS
> +mount --bind $DIR $DIR

 Cannot we add this functionality directly to the switch_root command?
 I mean call:

    mount --bind /newroot/subroot /newroot/subroot 
    mount --move /newroot/subroot /

 Now we have:

    mount --move newroot /
    chroot /newroot/subroot


    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
