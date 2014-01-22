From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Advanced dracut use help or tips needed.
Date: Wed, 22 Jan 2014 13:17:23 +0100
Message-ID: <52DFB6D3.1090907@redhat.com>
References: <1726532839.368644133.1389443257576.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1726532839.368644133.1389443257576.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: olivier.lahaye1-GANU6spQydw@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/11/2014 01:27 PM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
> 
> Hi,
> 
> Please forgive me if this is the wrong list to post, but I didn't find any
> other places to ask what I'm looking for regarding advanced usage of dracut.
> 
> 
> I'm part of systemimager developpers, a tool to build and deploy linux images
> on computers (often used in clusters to deploy nodes).
> 
> This perl software is building it's own initramfs from scratch (build kernel
> and all content), unfortunately, this is problematic as it needs a recent
> kernel to support latest hardware.(detect disk or net adapters) 
> Unfortunateley, trying to build everything on an rhel6 distro for example
> will result in bad binaries. Indeed, if we build kernel 3.10 on a 2.6 kernel
> (it works), but then building lvm tools (bad binaries) as the tools will be
> built with kernel 2.6 system includes and run on a 3.10 kernel resulting at
> best in crashes and at worse in data loss. More over, it is based on udev
> only (no systemd or network manager). thus, now it's even more difficult to
> build it (difficult to build udev without systemd, ...)
> 
> My aim would be to drop this old way of doing stuff and use dracut to build a
> bootable image using system installed binaries. Indeed, this image is only
> used to boot the node, create disk partition table, format partitions, init
> network download some post install scripts, start a custom deployment
> monitoring daemon and copy the image from server using preconfigured method
> (either rsync, nfs, bittorrent, ...) (and reboot) As linux vendors are
> backporting support for latest hardware, having the latest binaries is not
> needed anymore. using booted system materials will be sufficient.
> 
> For example, here is the actual content of the initrd_template we are using:
> http://olivier.lahaye1.free.fr/OSCAR/initrd_template.txt It has no second
> stage and it is far from being optimized but it does more or less what we
> need.
> 
> Despite my googleing, I've been unable to find examples other than creating a
> basic initial ramdisk for booting an installed OS. I was even unable to find
> how the fedora or redhat pxe boot image were created (and how they are
> built).
> 
> what I'm looking for would be some sort of comand that would do:
> 
> dracut --include-all-network-drivers --include-all-disk-drivers
> --include-nfsandother_drivers
> --put_what_is_needed_for_an_advanced_initramfs(udev+systemd+networkmanager+...)
> --put_buzybox --add_binaries_from_running_system <list_of_binaries.txt>
> --add_binaries_required_libs_from_system --add_other_files
> --start_inital_system_tasks_like_systemd_then_jump_to_our_rcS_script
> 
> I'd greatly apreciate any help, tip on how to proceed or even pointer to
> pages describing how the distro installation initial pxe disks are build (for
> example how the code calling the second stage is put into the image and from
> when it is taken from).
> 
> Best regards.
> 

https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#NetworkBoot
