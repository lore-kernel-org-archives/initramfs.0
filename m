From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: missing rbd module
Date: Tue, 7 Jun 2016 10:42:42 +0200
Message-ID: <769f4a65-85d9-1cf3-e65a-3380d36feb9d@redhat.com>
References: <5731A4E9020000CD0002B5F3@mail.dbknb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5731A4E9020000CD0002B5F3-1jfxMrhkDyKkjWMC6Rhk8g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?Q?Steffen_Wei=c3=9fgerber?= <WeissgerberS-Srp0Ujq4vxI@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 10.05.2016 um 09:07 schrieb Steffen Wei=DFgerber:
> Hello,
>=20
> switching from dracut 043-r2 to 044 I miss the rbd module.
>=20
> Up to 043-r2 I used dracut on gentoo based on portage overlay hacking=
-gentoo
> provided by mad-hacking.net and booting from rbd images provided by o=
ur ceph
> storage cluster worked fine.
>=20
> Since version 044 dracut is available in portage and the overlay seem=
s to be no longer
> available. But now in /usr/lib/dracut/modules.d/ the directory 95rbd =
is missing.
>=20
> Why this is removed? Booting from rbd directly is a cool feature, I t=
hink?
>=20
> Regards
>=20
> Steffen
>=20
>=20
>=20
>=20

must be an add-on ... dracut does not ship 95rbd
please ask your packager/distribution
