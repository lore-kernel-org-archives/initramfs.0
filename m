From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Tue, 12 Apr 2016 16:41:50 +0200
Message-ID: <1460472110.3152.14.camel@trentalancia.net>
References: <1460470060.3152.3.camel@trentalancia.net>
	 <570D0533.6070704@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570D0533.6070704-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On mar, 2016-04-12 at 16:24 +0200, Harald Hoyer wrote:
> Am 12.04.2016 um 16:07 schrieb Guido Trentalancia:
> > Do not mount the /run directory with the "noexec" option, otherwise
> > the
> > system bootup fails (no binary can be executed, everything fails
> > with
> > permission denied errors).
> >=20
> > The bug was introduced in version 042 (11 Jun 2015) and affects all
> > versions up to 044 (latest) and including git checked out on 12 Apr
> > 2016.
> >=20
> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0modules.d/99base/init.sh |=C2=A0=C2=A0=C2=A0=C2=A02 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > --- dracut-044/modules.d/99base/init.sh	2015-11-25
> > 14:22:28.000000000 +0100
> > +++ dracut-044-99base-init-should-mount-newrun-as-
> > exec/modules.d/99base/init.sh	2016-04-12 15:37:44.163185387
> > +0200
> > @@ -64,7 +64,7 @@ fi
> > =C2=A0
> > =C2=A0if ! ismounted /run; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkdir -m 0755 /newrun
> > -=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D0755,noexec,nosui=
d,nodev,strictatime
> > tmpfs /newrun >/dev/null
> > +=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D0755,nosuid,nodev=
,strictatime tmpfs
> > /newrun >/dev/null
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -a /run/* /newrun >/dev/null 2>&1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mount --move /newrun /run
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -fr -- /newrun
> >=20
>=20
> Which binary resides in /run ??


The whole initram filesystem binaries, including (/run/initramfs)/bin,
(/run/initramfs)/sbin, (/run/initramfs)/usr/bin and
(/run/initramfs)/usr/sbin.

It starts to break immediately after mount at line 70 of 99base/init.sh
(rm -fr -- /newrun) up to and including 99base/udevsettle() (loops the
"permission denied" failure on execution of udevadm).

The patch has been tested and it works fine. Without the patch, dracut
is unusable (the system cannot be booted).

Regards,

Guido
