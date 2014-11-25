From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/33] 90multipath: install dracut-specific service file
Date: Tue, 25 Nov 2014 13:26:10 +0100
Message-ID: <54747562.5080905@redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-11-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-11-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.11.2014 15:56, Thomas Renninger wrote:
> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> 
> The multipathd package might install a service and a socket
> file. Using the original service file from the installed
> system without the socket file triggers a bug in systemd,
> causing systemd to crash.
> 
> As we don't actually need to socket file in the initrd we
> should be installing our own service file which does not
> reference the socket file at all.
> 
> References: bnc#871610
> 
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/90multipath/module-setup.sh    |  7 +++----
>  modules.d/90multipath/multipathd.service | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>  create mode 100644 modules.d/90multipath/multipathd.service
> 
> diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
> index bbee5d9..0f88f82 100755
> --- a/modules.d/90multipath/module-setup.sh
> +++ b/modules.d/90multipath/module-setup.sh
> @@ -104,10 +104,9 @@ install() {
>      fi
>  
>      if dracut_module_included "systemd"; then
> -        inst_multiple \
> -            $systemdsystemunitdir/multipathd.service
> -        mkdir -p "${initdir}${systemdsystemconfdir}/sysinit.target.wants"
> -        ln -rfs "${initdir}${systemdsystemunitdir}/multipathd.service" "${initdir}${systemdsystemconfdir}/sysinit.target.wants/multipathd.service"
> +        inst_simple "${moddir}/multipathd.service" "${systemdsystemunitdir}/multipathd.service"
> +        mkdir -p "${initdir}${systemdsystemunitdir}/sysinit.target.wants"
> +        ln -rfs "${initdir}${systemdsystemunitdir}/multipathd.service" "${initdir}${systemdsystemunitdir}/sysinit.target.wants/multipathd.service"
>      else
>          inst_hook pre-trigger 02 "$moddir/multipathd.sh"
>          inst_hook cleanup   02 "$moddir/multipathd-stop.sh"
> diff --git a/modules.d/90multipath/multipathd.service b/modules.d/90multipath/multipathd.service
> new file mode 100644
> index 0000000..44a7b80
> --- /dev/null
> +++ b/modules.d/90multipath/multipathd.service
> @@ -0,0 +1,15 @@
> +[Unit]
> +Description=Device-Mapper Multipath Device Controller
> +Before=iscsi.service iscsid.service lvm2-activation-early.service
> +DefaultDependencies=no
> +Conflicts=shutdown.target
> +
> +[Service]
> +Type=simple
> +ExecStartPre=/sbin/modprobe dm-multipath
> +ExecStart=/sbin/multipathd -s -d
> +ExecReload=/sbin/multipathd reconfigure
> +ExecStop=/sbin/multipathd shutdown
> +
> +[Install]
> +WantedBy=sysinit.target
> 

applied, thanks!

Also added a patch to turn off the service via kernel command line options.
