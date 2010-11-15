From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 2/3] 90crypt: probe for keydev asynchronously; changed kernel arg
Date: Mon, 15 Nov 2010 18:06:56 +0100
Message-ID: <1289840431-sup-8309@ittemni>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name> <1289553710-7568-2-git-send-email-aidecoe@aidecoe.name> <AANLkTimg81mVgKeJ93y_J52Kud_NaUSB6RLT3wFst7fN@mail.gmail.com> <1289838915-sup-9150@ittemni> <AANLkTin4CecwByk3-EkGQHOGNN3=jrnjwWrh4YzEzC9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1289840816-242054-14036-1985-2-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTin4CecwByk3-EkGQHOGNN3=jrnjwWrh4YzEzC9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1289840816-242054-14036-1985-2-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Andrey Borzenkov's message of Mon Nov 15 17:50:50 +0100 201=
0:
> 2010/11/15 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> > Excerpts from Andrey Borzenkov's message of Sat Nov 13 09:50:54 +0100=
 2010:
> >> 2010/11/12 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> >> [...]
> >> > diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90cryp=
t/cryptroot-ask.sh
> >> [...]
> >> > =C2=A0inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
> >>
> >> As you are currently working on it, could you look into making
> >> cryptroot coexist with plymouth? Currently they fight for
> >> /sbin/cryptroot-ask; I thought about adding minimal plugin support
> >> (i.e. something like /cryptroot-ask.d where modules can drop their
> >> implementation; they will be tried is sequence until some succeeds).=

> >> Then /sbin/cryptroot-ask could be moved to base and be simple wrappe=
r
> >> around this directory.
> >>
> >> Unfortunately I do not currently have ready-to-use infrastructure to=

> >> test this implementation.
> >
> > OK. =C2=A0Thanks for reporting that. =C2=A0Matt Smith has already mer=
ged
> > cryptroot-ask from plymouth to crypt module and it worked well until
> > that my new patch. =C2=A0I'll try to fix the problem.
> =

> Actually I missed this patch, sorry. I'm still not sure how it behaves
> if plymouth binary is available but plymouthd itself is not active/not
> showing splash.

Just look at the commit 7254c24a76d5f5afe4168d513a00756dc85cb460.

Even with my new patch splash shows up.  The problem which appears with
my patch is that when you do rdbreak, boot process terminates as it
should, drops to shell and=E2=80=A6 console hangs (the last is the "featu=
re"
which appears with keydev; I'll investigate on it as soon as will have
some time).
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1289840816-242054-14036-1985-2-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJM4WiwAAoJEPATRTHh2/q1afkH/jsrPlZ4LlBwF/6vNj+cHJrs
Zf1CpGGAHtYgR1o8r+amjNd30EMySmxw9NQ9sAzO9b1BgS47qmsdckWvvwP75t4E
t2/70+paOz3TIGeU5feVq5rA26qKjws8T/Cpz1JlBSve7lGN/nkdVecrUBOqemdc
tVwHP/QXWr2VNbwChLP79OAvrnQR3LyZ+Y8DEEjSDYBBkv9OuaFdIS8RcdLO9UAe
urE+k9qOkcLjShopdkGgWyUBfrMq2CwazD5UoZML8v1/eygMbztjlQRa8oiStwkF
exGMMg/8xvjuqUPYFthK6WD24lwAZKV9rCNj1Rvl3gSDX8QOniAglIA6gkvVJl0=
=0Ptm
-----END PGP SIGNATURE-----

--=-1289840816-242054-14036-1985-2-=--
