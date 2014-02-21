From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Advanced dracut use help or tips needed.
Date: Fri, 21 Feb 2014 16:39:09 +0100
Message-ID: <5307731D.80403@redhat.com>
References: <557206706.564515170.1392882748561.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557206706.564515170.1392882748561.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: olivier.lahaye1-GANU6spQydw@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/20/2014 08:52 AM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
> 
> Hi Harald,
> 
> Thanks for your answer, I know this doc; I've googled a lot, but I'm unable to find what I need.
> All those docs explain how to boot an OS. either local or networked.
> I mean, the initrd end with a swaproot and finish boot on the booted OS.
> 
> That's not what I want.
> 
> I'm looking for something that:
> 1/ detect all network and all hard drives

difficult to know, without specifying a timeout.
firmware and devices can take as long as they want to initialize

> 2/ start network

"rd.neednet=1 ip=dhcp" on the kernel command line

> 3/ run MY script

Hook a systemd service in

https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#dracutbootup7

Do not specify "root=..." on the kernel cmdline.

Your service should have

Before: basic.target
After: sysinit.target

Then in your service, you can wait as long as you want, while in the background
all drivers load.

you can do the same as dracut-initqueue.

> 4/ reboots or shutdown
> NO swaproot and NO os boot
> 
> In the doc, I've been unable to find the following infos:
> 1/ how do I tell to dracut to include ALL drivers including frimwares
>    do I really need to find /lib/modules |xargs to create a full list and give drivers one y one to the dracut command line options? Really no way to specify all drivers or at least all network drivers + all hdisk controler + all filesystems? (for example, the pxeboot image for fedora install has ALL drivers + all firmwares)

--no-hostonly for network + disk


> 2/ how to I tell to dracut that I don't want swaproot? (for example fedora pxeboot  image runs a secondstage loader, thus no swaproot)

do not specify "root="

> 3/ how do I tell dracut that instead I want to run /etc/rcS (or /bin/my_systemimager_scrit.sh)? (for example fedora pxeboot image runs a secondstage loader)

hook your service in the boot

> 
> Assuming that all my specific software is located in /usr/lib/systemimager/template_img/
> and knowing that I need to run /usr/bin/system_imager_client.sh
> and knowing that I need parted+buzybox+lvmtools+*mkfs*+rsync_client+ssh_client
> (and optionaly knowing that I need fr keyboard)
> 
> What would be a typical dracut command? (that would work the same on rhel-6 and on fedora-20 or debian-7)
> 
> My problems are:
> 1/ was unable to tell dracut no to swaproot
> 2/ was unable to tell to dracut to run my scrip instead
> 3/ was unable to tell "all drivers" (I can fallback to list them all but seems stupid)
> 4/ I'd like to use systemd when  possible


