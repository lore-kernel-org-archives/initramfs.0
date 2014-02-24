From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Advanced dracut use help or tips needed.
Date: Mon, 24 Feb 2014 09:20:20 +0100
Message-ID: <530B00C4.10309@redhat.com>
References: <1065426580.573286201.1393058780798.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1065426580.573286201.1393058780798.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: olivier.lahaye1-GANU6spQydw@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/22/2014 09:46 AM, olivier.lahaye1-GANU6spQydw@public.gmane.org wrote:
> Hi Harald,
> 
> Thanks you for your detailed response, I'll start to dig my case using your
> tips. I still have few more questions though.
> 
>>> 1/ detect all network and all hard drives
> I just want to do the same as a linux installation disk. (as SystemImager is
> a sort of OS install disk). I mean, how do all OS install disk wait that
> needed drivers have finished to initialize? I just need that udev scan
> hardware and load needed drivers, nothing more. isn't there an udev target
> for that? I just need to run my script once network is up and once hard
> drives harve been detected. Can't I set a systemd dependacy on network and
> or disks? does a target matches that kind of need?

Kind of. In dracut we use udev settle in the dracut initqueue loop to wait
until all needed devices show up.

Basically, you need to know what to wait for to do the waiting :-)

> 
> - Systemd compatibility with non systemd distros. I see that you answered my
> restion about running my script using systemd, but many distro are not using
> systemd by default. do you think that using dracut with systemd on those
> distros is stable enough for my purpose? (I think about ubuntu, debian,
> rhel6, ...) does it work at least on rhel6? If not, are there alternatives?
> (I need to support: rhel-6+ fedora-17+ debian-6+ ubuntu-1204+ SuSE-11+)

If you don't want to rely on systemd, you have to use the pure dracut
mechanisms. You create "end of wait" conditions with iniqueue/finished hooks,
where you can also call out to your custom script, and never return, if you want.

> 
> - Kernel boot option. how does the "rd.neednet=1 ip=dhcp" work when used?
> first device found that can get an ip wins? is there an order? if I have 2
> ethernet devices and I want to create a bond later (thus both connected) is
> eth0 chosen over eth1? (for example if a dhcp servers gives addr to both) 
> Isn't there a dracut module for network setup using dhcp and udev (to detect
> hardware) that would add a systemd target?

As of now, networking is not yet hooked in the systemd mechanism. This will
change in the future, but as of now, these are just custom dracut network
scripts. Setup of the network is driven by the kernel command line or injected
or static pseudo kernel command line options in /etc/cmdline.d/*.conf.

> 
> - Systemd targets required befor I run my script Can I add "After:
> network.target" to make sure I have network initialized?

Hmm, sadly not yet.

> 
> - Supported filesystems Is there a way to add all supported filesystem to
> the initramfs.img or should I list them all updating the list when new ones
> are added?

If you generate a non-hostonly aka generic initramfs, all available filesystems
are put in the initramfs.

> 
> - Firmwares for drivers (net) You told me to use "--no-hostonly for network
> + disk", but isn't there an option for include all modules present in
> /lib/modules/<kernel>? At least, does --no-hostonly includes drivers
> firmwares if present when needed? Can rd.neednet=1 ip=dhcp work with a NIC
> that requires a firmware to be loaded?

yes, firmwares are included for all drivers, which are in the initramfs image.

To include all /lib/modules/<kernel> you would have to write your own dracut
module, which does exactly that. Needed firmware would be included also
automatically.

> 
> - dractut default modules: how do I know? How do I knwow which modules are
> used by default and which ones are not (thus requiring me to use the -m
> option). For example, I've installed dracut-network which contains many
> modules. is there a sort of depend in it? any doc on that (no man in the
> fedora package and insid the modules. Do I need to reverse engineer the file
> to understand their function and usage?)

Reverse engineering + the documentation on the kernel command line parameters
is the fastest way to get an overview. Most shell scripts should be fairly easy
to understand.

All modules have a "check" function in module-setup.sh. If a module is included
is determined at runtime. Recent dracut modules output a warning, why the
module is not included in the initramfs, if a tool is missing. Of course
nothing prevents you from specifying the exact list.

> 
> - dracut redudant options? What is the difference between using
> --filesystems btrfs and --add-drivers btrfs?? What is the difference between
> using --install /usr/sbin/fsck.ext3 and --fscks ext3

* --filesystems btrfs
  would include the kernel driver btrfs and the fsck tool (if there were any)
* --add-drivers btrfs
  would only include the kernel driver
* --fscks ext3
  would only add the fsck.ext3
* --install <foo>
  just installs <foo> without any logic (except shared libs)

> 
> - including modules: are dependancies for modules handled? Does --modules
> includes depending modules. I mean does --module snd includes
> snd_hwdep,snd_timer,snd_hda_codec_idt,snd_pcm,snd_seq,snd_hda_codec,snd_hda_intel,snd_seq_device
> as well?

"--module" does not exist

"--modules" is for dracut modules, not kernel modules

what you probably meant is "--add-drivers snd"

This would add the kernel driver/module "snd" with all its dependencies
determined with:

$ modprobe "snd" --ignore-install --show-depends
insmod /lib/modules/3.14.0-0.rc2.git3.2.fc21.x86_64/kernel/sound/soundcore.ko
insmod /lib/modules/3.14.0-0.rc2.git3.2.fc21.x86_64/kernel/sound/core/snd.ko

So, "snd.ko soundcore.ko" ... nothing of snd_hda_intel.


> 
> Sorry to bother whith such questions, but I'm completely new in this early
> OS boot world. As I said before, google is of no help for me as 99.99% of
> answers are about creating a simple initrd for OS boot. So if you could
> bootstrap my knowledge, that would greatly help me in fixing SystemImager
> faster.
> 
> Best regards,
> 
> Olivier.
> 

No problem. What you can do right now is:
* ask me more questions
* clarify the documentation in the dracut project (asciidoc *.asc files)
* send patches for the documentation
-> win-win for all of us
