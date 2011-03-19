From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sat, 19 Mar 2011 18:00:09 +0100
Message-ID: <1300544966-sup-1505@ittemni>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1300554009-792082-29800-5003-17-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1300554009-792082-29800-5003-17-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from jaivuk's message of Sat Mar 19 15:02:09 +0100 2011:
> However when I added rd.luks.key=3D/mykey:abcd-1234 into the grub
> (Instead of abcd-1234 I use real UUID of my key) the boot fails and I
> end up in the dracut shell.
> =

> Here is how my updated kernel parameters look like:
> =

> kernel /vmlinuz-2.6.35.11-83.fc14.i686 ro root=3D/dev/mapper/vg2-lv_roo=
t
> rd.luks.uuid=3Dluks-6508ce25-91d1-469a-9423-7b10ef00754e
> rd.luks.uuid=3Dluks-73608094-4b4d-48bf-99a6-0493aeb7498d
> rd.luks.uuid=3Dluks-9d1124c6-22fe-4572-984b-175c0e307a1f
> rd.luks.uuid=3Dluks-eac11ed2-4136-4f73-bda7-1af1c09fe644
> rd.md.uuid=3Deb005502:33822bc2:b956ad0a:be45f8e0
> rd.md.uuid=3D9ce2b0c0:ed400210:451f5dab:694b56f7
> rd.md.uuid=3D5e644250:1dda1a02:9365481e:4e0aee0a
> rd.md.uuid=3D2e0eedaf:41d79b6b:0bed1099:5adc22ef rd.lvm.lv=3Dvg2/lv_roo=
t
> rd.lvm.lv=3Dvg2/lv_swap rd.dm=3D0 rd.luks.key=3D/mykey:abcd-1234

UUID should be prefixed with UUID=3D, so it should be:

  rd.luks.key=3D/mykey:UUID=3Dabcd-1234

because you can specify labels there, too:

  rd.luks.key=3D/mykey:LABEL=3Dkeys


> The change in dracut seem to be quite turbulent and I hope it will
> settle a bit. It make take me a while to create patch for dracut 008
> and then I can realize you are elsewhere with dracut 009...

Options format is settled with 008. We're not planning any further
changes.


> dracut.kernel man page confuses me as well:
> "If luksdev is given, the specified key will only be applied for that
> LUKS device. Possible values are the same as for keydev. Unless you
> have several LUKS devices, you don't have to specify this parameter."
> =

> I have several luks devices, but one key only. Does it mean I have to
> list them all manually for the key again?

I meant that if you have several luks devices with different keys, you
can specify which key is for which device to avoid unnecessary
decryption of other devices.


> So I have to ask you - what logic is used to mount luks partitions
> with the key on external device in dracut 008?
> (When I modified dracut 005 I had to add delay before USB was checked,
> in dracut 008 USB is checked in the loop but if it fails, it does not
> ask for password, but ends in shell.)

In Dracut 008 devices are probed for key file asynchronously with udev
rules. If device eventually appears, it's probed for key. If key is
found, it's added to the list of possibles keys to try.


> I have this idea how it can be done (when external key is specified)
> I suggest to replace once instance of cryptsetup luksOpen command
> which waits for password and blocks boot proccess
> with two parallel instances which will try to unlock the same luks devi=
ce:
> - first instance will ask user for password - in the same way it is
> done now - cryptsetup luksOpen,
> - second intance will:
> a) monitor keydev in the loop with sleep. Once keydev is mounted and
> the key is found, it will try to unlock luks partition with that key
> and when this is successful,
> b) Then it will kill the crytpsetup process waiting in the first
> instance, first instance will then recheck luks device was
> successfully mounted and boot will continue.
> =

> In my view this can be implemented without any changes in the
> cryptsetup tools. Another option to consider is to try to mount luks
> device based on event comming from udev (once key is attached) - and
> then perform point b) - what do you think?

As said above, it's based on udev since 008.


> In this way once user is asked for password he/she can either enter it
> manually or insert the key.

You suggest that for every luks device Dracut should stop and let the
user decide to choose between key or password?
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1300554009-792082-29800-5003-17-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNhOEZAAoJEPATRTHh2/q1TQ0H/0onJD3noSl+uExHuDhxmn6g
opwv3+p0H0ZghLke5miDv4QEi5TbZ8xd5WhautFiT17GbzxoqpYzctlq448pblQf
j5xrNxGbV+H2DmuplivNHr1GLV/KUHWmUCAwZiDYZNJiVf0uZQiCzhN1jXxCJNZy
bu1VPRh5Ag637wR6BApAPmy9hKuJDyBhY/kEJlYNAXwElyUd2QSs8x3uh+qWw/66
bGZHzRnCi6611RVtJL6icna+qqxn9EATEAnKqRwXp/Rv+SbWaZaVnXMIM3V9hT5I
WaO02XtbB/SQTdJunVis0HkxpYGgeWJ+4hoyfOl7XWCjiMQOzHjyMY8JOqSRpM4=
=26GY
-----END PGP SIGNATURE-----

--=-1300554009-792082-29800-5003-17-=--
