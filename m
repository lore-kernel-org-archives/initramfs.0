From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] udev-rules: add eudev rules
Date: Tue, 28 Jan 2014 15:41:23 +0100
Message-ID: <52E7C193.4080200@redhat.com>
References: <E1W5K2T-0000zh-LK@secretive.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1W5K2T-0000zh-LK-7GBPmfXo8GgjmsMGrRdz4w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/25/2013 11:00 AM, Alexander Tsoy wrote:
> eudev configured with "--enable-modules --disable-libkmod" installs
> 80-drivers-modprobe.rules instead of 80-drivers.rules
> 
> https://bugs.gentoo.org/show_bug.cgi?id=494188
> ---
>  modules.d/95udev-rules/module-setup.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
> index 88c3da2..ebc4447 100755
> --- a/modules.d/95udev-rules/module-setup.sh
> +++ b/modules.d/95udev-rules/module-setup.sh
> @@ -39,6 +39,8 @@ install() {
>      prepare_udev_rules 59-persistent-storage.rules 61-persistent-storage.rules
>      # debian udev rules
>      inst_rules 91-permissions.rules
> +    # eudev rules
> +    inst_rules 80-drivers-modprobe.rules
>  
>      {
>          for i in cdrom tape dialout floppy; do
> 

Thanks! Pushed.
