From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: kernel modules scanning
Date: Tue, 30 Jun 2009 13:07:12 +0200
Message-ID: <4A49F1E0.8030005@bfh.ch>
References: <4A49A3EF.2040504@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A49A3EF.2040504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
> Seewer mentioned that instmods =block is failing to pull in block device 
> drivers on Debian.  Debian lacks the modules.* lists.  The following 
> code is used to generate these lists on Fedora.
> 
> kernel.spec:
>     collect_modules_list()
>     {
>       sed -r -n -e "s/^([^ ]+) \\.?($2)\$/\\1/p" drivers.undef |
>       LC_ALL=C sort -u > $RPM_BUILD_ROOT/lib/modules/$KernelVer/modules.$1
>     }
> 
>     collect_modules_list networking \
> 
> 'register_netdev|ieee80211_register_hw|usbnet_probe'
>     collect_modules_list block \
> 
> 'ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register' 
> 
>     collect_modules_list drm \
>                          'drm_open|drm_init'
>     collect_modules_list modesetting \
>                          'drm_crtc_init'
> 
> Under the assumption that we cannot rely on modules.* list files since 
> it is not shipped by other distributions, the next best thing is to do a 
> similar scanning during dracut runtime.  This is a bit slower than 
> simply reading the modules.* files but it seems we have no choice.
> 
> I had implemented the equivalent of "modesetting" and the important 
> subset of "networking" that we require in dracut.  The equivalent for 
> "block" however is a bit more complex given the long list of alternative 
> symbol names.
> 
> I had considered implementing the equivalent of collect_modules_list in 
> dracut.  Perhaps we could implement the equivalent with an additional 
> parameter of base directory so it does not bother scanning the entire 
> directory tree looking for modules.
> 
> Just a thought.

All I can say here is yes please!

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
