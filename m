From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] dracut, dracut-functions: better vercmp; credits go to
 V. Lowther
Date: Fri, 11 Jun 2010 21:57:04 +0200
Message-ID: <20100611215704.283c46c0@etiriah.ds.pg.gda.pl>
References: <20100611211034.609135f8@etiriah.ds.pg.gda.pl>
	<201006112023.01475.adam@spra.gg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ri7lpI.YJLR.p5m1.=Vf_sz"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006112023.01475.adam-2iSS7ArDF14@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/ri7lpI.YJLR.p5m1.=Vf_sz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>:
> On Friday 11 Jun 2010 20:10:34 Amadeusz =C5=BBo=C5=82nowski wrote:
> > diff --git a/dracut b/dracut
> > index 139d0e0..3b1e7e8 100755
> > --- a/dracut
> > +++ b/dracut
> > @@ -184,7 +184,7 @@ abs_outfile=3D$(readlink -f "$outfile") &&
> > outfile=3D"$abs_outfile"
> >=20
> >  srcmods=3D"/lib/modules/$kernel/"
	> >  [[ $drivers_dir ]] && {
> > -    if verlt $(modprobe --version | cut -d' ' -f3) 3.7; then
> > +    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.5; then
> >          derror 'To use --kmoddir option module-init-tools >=3D 3.7 is
> > required.' exit 1
> >      fi
>=20
> Which version? 3.7? Or 3.5

3.7. Thanks for being alert!


Cheers,
Amadeusz =C5=BBo=C5=82nowski

--=20
PGP key: 1024D/C284750D

--Sig_/ri7lpI.YJLR.p5m1.=Vf_sz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwSlRAACgkQ+hU8EsKEdQ2nNwCeIXZoSFm2ZtZt0f1bT0AHF3UA
u/kAn3IMSNlaq3oHjLrQXV9Oz60dA4CH
=2NRV
-----END PGP SIGNATURE-----

--Sig_/ri7lpI.YJLR.p5m1.=Vf_sz--
