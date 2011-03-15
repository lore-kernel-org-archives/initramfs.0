From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut 005 question
Date: Tue, 15 Mar 2011 11:43:13 +0100
Message-ID: <1300181816-sup-175@ittemni>
References: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG@mail.gmail.com> <AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75@mail.gmail.com> <1300101485-sup-8139@ittemni> <AANLkTik9Q+ga+nvjawVOc4gYdHohwwEN7FYC02Kdmi4H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1300185793-891619-29800-2275-8-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTik9Q+ga+nvjawVOc4gYdHohwwEN7FYC02Kdmi4H-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1300185793-891619-29800-2275-8-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from jaivuk's message of Tue Mar 15 10:25:06 +0100 2011:
> Let me tell you what I want to achieve here - I have a host with
> several luks partitions using the same key and I want them to be
> unlocked by plugging USB stick with the key during the boot and not
> typing the key via the keyboard at any stage.
>
> I managed to install F14 with dracut-006-6.fc14 and I configured
> second key and I assumed it will work. But it didn't. To my surpsire I
> do not see rd_LUKS_KEYDEV_UUID anywhere in the 90crypt/* folder. I
> searched whole modules.d and I did not find it either. So it looks to
> me this version of dracut actually dropped support of key on external
> device entirely?

I don't know how Fedora releases the packages, but support for keys on
external device *started* with 007 [0]. And with 008 [1] parameters
names have changed. With 008 logic of probing devices for key has
changed. You might want to try how it behaves for your case.


> What I would like to do now is to install dracut 008 (or the latest
> version) in my F14 and try my USB key with it. I checked dracut 006
> has dependency on plymouth-scripts, can you please advise me if it is
> the same for dracut 008? Do I have to install latests plymouth-scripts
> or is it optional?
> And can you please give me any hint what is the best way of upgrade
> from 006 to the latest one?

You can try using source package from sf.net.


[0]
http://sourceforge.net/projects/dracut/files/dracut-007.tar.bz2/download

[1]
http://sourceforge.net/projects/dracut/files/dracut-008.tar.bz2/download
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1300185793-891619-29800-2275-8-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNf0LBAAoJEPATRTHh2/q1zHYIAKJxdSeA+AjbhzIA5/3hCG+H
qbsQS++Zao7FejLoqrZjOiO7TbByuQ54y4Jqbvn2f0RDjVwgBfz/KnLT18u5J4ig
f4WxooXmIizkid3M3p8PJp+K3x6WuUO9cB0hwZcUib8rhj5zdhbHatWWRt3NaIIy
CDPPG1i0F1JhyDMzE1Mb7j0GZ2J+Nsk/aq+LeqwKVp2bYBCDZPOJwxWaugtWtDgE
5gXjYuxdKCDG2PdyGdmwzHqrc/BcWlISynE5E74C0Q8MFt66gQN13GuuFQ0Lj91/
ZckN2Pi2r8JFGw3E6uE7t352EFg76rQCdujyNRVm4fuANH6RKJshpXU+GR4lCAU=
=N+RQ
-----END PGP SIGNATURE-----

--=-1300185793-891619-29800-2275-8-=--
