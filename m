From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Ensure UNICODE keyboard layout is functional in emergency shell
Date: Fri, 8 Jan 2010 10:54:55 +0300
Message-ID: <201001081054.55497.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2428649.WF2dbatYxi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart2428649.WF2dbatYxi
Content-Type: multipart/mixed;
  boundary="Boundary-01=_PTuRLnUixByJjcS"
Content-Transfer-Encoding: 7bit


--Boundary-01=_PTuRLnUixByJjcS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The attached patch ensures that keyboard in emergency shell more closely=20
corresponds to live system. I am not sure about UNIKEYTABLE which=20
console_init checks as well - if it is not artifact, it can be easily=20
added as well.

=2Dandrey

--Boundary-01=_PTuRLnUixByJjcS
Content-Type: message/rfc822;
  name="unikbd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="unikbd"

Subject: [PATCH] Ensure UNICODE keyboard layout is functional in emergency shell
From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

/lib/udev/cosole_init will load either non-unicode or unicode versions
of keyboard layout for the same value of KEYMAP depending on language
setting. The simplest solution is to install both versions in initrd;
it does not take much space.

While on it, copy some additional maps to ensure emergency shell
has the same keyboard layout as full system.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/10redhat-i18n/install |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)


diff --git a/modules.d/10redhat-i18n/install b/modules.d/10redhat-i18n/install
index 9f74cf7..3cdd57d 100755
--- a/modules.d/10redhat-i18n/install
+++ b/modules.d/10redhat-i18n/install
@@ -27,12 +27,20 @@ install_local()
             KEYMAP=/etc/sysconfig/console/default.kmap
 	else
             . /etc/sysconfig/keyboard
-            [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
+	    if [[ $KEYTABLE && -d /lib/kbd/keymaps ]]; then
+		[[ $KEYTABLE =~ *.uni ]] && UNIKEYMAP="$KEYTABLE.map" \
+		    || UNIKEYMAP="$KEYTABLE.uni.map"
+		KEYMAP="$KEYTABLE.map"
+	    fi
 	fi
 	if [[ $KEYMAP ]]; then
             [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
             inst loadkeys
             findkeymap $KEYMAP
+            [[ $UNIKEYMAP ]] && findkeymap $UNIKEYMAP
+	    [[ $GRP_TOGGLE ]] && findkeymap $GRP_TOGGLE.map
+	    findkeymap delete.map
+	    findkeymap backspace.map
 
             for FN in $KEYMAPS; do
 		if [ -L $FN ]; then

--Boundary-01=_PTuRLnUixByJjcS--

--nextPart2428649.WF2dbatYxi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktG5M8ACgkQR6LMutpd94zcOQCdEv2bZ+hGdLlzZm6Ag+WJkI6p
35kAmwapatlJkT6mjHeY2A7SJqifJIM7
=vvFY
-----END PGP SIGNATURE-----

--nextPart2428649.WF2dbatYxi--
