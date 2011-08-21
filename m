From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 2/2] crypt: changed cmdline arg name from rd.luks.tout to rd.luks.key.tout
Date: Sun, 21 Aug 2011 10:31:59 +0200
Message-ID: <1313915241-sup-8217@raeviah>
References: <loom.20110818T175530-594@post.gmane.org> <1313915200-13079-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1313915520-957697-5399-9626-1-="
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1313915200-13079-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1313915520-957697-5399-9626-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've tested this patch and it works well.  Thank you!  I've just moved
'tout' param to luks.key namespace, because it's a timeout for key
discovery, yes?


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=-1313915520-957697-5399-9626-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJOUMKAAAoJEPATRTHh2/q1SsoH/RqN3PBqwePYDRYE8X+OTuIJ
4zFRFD5/kj4OKgh8hawjMQQvqiZYg5taRxfV43XZ4bAEDGYeChj/cSEyGHFI7Qkf
EZX6XVIQ7lHUMU2r6OJZOIcNq3Y428AxkQpGIo89s/ZggYqy9TUonL7k+9dvB7ul
K0NDa1Je//g9eeqxTC6XrqzxZ5TtS4byC0DWJ2FMMTjS/P3POPeBZMJ5a9Xre1YG
F/pMxVG6dm1htpP/FsOHanvT4MtqJKp0yfRX8z59PA+/98k+pKRLf9hpZ06XdK5+
wSkhBcnI+nEMeUdNwBqoHfTDJWSsu3yWe6eEv5XxNTeb/oHe4ZyxnCikHWzlQqE=
=vUPh
-----END PGP SIGNATURE-----

--=-1313915520-957697-5399-9626-1-=--
