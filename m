From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH] usrmount should skip comments in fstab
Date: Sat, 25 Feb 2012 23:08:51 +0100
Message-ID: <1715374.OIWgrar2Ec@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2267854.smK48NKEAy"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2267854.smK48NKEAy
Content-Type: multipart/mixed; boundary="nextPart1737637.QIuOkid6AQ"
Content-Transfer-Encoding: 7Bit


--nextPart1737637.QIuOkid6AQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi!

Currently usrmount chokes on fstab lines like:
#... /usr ...
It will try to mount "#...", which obviously is wrong.

Attached patch fixes this by skipping over lines beginning with "#". It still 
does not handle cases like " #...", but is enough to work in my case.

Kind regards,
Dennis
--nextPart1737637.QIuOkid6AQ
Content-Disposition: attachment; filename="dracut-usrmount-comments.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="dracut-usrmount-comments.patch"

--- /usr/lib/dracut/modules.d/98usrmount/mount-usr.sh.orig	2012-02-25 22:40:15.122000048 +0100
+++ /usr/lib/dracut/modules.d/98usrmount/mount-usr.sh	2012-02-25 23:00:24.452698091 +0100
@@ -10,6 +10,7 @@
     local _dev _mp _fs _opts _rest _usr_found _ret
     # check, if we have to mount the /usr filesystem
     while read _dev _mp _fs _opts _rest; do
+		[ "$_dev" = "${_dev###}" ] || continue
         if [ "$_mp" = "/usr" ]; then
             case "$_dev" in
                 LABEL=*)

--nextPart1737637.QIuOkid6AQ--

--nextPart2267854.smK48NKEAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk9JW/gACgkQjqfyF1DtJW6VmgCfeua8eD7uvLE7JZlgD5EZoEc8
72cAmwZSTcQFVnBGM6zO8lhGxcDYYfa7
=omt9
-----END PGP SIGNATURE-----

--nextPart2267854.smK48NKEAy--
