From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 14:55:26 +0100
Message-ID: <494BA7CE.2020007@suse.de>
References: <1229540094.28858.150.camel@aglarond.local>	<20081217190700.GA15377@infradead.org>	<4949FD67.6040906@suse.de>	<494B5031.5080306@bfh.ch> <20081219091841.207bc951@kopernikus.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081219091841.207bc951-Hxm9IJOWyO+kWa+peg0mPg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Bernhard Walle <bwalle-l3A5Bk7waGM@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Bernhard Walle <bwalle-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>

Hi all,

Bernhard Walle wrote:
> * Seewer Philippe [2008-12-19 08:41]:
>> Hannes Reinecke wrote:
>> [snip]
>>> If anyone is interested I can give a short overview of it.
>> Please do so, would be appreciated.
>=20
> A good start is the manual page in section 5:
> http://git.opensuse.org/?p=3Dprojects/mkinitrd.git;a=3Dblob_plain;f=3D=
man/mkinitrd.5.txt;hb=3D7583c3cc047edc3e8f1a06e8b7925bd27ac0228c
>=20
> (The git.kernel.org and the opensuse.org repos are basically the same=
,
> we just switched to opensuse.org after the internal maintainership ha=
s
> been transferred from Hannes to myself because it was easier to add
> new users there. The opensuse.org git repo site didn't exist when the
> kernel.org mkinitrd repo was created.)
>=20
> Anyway:
>=20
> The basic idea is to have most stuff not in the main 'mkinitrd' scrip=
t
> but in modules. Each module has (normally) a setup script part that i=
s
> executed when the initrd is created, and a boot part that is executed
> when the initrd is running. For example, NFS root is in the 'nfs-util=
'
> package, not in 'mkinitrd'. Same for iSCSI. Or the kdump part is
> not in the main mkinitrd but in our 'kdump' package [1]. So the main
> initrd  package is quite small but still very flexible.
>=20
> It's also flexible enough to use Busybox as module that resides in th=
e
> 'busybox' package and can then be enabled with -F busybox (feature)
> when building the initrd.
>=20
> Only documentation is at the current time a bit weak, one has to fidd=
le
> some stuff from the sources when writing new modules. But that's easy
> to fix. :-)
>=20
> Hannes may explain more ...
>=20
Yes, quite so. The design principles are as follows:

The goal of the initrd is to activate and mount the root fs.
And the root fs _only_. Every other system should be configured
once the main system is running.

So mkinitrd has two parts:
a) Detect the configuration of the rootfs and create the
   initramfs
b) Configure the rootfs on boot.

Therefore there are two distinct script types:

setup-XXX.sh - run during initrd creation time to detect
  and record the configuration

boot-XXX.sh - run during boot to configure the subsystem

The setup scripts have these tasks:
- Detect the rootfs
- Unwind the storage stack and record the configuration
  on each level
- Copy the required contents into the initramfs
- Pack initramfs for use

The boot scripts have these tasks:
- Initial configuration (create required device nodes, start udev)
- Configure the storage stack
- fsck and mount the root fs

So basically the boot scripts have to be called in reverse
order to the setup scripts.
To ensure the order is preserved during each run I've
introduced some 'stages', which are run consecutively.
These stages are documented in mkinitrd.5

The neat thing here is that we've split off each
configuration into small scripts, which will be called
if present. This allows for a pretty modular setup
and avoid the massive requirement setting of an
monolithic script.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
