From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] Correct paths for openSUSE
Date: Tue, 02 Jun 2015 12:25:14 +0200
Message-ID: <556D848A.5070308@redhat.com>
References: <1427127138-12932-1-git-send-email-trenn@suse.de> <1427127138-12932-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427127138-12932-2-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Rodrigues <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

On 23.03.2015 17:12, Thomas Renninger wrote:
> From: Christian Rodrigues <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
> 
> openSUSE has things stored in different places, so fixup the
> paths here.
> 
> Signed-off-by: Christian Rodrigues <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  dracut.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 17bf8f2..1aa7d31 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -809,7 +809,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
>  [[ $mdadmconf_l ]] && mdadmconf=$mdadmconf_l
>  [[ $lvmconf_l ]] && lvmconf=$lvmconf_l
>  [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
> -[[ $fw_dir ]] || fw_dir="/lib/firmware/updates /lib/firmware"
> +[[ $fw_dir ]] || fw_dir="/lib/firmware/updates /lib/firmware /lib/firmware/$kernel"
>  [[ $tmpdir_l ]] && tmpdir="$tmpdir_l"
>  [[ $tmpdir ]] || tmpdir=/var/tmp
>  [[ $INITRD_COMPRESS ]] && compress=$INITRD_COMPRESS
> 

pushed, thanks
