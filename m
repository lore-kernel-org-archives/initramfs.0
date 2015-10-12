From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut is too "clever" at identifying modules to exclude.
Date: Mon, 12 Oct 2015 17:29:45 +0200
Message-ID: <561BD1E9.5010007@redhat.com>
References: <20150409140840.0bb6d59d@notabene.brown>
 <87r3l023ha.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3l023ha.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Neil Brown <neilb-IBi9RG/b67k@public.gmane.org>, trenn-IBi9RG/b67k@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.10.2015 05:02, Neil Brown wrote:
> 
> If I have booted a kernel with md/raid built in (no modules) and
> I use dracut to build the initramfs for a different kernel which
> has the md code compiled as separate modules, then it does not include
> the required md modules in the initramfs.
> 
> As a particular instance this happen when the root filesystem is on
> RAID0.  The 'raid0.ko' module is not included and boot fails.
> 
> https://bugzilla.opensuse.org/show_bug.cgi?id=935993
> 
> This only happens when 'host-only' is selected (which is the default for
> openSUSE).
> 
> the modules.d/90mdraid/module-setup.sh code calls
> 
>     instmods =drivers/md
> 
> instmods calls
>    module_is_host_only "raid0"
> and this incorrectly fails.
> 
> If raid0.ko didn't have any alias this would succeed, but it does.
> 
> $ modinfo -F alias raid0
> md-level-0
> md-raid0
> md-personality-2

Huh? Is the module not loaded?

> 
> However these aliases don't appear in any modalias file in /sys/devices,
> in /proc/crypto, or in /proc/modules.
> 
> Maybe you could parse /proc/mdstat..
> 
> if [ -f /proc/mdstat ]; then
>   while read _d _c _a _m _x; do
>    if [ "$_c" = ':' -a "$_a" = 'active' ]; then
>       host_modalias["md-$_m"]=1
>    fi
>   done < /proc/mdstat
> fi
> 
> but it all seems rather fragile.  There are probably other modules that
> might miss out accidentally. dm?
> 
> Do we really need the host_modalias stuff?
> 
> Thanks,
> NeilBrown
> 
