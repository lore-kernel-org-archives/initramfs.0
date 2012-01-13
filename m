From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Create a symlink for the live image's base loop device
Date: Fri, 13 Jan 2012 04:06:59 -0800
Message-ID: <20120113120659.GT2650@lister.brianlane.com>
References: <1324419753-14324-1-git-send-email-bcl@redhat.com>
 <4F100A64.5050607@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Io0qd97/NjzvBhmu"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F100A64.5050607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--Io0qd97/NjzvBhmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 11:41:40AM +0100, Harald Hoyer wrote:
> On 20.12.2011 23:22, Brian C. Lane wrote:
> > From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >=20
> > It is useful to know that loop device that the live image's / is mounted
> > from. Make a /dev/live-baseloop symlink that points to it.
> > ---
> >  modules.d/90dmsquash-live/dmsquash-live-root |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/9=
0dmsquash-live/dmsquash-live-root
> > index b704139..cb104e4 100755
> > --- a/modules.d/90dmsquash-live/dmsquash-live-root
> > +++ b/modules.d/90dmsquash-live/dmsquash-live-root
> > @@ -200,6 +200,9 @@ if [ -n "$ROOTFLAGS" ]; then
> >      ROOTFLAGS=3D"-o $ROOTFLAGS"
> >  fi
> > =20
> > +if [ -b "$BASE_LOOPDEV" ]; then
> > +    ln -s $BASE_LOOPDEV /dev/live-baseloop
> > +fi
> >  ln -s /dev/mapper/live-rw /dev/root
> >  printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT=
" > $hookdir/mount/01-$$-live.sh
> > =20
>=20
> changed the symlink to /run/initramfs/live-baseloop, because /dev should =
be only
> be maintained by udev and the kernel

Thanks, I wasn't sure exactly what to call it.

--=20
Brian C. Lane | Anaconda Team | IRC: bcl #anaconda | Port Orchard, WA (PST8=
PDT)

--Io0qd97/NjzvBhmu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEVAwUBTxAeYxF+jBaO/jp/AQIxnwf/buKZ5xOWXEQ9pzK6b1PxaSqJqKgAZYQh
nRacDc4OsY/nhC2xNYOF2bShkTIx0ws8zchBYiQnkEzkvFNLMQnSHDaUa6fcCCCt
rWqntmy/qmiU8r78rMuRGwtelNjSctjAOBRVDPd3LFGMtF5scDATPXLwNwGfio+W
8RUEhYp1eLIvH+CJdetJnyBC72Opkxytdo6SRV+oHba144MxvzRM6u5b697XUrXt
3Eb3oRxaUFy2XhkktBZIpcB0Y0LlCRyyBXXMEELqlJROAPIWMvQtdRKettfV7CEg
dNL0Y50B3aPPFa1xxgT2qBfsPEqvg1nrT6pRkzMlOquyBp/RBB2jjg==
=an87
-----END PGP SIGNATURE-----

--Io0qd97/NjzvBhmu--
