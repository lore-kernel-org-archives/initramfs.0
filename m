From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] kernel-modules: Drop explicit modules that are found
 with block_module_filter
Date: Wed, 29 Oct 2014 14:14:45 +0100
Message-ID: <5450E845.5060702@redhat.com>
References: <1414324095-29818-1-git-send-email-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414324095-29818-1-git-send-email-pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 26.10.2014 12:48, Peter Robinson wrote:
> The usb_storage, nvme and sdhci_acpi modules are discovered with the
> block_module_filter so there's no need to explicitly list them here.
> 
> Signed-off-by: <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index 83b8995..2fa263c 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -44,8 +44,7 @@ installkernel() {
>          instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
>              atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
>              hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
> -            pcmcia usb_storage nvme hid-hyperv hv-vmbus \
> -            sdhci_acpi hyperv-keyboard
> +            pcmcia hid-hyperv hv-vmbus hyperv-keyboard
>  
>          if [[ "$(uname -p)" == arm* ]]; then
>              # arm specific modules
> 

Thanks! Pushed
