From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] udev-rules: add 80-net-setup-link.rules and .link files
Date: Wed, 05 Mar 2014 10:42:20 +0100
Message-ID: <5316F17C.2080402@redhat.com>
References: <E1WKXL5-0000nX-FT@secretive.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1WKXL5-0000nX-FT-7GBPmfXo8GgjmsMGrRdz4w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/03/2014 06:49 PM, Alexander Tsoy wrote:
> With systemd >= 209 these file are required for predictable network interface
> names
> ---
>  modules.d/95udev-rules/module-setup.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
> index 584d5c8..2d36712 100755
> --- a/modules.d/95udev-rules/module-setup.sh
> +++ b/modules.d/95udev-rules/module-setup.sh
> @@ -32,7 +32,8 @@ install() {
>          60-pcmcia.rules \
>          50-udev.rules 95-late.rules \
>          50-firmware.rules \
> -        75-net-description.rules 80-net-name-slot.rules \
> +        75-net-description.rules \
> +        80-net-name-slot.rules 80-net-setup-link.rules \
>          "$moddir/59-persistent-storage.rules" \
>          "$moddir/61-persistent-storage.rules"
>  
> @@ -42,6 +43,13 @@ install() {
>      # eudev rules
>      inst_rules 80-drivers-modprobe.rules
>  
> +    for _i in \
> +        ${systemdutildir}/network/*.link \
> +        ${hostonly:+/etc/systemd/network/*.link} \
> +        ; do
> +        [[ -e "$_i" ]] && inst "$_i"
> +    done
> +
>      {
>          for i in cdrom tape dialout floppy; do
>              if ! egrep -q "^$i:" "$initdir/etc/group" 2>/dev/null; then
> 

Very nice, thanks! Pushed.
