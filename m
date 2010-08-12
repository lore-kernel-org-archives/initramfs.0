From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH] Fix autodetection of UNICODE keymap
Date: Thu, 12 Aug 2010 21:26:04 +0400
Message-ID: <201008122126.09007.arvidjaar@mail.ru>
References: <4C63D629.4040204@redhat.com> <E1OjWGr-0004HZ-00.arvidjaar-mail-ru@f169.mail.ru> <4C63E8EC.7040507@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4393236.8JdZBrvJbF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C63E8EC.7040507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org

--nextPart4393236.8JdZBrvJbF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 12 of August 2010 16:28:28 Harald Hoyer wrote:
> On 08/12/2010 01:48 PM, Andrey Borzenkov wrote:
> > Thu, 12 Aug 2010 13:08:25 +0200 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =
=D0=BE=D1=82 Harald=20
Hoyer<harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> >> On 08/12/2010 01:05 PM, Harald Hoyer wrote:
> >>> On 08/11/2010 07:47 PM, Andrey Borzenkov wrote:
> >>>> +
> >>>> + # KEYTABLE is a bit special - it defines base keymap name and
> >>>> UNICODE + # determines whether non-UNICODE or UNICODE version
> >>>> is used +
> >>>> + if [[ ${KEYTABLE} ]]; then
> >>>> + if [[ ${UNICODE} =3D=3D 1 ]]; then
> >>>> + [[ ${KEYTABLE} =3D~ .*\.uni.* ]] ||
> >>>> KEYTABLE=3D${KEYTABLE%.map*}.uni + fi
> >>>> +
> >>>> + KEYMAP=3D${KEYTABLE}
> >>>> + fi
> >>>=20
> >>> On Fedora we would end with:
> >>>=20
> >>> KEYTABLE=3D"de-latin1-nodeadkeys"
> >>>=20
> >>> at
> >>>=20
> >>> KEYMAP=3D"de-latin1-nodeadkeys.uni"
> >>>=20
> >>> which does not exist.
> >=20
> > Could you send me your /etc/sysconfig/keyboard (or where these are
> > defined)?
> >=20
> > So, in other words - you have UTF-8 environment but load
> > non-UNICODE keyboard?
> >=20
> >> Fedora's console_init calls "loadkeys" with "-u", if its LANG has
> >> .UTF-8
> >=20
> > It does not help here, unfortunately. Which version of initscripts
> > is it? --
>=20
> http://git.fedorahosted.org/git/?p=3Dinitscripts.git;a=3Dblob;f=3Dsrc/con=
so
> le_init.c
>=20
> It's been like this forever...
>=20
> http://git.fedorahosted.org/git/?p=3Dinitscripts.git;a=3Dhistory;f=3Dsrc/=
co
> nsole_init.c
>=20
> # loadkeys -u de-latin1-nodeadkeys
> Loading /lib/kbd/keymaps/i386/qwertz/de-latin1-nodeadkeys.map.gz

OK, so

=2D KEYTABLE handling is Mandriva specific patch. Sorry for confusion
=2D loadkeys -u fails misereably for all Russian keymaps that use 8 bit=20
character set. This is generic kbd issue that is not easy to fix (in=20
short - loadkeys treats all single byte characters as latin1. So it=20
converts into UNICODE just fine - but not Russian UNICODE, rather Latin=20
one ...).=20

This means there is no way to have single Russian keymap that works=20
either in 8 bit or UTF-8 character sets. But Mandriva tools use single=20
KEYTABLE for defining keyboard layout ...

I think I just leave it as distro-specific patch for now then.

--nextPart4393236.8JdZBrvJbF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxkLq0ACgkQR6LMutpd94yalwCgi6UahRVyvJLR3Yh5+3Gv8IfC
dOQAmgMZ4g3Q9vYDdgy4IqXqT5x3WGub
=XHPV
-----END PGP SIGNATURE-----

--nextPart4393236.8JdZBrvJbF--
