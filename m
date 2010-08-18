From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] 60xen: use 'hash' instead of 'type'
Date: Wed, 18 Aug 2010 17:31:03 +0200
Message-ID: <20100818173103.27a444da@aidecoe.name>
References: <20100818172944.3244c1e0@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/1Y13ghjxr1YwB75lKNfhMIK"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100818172944.3244c1e0-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/1Y13ghjxr1YwB75lKNfhMIK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


---
 modules.d/60xen/check   |    9 +++++----
 modules.d/60xen/install |    7 +++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/modules.d/60xen/check b/modules.d/60xen/check
index 49d5435..6b9cabe 100755
--- a/modules.d/60xen/check
+++ b/modules.d/60xen/check
@@ -1,14 +1,15 @@
 #!/bin/bash
=20
 # No Xen-detect? Boo!!
-XENDETECT=3D$(type -P xen-detect)
-[ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] && XENDETECT=3D"/usr/=
lib/xen-default/bin/xen-detect"
-[ -z "$XENDETECT" ] && exit 1
+if ! hash xen-detect 2>/dev/null; then
+    [[ -d /usr/lib/xen-default ]] && \
+        hash -p /usr/lib/xen-default/bin/xen-detect xen-detect || exit 1
+fi
=20
 . $dracutfunctions
 [[ $debug ]] && set -x
=20
 # Yes, we are under Xen PV env.
-$XENDETECT | egrep -q -v 'PV' || exit 0
+xen-detect | grep -q -v PV || exit 0
=20
 exit 1
diff --git a/modules.d/60xen/install b/modules.d/60xen/install
index 22f5329..6ae0060 100755
--- a/modules.d/60xen/install
+++ b/modules.d/60xen/install
@@ -1,6 +1,5 @@
 #!/bin/bash
-XENDETECT=3D$(type -P xen-detect)
-[ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] && XENDETECT=3D"/usr/=
lib/xen-default/bin/xen-detect"
-inst $XENDETECT /sbin/xen-detect
+hash xen-detect 2>/dev/null || \
+    hash -p /usr/lib/xen-default/bin/xen-detect xen-detect
+inst "$(hash -t xen-detect)" /sbin/xen-detect
 inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
-
--=20
1.7.2

--Sig_/1Y13ghjxr1YwB75lKNfhMIK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxr/LcACgkQ+hU8EsKEdQ3NzwCgzyEBpWktqSJkidqGKARu2X0e
7TkAoOQuV2dfxgZKEJxTGqIP03EfUgss
=VDU7
-----END PGP SIGNATURE-----

--Sig_/1Y13ghjxr1YwB75lKNfhMIK--
