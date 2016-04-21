From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v2 2/2]: dracut: 10i18n: support default
 loadkeys/setfont data paths using symbolic links
Date: Thu, 21 Apr 2016 14:34:30 +0200
Message-ID: <1461242070.10934.14.camel@trentalancia.net>
References: <1460387675.2670.21.camel@trentalancia.net>
	 <1460718405.2616.14.camel@trentalancia.net> <5718C48E.4000808@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5718C48E.4000808-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 21/04/2016 at 14.16 +0200, Harald Hoyer wrote:
> On 15.04.2016 13:06, Guido Trentalancia wrote:
> >=20
> > Avoid keymap/font not found error when loadkeys/setfont
> > are compiled with the default data directory path.
> >=20
> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0modules.d/10i18n/module-setup.sh |=C2=A0=C2=A0=C2=A0=C2=A07 +=
++++++
> > =C2=A01 file changed, 7 insertions(+)
> >=20
> > --- dracut-038/modules.d/10i18n/module-setup.sh 2016-04-15
> > 12:58:46.105952161 +0200
> > +++ dracut-038-10i18n-create-usr-share-symlinks-
> > v2/modules.d/10i18n/module-setup.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=
16-04-15
> > 12:59:06.874241231 +0200
> > @@ -100,6 +100,13 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_rules ${moddir}/10-console.rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${kbddir} !=3D=
 "/usr/share" ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_dir /usr/share
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0for _src in $(eval echo {${KBDSUBDIRS}}); do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ! -e "${initdir}/usr/share/${_src}" ] &=
& ln -s
> > "${kbddir}/${_src}" "${initdir}/usr/share/${_src}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install_all_kbd()=C2=A0
>=20
>=20
> Thanks.. pushed


You're welcome.

And, important to note, it's not a bug, it's a robustness feature that =
we added...
