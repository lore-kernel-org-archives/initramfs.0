From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 98systemd: fixup rootfs-generator installation path
Date: Tue, 20 May 2014 13:29:16 +0200
Message-ID: <537B3C8C.6050103@redhat.com>
References: <1400577610-119478-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400577610-119478-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

On 20.05.2014 11:20, Hannes Reinecke wrote:
> The rootfs-generator was installed in the wrong path
> in the initrd, cause it never to be run.
> 
> References: bnc#878714
> 
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/98systemd/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
> index e14ce39..4516b9a 100755
> --- a/modules.d/98systemd/module-setup.sh
> +++ b/modules.d/98systemd/module-setup.sh
> @@ -192,7 +192,7 @@ install() {
>      inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount
>      inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
>  
> -    inst_script "$moddir/rootfs-generator.sh" /lib/systemd/system-generators/dracut-rootfs-generator
> +    inst_script "$moddir/rootfs-generator.sh" $systemdutildir/system-generators/dracut-rootfs-generator
>  
>      inst_binary true
>      ln_r $(type -P true) "/usr/bin/loginctl"
> 

Thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=ed2005fa5ba7d618bbb2c63bac616fba32a17a5d
