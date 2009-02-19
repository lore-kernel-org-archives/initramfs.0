From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: Tainting the initrd
Date: Thu, 19 Feb 2009 18:37:59 +0530
Message-ID: <200902191838.09441.rrs@researchut.com>
References: <t7sv66-dk4.ln1@news.researchut.com> <82ecf08e0902190357l576547f5s5f156c3e9c64a4aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5591541.5Tl9mcuYyY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <82ecf08e0902190357l576547f5s5f156c3e9c64a4aa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart5591541.5Tl9mcuYyY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 19 Feb 2009 17:27:54 Thiago Galesi wrote:
> Well, since the original initrd is vendor provided you could simply
> ask for a md5sum of the current initrd and match it against existing /
> known initrds...

No. The initrd image is generated usually from the post-installation script=
s=20
of kernel packages. These days these are utilities like update-initramfs,=20
which just get called in from the post-installation script of the kernel=20
package.
So there's no way the OS vendor giving an md5sum, because there is no defau=
lt=20
initrd shipped by the OS vendor.

Ritesh
=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."


--nextPart5591541.5Tl9mcuYyY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmdWbIACgkQ4Rhi6gTxMLw/PwCgiDWlZNVk8i/Wcmswkt3U8KZA
2VoAn1kALzrMBgy4q2SUAGbCMPbYJ3mG
=KLmI
-----END PGP SIGNATURE-----

--nextPart5591541.5Tl9mcuYyY--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
