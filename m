From: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: patches
Date: Wed, 14 Jul 2010 02:05:35 +0200
Message-ID: <201007140205.35944.maarten.vanraes@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P9PPMEAeT+sB49l"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:message-id;
        bh=ir2QS6VgjeqhzHDCR+aeN/OI+9yWUQc1k3HW2iBSHQw=;
        b=gZupHENEerHDuDCNoKfJUNaOULYyB2v6yxddSsyAdZ5oP9DKtvJP1hzPSJtQOCbkiX
         4zr4XGKJv35P+BP/cq0HtB9ETFffG2n866QP9tb4batE25O+5H+9if8k6YFIM+LgeGCU
         rgSw3VLEkiJQf7+CjtJK1RotCqhlZd3aLRgXw=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Boundary-00=_P9PPMEAeT+sB49l
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Here are some patches, some that were used as patches in the mandriva builds, 
and a first one from me, to fix nfs hostonly on chrooted installs.

Kind regards,

Maarten Vanraes

--Boundary-00=_P9PPMEAeT+sB49l
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-conffile-before-confdir.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-conffile-before-confdir.patch"

=46rom 25419eb164e842499d391bb396f71ddede9ad0ed Mon Sep 17 00:00:00 2001
=46rom: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Date: Wed, 14 Jul 2010 01:30:16 +0200
Subject: [PATCH 1/3] conffile before confdir

conffile should be sourced before confdir

Signed-off-by: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 dracut |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index 6b590f5..d21736b 100755
=2D-- a/dracut
+++ b/dracut
@@ -130,6 +130,9 @@ if [[ ! -d $confdir ]]; then
     [[ $allowlocal ]] && confdir=3D"$dracutbasedir/dracut.conf.d"
 fi
=20
+# source our config file
+[[ -f $conffile ]] && . "$conffile"
+
 # source our config dir
 if [ "$confdir" ] && [  -d "$confdir" ]; then
     for f in "$confdir"/*.conf; do=20
@@ -137,9 +140,6 @@ if [ "$confdir" ] && [  -d "$confdir" ]; then
     done
 fi
=20
=2D# source our config file
=2D[[ -f $conffile ]] && . "$conffile"
=2D
 # these optins add to the stuff in the config file
 [[ $add_dracutmodules_l ]] && add_dracutmodules+=3D" $add_dracutmodules_l"
 [[ $add_drivers_l ]] && add_drivers+=3D" $add_drivers_l"
=2D-=20
1.6.4.4


--Boundary-00=_P9PPMEAeT+sB49l
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-bootchartd-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-bootchartd-support.patch"

=46rom 325eac162cb35d76e50633796b086ab3a0dcd475 Mon Sep 17 00:00:00 2001
=46rom: Frederic Crozat <fcrozat-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Date: Wed, 14 Jul 2010 01:50:55 +0200
Subject: [PATCH 2/3] bootchartd support

add preliminary bootchard support

Signed-off-by: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 modules.d/00bootchartd/check   |    2 ++
 modules.d/00bootchartd/install |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/00bootchartd/check
 create mode 100644 modules.d/00bootchartd/install

diff --git a/modules.d/00bootchartd/check b/modules.d/00bootchartd/check
new file mode 100644
index 0000000..b691465
=2D-- /dev/null
+++ b/modules.d/00bootchartd/check
@@ -0,0 +1,2 @@
+#!/bin/sh
+[ -x /sbin/bootchartd ]
diff --git a/modules.d/00bootchartd/install b/modules.d/00bootchartd/install
new file mode 100644
index 0000000..ff29de0
=2D-- /dev/null
+++ b/modules.d/00bootchartd/install
@@ -0,0 +1,15 @@
+#!/bin/bash
+
+inst /sbin/bootchartd=20
+inst /bin/bash=20
+ln -s /init "${initdir}/sbin/init"
+mkdir -p /lib/bootchart/
+inst /lib/bootchart/bootchart-collector=20
+inst /etc/bootchartd.conf=20
+inst /sbin/accton=20
+inst /usr/bin/pkill /bin/pkill
+inst /bin/echo
+inst /bin/grep=20
+inst /bin/usleep
+inst /usr/bin/[  /bin/[
+mknod -m 0666 "${initdir}/dev/null" c 1 3
=2D-=20
1.6.4.4


--Boundary-00=_P9PPMEAeT+sB49l
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-fix-hostonly-check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-fix-hostonly-check.patch"

=46rom 4a364127faed338ac74e169a077373bd28eb3b41 Mon Sep 17 00:00:00 2001
=46rom: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 14 Jul 2010 01:57:19 +0200
Subject: [PATCH 3/3] fix hostonly check

this bugfix fixes chrooted hostonly check by checking fstab instead of
mount

Signed-off-by: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 modules.d/95nfs/check |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/95nfs/check b/modules.d/95nfs/check
index f72aaae..3dad486 100755
=2D-- a/modules.d/95nfs/check
+++ b/modules.d/95nfs/check
@@ -4,7 +4,7 @@
=20
 # If hostonly was requested, fail the check if we are not actually
 # booting from root.
=2D[ "$1" =3D "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
+[ "$1" =3D "-h" ] && ! egrep -q '\s/\s+nfs[34]?\s' /etc/fstab && exit 1
=20
 # If our prerequisites are not met, fail anyways.
 which rpcbind >/dev/null 2>&1 || which portmap >/dev/null 2>&1 || exit 1
=2D-=20
1.6.4.4


--Boundary-00=_P9PPMEAeT+sB49l--
