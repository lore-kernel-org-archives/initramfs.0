From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] deb-pkg: Inhibit initramfs builders if
 CONFIG_BLK_DEV_INITRD is not set
Date: Fri, 15 Nov 2013 03:03:25 +0000
Message-ID: <1384484605.2771.13.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-zmRfuZi4sG3wz0G/3Z4t"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Petr Baudis <pasky@ucw.cz>, linux-kbuild@vger.kernel.org, Thomas Lange <lange@debian.org>, debian-kernel@lists.debian.org, initramfs@vger.kernel.org


--=-zmRfuZi4sG3wz0G/3Z4t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The kernel postinst hook for initramfs-tools will build an initramfs
on installation unless $INITRD is set to 'No'.  make-kpkg generates a
postinst script that sets this variable appropriately, but we don't.
Set it based on CONFIG_BLK_DEV_INITRD.

This should also work with dracut when <http://bugs.debian.org/729622>
is fixed.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 scripts/package/builddeb | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 90e521f..65014e1 100644
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -172,8 +172,15 @@ fi
=20
 # Install the maintainer scripts
 # Note: hook scripts under /etc/kernel are also executed by official Debia=
n
-# kernel packages, as well as kernel packages built using make-kpkg
+# kernel packages, as well as kernel packages built using make-kpkg.
+# make-kpkg sets $INITRD to indicate whether an initramfs is wanted, and
+# so do we; recent versions of dracut and initramfs-tools will obey this.
 debhookdir=3D${KDEB_HOOKDIR:-/etc/kernel}
+if grep -q '^CONFIG_BLK_DEV_INITRD=3Dy' $KCONFIG_CONFIG; then
+	want_initrd=3DYes
+else
+	want_initrd=3DNo
+fi
 for script in postinst postrm preinst prerm ; do
 	mkdir -p "$tmpdir$debhookdir/$script.d"
 	cat <<EOF > "$tmpdir/DEBIAN/$script"
@@ -184,6 +191,9 @@ set -e
 # Pass maintainer script parameters to hook scripts
 export DEB_MAINT_PARAMS=3D"\$*"
=20
+# Tell initramfs builder whether it's wanted
+export INITRD=3D$want_initrd
+
 test -d $debhookdir/$script.d && run-parts --arg=3D"$version" --arg=3D"/$i=
nstalled_image_path" $debhookdir/$script.d
 exit 0
 EOF

--=20
Ben Hutchings
DNRC Motto:  I can please only one person per day.
Today is not your day.  Tomorrow isn't looking good either.

--=-zmRfuZi4sG3wz0G/3Z4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUoWO/ee/yOyVhhEJAQpmEg//YdzC+ZgFKe/WWlXWHkw9mkhWZKEBJXXI
qw9ZboCESpC2Q0cUTj0G13OL3ymLpbVp3OMDrKnY9LzmZiWn733Xwc51fpLhyIlB
hPgGuMvHto2AAfZ1wERYS3t90BzqehqQ5/lh54SY3Pm/8ltvLdcjmzrXfSeodpmE
ziUruAVyxfTD9vjaVvuMSl2GrkUtAgxMMyrTPKelkhy5phFfATw4WaRMTJ+VzzfX
L9BL3y8NmtFclxu5AFUWR40LqX7eDgwqlj2768VQRg52uaw9PfO+SlMpWah1sz4m
kqzl3TfOnA/gvCHu92NNoQA1uND7rQ6r24JfdYWsodGJ2/zla/O4GoakaJt/H1uC
DcgOZIcAEFjgIypTexQErWXF8xXyK2AhfDiXlNwqq19QUpDxHxm5qVxlkfKfDW7y
oX8TBf2jVpNkcJr0c6Rn6bskzRNGARNIeRdi/E48qNJK7wlSrQyGY0t4o5OcJTds
ySZ+73CpBXsO1SiLyOTYaHWNlNF8pCH5XeuN6t88u8aZxVevUH2QgPD6zCnXocLV
3MZ5oM8n6owK9TXn9s1XbHAFhIgcB9UAD+Fu15rHQs3FOemAWrGIUug4iKqVjQtL
OfIpBDcDxw2d9VuvJ4JKhV7Q5kIa4tecujIeU4je29MG6q+TEm+74eOYfd/BiAUF
jIBC8399HA8=
=1NdF
-----END PGP SIGNATURE-----

--=-zmRfuZi4sG3wz0G/3Z4t--
