From: Olivier LAHAYE <olivier.lahaye1-GANU6spQydw@public.gmane.org>
Subject: Re: Advanced dracut use help or tips needed.
Date: Mon, 24 Feb 2014 14:52:08 +0100
Message-ID: <10A5E071-0DF9-4178-8106-E1A66D1C3490@free.fr>
References: <1065426580.573286201.1393058780798.JavaMail.root@spooler6-g27.priv.proxad.net> <530B00C4.10309@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <530B00C4.10309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Harald.

Thanks a lot for your patience and detailed answer.

I'll do my best to help. I will certainly have more questions, especial=
ly for the active waiting loop for net as I'm not sure I've understood =
well.
As for systemd I like it very much. My question was about distros that =
don't like systemd. My wish is to write a dracut module for systemimage=
r and I'd like to avoid managing difference between systemd and non sys=
temd distros. I just hope that dracut systemd module exists on all dist=
ros I need to support.

Best regards

Le 24 f=C3=A9vr. 2014 =C3=A0 09:20, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> a =
=C3=A9crit :

> On 02/22/2014 09:46 AM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
>> Hi Harald,
>>=20
>> Thanks you for your detailed response, I'll start to dig my case usi=
ng your
>> tips. I still have few more questions though.
>>=20
>>>> 1/ detect all network and all hard drives
>> I just want to do the same as a linux installation disk. (as SystemI=
mager is
>> a sort of OS install disk). I mean, how do all OS install disk wait =
that
>> needed drivers have finished to initialize? I just need that udev sc=
an
>> hardware and load needed drivers, nothing more. isn't there an udev =
target
>> for that? I just need to run my script once network is up and once h=
ard
>> drives harve been detected. Can't I set a systemd dependacy on netwo=
rk and
>> or disks? does a target matches that kind of need?
>=20
> Kind of. In dracut we use udev settle in the dracut initqueue loop to=
 wait
> until all needed devices show up.
>=20
> Basically, you need to know what to wait for to do the waiting :-)
>=20
>>=20
>> - Systemd compatibility with non systemd distros. I see that you ans=
wered my
>> restion about running my script using systemd, but many distro are n=
ot using
>> systemd by default. do you think that using dracut with systemd on t=
hose
>> distros is stable enough for my purpose? (I think about ubuntu, debi=
an,
>> rhel6, ...) does it work at least on rhel6? If not, are there altern=
atives?
>> (I need to support: rhel-6+ fedora-17+ debian-6+ ubuntu-1204+ SuSE-1=
1+)
>=20
> If you don't want to rely on systemd, you have to use the pure dracut
> mechanisms. You create "end of wait" conditions with iniqueue/finishe=
d hooks,
> where you can also call out to your custom script, and never return, =
if you want.
>=20
>>=20
>> - Kernel boot option. how does the "rd.neednet=3D1 ip=3Ddhcp" work w=
hen used?
>> first device found that can get an ip wins? is there an order? if I =
have 2
>> ethernet devices and I want to create a bond later (thus both connec=
ted) is
>> eth0 chosen over eth1? (for example if a dhcp servers gives addr to =
both)=20
>> Isn't there a dracut module for network setup using dhcp and udev (t=
o detect
>> hardware) that would add a systemd target?
>=20
> As of now, networking is not yet hooked in the systemd mechanism. Thi=
s will
> change in the future, but as of now, these are just custom dracut net=
work
> scripts. Setup of the network is driven by the kernel command line or=
 injected
> or static pseudo kernel command line options in /etc/cmdline.d/*.conf=
=2E
>=20
>>=20
>> - Systemd targets required befor I run my script Can I add "After:
>> network.target" to make sure I have network initialized?
>=20
> Hmm, sadly not yet.
>=20
>>=20
>> - Supported filesystems Is there a way to add all supported filesyst=
em to
>> the initramfs.img or should I list them all updating the list when n=
ew ones
>> are added?
>=20
> If you generate a non-hostonly aka generic initramfs, all available f=
ilesystems
> are put in the initramfs.
>=20
>>=20
>> - Firmwares for drivers (net) You told me to use "--no-hostonly for =
network
>> + disk", but isn't there an option for include all modules present i=
n
>> /lib/modules/<kernel>? At least, does --no-hostonly includes drivers
>> firmwares if present when needed? Can rd.neednet=3D1 ip=3Ddhcp work =
with a NIC
>> that requires a firmware to be loaded?
>=20
> yes, firmwares are included for all drivers, which are in the initram=
fs image.
>=20
> To include all /lib/modules/<kernel> you would have to write your own=
 dracut
> module, which does exactly that. Needed firmware would be included al=
so
> automatically.
>=20
>>=20
>> - dractut default modules: how do I know? How do I knwow which modul=
es are
>> used by default and which ones are not (thus requiring me to use the=
 -m
>> option). For example, I've installed dracut-network which contains m=
any
>> modules. is there a sort of depend in it? any doc on that (no man in=
 the
>> fedora package and insid the modules. Do I need to reverse engineer =
the file
>> to understand their function and usage?)
>=20
> Reverse engineering + the documentation on the kernel command line pa=
rameters
> is the fastest way to get an overview. Most shell scripts should be f=
airly easy
> to understand.
>=20
> All modules have a "check" function in module-setup.sh. If a module i=
s included
> is determined at runtime. Recent dracut modules output a warning, why=
 the
> module is not included in the initramfs, if a tool is missing. Of cou=
rse
> nothing prevents you from specifying the exact list.
>=20
>>=20
>> - dracut redudant options? What is the difference between using
>> --filesystems btrfs and --add-drivers btrfs?? What is the difference=
 between
>> using --install /usr/sbin/fsck.ext3 and --fscks ext3
>=20
> * --filesystems btrfs
>  would include the kernel driver btrfs and the fsck tool (if there we=
re any)
> * --add-drivers btrfs
>  would only include the kernel driver
> * --fscks ext3
>  would only add the fsck.ext3
> * --install <foo>
>  just installs <foo> without any logic (except shared libs)
>=20
>>=20
>> - including modules: are dependancies for modules handled? Does --mo=
dules
>> includes depending modules. I mean does --module snd includes
>> snd_hwdep,snd_timer,snd_hda_codec_idt,snd_pcm,snd_seq,snd_hda_codec,=
snd_hda_intel,snd_seq_device
>> as well?
>=20
> "--module" does not exist
>=20
> "--modules" is for dracut modules, not kernel modules
>=20
> what you probably meant is "--add-drivers snd"
>=20
> This would add the kernel driver/module "snd" with all its dependenci=
es
> determined with:
>=20
> $ modprobe "snd" --ignore-install --show-depends
> insmod /lib/modules/3.14.0-0.rc2.git3.2.fc21.x86_64/kernel/sound/soun=
dcore.ko
> insmod /lib/modules/3.14.0-0.rc2.git3.2.fc21.x86_64/kernel/sound/core=
/snd.ko
>=20
> So, "snd.ko soundcore.ko" ... nothing of snd_hda_intel.
>=20
>=20
>>=20
>> Sorry to bother whith such questions, but I'm completely new in this=
 early
>> OS boot world. As I said before, google is of no help for me as 99.9=
9% of
>> answers are about creating a simple initrd for OS boot. So if you co=
uld
>> bootstrap my knowledge, that would greatly help me in fixing SystemI=
mager
>> faster.
>>=20
>> Best regards,
>>=20
>> Olivier.
>=20
> No problem. What you can do right now is:
> * ask me more questions
> * clarify the documentation in the dracut project (asciidoc *.asc fil=
es)
> * send patches for the documentation
> -> win-win for all of us
