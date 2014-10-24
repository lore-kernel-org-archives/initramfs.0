From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add hyperv-keyboard kernel module for Hyper-V Gen2 VM
Date: Fri, 24 Oct 2014 09:11:21 +0200
Message-ID: <5449FB99.50607@redhat.com>
References: <1412844091-32321-1-git-send-email-vaughan.cao@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412844091-32321-1-git-send-email-vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vaughan Cao <vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09.10.2014 10:41, Vaughan Cao wrote:
> The synthetic keyboard of a Gen2 Linux VM doesn't work before the
> hyperv_keyboard module is loaded. Without it, we can't cancel the media check
> phase if boot with rd.live.check option.
> Gen1 Linux VM doesn't have the same issue because the host emulates the legacy
> i8042 keyboard for Gen1 VM.
> 
> Signed-off-by: Vaughan Cao <vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index eea30e6..83b8995 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -45,7 +45,7 @@ installkernel() {
>              atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
>              hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
>              pcmcia usb_storage nvme hid-hyperv hv-vmbus \
> -            sdhci_acpi
> +            sdhci_acpi hyperv-keyboard
>  
>          if [[ "$(uname -p)" == arm* ]]; then
>              # arm specific modules
> 

applied, thanks
