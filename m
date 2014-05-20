From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] udev-rules: include 59-scsi-sg3_utils.rules
Date: Tue, 20 May 2014 13:29:49 +0200
Message-ID: <537B3CAD.7080306@redhat.com>
References: <5313441.RfDPQevkKo@e117>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5313441.RfDPQevkKo@e117>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Julian Wolf <juwolf-IBi9RG/b67k@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03.04.2014 14:55, Julian Wolf wrote:
> Without the 59-scsi-sg3_utils.rules udev-rule a couple of devices are missing 
> in /dev/disk/by-id.
> 
> If the luks device is specified by-id in /etc/crypttab and rd.luks.uuid not 
> passed as a commandline parameter during boot, systemd tries to start its 
> crypto services which depend on those missing devices until it times out and 
> exits to dracut rescue shell.
> 
> Signed-off-by: Julian Wolf <juwolf-IBi9RG/b67k@public.gmane.org>
> ---
>  modules.d/95udev-rules/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-
> rules/module-setup.sh
> index 2d36712..fab4ffc 100755
> --- a/modules.d/95udev-rules/module-setup.sh
> +++ b/modules.d/95udev-rules/module-setup.sh
> @@ -32,6 +32,7 @@ install() {
>          60-pcmcia.rules \
>          50-udev.rules 95-late.rules \
>          50-firmware.rules \
> +        59-scsi-sg3_utils.rules \
>          75-net-description.rules \
>          80-net-name-slot.rules 80-net-setup-link.rules \
>          "$moddir/59-persistent-storage.rules" \
> 

Thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=c96f1b1e6b25f0795d163a5b8ba498565d3201d5
