From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] dracut: write-ifcfg.sh: load net-lib.sh
Date: Tue, 20 May 2014 11:36:03 +0200
Message-ID: <537B2203.5010304@redhat.com>
References: <20140507141827.27588.20483.sendpatchset@dhcp-33-231.bos.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140507141827.27588.20483.sendpatchset-cl2/UFW8KLzV1gMhexUvwR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 16:18, Marc Milgram wrote:
> When kdump boots the second kernel, it complains:
> 
> dracut-pre-pivot[429]: //lib/dracut/hooks/pre-pivot/85-write-ifcfg.sh: line 168: is_persistent_ethernet_name: command not found 
> 
> is_persistent_ethernet_name is defined in net-lib.sh, but write-ifcfg.sh
> doesn't load that library.  Solution is to load the library.
> 
> Tested that this fix eliminates the error message.
> 
> Signed-off-by: Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
> index 5de2e90..e30749b 100755
> --- a/modules.d/45ifcfg/write-ifcfg.sh
> +++ b/modules.d/45ifcfg/write-ifcfg.sh
> @@ -5,6 +5,8 @@
>  # NFS root might have reached here before /tmp/net.ifaces was written
>  udevadm settle --timeout=30
>  
> +command -v is_persistent_ethernet_name || . /lib/net-lib.sh
> +
>  if [ -e /tmp/bridge.info ]; then
>      . /tmp/bridge.info
>  fi


Thanks!
http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=8fa1afb65cef30d56ce2e141b0b594cf780120a1
