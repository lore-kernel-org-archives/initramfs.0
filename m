From: Fatih =?utf-8?q?A=C5=9F=C4=B1c=C4=B1?= <fatih-caicS1wCkhO6A22drWdTBw@public.gmane.org>
Subject: Re: [PATCH 49/50] Modify hook loading to make it slightly easier to script.
Date: Wed, 18 Feb 2009 04:07:40 +0200
Message-ID: <200902180407.44139.fatih@pardus.org.tr>
References: <200902161907.n1GJ7Mrh029004@hera.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1547883.Kl527hQprV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902161907.n1GJ7Mrh029004-Dj75qbTlC0E76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--nextPart1547883.Kl527hQprV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Pazartesi 16 =C5=9Eubat 2009 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=
=C4=B1n=C4=B1z:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for hooks in pre-*/* ; do inst=
all -m 0755 $$hook $(DESTDIR/usr/libexec/dracut ; done
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for hooks in hooks/* ; do inst=
all -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done

Typo here. Must be

for hook in hooks/*


--nextPart1547883.Kl527hQprV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmbbXAACgkQ7iwp/WNlYWlK3ACg1VR3/DFcfPgkFv/ZNmbZRJWf
REoAn0FOTkL05w2dQkQDK/KlTE7NV/L6
=5O6m
-----END PGP SIGNATURE-----

--nextPart1547883.Kl527hQprV--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
