From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 dracut 0/3] Install kernel module for active watchdog
Date: Fri, 15 Apr 2016 11:54:03 +0200
Message-ID: <5710BA3B.8030600@redhat.com>
References: <cover.1458099200.git.panand@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1458099200.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 16.03.2016 04:39, Pratyush Anand wrote:
> Changes since V4:
> -- Renamed 04watchdog.conf to 00watchdog.conf
> Changes since V3:
> -- Incorporated changes suggested by Harald for V2 patches
> 
> Changes since V2:
> -- Added one more patch to update rd.driver.pre with watchdog module name,
> so that they are loaded into kernel as early as possible.
> -- Removed creation of tmp/active-watchdogs. modinfo will be helpful for
> kexec-tools.
> -- Now we add modules for active watchdog in hostonly mode and modules for
> all watchdog in no-hostonly mode.
> 
> Changes since RFC:
> -- Added one more patch to take care that dracut does not add watchdog
> hooks when systemd module is included. In that case systemd daemon will
> manage watchdog for kicking.
> -- Removed --nowdt argument. User can use -o or --omit when wathdog module
> is not needed. Thanks Harald for this suggestion.
> -- Now I also do not check for "hostonly" to add modules for active
> watchdog. It seems reasonable to add kernel watchdog modules whenever,
> dracut watchdog module has been added.
> 
> 
> 
> Pratyush Anand (3):
>   watchdog: Do not add hooks if systemd module is included
>   watchdog: install module for active watchdog
>   watchdog: ensure that module is loaded as early as possible
> 
> Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
>  modules.d/04watchdog/module-setup.sh | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

pushed, please review my changes:
<https://github.com/dracutdevs/dracut/commit/74e2d1e69f5527ab31b01fc19f67143d1f091980>
