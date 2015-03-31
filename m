From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 4/4] crypt/parse-crypt.sh: hide encrypted devices from
 systemd timeout warnings.
Date: Wed, 1 Apr 2015 06:59:01 +1100
Message-ID: <20150401065901.6274a650@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/XiDgR1AYVG0zmmgiDPZTpBR"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org

--Sig_/XiDgR1AYVG0zmmgiDPZTpBR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


[I was alerted that you had replied to the list, but not to me.
 I'm not on the list..]

> >=20
> > +    while read _dev _uuid ; do=20
> > +        set_systemd_timeout_for_dev $_dev
> > +    done
>=20
> missing redirector from /etc/crypttab I guess

Sorry about that.  The missing redirector is actually from=20
   /usr/lib/dracut/modules.d/90crypt/block_uuid.map
but that looks like an openSUSE specific thing...

https://build.opensuse.org/package/view_file/openSUSE:13.2/dracut/0144-90cr=
ypt-Fixed-crypttab_contains-to-also-work-with-de.patch?expand=3D1

It should just use /etc/crypttab, but then the "read" needs to change

 while read _mapper _dev _rest; do
    set_systemd_timeout_for_dev $_dev
 done < /etc/crypttab

Thanks,
NeilBrown

--Sig_/XiDgR1AYVG0zmmgiDPZTpBR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRr8hTnsnt1WYoG5AQI6dA/8DUv3JWRQOr2F+3BgfcUIGymfsC1s8GWR
tQkeVlWvpXSqNK6coK6gu686hKbzUHrSo6yM7agxWfunM1vqXrv8CzDPtPu3Y/Qn
LgBijEBsZQ83sq+EbO4TZB0Chcchqfyl3lyrjLESEzKTFDTAohieriZmzxFyp8Qc
x2xWok8xLd9ys6cEeNs4KffplUfcqF41PWm3sLo+ua3NmrAFhRAbrjaldV9psDNC
b7IcEfKOxNeybkBjmMkH2eykOwELm0SvuYPxTKVo9ODSo7O5jHeE4JS56U7iVK/L
K8X6URtbypHZQv6QPe1mPShq2jiFidhsoh3T6nkIjJBTkbaXHFtO2vJd8KO34vFR
SsCdV//Li4pDoOF30kn6UpMEbihtjW0a+mA1tfF+yFPLaKzPOTnJS0eyPMwfcSze
rM8IXqr4K4V/ZS4qVtCfjFKiaKoh81+vGt2fWxnr4HHvsQDuUTzIRXg109LktOM0
GVw8GNMlv5+RffC2XlLrIceasz+NEyIbc0/FIcYUN09ga5i6yIOS/wdn2dGI9YHY
+xWWXYNkynT0MhjzdkCXIBNf3X7dFSAIZ2WJzsMoOdY4cWFx4C+EGkjTjEvZiGg1
wjvBua9ZxJliLUmqhx0SQy243kvk8YN/bmePw0VWYInmKVAxeSjT0ZiNngSiv1wp
NGduzLodWUM=
=1jsv
-----END PGP SIGNATURE-----

--Sig_/XiDgR1AYVG0zmmgiDPZTpBR--
