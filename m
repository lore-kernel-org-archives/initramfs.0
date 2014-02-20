From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: Re: Advanced dracut use help or tips needed.
Date: Thu, 20 Feb 2014 08:52:28 +0100 (CET)
Message-ID: <557206706.564515170.1392882748561.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <52DFB6D3.1090907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52DFB6D3.1090907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Harald,

Thanks for your answer, I know this doc; I've googled a lot, but I'm un=
able to find what I need.
All those docs explain how to boot an OS. either local or networked.
I mean, the initrd end with a swaproot and finish boot on the booted OS=
=2E

That's not what I want.

I'm looking for something that:
1/ detect all network and all hard drives
2/ start network
3/ run MY script
4/ reboots or shutdown
NO swaproot and NO os boot

In the doc, I've been unable to find the following infos:
1/ how do I tell to dracut to include ALL drivers including frimwares
   do I really need to find /lib/modules |xargs to create a full list a=
nd give drivers one y one to the dracut command line options? Really no=
 way to specify all drivers or at least all network drivers + all hdisk=
 controler + all filesystems? (for example, the pxeboot image for fedor=
a install has ALL drivers + all firmwares)
2/ how to I tell to dracut that I don't want swaproot? (for example fed=
ora pxeboot  image runs a secondstage loader, thus no swaproot)
3/ how do I tell dracut that instead I want to run /etc/rcS (or /bin/my=
_systemimager_scrit.sh)? (for example fedora pxeboot image runs a secon=
dstage loader)

Assuming that all my specific software is located in /usr/lib/systemima=
ger/template_img/
and knowing that I need to run /usr/bin/system_imager_client.sh
and knowing that I need parted+buzybox+lvmtools+*mkfs*+rsync_client+ssh=
_client
(and optionaly knowing that I need fr keyboard)

What would be a typical dracut command? (that would work the same on rh=
el-6 and on fedora-20 or debian-7)

My problems are:
1/ was unable to tell dracut no to swaproot
2/ was unable to tell to dracut to run my scrip instead
3/ was unable to tell "all drivers" (I can fallback to list them all bu=
t seems stupid)
4/ I'd like to use systemd when  possible

Sorry for asking things that may be evident to you, but I'm new in this=
 world and 99.999% of google results only points to basic dracut usage =
explaining how to build/rebuild an OS boot image.

Best regards,

Olivier.

----- Mail original -----
> De: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "olivier lahaye1" <olivier.lahaye1-GANU6spQydw@public.gmane.org>, initramfs@vger.k=
ernel.org
> Envoy=C3=A9: Mercredi 22 Janvier 2014 13:17:23
> Objet: Re: Advanced dracut use help or tips needed.
>=20
> On 01/11/2014 01:27 PM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
> >=20
> > Hi,
> >=20
> > Please forgive me if this is the wrong list to post, but I didn't
> > find any
> > other places to ask what I'm looking for regarding advanced usage
> > of dracut.
> >=20
> >=20
> > I'm part of systemimager developpers, a tool to build and deploy
> > linux images
> > on computers (often used in clusters to deploy nodes).
> >=20
> > This perl software is building it's own initramfs from scratch
> > (build kernel
> > and all content), unfortunately, this is problematic as it needs a
> > recent
> > kernel to support latest hardware.(detect disk or net adapters)
> > Unfortunateley, trying to build everything on an rhel6 distro for
> > example
> > will result in bad binaries. Indeed, if we build kernel 3.10 on a
> > 2.6 kernel
> > (it works), but then building lvm tools (bad binaries) as the tools
> > will be
> > built with kernel 2.6 system includes and run on a 3.10 kernel
> > resulting at
> > best in crashes and at worse in data loss. More over, it is based
> > on udev
> > only (no systemd or network manager). thus, now it's even more
> > difficult to
> > build it (difficult to build udev without systemd, ...)
> >=20
> > My aim would be to drop this old way of doing stuff and use dracut
> > to build a
> > bootable image using system installed binaries. Indeed, this image
> > is only
> > used to boot the node, create disk partition table, format
> > partitions, init
> > network download some post install scripts, start a custom
> > deployment
> > monitoring daemon and copy the image from server using
> > preconfigured method
> > (either rsync, nfs, bittorrent, ...) (and reboot) As linux vendors
> > are
> > backporting support for latest hardware, having the latest binaries
> > is not
> > needed anymore. using booted system materials will be sufficient.
> >=20
> > For example, here is the actual content of the initrd_template we
> > are using:
> > http://olivier.lahaye1.free.fr/OSCAR/initrd_template.txt It has no
> > second
> > stage and it is far from being optimized but it does more or less
> > what we
> > need.
> >=20
> > Despite my googleing, I've been unable to find examples other than
> > creating a
> > basic initial ramdisk for booting an installed OS. I was even
> > unable to find
> > how the fedora or redhat pxe boot image were created (and how they
> > are
> > built).
> >=20
> > what I'm looking for would be some sort of comand that would do:
> >=20
> > dracut --include-all-network-drivers --include-all-disk-drivers
> > --include-nfsandother_drivers
> > --put_what_is_needed_for_an_advanced_initramfs(udev+systemd+network=
manager+...)
> > --put_buzybox --add_binaries_from_running_system
> > <list_of_binaries.txt>
> > --add_binaries_required_libs_from_system --add_other_files
> > --start_inital_system_tasks_like_systemd_then_jump_to_our_rcS_scrip=
t
> >=20
> > I'd greatly apreciate any help, tip on how to proceed or even
> > pointer to
> > pages describing how the distro installation initial pxe disks are
> > build (for
> > example how the code calling the second stage is put into the image
> > and from
> > when it is taken from).
> >=20
> > Best regards.
> >=20
>=20
> https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
>=20
> https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#Networ=
kBoot
>=20
