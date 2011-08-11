From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: dracut: automatically add "unix" kernel module
Date: Fri, 12 Aug 2011 01:01:21 +0200
Message-ID: <1824774.VrzXCv2fyA@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5459658.psUQDruG4A"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart5459658.psUQDruG4A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Dracut currently does not seem to automatically include the "unix" kernel 
module in the initramfs, which causes udev to be unable to start ("address 
family not supported by protocol").

It should be adjusted to include it if possible.

I am using dracut-011 and had to set add_drivers+="unix" in dracut.conf to be 
able to boot my system.

Kind regards,
Dennis
--nextPart5459658.psUQDruG4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk5EX0cACgkQjqfyF1DtJW6YIACgmiT+98dkPFLNZ0yExt02LxFS
MMAAoLfSvqOneG3QVB7RVcQyDvM4Lbkz
=Bdt9
-----END PGP SIGNATURE-----

--nextPart5459658.psUQDruG4A--
