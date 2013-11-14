From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH] kernel-modules: Add ohci-pci module needed in (at least)
 kernel 3.12.0
Date: Thu, 14 Nov 2013 10:16:29 +0100
Message-ID: <l624d2$k3j$1@ger.gmane.org>
References: <1384416331-22482-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384416331-22482-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Colin Guthrie at 14/11/13 09:05 did gyre and gimble:
> https://bugs.mageia.org/show_bug.cgi?id=11645
> ---
>  modules.d/90kernel-modules/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index 2100336..e2aa952 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -37,7 +37,7 @@ installkernel() {
>          }
>  
>          hostonly='' instmods sr_mod sd_mod scsi_dh ata_piix \
> -            ehci-hcd ehci-pci ehci-platform ohci-hcd uhci-hcd xhci-hcd hid_generic \
> +            ehci-hcd ehci-pci ehci-platform ohci-hcd ohci-pci uhci-hcd xhci-hcd hid_generic \
>              unix
>  
>          instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
> 

For reference, this was fixed by Harald independently this morning:

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=28609baf6e9581ea97c4550340e2a6031c1b6fbd

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
