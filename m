From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v2] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Thu, 14 Apr 2016 13:41:37 +0200
Message-ID: <1460634097.2782.6.camel@trentalancia.net>
References: <1460470060.3152.3.camel@trentalancia.net>
	 <570D0533.6070704@redhat.com> <1460472110.3152.14.camel@trentalancia.net>
	 <570F71FD.3020101@redhat.com> <1460632714.2782.3.camel@trentalancia.net>
	 <570F7F54.5050904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570F7F54.5050904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Harald.

Given that you insist, I'll help you on this...

Please try the attached second version of the patch, which includes the
check you like.

On gio, 2016-04-14 at 13:30 +0200, Harald Hoyer wrote:
> On 14.04.2016 13:18, Guido Trentalancia wrote:
> > Hello Harald.
> >=20
> > My reply follows the quoted text from previous messages...
> >=20
> > On gio, 2016-04-14 at 12:33 +0200, Harald Hoyer wrote:
> > > On 12.04.2016 16:41, Guido Trentalancia wrote:
> > > > On mar, 2016-04-12 at 16:24 +0200, Harald Hoyer wrote:
> > > > > Am 12.04.2016 um 16:07 schrieb Guido Trentalancia:
> > > > > > Do not mount the /run directory with the "noexec" option,
> > > > > > otherwise
> > > > > > the
> > > > > > system bootup fails (no binary can be executed, everything
> > > > > > fails
> > > > > > with
> > > > > > permission denied errors).
> > > > > >=20
> > > > > > The bug was introduced in version 042 (11 Jun 2015) and
> > > > > > affects
> > > > > > all
> > > > > > versions up to 044 (latest) and including git checked out
> > > > > > on 12
> > > > > > Apr
> > > > > > 2016.
> > > > > >=20
> > > > > > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > > > > > ---
> > > > > > =C2=A0modules.d/99base/init.sh |=C2=A0=C2=A0=C2=A0=C2=A02 +=
-
> > > > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > --- dracut-044/modules.d/99base/init.sh	2015-11-25
> > > > > > 14:22:28.000000000 +0100
> > > > > > +++ dracut-044-99base-init-should-mount-newrun-as-
> > > > > > exec/modules.d/99base/init.sh	2016-04-12
> > > > > > 15:37:44.163185387
> > > > > > +0200
> > > > > > @@ -64,7 +64,7 @@ fi
> > > > > > =C2=A0
> > > > > > =C2=A0if ! ismounted /run; then
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkdir -m 0755 /newrun
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o
> > > > > > mode=3D0755,noexec,nosuid,nodev,strictatime
> > > > > > tmpfs /newrun >/dev/null
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0mount -t tmpfs -o mode=3D0755,nosu=
id,nodev,strictatime
> > > > > > tmpfs
> > > > > > /newrun >/dev/null
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -a /run/* /newrun >/dev/nu=
ll 2>&1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mount --move /newrun /run
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -fr -- /newrun

Do not mount the /run directory with the "noexec" option, otherwise the
system bootup fails (no binary can be executed, everything fails with
permission denied errors).

The bug was introduced with the following commit:

commit c4184b5cf1b4892712de1370f8d2d92e5cc2e705
Author: Nikoli
Date:   Sat Nov 15 17:01:18 2014 +0300

and it started to affect version 042 (11 Jun 2015) and greater up and
including version 044 (latest) and git checked out on 13 Apr 2016.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/99base/init.sh |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- dracut-042/modules.d/99base/init.sh	2016-04-14 13:34:31.594743542 +=
0200
+++ dracut-042-99base-init-should-mount-newrun-as-exec-v2/modules.d/99b=
ase/init.sh	2016-04-14 13:34:09.442551940 +0200
@@ -64,7 +64,12 @@ fi
=20
 if ! ismounted /run; then
     mkdir -m 0755 /newrun
-    mount -t tmpfs -o mode=3D0755,noexec,nosuid,nodev,strictatime tmpf=
s /newrun >/dev/null
+    if [ `echo $(readlink -f /bin/sh) | grep "^/run/"` ]; then
+        mount -t tmpfs -o mode=3D0755,noexec,nosuid,nodev,strictatime =
tmpfs /newrun >/dev/null
+    else
+        # the initramfs is based in /run, so don't mount it with noexe=
c
+        mount -t tmpfs -o mode=3D0755,nosuid,nodev,strictatime tmpfs /=
newrun >/dev/null
+    fi
     cp -a /run/* /newrun >/dev/null 2>&1
     mount --move /newrun /run
     rm -fr -- /newrun
