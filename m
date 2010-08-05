From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fix ahci detection in kernel 2.6.35
Date: Thu, 05 Aug 2010 18:17:12 +0200
Message-ID: <4C5AE408.3090301@redhat.com>
References: <20100805160657.29650.45441.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100805160657.29650.45441.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks! And pushed.

On 08/05/2010 06:06 PM, Andrey Borzenkov wrote:
> Kernel 2.6.35 (may be, earlier) split ahci into libahci.ko and ahci.ko
> and added ahci_platform.ko. As a result, drivers ahci and ahci_platform
> do not contain any symbol that are checked for storage modules (it is
> libahci.ko that references ata_scsi_ioctl now). So add additional
> symbol ahci_init_controller; it seems this is expected to be called by
> every driver based on libahci.ko.
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   modules.d/90kernel-modules/installkernel |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
> index 2171e5a..e679b10 100755
> --- a/modules.d/90kernel-modules/installkernel
> +++ b/modules.d/90kernel-modules/installkernel
> @@ -1,7 +1,7 @@
>   #!/bin/bash
>   if [[ -z $drivers ]]; then
>       block_module_test() {
> -	local blockfuncs='ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
> +	local blockfuncs='ahci_init_controller|ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
>
>   	egrep -q "$blockfuncs" "$1"
>       }
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
