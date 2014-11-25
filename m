From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 09/33] 90multipath: Load device_handler modules early
 during boot
Date: Tue, 25 Nov 2014 13:25:41 +0100
Message-ID: <54747545.6060708@redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-10-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-10-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.11.2014 15:56, Thomas Renninger wrote:
> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> 
> The device handler modules need to be loaded early during boot
> to avoid I/O errors being printed to the system log.
> 
> References: bnc#871617
> 
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/90multipath/module-setup.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
> index 7a60b2e..bbee5d9 100755
> --- a/modules.d/90multipath/module-setup.sh
> +++ b/modules.d/90multipath/module-setup.sh
> @@ -28,6 +28,15 @@ depends() {
>  }
>  
>  # called by dracut
> +cmdline() {
> +    for m in scsi_dh_alua scsi_dh_emc scsi_dh_rdac ; do
> +        if module_is_host_only $m ; then
> +            printf 'rd.driver.pre=%s ' "$m"
> +        fi
> +    done
> +}
> +
> +# called by dracut
>  installkernel() {
>      local _ret
>      local _arch=$(uname -m)
> @@ -89,6 +98,11 @@ install() {
>      inst_libdir_file "libmultipath*" "multipath/*"
>      inst_libdir_file 'libgcc_s.so*'
>  
> +    if [[ $hostonly_cmdline ]] ; then
> +        local _conf=$(cmdline)
> +        [[ $_conf ]] && echo "$_conf" >> "${initdir}/etc/cmdline.d/90multipath.conf"
> +    fi
> +
>      if dracut_module_included "systemd"; then
>          inst_multiple \
>              $systemdsystemunitdir/multipathd.service
> 

applied, thanks!
