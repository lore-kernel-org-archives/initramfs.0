From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: Re: Advanced dracut use help or tips needed.
Date: Sat, 22 Feb 2014 09:46:20 +0100 (CET)
Message-ID: <1065426580.573286201.1393058780798.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <5307731D.80403@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5307731D.80403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Harald,

Thanks you for your detailed response, I'll start to dig my case using =
your tips.
I still have few more questions though.

>> 1/ detect all network and all hard drives
I just want to do the same as a linux installation disk. (as SystemImag=
er is a sort of OS install disk).
I mean, how do all OS install disk wait that needed drivers have finish=
ed to initialize?
I just need that udev scan hardware and load needed drivers, nothing mo=
re. isn't there an udev target for that?
I just need to run my script once network is up and once hard drives ha=
rve been detected.
Can't I set a systemd dependacy on network and or disks? does a target =
matches that kind of need?

- Systemd compatibility with non systemd distros.
I see that you answered my restion about running my script using system=
d, but many distro are not using systemd by default. do you think that =
using dracut with systemd on those distros is stable enough for my purp=
ose? (I think about ubuntu, debian, rhel6, ...) does it work at least o=
n rhel6? If not, are there alternatives? (I need to support: rhel-6+ fe=
dora-17+ debian-6+ ubuntu-1204+ SuSE-11+)

- Kernel boot option.
how does the "rd.neednet=3D1 ip=3Ddhcp" work when used? first device fo=
und that can get an ip wins? is there an order? if I have 2 ethernet de=
vices and I want to create a bond later (thus both connected) is eth0 c=
hosen over eth1? (for example if a dhcp servers gives addr to both)
Isn't there a dracut module for network setup using dhcp and udev (to d=
etect hardware) that would add a systemd target?

- Systemd targets required befor I run my script
Can I add "After: network.target" to make sure I have network initializ=
ed?

- Supported filesystems
Is there a way to add all supported filesystem to the initramfs.img or =
should I list them all updating the list when new ones are added?

- Firmwares for drivers (net)
You told me to use "--no-hostonly for network + disk", but isn't there =
an option for include all modules present in /lib/modules/<kernel>?
At least, does --no-hostonly includes drivers firmwares if present when=
 needed?
Can rd.neednet=3D1 ip=3Ddhcp work with a NIC that requires a firmware t=
o be loaded?

- dractut default modules: how do I know?
How do I knwow which modules are used by default and which ones are not=
 (thus requiring me to use the -m option). For example, I've installed =
dracut-network which contains many modules. is there a sort of depend i=
n it? any doc on that (no man in the fedora package and insid the modul=
es. Do I need to reverse engineer the file to understand their function=
 and usage?)

- dracut redudant options?
What is the difference between using --filesystems btrfs and --add-driv=
ers btrfs??
What is the difference between using --install /usr/sbin/fsck.ext3 and =
--fscks ext3

- including modules: are dependancies for modules handled?
Does --modules includes depending modules. I mean does --module snd inc=
ludes snd_hwdep,snd_timer,snd_hda_codec_idt,snd_pcm,snd_seq,snd_hda_cod=
ec,snd_hda_intel,snd_seq_device as well?

Sorry to bother whith such questions, but I'm completely new in this ea=
rly OS boot world. As I said before, google is of no help for me as 99.=
99% of answers are about creating a simple initrd for OS boot.
So if you could bootstrap my knowledge, that would greatly help me in f=
ixing SystemImager faster.

Best regards,

Olivier.

----- Mail original -----
> De: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "olivier lahaye1" <olivier.lahaye1-GANU6spQydw@public.gmane.org>
> Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Envoy=C3=A9: Vendredi 21 F=C3=A9vrier 2014 16:39:09
> Objet: Re: Advanced dracut use help or tips needed.
>=20
> On 02/20/2014 08:52 AM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
> >=20
> > Hi Harald,
> >=20
> > Thanks for your answer, I know this doc; I've googled a lot, but
> > I'm unable to find what I need.
> > All those docs explain how to boot an OS. either local or
> > networked.
> > I mean, the initrd end with a swaproot and finish boot on the
> > booted OS.
> >=20
> > That's not what I want.
> >=20
> > I'm looking for something that:
> > 1/ detect all network and all hard drives
>=20
> difficult to know, without specifying a timeout.
> firmware and devices can take as long as they want to initialize
>=20
> > 2/ start network
>=20
> "rd.neednet=3D1 ip=3Ddhcp" on the kernel command line
>=20
> > 3/ run MY script
>=20
> Hook a systemd service in
>=20
> https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#dracut=
bootup7
>=20
> Do not specify "root=3D..." on the kernel cmdline.
>=20
> Your service should have
>=20
> Before: basic.target
> After: sysinit.target
>=20
> Then in your service, you can wait as long as you want, while in the
> background
> all drivers load.
>=20
> you can do the same as dracut-initqueue.
>=20
> > 4/ reboots or shutdown
> > NO swaproot and NO os boot
> >=20
> > In the doc, I've been unable to find the following infos:
> > 1/ how do I tell to dracut to include ALL drivers including
> > frimwares
> >    do I really need to find /lib/modules |xargs to create a full
> >    list and give drivers one y one to the dracut command line
> >    options? Really no way to specify all drivers or at least all
> >    network drivers + all hdisk controler + all filesystems? (for
> >    example, the pxeboot image for fedora install has ALL drivers +
> >    all firmwares)
>=20
> --no-hostonly for network + disk
>=20
>=20
> > 2/ how to I tell to dracut that I don't want swaproot? (for example
> > fedora pxeboot  image runs a secondstage loader, thus no swaproot)
>=20
> do not specify "root=3D"
>=20
> > 3/ how do I tell dracut that instead I want to run /etc/rcS (or
> > /bin/my_systemimager_scrit.sh)? (for example fedora pxeboot image
> > runs a secondstage loader)
>=20
> hook your service in the boot
>=20
> >=20
> > Assuming that all my specific software is located in
> > /usr/lib/systemimager/template_img/
> > and knowing that I need to run /usr/bin/system_imager_client.sh
> > and knowing that I need
> > parted+buzybox+lvmtools+*mkfs*+rsync_client+ssh_client
> > (and optionaly knowing that I need fr keyboard)
> >=20
> > What would be a typical dracut command? (that would work the same
> > on rhel-6 and on fedora-20 or debian-7)
> >=20
> > My problems are:
> > 1/ was unable to tell dracut no to swaproot
> > 2/ was unable to tell to dracut to run my scrip instead
> > 3/ was unable to tell "all drivers" (I can fallback to list them
> > all but seems stupid)
> > 4/ I'd like to use systemd when  possible
>=20
>=20
>=20
>=20
