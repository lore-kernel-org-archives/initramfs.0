From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Tue, 12 Apr 2016 17:07:01 +0200
Message-ID: <1460473621.3152.16.camel@trentalancia.net>
References: <1460470060.3152.3.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460470060.3152.3.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

In git the bug was introduced with the following commit:

commit c4184b5cf1b4892712de1370f8d2d92e5cc2e705
Date:=C2=A0=C2=A0=C2=A0Sat Nov 15 17:01:18 2014 +0300

=C2=A0=C2=A0=C2=A0=C2=A0Mount /dev, /dev/shm and /run noexec

The patch I proposed partially reverts that in order to fix this major
bug.

Regards,

Guido

On mar, 2016-04-12 at 16:07 +0200, Guido Trentalancia wrote:
> Do not mount the /run directory with the "noexec" option, otherwise
> the
> system bootup fails (no binary can be executed, everything fails with
> permission denied errors).
>=20
> The bug was introduced in version 042 (11 Jun 2015) and affects all
> versions up to 044 (latest) and including git checked out on 12 Apr
> 2016.
>=20
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
> =C2=A0modules.d/99base/init.sh |=C2=A0=C2=A0=C2=A0=C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- dracut-044/modules.d/99base/init.sh	2015-11-25
> 14:22:28.000000000 +0100
> +++ dracut-044-99base-init-should-mount-newrun-as-
> exec/modules.d/99base/init.sh	2016-04-12 15:37:44.163185387
> +0200
> @@ -64,7 +64,7 @@ fi
> =C2=A0
> =C2=A0if ! ismounted /run; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkdir -m 0755 /newrun
> -=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D0755,noexec,nosuid,=
nodev,strictatime
> tmpfs /newrun >/dev/null
> +=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D0755,nosuid,nodev,s=
trictatime tmpfs
> /newrun >/dev/null
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -a /run/* /newrun >/dev/null 2>&1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mount --move /newrun /run
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -fr -- /newrun
