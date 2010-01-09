From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Add user suspend support
Date: Sat, 9 Jan 2010 18:59:15 +0300
Message-ID: <201001091859.15780.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1875571.30lO5jfbKC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart1875571.30lO5jfbKC
Content-Type: multipart/mixed;
  boundary="Boundary-01=_TfKSLauo+Dg2yUB"
Content-Transfer-Encoding: 7bit


--Boundary-01=_TfKSLauo+Dg2yUB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Attached patch adds use mode suspend support. Currently dracut won't=20
resume after s2disk. There are several points that likely need=20
discussion.

1. Command like parsing partially duplicates that of 95resume. Both are=20
using the same parameter resume=3D; and I'd like to make sure each one is=20
self contained in case other module is disabled. Alternative probably is

a) make 95uswsusp install file from 95resume under the same name
b) supply resume=3D parsing like some (library) file outside of these=20
modules and make both of them install it

I do not particular care one way or other except currently dracut stops=20
to ask me whether file should be overwritten. This will break non-
interactive usage.

2. Location of resume binary may well be system dependant

3. Splashed handling is rather biased toward plymouth and how I=20
understand it (i.e. - either splash everywhere or nowhere).

Comments welcome :)

--Boundary-01=_TfKSLauo+Dg2yUB
Content-Type: message/rfc822;
  name="uswsusp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uswsusp"

Subject: [PATCH] Add user suspend support
From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

This patch adds support for user mode suspend to disk. It is installed
in parallel to kernel mode suspend module; either will fail if
system was not suspended using correct tool so next one can be tried.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/95uswsusp/check             |    2 ++
 modules.d/95uswsusp/install           |    6 ++++++
 modules.d/95uswsusp/parse-uswsusp.sh  |   20 ++++++++++++++++++++
 modules.d/95uswsusp/resume-uswsusp.sh |   11 +++++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/95uswsusp/check
 create mode 100755 modules.d/95uswsusp/install
 create mode 100755 modules.d/95uswsusp/parse-uswsusp.sh
 create mode 100755 modules.d/95uswsusp/resume-uswsusp.sh


diff --git a/modules.d/95uswsusp/check b/modules.d/95uswsusp/check
new file mode 100755
index 0000000..ba95479
--- /dev/null
+++ b/modules.d/95uswsusp/check
@@ -0,0 +1,2 @@
+#!/bin/sh
+[ -x /usr/sbin/resume ]
diff --git a/modules.d/95uswsusp/install b/modules.d/95uswsusp/install
new file mode 100755
index 0000000..f8afe3a
--- /dev/null
+++ b/modules.d/95uswsusp/install
@@ -0,0 +1,6 @@
+#!/bin/bash
+inst /usr/sbin/resume
+[ -f /etc/suspend.conf ] && inst /etc/suspend.conf
+
+inst_hook cmdline 10 "$moddir/parse-uswsusp.sh"
+inst_hook mount 10 "$moddir/resume-uswsusp.sh"
diff --git a/modules.d/95uswsusp/parse-uswsusp.sh b/modules.d/95uswsusp/parse-uswsusp.sh
new file mode 100755
index 0000000..7a0925f
--- /dev/null
+++ b/modules.d/95uswsusp/parse-uswsusp.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+if resume=$(getarg resume=) && ! getarg noresume; then 
+    export resume
+else
+    unset resume
+fi
+
+case "$resume" in
+    LABEL=*)
+	resume="$(echo $resume | sed 's,/,\\x2f,g')"
+	resume="/dev/disk/by-label/${resume#LABEL=}" ;;
+    UUID=*)
+	resume="/dev/disk/by-uuid/${resume#UUID=}" ;;
+esac
+
+if splash=$(getarg splash=); then
+    export splash
+else
+    unset splash
+fi
diff --git a/modules.d/95uswsusp/resume-uswsusp.sh b/modules.d/95uswsusp/resume-uswsusp.sh
new file mode 100755
index 0000000..9b18567
--- /dev/null
+++ b/modules.d/95uswsusp/resume-uswsusp.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+case "$splash" in
+    quiet )
+	a_splash="-P splash=y"
+    ;;
+    * )
+	a_splash="-P splash=n"
+    ;;
+esac
+
+/usr/sbin/resume $a_splash "$resume"

--Boundary-01=_TfKSLauo+Dg2yUB--

--nextPart1875571.30lO5jfbKC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktIp9MACgkQR6LMutpd94zjLACeN1/ByXpuHbfHXsm4fWH65g8R
/4QAoKURoMyA8zu7n/AwG5XUjQCBXVwE
=jZYb
-----END PGP SIGNATURE-----

--nextPart1875571.30lO5jfbKC--
