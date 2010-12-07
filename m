From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: create ldconfig aux cache directory on the initrd
Date: Tue, 07 Dec 2010 12:55:16 +0100
Message-ID: <1291722519-sup-5302@ittemni>
References: <1291686260-32371-1-git-send-email-christian.ch.heinz@gmail.com> <1291715126-sup-971@ittemni> <20101207111133.GA32623@neptun>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1291722916-184981-23315-2263-1-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20101207111133.GA32623@neptun>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1291722916-184981-23315-2263-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Christian Heinz's message of Tue Dec 07 12:11:33 +0100 2010=
:
> > What is the benefit of "falling partially" over "falling completely".=

> > I'm wondering if there shouldn't be check if dracut is run by non-roo=
t
> > and then exit immediately.  Normal user cannot read some files (e.g.
> > /bin/mount), so what's the point?
> =

> Not having read permission for /bin/mount as normal user looks weird to=

> me. I use dracut on Arch Linux, though I also just tested on a Fedora V=
M
> and everything builds/runs just fine without root permissions. Are ther=
e
> any compelling reasons to restrict image generation to root only? Am
> I missing something fundamental?

If it builds just fine with your patch, that's cool.  Maybe it's a good
starting point to consider permissions policy in Gentoo. :-)


Cheers,
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1291722916-184981-23315-2263-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJM/iCkAAoJEPATRTHh2/q1ItUH/iRY/XOLxZRBk8ByaZh1EqBI
IXstzvOZQ2U4jB6P2BQUXPVTsgtcyhM34XZ8J0JAhyr5TJfqZiIic50SJFa0SQ+K
AHexR9BEmnyjgdd9yYfCyZZYfvac3ZrhsU2XtK+tBdYsPzx20urHCfVDYARZ1oLa
17S7NNeRWIwyHmCjfiR5ftzf9vK5axkyVIknHhVpDk0AwPYVfvcn/5Puf2VRCNQn
+iv7YymCKUSu/EUh9ksQWQ2aah4JzNh5awKd6tn1PqiIshKoFliq3pwZWRD8QvMz
tJuhhf7SQMMToutgfj3ipwqVkKkmx+h7mhr3nG1ekiuzc/zeiDsHaq5dIf/MiTA=
=hCDA
-----END PGP SIGNATURE-----

--=-1291722916-184981-23315-2263-1-=--
