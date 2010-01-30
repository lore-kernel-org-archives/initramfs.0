From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Pass init argument(s) to real init
Date: Sat, 30 Jan 2010 17:57:45 +0300
Message-ID: <201001301757.49473.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1891021.hXtxym0hVf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart1891021.hXtxym0hVf
Content-Type: multipart/mixed;
  boundary="Boundary-01=_qjEZLPiB7/A1OzS"
Content-Transfer-Encoding: 7bit


--Boundary-01=_qjEZLPiB7/A1OzS
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I was rather surprised why all my attempts to enter single user were not=20
successful :) Simple patch to collect and pass to real init what _looks_=20
like init arguments.

=2Dandrey

--Boundary-01=_qjEZLPiB7/A1OzS
Content-Type: message/rfc822;
  name="initargs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="initargs"

Subject: [PATCH] Pass init argument(s) to real init
From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

Common wisdom to enter single user on Linux is to edit command
line and add "single". This was not possible because switch_root
was always called with empty init arguments. Collect them from
command line and pass to real init when switching root.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/99base/init |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)


diff --git a/modules.d/99base/init b/modules.d/99base/init
index ab033a7..e5158f8 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -259,10 +259,10 @@ done
 
 initargs=""
 
+read CLINE </proc/cmdline
 if getarg init= >/dev/null ; then
     ignoreargs="console BOOT_IMAGE"
     # only pass arguments after init= to the init
-    read CLINE </proc/cmdline
     CLINE=${CLINE#*init=}
     set $CLINE
     shift
@@ -273,6 +273,16 @@ if getarg init= >/dev/null ; then
         initargs="$initargs $x"
     done
     unset CLINE
+else
+    set $CLINE
+    shift
+    for x in "$@"; do
+        case "$x" in
+            [0-9]|s|S|single|emergency|auto )
+                initargs="$initargs $x"
+            ;;
+        esac
+    done
 fi
 
 # Debug: Copy state

--Boundary-01=_qjEZLPiB7/A1OzS--

--nextPart1891021.hXtxym0hVf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktkSOoACgkQR6LMutpd94xzmwCgr13FggX3xhOwe2n8PdHVypjo
y+0AnjA74z4nPkXZD7GSgkyO787HcvFG
=h2Kv
-----END PGP SIGNATURE-----

--nextPart1891021.hXtxym0hVf--
