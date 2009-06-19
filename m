From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 07/13] make iSCSI boot with root=dhcp and mount partitions
 labeled with "ROOT" or "/"
Date: Fri, 19 Jun 2009 13:09:00 +0200
Message-ID: <4A3B71CC.1010509@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com> <1245409551-30493-8-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-8-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/19/2009 01:05 PM, Harald Hoyer wrote:
> diff --git a/modules.d/99base/install b/modules.d/99base/install
> index 68d40fb..06cf6db 100755
> --- a/modules.d/99base/install
> +++ b/modules.d/99base/install
> @@ -7,9 +7,8 @@ fi
>   # install our scripts and hooks
>   inst "$moddir/init" "/init"
>   # Bail out if switch_root does not exist
> -if [ ! -x "$moddir/switch_root" ]; then
> -    # assume it is installed in the standard path
> -    dracut_install switch_root
> +if which switch_root>/dev/null 2>&1; then
> +    dracut_install switch_root
>   else
>       inst "$moddir/switch_root" "/sbin/switch_root"
>   fi

Hmpf.. that should have been a seperate patch
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
