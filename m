From: Lance Albertson <lance-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
Subject: Re: dracut version 004 tarball missing on SF
Date: Mon, 01 Feb 2010 08:35:30 -0800
Message-ID: <4B6702D2.4020203@osuosl.org>
References: <201001301716.19360.arvidjaar@mail.ru> <4B669ACE.8090504@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig659997C1083114C0FA6F163D"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B669ACE.8090504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig659997C1083114C0FA6F163D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2010 01:11 AM, Harald Hoyer wrote:
> On 01/30/2010 03:16 PM, Andrey Borzenkov wrote:
>> GIT is tagged with 004, but there is still no tarball on SF. Would
>> somebody release it? Thank you!
>=20
> yes, I will..
>=20
> If you want a tgz, you can always click on the "snapshot" link in the
> gitweb.
>=20
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;a=3D=
snapshot;h=3D3ee26913e7c39e0f26fc6dd9e19f6975357f37e5;sf=3Dtgz

That doesn't make it easy for distributions to use unfortunately.
Gentoo's ebuild system doesn't like using the tarball from gitweb as it
changes the checksum on it every time someone downloads it. I'll bump it
soon in Gentoo.

Thanks!

--=20
Lance Albertson                                    lance <at> osuosl.org
Systems Administrator / Architect                        Open Source Lab
Network Services                                 Oregon State University
Work: 541-737-9975                                   PGP Key: 0x27F4B742
GPG Fingerprint       0423 92F3 544A 1282 5AB1  4D07 416F A15D 27F4 B742


--------------enig659997C1083114C0FA6F163D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iD8DBQFLZwLVQW+hXSf0t0IRAnTWAKCm3ut2bkcs1OmR9S0asgMcJQV6NgCfcuLf
jkgjD7rpSjl1ysvYs6ztjCw=
=DDZv
-----END PGP SIGNATURE-----

--------------enig659997C1083114C0FA6F163D--
