From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut 005 question
Date: Mon, 14 Mar 2011 12:25:55 +0100
Message-ID: <1300101485-sup-8139@ittemni>
References: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG@mail.gmail.com> <AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1300101955-975312-29800-3030-2-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1300101955-975312-29800-3030-2-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Dracut 005? Keys are supported since 006, IIRC.

Excerpts from jaivuk's message of Mon Mar 14 11:53:59 +0100 2011:
> My root partition and other partitions on the same lvm group mount
> fine, but my second volume group (vg3) is not OK:
> My root partition is configured like that:
> md raid -> luks1 -> LVM vg2 -> filesystem
> =

> My second volume group:
> LVM vg3 -> luks2 -> filesystem

Do you I understand correctly, that you'd like Dracut to mount all
partitions? Or even activate all volume groups? Dracut is meant to mount
root partition and as soon it's done, he switches to it. You cannot
expect it will mount any other stuff. The rest should be done by
system's init scripts.

I have actually a setup, where I have one volume group divided between
two physical devices. Dracut opens only part of it where root is, then
switches to it and the second physical device is activated by init
scripts.
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1300101955-975312-29800-3030-2-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNfftDAAoJEPATRTHh2/q1EEMH/0Y0zFLvo8Z9L6qeqoCMNF0u
gV+19Bd6MvE3Tgn6vYlrT/Hvz/Qbia459TiUAzRhF0LzDOs8P8PhU9Gl4DKrhczf
0sQMeWAl3k1WOXnA3BMyWHmzxqPNuU2uEyqmIkzty8ZwhBnUzLqRvAGu5yR5xl+0
EdJMVuLUB+vu35yToHuHFwI6yIRtPkPTU47hQ0d5/5RGxeNKBNv+6w3sZI6vkRyr
Zp+MsxqYmSF/pOIQHspkqowFp6Pe4c6TpKrmIw2fPwW4pfB07s3BjGoZA036AEuH
c+abF8l411X2wUz86BYC1VBfllu5bPQyyjtvPNrvFvpZ7UImkgKjZNHotxfGW1w=
=fZji
-----END PGP SIGNATURE-----

--=-1300101955-975312-29800-3030-2-=--
