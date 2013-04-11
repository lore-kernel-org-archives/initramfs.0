From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] [40network] Fix ifup.sh to always execute initqueue/online hook after bringing up an interface
Date: Thu, 11 Apr 2013 18:13:13 +0200
Message-ID: <1888619.XKMYbluzRY@ernie>
References: <1365694894-7926-1-git-send-email-devurandom@gmx.net> <5166DA48.20803@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3801096.Tsrb4vQv1b"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5166DA48.20803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart3801096.Tsrb4vQv1b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 11. April 2013, 17:44:08 schrieb Harald Hoyer:
> IIRC, that is done, as soon as the dhcp client gets an IP

These patches are already a few months old, so dracut's behaviour may very 
well have changed in the meantime. Where does what you describe happen?

--Dennis
--nextPart3801096.Tsrb4vQv1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlFm4RkACgkQjqfyF1DtJW6G3gCfdFTygF/AefposhryWQj1vgrI
PB8An13ViFCPWgQF1zT5wrqCesSwHXit
=ZV8j
-----END PGP SIGNATURE-----

--nextPart3801096.Tsrb4vQv1b--
