From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 2/3] 90crypt: probe for keydev asynchronously; changed kernel arg
Date: Mon, 15 Nov 2010 17:42:48 +0100
Message-ID: <1289838915-sup-9150@ittemni>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name> <1289553710-7568-2-git-send-email-aidecoe@aidecoe.name> <AANLkTimg81mVgKeJ93y_J52Kud_NaUSB6RLT3wFst7fN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1289839368-929665-14036-488-1-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTimg81mVgKeJ93y_J52Kud_NaUSB6RLT3wFst7fN-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1289839368-929665-14036-488-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Andrey Borzenkov's message of Sat Nov 13 09:50:54 +0100 201=
0:
> 2010/11/12 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> [...]
> > diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/c=
ryptroot-ask.sh
> [...]
> > =C2=A0inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
> =

> As you are currently working on it, could you look into making
> cryptroot coexist with plymouth? Currently they fight for
> /sbin/cryptroot-ask; I thought about adding minimal plugin support
> (i.e. something like /cryptroot-ask.d where modules can drop their
> implementation; they will be tried is sequence until some succeeds).
> Then /sbin/cryptroot-ask could be moved to base and be simple wrapper
> around this directory.
> =

> Unfortunately I do not currently have ready-to-use infrastructure to
> test this implementation.

OK.  Thanks for reporting that.  Matt Smith has already merged
cryptroot-ask from plymouth to crypt module and it worked well until
that my new patch.  I'll try to fix the problem.
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1289839368-929665-14036-488-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJM4WMIAAoJEPATRTHh2/q1HRUIAJG9budze51V6K1J6n6bL/Gi
S4LBdhkR958/zFLDCy9jdmWNvjSPLPa5ngtXv62vmYcYR101nhK/qZ3epeYoKmVx
8Y/QNlNJ9RegKLapXzHtGyxOX0FWZH9V7TLuU4voznr88+VBfTB2gZpHOZ7QWfQ4
IH9D3WIAVL1nTBDHg6fwadILSYuUlGlLORWrrfUZJ0WEKTZvaH1YMWO7g8zLmwwI
eZpWAb5k8fDJhVhBjel+J5feD8A3sdqF71trsOPSQeK5RwhrMUyGH76SORrdWEuU
2Nd2pQAmmBgveLLnGVnfiFHbgb3z5n06YYb30W02upmpBrWumTSZRZVGTzfo5d0=
=p3Qr
-----END PGP SIGNATURE-----

--=-1289839368-929665-14036-488-1-=--
