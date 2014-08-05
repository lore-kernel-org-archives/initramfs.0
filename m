From: "Claudio A. T. Clemens" <asturio-hi6Y0CQ0nG0@public.gmane.org>
Subject: cryptsetup + lvm order and crypt name
Date: Wed, 06 Aug 2014 00:26:09 +0200
Message-ID: <53E15A01.9040604@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IFih9Bb26nTgr4FwgJ5dB6kPjqAq8ulDL"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFih9Bb26nTgr4FwgJ5dB6kPjqAq8ulDL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi there,

I installed a new Debian (7.6) system, where I have a huge crypted
partition. This crypted partition is used as a lvm VG where the actual
Linux partitions are. Everything worked ok, till I installed dracut
(after installing a newer Kernel, which needed dracut). It was version
020, but now I'm using 038. So the Problem is my partitions setup, which
dracut can't handle (or I can't configure it).

If I boot with rd.auto=3D1, then after some time I get a prompt, where I
need to enter the password for decrypting the crypted partition. Then
the boot goes on, but after a while I'm asked again for the password for
the same partition (some Debian init-script), and then I'm stuck there,
since the partition is already in use.

If I boot without rd.auto=3D1, then nothing happens, and after a while I
get a dracut shell. The only way to boot the system is typing the followi=
ng:

- cryptsetup luksOpen /dev/sda5 sda5_crypt
(sda5_crypt is the name I gave to the crypted volume during
installation) Enter password here
- lvm vgscan
- lvm vgchange -ay
- exit

dracut then can boot successfully.

If I give other name in cryptsetup, instead of sda5_crypt, I end again
in the same boot phase, where the password is asked for a second time.
So I suspect, the the "normal" dracut boot is decrypting my /dev/sda5
with another name. The name is given in the /etc/crypttab, but
rd.luks.crypttab=3D1 doesn't help. I think the debian script only search
if there is a decrypted partition with the exact name as in the crypttab.=


I don't know if this order is supported, first decrypt, than lvm.

What should I do? I'm not a dracut hacker (by now).

Thanks for any idea.

Claudio
--=20
         _
+--- ,--(_) -----------------------------------------------------------+
|  _/ ;-._\    Dipl.-Inf. Univ. Claudio Clemens         saucy          |
| (_)(   ) )   asturio at gmx (.) net           GNU/Linux User #79942  |
|   \ ;-'_/    http://asturio.gmxhome.de/begin.html                    |
|    `--(_)    "YE GODS, I HAVE FEET??!"          <- Userfriendly      |
Chegou a conta telefonicAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!!!..


--IFih9Bb26nTgr4FwgJ5dB6kPjqAq8ulDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPhWgIACgkQd4jGrCHoMHo8aQCePjGzDU0Ax+uskCnKPRh46d/A
suoAn31eLuLHQIyD1T3fDr7cLMN/96Rr
=L2AI
-----END PGP SIGNATURE-----

--IFih9Bb26nTgr4FwgJ5dB6kPjqAq8ulDL--
