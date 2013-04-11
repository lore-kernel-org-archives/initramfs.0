From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] [40network] Fix ifup.sh to always execute initqueue/online hook after bringing up an interface
Date: Thu, 11 Apr 2013 17:45:36 +0200
Message-ID: <2242674.iHc4GMAWkg@ernie>
References: <1365694894-7926-1-git-send-email-devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4456012.FMUuNiK2kX"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694894-7926-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart4456012.FMUuNiK2kX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

This fix is required for net_add_parse_vars in my "[PATCH 1/2] [40network] Add 
variable parsing framework for network related variables" to work properly. 

The online hook was previously not executed for dhcp enabled interfaces, which 
resulted in my code not being executed.

--Dennis
--nextPart4456012.FMUuNiK2kX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlFm2qAACgkQjqfyF1DtJW7QxwCfYIwok6qTKs/EIGO9xRLLprgj
sXMAn2p0Fh637UEfr1xko93HWMzfIUc+
=9e6d
-----END PGP SIGNATURE-----

--nextPart4456012.FMUuNiK2kX--
