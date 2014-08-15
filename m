From: Claudio Clemens <asturio-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: cryptsetup + lvm order and crypt name
Date: Fri, 15 Aug 2014 13:11:25 +0200
Message-ID: <53EDEADD.2070103@gmx.net>
References: <53E15A01.9040604@gmx.net> <871tsuks7j.fsf@freja.aidecoe.name> <53E3E5F9.4040507@gmx.net> <8761i3pi87.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="a8AucioBXJuaiROHvdGA24fUdll8WCr74"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8761i3pi87.fsf-txNSArhcdoZACdk+e2mhCEEMvNT87kid@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a8AucioBXJuaiROHvdGA24fUdll8WCr74
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 08.08.2014 09:12, schrieb Amadeusz =C5=BBo=C5=82nowski:
> First of all I advise to call dracut like that:
>=20
>   dracut -H '' <kernel-version>
>=20
> it will generate host-specific initramfs for specified kernel version i=
n
> default location.  Later edit variable GRUB_CMDLINE_LINUX_DEFAULT in
> /etc/default/grub and put there parameters you want. After that
> regenerate grub2 config with grub2-mkconfig.
>=20
> I hope that helps. :-)

Ok... it was a while now. But I managed to boot my system. The -H flag
wasn't needed. I put the boot configuration Opts in grub, and not
dracut. Just for the documentation of it I have this setup:

In /etc/default/grub
GRUB_CMDLINE_LINUX=3D"rd.auto rd.luks rd.luks.crypttab
rd.luks.uuid=3D83e0aaa5-a8ad-4435-afff-0d52b1071fc3 rd.lvm
rd.lvm.vg=3Dboromir rd.md=3D0 rd.dm"

The only really needed option was rd.auto (maybe other options now
implies rd.auto). But the problem was a conflict between my
installation, Debian's dracut and Debian's cryptsetup.

When I installed my system and encrypted my /dev/sda5, I gave the
encrypted partition the name sda5_crypt. This value was written in
/etc/crypttab. So for accessing the partition at boot-time what is done
is: cryptsetup luksOpen /dev/sda5 sda5_crypt

When booting /etc/init.d/cryptdisks* looks for sda5_crypt, if it is
there, it won't do anything and boot will continue. If it is not there,
it asks for the passphrase and try to decrypt it.

The problem was that dracut, when calling "cryptsetup luksOpen" won't
use the name given in /etc/crypttab, but "luks-<UUID of the partition>".
When /etc/init.d/cryptdisk* comes in, there is no sda5_crypt present, so
it tried to decrypt the partition again, which is not possible, because
it is actually already in use.

My solution for the problem was to rename the decrypt volume in
/etc/crypttab from "sda5_crypt" to "luks-<UUID of /dev/sda5>". So I use
the same name dracut uses when calling cryptsetup and the
Debian-init-scripts finds the device.

I think the elegant solution would be in dracut, which could have a boot
option to the name of the decrypted device (or read it from
/etc/crypttab when creating the image), or the cryptdisks-init-scripts
which could see if the encrypted device is already decrypted, and not
only look if the name is present.

I hope this can help any one with a similar problem.

Thanks for the help,

Claudio

PS - I'll fill then a bug-report/wish for both Debian-Packages so they
are aware of the problem.

--=20
+- .''`. ---| Dipl.-Inf. Univ. Claudio Clemens |-------| wheezy |-----+
| : :' :      asturio at gmx (.) net           GNU/Linux User #79942  |
| `. `'       http://asturio.gmxhome.de/begin.html                    |
|   `-        "YE GODS, I HAVE FEET??!"         <- Userfriendly       |
"I will take the ring, though I do not know the way" Frodo Baggins


--a8AucioBXJuaiROHvdGA24fUdll8WCr74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPt6uwACgkQd4jGrCHoMHpSkwCfRWy+61DwhlrnACyZS7IpfuV7
QNQAnRsXKCfzvm6aH0qQd6BVvmvq+VLx
=W/1c
-----END PGP SIGNATURE-----

--a8AucioBXJuaiROHvdGA24fUdll8WCr74--
