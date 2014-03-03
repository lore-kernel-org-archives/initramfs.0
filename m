From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add -[-no]-hostonly-cmdline option handling for getopt
Date: Mon, 03 Mar 2014 12:46:54 +0100
Message-ID: <53146BAE.9060903@redhat.com>
References: <20140303072200.GA20357@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140303072200.GA20357-2coKmSd1Zb6BYdNaKHuJJRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 03/03/2014 08:22 AM, WANG Chao wrote:
> commit ab9457e introduce such new options but it missed to add these
> options to getopt arguments.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 74640ad..79c59d5 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -349,6 +349,8 @@ rearrange_params()
>          --long host-only \
>          --long no-hostonly \
>          --long no-host-only \
> +        --long hostonly-cmdline \
> +        --long no-hostonly-cmdline \
>          --long persistent-policy: \
>          --long fstab \
>          --long help \
> 

oh, good catch! Thanks!
