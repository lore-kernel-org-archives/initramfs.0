From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] selinux: umount $NEWROOT/dev and its submounts
Date: Tue, 18 Jun 2013 09:01:58 +0200
Message-ID: <51C005E6.5030206@redhat.com>
References: <20130618055804.GA3612@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618055804.GA3612-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/18/2013 07:58 AM, WANG Chao wrote:
> $NEWROOT/dev and its submounts should be umounted after we use it.
> Otherwise it fails other scripts that umount /sysroot only.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/98selinux/selinux-loadpolicy.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/modules.d/98selinux/selinux-loadpolicy.sh b/modules.d/98selinux/selinux-loadpolicy.sh
> index 5dddfc2..436ee6b 100755
> --- a/modules.d/98selinux/selinux-loadpolicy.sh
> +++ b/modules.d/98selinux/selinux-loadpolicy.sh
> @@ -48,6 +48,7 @@ rd_load_policy()
>              [ -e "$NEWROOT"/.autorelabel ] && LANG=C /usr/sbin/setenforce 0
>              mount --rbind /dev "$NEWROOT/dev"
>              LANG=C chroot "$NEWROOT" /sbin/restorecon -R /dev
> +            umount -R "$NEWROOT/dev"
>              return 0
>          fi
>  
> 


Thanks! Pushed.
