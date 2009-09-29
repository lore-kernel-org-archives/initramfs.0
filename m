From: Lance Albertson <lance-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
Subject: dracut now in Gentoo
Date: Tue, 29 Sep 2009 09:36:47 -0700
Message-ID: <4AC2379F.2080409@osuosl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB7BD5C12377471AE3896A7C4"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7BD5C12377471AE3896A7C4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I recently attended Linux Plumbers Conf and saw Harald's talk on dracut
which got me interested in getting it into Gentoo. I just committed a
working ebuild for the latest version into the tree [1]. We had to make
a few patches in order to get it to work for us, so I created a branch
of the patches on github [2] for you guys to look at. If you prefer, I
can send the patches directly here. I wasn't the original author for
some of the patches, but you can see the discussion in the original bug
[3]. Specifically 3649a19207 needs some more work to make it more distro
agnostic.

I tested an image on a Gentoo machine and it worked but I haven't fully
tested all of the capabilities yet (I'm planning on doing that soon). If
you have any comments or suggestions for the Gentoo package, please
direct them to me since I'm the new maintainer.

Cheers-

[1] http://packages.gentoo.org/package/sys-kernel/dracut
[2] http://github.com/ramereth/dracut/tree/gentoo-002
[3] http://bugs.gentoo.org/show_bug.cgi?id=3D278442

--=20
Lance Albertson                                    lance <at> osuosl.org
Systems Administrator / Architect                        Open Source Lab
Network Services                                 Oregon State University
Work: 541-737-9975                                   PGP Key: 0x27F4B742
GPG Fingerprint       0423 92F3 544A 1282 5AB1  4D07 416F A15D 27F4 B742


--------------enigB7BD5C12377471AE3896A7C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iD8DBQFKwjefQW+hXSf0t0IRAokoAJ9GOAAcDaeCgIchcvbBlGJajmmOaQCgozRE
IPiNlo/48MQyh4MT1hP3KCM=
=Exwq
-----END PGP SIGNATURE-----

--------------enigB7BD5C12377471AE3896A7C4--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
