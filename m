From: Lance Albertson <lance-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
Subject: Re: dracut now in Gentoo
Date: Tue, 29 Sep 2009 11:27:52 -0700
Message-ID: <4AC251A8.9070203@osuosl.org>
References: <4AC2379F.2080409@osuosl.org> <4AC24413.7080506@redhat.com> <4AC24478.3050607@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF83A5F82BB0B6C36A0DBE2EE"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AC24478.3050607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF83A5F82BB0B6C36A0DBE2EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/29/2009 10:31 AM, Harald Hoyer wrote:
> On 09/29/2009 07:29 PM, Harald Hoyer wrote:

>> Very nice, I will try merge your changes from the git :)
>=20
> Ok, pushed the changes.

Outstanding, thanks!

> Btw, switch_root is now in util-linux-ng.

Ah, looks like sys-apps/util-linux in Gentoo is actually util-linux-ng.
I'll fix package so that it deals with this correctly. I missed catching
that during the testing phase. I also plan on making a "git" ebuild so
that folks can test dracut easily on Gentoo from the git checkout.

I'm going to look into seeing about getting dracut support in genkernel
(Gentoo's kernel & initramfs builder) down the road. Having the option
for using it would be great. I'll also see if there are any features
that Gentoo needs specifically in dracut before we can use it more.

Cheers-

--=20
Lance Albertson                                    lance <at> osuosl.org
Systems Administrator / Architect                        Open Source Lab
Network Services                                 Oregon State University
Work: 541-737-9975                                   PGP Key: 0x27F4B742
GPG Fingerprint       0423 92F3 544A 1282 5AB1  4D07 416F A15D 27F4 B742


--------------enigF83A5F82BB0B6C36A0DBE2EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iD8DBQFKwlGpQW+hXSf0t0IRAl2GAJ9d+tvYGMr/z2wDsNJWChRrjEyvswCeMIZB
99riT1FKTT9GQ7B9VxZ7mpM=
=cOWO
-----END PGP SIGNATURE-----

--------------enigF83A5F82BB0B6C36A0DBE2EE--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
