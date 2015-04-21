From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] dracut-systemd: ensure grep is installed as needed by
 rootfs-generator
Date: Wed, 22 Apr 2015 09:47:55 +1000
Message-ID: <20150422094755.5707db6f@notabene.brown>
References: <20150409140840.0bb6d59d@notabene.brown>
	<553660CE.7090509@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/gTKyH_4S3e7.CXebi+Y=zB/"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <553660CE.7090509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/gTKyH_4S3e7.CXebi+Y=zB/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2015 16:38:06 +0200 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 09.04.2015 06:08, NeilBrown wrote:
> >=20
> >=20
> > rootfs-generator uses 'grep', but it is not installed in the initramfs =
by=20
> > default. So explicitly install it when installing rootfs-generator.sh
> >=20
> > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> >=20
> > diff --git a/modules.d/98dracut-systemd/module-setup.sh=20
> > b/modules.d/98dracut-systemd/module-setup.sh index=20
> > d9175573c777..780b39a2b4a1 100755 ---=20
> > a/modules.d/98dracut-systemd/module-setup.sh +++=20
> > b/modules.d/98dracut-systemd/module-setup.sh @@ -41,6 +41,7 @@ install(=
) {
> > inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount inst_script=20
> > "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
> >=20
> > +    inst_multiple grep inst_script "$moddir/rootfs-generator.sh"=20
> > $systemdutildir/system-generators/dracut-rootfs-generator
> >=20
> > for i in \
> >=20
>=20
> I removed the usage of "grep" from  rootfs-generator.sh for this simple c=
ase
> of finding a string in a small file.
>=20
> <http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=3Dd3d52b20e=
9374a6553c7a6cbe9ff0a9e08df10f9>

Just as good.  Thanks.

NeilBrown

--Sig_/gTKyH_4S3e7.CXebi+Y=zB/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVTbhtDnsnt1WYoG5AQJfqA/9HJqx5Dpra1avWTlRuo7XTi0JvYpYwqPS
N6WwjHUQX7tUPE2c+0OC8mBaNrALXVLlWDfA2gs7jDWrasCAhY6o1v0hKxHHgtkn
moAklF5zrzRNm0xa1nb6jL2DC/GdKFKYuYlbbxwUdLYSpVED7A0eI6Rni9Z1IfDY
DtlrBB+ynvK/p8KTQJ0ANcBw9Stmb769bsvb+K+tQtQ8w4N1uJjBhArIxW1YRSqy
ipH9SKvfoadMucYjwgaiG8hyjrDWEd5/vUvR2fnVJoDpqgoqg1gPM4MYMB/xFLJ6
T/ODASSdmP+f9riVnyMX1ZwbZLPmoi8OUSCbgLLUzhHF1Y3r80aNT/X849NAuqtl
5jkdEziyKqA23z+StIWOhE4buelGJJktimkqKHRIgfjXtSVKpgPYMd5zZyQ729bz
5lh3fZq+kwAeukUGtUbFK5TRsnwsRvia3dgqU3xfhGespN5BFgpw8VYvzrI0Ya5O
NzcqHrTipZr0SDjfpZJydN/lqnRP6WZ1ismfzF8ir7WPGyUv123LYz3Q/vSSGB+W
LCNGaQylqsPTNTxNH1rqztgBIzJZZoJxuKEXjY4jTVYLoKAISqplf3L2qHcFBkZz
km8Pf0UnV2Pm00kVvciozVoy6GCgk2XyKh0ZrXb5MrrVTfY7npX7c0mpMNdBGPei
HDAEqrJiSdM=
=0cUO
-----END PGP SIGNATURE-----

--Sig_/gTKyH_4S3e7.CXebi+Y=zB/--
