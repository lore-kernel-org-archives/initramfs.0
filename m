From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] kernel-modules: Fix storage module selection for sdhci/mmc/ahci
Date: Fri, 23 May 2014 16:16:37 +0100
Message-ID: <CALeDE9Pea9UE4yqXb68aj4pq7NMP1J6QXHs50iyvuWCLEk7OjA@mail.gmail.com>
References: <1400842441-3728-1-git-send-email-pbrobinson@gmail.com>
	<537F5D8F.6020905@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r0Tg/hEruuvG9XwqyTRicuOn7LcQKoL4ZVxKW6hQhCk=;
        b=rSl9tlJTdfUlLSZf95sKUtZdjMWSvvBfCNMvXI884WG8uK8/rxmWDgJLowIuH2hOa+
         Y9hGkXrVdPCy8iDgk/BNPz9Df+IcfHxAvQXqk/TSYPaJQiPJLU/GhvXDrMpOgmsR5pZC
         ma+0yxFt6xsTwL7Cjn9hRKr6Vl02AiikPUpBxye833nifhOOMoql1YU+bSzoyWVvCHMK
         DyWQeLdOuUhd9xaHg6/4dYQZ10LJ33pLh4eTSmO1MBYlg4LO1uI2PoAYzoUK7G79hi7q
         CIcqKjEYYZOOnY2XkVRoxwKfoke0tpXMbxLs9hOsXJ6nZiOY+sMxS4/Vv4BhbJt+JRoZ
         itzg==
In-Reply-To: <537F5D8F.6020905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, May 23, 2014 at 3:39 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 23.05.2014 12:54, Peter Robinson wrote:
>> Currently the block driver detection for generic initrd doesn't include
>> the SD/MMC drivers so we fail to boot generic images on any device using
>> those platforms as boot devices when using a generic initrd. Add logic
>> to detect those modules. This primarily fixes embedded ARM devices but
>> also likely intel tablets/dev boards and enterprise hypervisors that
>> have the ability to boot from SD.
>>
>> Also the ahci_init_controller misses a number of drivers that use the
>> libahci_platform module for the init so this fixes some missing achi
>> moduless too.
>>
>> Finally it cleans up the ARM storage module hacks that the above now
>> deals with in a more generic manner.
>>
>> Signed-off-by: <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  modules.d/90kernel-modules/module-setup.sh | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
>> index 2378663..5271438 100755
>> --- a/modules.d/90kernel-modules/module-setup.sh
>> +++ b/modules.d/90kernel-modules/module-setup.sh
>> @@ -6,7 +6,7 @@
>>  installkernel() {
>>      if [[ -z $drivers ]]; then
>>          block_module_filter() {
>> -            local _blockfuncs='ahci_init_controller|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect'
>> +            local _blockfuncs='ahci_platform_get_resources|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect|mmc_add_host|sdhci_pltfm_init'
>>              # subfunctions inherit following FDs
>>              local _merge=8 _side2=9
>>              function bmf1() {
>> @@ -51,9 +51,7 @@ installkernel() {
>>
>>          if [[ "$(uname -p)" == arm* ]]; then
>>              # arm specific modules
>> -            hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
>> -                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
>> -                ehci-tegra mmc_block usb_storage
>> +            hostonly='' instmods omapdrm panel-tfp410
>>          fi
>>
>>          # install virtual machine support
>>
>
> Hmm.. increases the size of the generic x86 image by 1.4MB
>
> most notably:
>
> usr/lib/firmware/mrvl/sd8797_uapsta.bin         458108
> usr/lib/firmware/mrvl/sd8897_uapsta.bin         639012
>
> pulled in by
> kernel/drivers/net/wireless/mwifiex/mwifiex_sdio.ko.xz
>
> questionable module for the initramfs

It must have picked up on the SDIO driver, interesting it only got two
(plus libertas) yet we have 15 SDIO drivers enabled in the kernel.
I'll review the drivers/functions see how it can be evolved. I'll post
a patch of top of this one once confirmed. I've got some other minor
bits to do too.

Thanks,
Peter
