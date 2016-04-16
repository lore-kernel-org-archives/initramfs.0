From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH] dracut: add support for updating the CPU microcode
Date: Sat, 16 Apr 2016 15:54:22 +0200
Message-ID: <1460814862.4296.4.camel@trentalancia.net>
References: <1460762332.3054.2.camel@trentalancia.net>
	 <5711D522.3090907@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5711D522.3090907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Andrei,

thanks for getting back on this...

On Sat, 16/04/2016 at 09.01 +0300, Andrei Borzenkov wrote:
> 16.04.2016 02:18, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > This is the initial version of a new "microcode" dracut module
> > that can be used to update the microcode on Intel(R) CPUs.
> >=20
>=20
> ??? dracut already supports early microcode loading, why it is not
> enough and what problem this patch solves?

To be honest, I didn't notice it. I was expecting such support, if
available, to be a module and I couldn't find it, so I wrote it.

However, I have noticed it is much simpler than the actual
implementation. It doesn't differentiate between Intel and AMD (why it
should ?), it just loads the microcode in the standard location as
defined by the microcode update utility.

> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0modules.d/00microcode/module-setup.sh |=C2=A0=C2=A0=C2=A026
> > ++++++++++++++++++++++++++
> > =C2=A0modules.d/99base/init.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A09=
 +++++++++
> > =C2=A02 files changed, 35 insertions(+)
> >=20
> > diff -pruN dracut-git/modules.d/00microcode/module-setup.sh dracut-
> > git-microcode-update/modules.d/00microcode/module-setup.sh
> > --- dracut-git/modules.d/00microcode/module-setup.sh	1970-
> > 01-01 01:00:00.000000000 +0100
> > +++ dracut-git-microcode-update/modules.d/00microcode/module-
> > setup.sh	2016-04-16 01:11:20.719287468 +0200
> > @@ -0,0 +1,26 @@
> > +#!/bin/bash
> > +
> > +# Dracut module to update the microcode on Intel(R) CPUs
> > +# Copyright 2016 Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > +
> > +# called by dracut
> > +check() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0[[ "$mount_needs" ]] && return 1
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0require_binaries microcode_ctl || return 1
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0return 0
> > +}
> > +
> > +# called by dracut
> > +depends() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0return 0
> > +}
> > +
> > +# called by dracut
> > +install() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0inst microcode_ctl
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0inst_dir /lib/firmware
> > +=C2=A0=C2=A0=C2=A0=C2=A0inst /lib/firmware/microcode.dat
> > +}
> > diff -pruN dracut-git/modules.d/99base/init.sh dracut-git-
> > microcode-update/modules.d/99base/init.sh
> > --- dracut-git/modules.d/99base/init.sh	2016-04-14
> > 22:21:22.681548895 +0200
> > +++ dracut-git-microcode-update/modules.d/99base/init.sh	201
> > 6-04-16 01:09:58.517080944 +0200
> > @@ -62,6 +62,15 @@ if ! ismounted /dev/shm; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D1777,noexec,=
nosuid,nodev,strictatime
> > tmpfs /dev/shm >/dev/null
> > =C2=A0fi
> > =C2=A0
> > +# Update CPU microcode
> > +if [ -x /usr/sbin/microcode_ctl ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0MICROCODE_CTL=3D/usr/sbin/microcode_ctl
> > +elif [ -x /sbin/microcode_ctl ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0MICROCODE_CTL=3D/sbin/microcode_ctl
> > +fi
> > +[ $MICROCODE_CTL ] && [ ! -e /dev/cpu/microcode ] && echo
> > "Creating microcode update device..." && mknod /dev/cpu/microcode c
> > 10 184
> > +[ $MICROCODE_CTL ] && [ -e /lib/firmware/microcode.dat ] &&
> > $MICROCODE_CTL -u
> > +
> > =C2=A0if ! ismounted /run; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkdir -m 0755 /newrun
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! str_starts "$(readlink -f /bin/s=
h)" "/run/"; then
