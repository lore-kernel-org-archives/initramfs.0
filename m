From: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/14] remove partitions from raid devices before they
 are used for something else
Date: Mon, 20 Jul 2009 19:31:07 +0200
Message-ID: <4A64A9DB.6060701@intel.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com> <1247676646-3837-8-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-8-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald Hoyer wrote:
> diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
> index 3b3eb7f..6bcf052 100644
> --- a/modules.d/90dmraid/61-dmraid-imsm.rules
> +++ b/modules.d/90dmraid/61-dmraid-imsm.rules
> @@ -12,4 +12,10 @@ ENV{ID_FS_TYPE}=="*_raid_member", \
>      TEST!="/tmp/.dmraid_scan-%k", \
>      RUN+="/bin/sh -c '>/tmp/.dmraid_scan-%k; /bin/ln -fs /sbin/dmraid_scan /initqueue/dmraid_scan.sh'"
>  
> +
> +ENV{ID_FS_TYPE}=="*_raid_member", \
> +    TEST!="/tmp/.dmraid_scan-%k", \
> +    ATTR{partition}!="?*", \
> +    RUN+="/sbin/partx -d $env{DEVNAME}"

/sbin/partx is missing in image created by dracut-0.5
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
