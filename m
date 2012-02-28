From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] usrmount should skip comments in fstab
Date: Tue, 28 Feb 2012 19:05:12 +0100
Message-ID: <3386081.Rui6F9cKcr@ernie>
References: <1715374.OIWgrar2Ec@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2081654.B4OkmtvBP9"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1715374.OIWgrar2Ec@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2081654.B4OkmtvBP9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 25. Februar 2012, 23:08:51 schrieb Dennis Schridde:
> It still does not handle cases like " #...", but is enough to work in my
> case.
This is not true if IFS contains the usual whitespaces, in which case read 
will already strip whitespace. So the patch should be safe for all cases.
--nextPart2081654.B4OkmtvBP9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk9NF1gACgkQjqfyF1DtJW5EggCfVC4DisGnD4kP1MqMcOT/zl9R
mxwAn2ixOaIapmqxx1ny0REKkTuJDbqv
=MZYc
-----END PGP SIGNATURE-----

--nextPart2081654.B4OkmtvBP9--
