From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v8] dracut: add support for custom locale definitions
Date: Sat, 23 Apr 2016 18:47:47 +0200
Message-ID: <1461430067.2604.13.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
	 <1460837622.3201.14.camel@trentalancia.net>
	 <1460838269.3201.18.camel@trentalancia.net>
	 <1461026208.2262.1.camel@trentalancia.net>
	 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
	 <1461341618.21231.0.camel@trentalancia.net> <571B2950.5060209@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571B2950.5060209-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On Sat, 23/04/2016 at 10.50 +0300, Andrei Borzenkov wrote:
> 22.04.2016 19:13, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Compile and install locale definitions using localedef from GNU
> > libc or,
> > if locale definitions cannot be compiled but are available on the
> > system
> > as split definitions, just install them.
> >=20
> > The resulting locale definitions archive contains at most two
> > different
> > locale definitions, therefore its size is relatively small.
> >=20
> > Add support for localised messages from core packages
> > (LC_MESSAGES).
> >=20
> > Add support for non-latin fonts using Unicode (tested successfully
> > with
> > Greek, Hebrew and Cyrillic).
> >=20
> > This revised version fixes several issues in the initial patch
> > (including
> > the possibility to build locale definitions). Thanks to Andrei
> > Borzenkov
> > for reviewing the initial patch and providing useful suggestions.
> >=20
> > Thanks for Harald Hoyer for the full style review and other useful
> > suggestions.
> >=20
> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0NEWS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A0=C2=A0=C2=A04
> > =C2=A0dracut-bash-completion.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A011 +-
> > =C2=A0dracut-init.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A037 ++++++++
> > =C2=A0dracut.8.asc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A08 +
> > =C2=A0dracut.conf.5.asc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0=C2=A014 ++-
> > =C2=A0dracut.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A020 +=
++-
> > =C2=A0modules.d/10i18n/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=
=A01
> > =C2=A0modules.d/10i18n/console_init.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A058 +++++++++-----
> > =C2=A0modules.d/10i18n/module-setup.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0140
> > +++++++++++++++++++++++++++++++++-
> > =C2=A0modules.d/10i18n/parse-i18n.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A08 +
> > =C2=A0modules.d/90crypt/module-setup.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A0=C2=A04
> > =C2=A0modules.d/91crypt-gpg/module-setup.sh |=C2=A0=C2=A0=C2=A0=C2=A0=
4
> > =C2=A0modules.d/99base/init.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A04
> > =C2=A0modules.d/99base/module-setup.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A04
> > =C2=A014 files changed, 279 insertions(+), 38 deletions(-)
> >=20
> > diff -pru dracut-git-orig/dracut.8.asc dracut-git-10i18n-full-
> > support-for-localisation/dracut.8.asc
> > --- dracut-git-orig/dracut.8.asc	2016-04-19
> > 02:19:10.650042399 +0200
> > +++ dracut-git-10i18n-full-support-for-localisation/dracut.8.asc=09
> > 2016-04-21 17:13:53.043188284 +0200
> > @@ -358,6 +358,14 @@ provide a valid _/etc/fstab_.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LVM or an encrypted partition.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[NB --device can be used for compatib=
ility with earlier
> > releases]
> > =C2=A0
> > +**--msg-localisation**::
> > +=C2=A0=C2=A0=C2=A0=C2=A0Include full localisation support for the =
i18n module
> > (slightly increases
> > +=C2=A0=C2=A0=C2=A0=C2=A0the initramfs size).
> > +
>=20
> It is not "full" in any case. You only install message catalogs for
> selected compnents.

It is meant "full" compared to the actual support, which does only
include keyboard localisation. There aren't other standard Linux
localisation features that can be added, so it's full.

Message catalogs can be installed by all components, by using the new
inst_i18n() function, as suggested by Harald.

> > +**--no-msg-localisation**::
> > +=C2=A0=C2=A0=C2=A0=C2=A0Do not include full localisation support f=
or the i18n module
> > (to save
> > +=C2=A0=C2=A0=C2=A0=C2=A0storage space or force the default locale)=
=2E
> > +
> > =C2=A0**-i, --include** _<SOURCE>_ _<TARGET>_::
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include the files in the SOURCE direc=
tory into the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TARGET directory in the final initram=
fs. If SOURCE is a file,
> > it will be
> > diff -pru dracut-git-orig/dracut-bash-completion.sh dracut-git-
> > 10i18n-full-support-for-localisation/dracut-bash-completion.sh
> > --- dracut-git-orig/dracut-bash-completion.sh	2016-04-19
> > 02:19:10.648042373 +0200
> > +++ dracut-git-10i18n-full-support-for-localisation/dracut-bash-
> > completion.sh	2016-04-21 17:16:41.148400079 +0200
> > @@ -28,11 +28,12 @@ _dracut() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--ro-mnt --force --kernel-=
only --no-
> > kernel --strip --nostrip
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--hardlink --nohardlink --=
noprefix
> > --mdadmconf --nomdadmconf
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--lvmconf --nolvmconf --de=
bug --
> > profile --verbose --quiet
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--local --hostonly --no-hosto=
nly --
> > fstab --help --bzip2 --lzma
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--xz --no-compress --gzip --l=
ist-
> > modules --show-modules --keep
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--printsize --regenerate-all =
--
> > noimageifnotneeded --early-microcode
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--no-early-microcode --print-=
cmdline=20
> > --prelink --noprelink --reproducible
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--uefi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--local --hostonly --no-hosto=
nly --
> > fstab --msg-localisation
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--no-msg-localisation --help =
--bzip2=20
> > --lzma --xz --no-compress
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--gzip --list-modules --show-=
modules=20
> > --keep --printsize
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--regenerate-all --
> > noimageifnotneeded --early-microcode
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--no-early-microcode --print-=
cmdline=20
> > --prelink --noprelink
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--reproducible --uefi
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0[ARG]=3D'-a -m -o -d -I -k -c -L --kver --add=20
> > --force-add --add-drivers
> > diff -pru dracut-git-orig/dracut.conf.5.asc dracut-git-10i18n-full-
> > support-for-localisation/dracut.conf.5.asc
> > --- dracut-git-orig/dracut.conf.5.asc	2016-04-19
> > 02:19:10.650042399 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/dracut.conf.5.asc	2016-04-21 17:21:57.576555027
> > +0200
> > @@ -99,9 +99,6 @@ Configuration files must have the extens
> > =C2=A0*hostonly_cmdline=3D*"__{yes|no}__"::
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0If set, store the kernel command line=
 arguments needed in the
> > initramfs
> > =C2=A0
> > -*i18n_install_all=3D*"__{yes|no}__"::
> > -=C2=A0=C2=A0=C2=A0=C2=A0If set to yes, install all available fonts=
 and keyboard files.
> > -
> > =C2=A0*persistent_policy=3D*"__<policy>__"::
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Use _<policy>_ to address disks and p=
artitions.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_<policy>_ can be any directory name =
found in /dev/disk.
> > @@ -196,7 +193,16 @@ provide a valid _/etc/fstab_.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Default is "LatArCyrHeb-16".
> > =C2=A0
> > =C2=A0*i18n_install_all=3D*"__{yes|no}__"::
> > -=C2=A0=C2=A0=C2=A0=C2=A0Install everything regardless of generic o=
r hostonly mode.
> > +=C2=A0=C2=A0=C2=A0=C2=A0Install all available fonts and keyboard f=
iles regardless of
> > generic
> > +=C2=A0=C2=A0=C2=A0=C2=A0or hostonly mode.
> > +
> > +*msg-localisation=3D*"__{yes|no}__"::
> > +=C2=A0=C2=A0=C2=A0=C2=A0Add full localisation support (includes me=
ssage-based
> > localisation
> > +=C2=A0=C2=A0=C2=A0=C2=A0and non latin font support).
> > +
>=20
> Are not fonts always installed? I do not see any dependency on this
> setings for fonts installation.

=46onts are installed but non latin characters are not being used, so
there is no full font localisation support.

> > +*no-msg-localisation=3D*"__{yes|no}__"::
> > +=C2=A0=C2=A0=C2=A0=C2=A0Do not add full localisation support (only=
 keyboard
> > localisation
> > +=C2=A0=C2=A0=C2=A0=C2=A0is added): saves some storage space.
> > =C2=A0
> > =C2=A0*reproducible=3D*"__{yes|no}__"::
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Create reproducible images.
> > diff -pru dracut-git-orig/dracut-init.sh dracut-git-10i18n-full-
> > support-for-localisation/dracut-init.sh
> > --- dracut-git-orig/dracut-init.sh	2016-04-19
> > 02:19:10.649042386 +0200
> > +++ dracut-git-10i18n-full-support-for-localisation/dracut-init.sh=09
> > 2016-04-22 18:05:08.033519479 +0200
> > @@ -214,6 +214,43 @@ inst_multiple() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return $_ret
> > =C2=A0}
> > =C2=A0
> > +# Install package translations (message-based localisations)
> > +inst_i18n() {
>=20
> l10n is more common abbreviation for message translations. i18n
> usually
> refers to ability to process non-ASCII characters.

I am following the naming advice from Harald and will keep the current
name (also for consistency with the name of the module).

> > +=C2=A0=C2=A0=C2=A0=C2=A0local _locale_dirs_dup
> > +=C2=A0=C2=A0=C2=A0=C2=A0local _locale_dirs
> > +=C2=A0=C2=A0=C2=A0=C2=A0local _tmppath
> > +=C2=A0=C2=A0=C2=A0=C2=A0[[ $1 ]] || return 1=C2=A0=C2=A0# no packa=
ge name
> > +=C2=A0=C2=A0=C2=A0=C2=A0[ -f /etc/locale.conf ] && . /etc/locale.c=
onf
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ ${LC_ALL} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LC_ALL_LOCALE=
 LC_ALL_CHARMAP < <(echo ${LC_ALL//./ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ ${LANG} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LANG_LOCALE L=
ANG_CHARMAP < <(echo ${LANG//./ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ ${LC_MESSAGES} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LC_MESSAGES_L=
OCALE LC_MESSAGES_CHARMAP < <(echo
> > ${LC_MESSAGES//./ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCA=
LE_SHORT
> > LC_ALL_LOCALE_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LANG_LOCALE} ]] && read LANG_LOCALE_S=
HORT
> > LANG_LOCALE_COUNTRY < <(echo ${LANG_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LC_MESSAGES_LOCALE} ]] && read LC_MES=
SAGES_LOCALE_SHORT
> > LC_MESSAGES_LOCALE_COUNTRY < <(echo ${LC_MESSAGES_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0_locale_dirs_dup=3D"${LC_ALL_LOCALE} ${LAN=
G_LOCALE}
> > ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT}
> > ${LC_MESSAGES_LOCALE_SHORT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0_tmppath=3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0_locale_dirs=3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0for dir in ${_locale_dirs_dup}
> > +=C2=A0=C2=A0=C2=A0=C2=A0do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case $_tmppath in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*\ ${dir}) ;;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*) _locale_dirs=3D"${_tmppath} ${dir}";;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0esac
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_tmppath=3D${_loca=
le_dirs}
> > +=C2=A0=C2=A0=C2=A0=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0for dir in ${_locale_dirs}; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ -d "/usr/share/=
locale/${dir}" ]] && for file in `find
> > "/usr/share/locale/${dir}" -type f -name "$1.mo"`; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_simple "${file}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0done
> > +}
> > +
> > =C2=A0dracut_install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple "$@"
> > =C2=A0}
> > diff -pru dracut-git-orig/dracut.sh dracut-git-10i18n-full-support-
> > for-localisation/dracut.sh
> > --- dracut-git-orig/dracut.sh	2016-04-19 02:19:10.652042425
> > +0200
> > +++ dracut-git-10i18n-full-support-for-localisation/dracut.sh=09
> > 2016-04-21 23:06:34.022740183 +0200
> > @@ -163,6 +163,10 @@ Creates initial ramdisk images for prelo
> > =C2=A0=C2=A0=C2=A0--mount "[MP]"	Same as above, but [DEV], [FSTYPE]=
 and
> > [FSOPTS] are
> > =C2=A0			determined by looking at the current
> > mounts.
> > =C2=A0=C2=A0=C2=A0--add-device "[DEV]"=C2=A0=C2=A0Bring up [DEV] in=
 initramfs
> > +=C2=A0=C2=A0--msg-localisation=C2=A0=C2=A0=C2=A0=C2=A0Add full loc=
alisation support rather than
> > only
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0the minimal keyboard support (default)
> > +=C2=A0=C2=A0--no-msg-localisation Do not add full localisation sup=
port, but
> > only
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0minimal keyboard support
> > =C2=A0=C2=A0=C2=A0-i, --include [SOURCE] [TARGET]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0Include the files in the SOURCE directory
> > into the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Target directory in the final initramfs.
> > @@ -344,6 +348,8 @@ rearrange_params()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long no-hos=
tonly-cmdline \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long persis=
tent-policy: \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long fstab =
\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long msg-localis=
ation \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long no-msg-loca=
lisation \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long help \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long bzip2 =
\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--long lzma \
> > @@ -538,6 +544,10 @@ while :; do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--persistent-=
policy)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0persistent_policy_l=3D"$2";=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
PARMS_TO_ST
> > ORE+=3D" '$2'"; shift;;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--fstab)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0use_fstab_l=3D"yes" ;;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--msg-localisation=
)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
msg_localisation_l=3D"yes" ;;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--no-msg-localisat=
ion)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
msg_localisation_l=3D"no" ;;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-h|--help)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0long_usage; exit 1 ;;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-i|
> > --include)=C2=A0=C2=A0include_src+=3D("$2");=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PARMS_TO_STORE+=3D" '$2'";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0shift;;
> > @@ -730,6 +740,8 @@ stdloglvl=3D$((stdloglvl + verbosity_mod_l
> > =C2=A0[[ $i18n_install_all_l ]] && i18n_install_all=3D$i18n_install=
_all_l
> > =C2=A0[[ $persistent_policy_l ]] &&
> > persistent_policy=3D$persistent_policy_l
> > =C2=A0[[ $use_fstab_l ]] && use_fstab=3D$use_fstab_l
> > +[[ $msg_localisation_l ]] && msg_localisation=3D$msg_localisation_=
l
> > +[[ $msg_localisation_l ]] || msg_localisation=3D"yes"
> > =C2=A0[[ $mdadmconf_l ]] && mdadmconf=3D$mdadmconf_l
> > =C2=A0[[ $lvmconf_l ]] && lvmconf=3D$lvmconf_l
> > =C2=A0[[ $dracutbasedir ]] || dracutbasedir=3D/usr/lib/dracut
> > @@ -1269,10 +1281,10 @@ export initdir dracutbasedir \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mods_to_load \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fw_dir drivers_dir debug no_kernel ke=
rnel_only \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0omit_drivers mdadmconf lvmconf root_d=
ev \
> > -=C2=A0=C2=A0=C2=A0=C2=A0use_fstab fstab_lines libdirs fscks nofsck=
s ro_mnt \
> > -=C2=A0=C2=A0=C2=A0=C2=A0stdloglvl sysloglvl fileloglvl kmsgloglvl =
logfile \
> > -=C2=A0=C2=A0=C2=A0=C2=A0debug host_fs_types host_devs swap_devs ss=
hkey add_fstab \
> > -=C2=A0=C2=A0=C2=A0=C2=A0DRACUT_VERSION udevdir prefix filesystems =
drivers \
> > +=C2=A0=C2=A0=C2=A0=C2=A0use_fstab fstab_lines msg_localisation lib=
dirs fscks \
> > +=C2=A0=C2=A0=C2=A0=C2=A0nofscks ro_mnt stdloglvl sysloglvl filelog=
lvl kmsgloglvl \
> > +=C2=A0=C2=A0=C2=A0=C2=A0logile debug host_fs_types host_devs swap_=
devs sshkey \
> > +=C2=A0=C2=A0=C2=A0=C2=A0add_fstab DRACUT_VERSION udevdir prefix fi=
lesystems drivers \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0systemdutildir systemdsystemunitdir s=
ystemdsystemconfdir \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hostonly_cmdline loginstall \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmpfilesdir
> > diff -pru dracut-git-orig/modules.d/10i18n/console_init.sh dracut-
> > git-10i18n-full-support-for-
> > localisation/modules.d/10i18n/console_init.sh
> > --- dracut-git-orig/modules.d/10i18n/console_init.sh	2016-
> > 04-20 14:11:02.824944921 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/10i18n/console_init.sh	2016-04-22
> > 17:54:50.913345284 +0200
> > @@ -6,6 +6,7 @@ if [ -x $systemdutildir/systemd-vconsole
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$systemdutildir/systemd-vconsole-setu=
p "$@"
> > =C2=A0fi
> > =C2=A0
> > +[ -e /etc/locale.conf ] && . /etc/locale.conf
> > =C2=A0[ -e /etc/vconsole.conf ] && . /etc/vconsole.conf
> > =C2=A0
> > =C2=A0DEFAULT_FONT=3DLatArCyrHeb-16
> > @@ -19,14 +20,14 @@ set_keyboard() {
> > =C2=A0}
> > =C2=A0
> > =C2=A0set_terminal() {
> > -=C2=A0=C2=A0=C2=A0=C2=A0local dev=3D$1
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "${UNICODE}" =3D 1 ]; then
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '\033%%G' >=
&7
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stty -F ${dev} iut=
f8
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "${FONT}" -a =
! "${FONT_MAP}" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/usr/bin/unicode_start "${FONT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0elif [ "${FONT}" -=
a "${FONT_MAP}" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/usr/bin/unicode_start "${FONT}" "${FONT_MAP}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '\033%%@' >=
&7
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stty -F ${dev} -iu=
tf8
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/bin/unicode_s=
top
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0}
> > =C2=A0
> > @@ -44,16 +45,6 @@ set_keymap() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loadkeys -q ${utf_switch} ${KEYMAP} $=
{EXT_KEYMAPS}
> > =C2=A0}
> > =C2=A0
> > -set_font() {
> > -=C2=A0=C2=A0=C2=A0=C2=A0local dev=3D$1; local trans=3D''; local un=
i=3D''
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0[ -z "${FONT}" ] && FONT=3D${DEFAULT_FONT}
> > -=C2=A0=C2=A0=C2=A0=C2=A0[ -n "${FONT_MAP}" ] && trans=3D"-m ${FONT=
_MAP}"
> > -=C2=A0=C2=A0=C2=A0=C2=A0[ -n "${FONT_UNIMAP}" ] && uni=3D"-u ${FON=
T_UNIMAP}"
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0setfont ${FONT} -C ${dev} ${trans} ${uni}
> > -}
> > -
> > =C2=A0dev_close() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec 6>&-
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec 7>&-
> > @@ -74,6 +65,27 @@ devname=3D${dev#/dev/}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit 1
> > =C2=A0}
> > =C2=A0
> > +if [ "${UNICODE}" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ "${UNICODE}" =3D YES -o "${UNICODE}" =
=3D yes -o "${UNICODE}"
> > =3D 1 ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D1
> > +=C2=A0=C2=A0=C2=A0=C2=A0elif [ "${UNICODE}" =3D NO -o "${UNICODE}"=
 =3D no -o "${UNICODE}"
> > =3D 0 ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D0
> > +=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D''
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +fi
> > +if [ ! "${UNICODE}" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0IFS=3D.
> > +=C2=A0=C2=A0=C2=A0=C2=A0set -- $LANG
> > +=C2=A0=C2=A0=C2=A0=C2=A0tail=3D$2
> > +=C2=A0=C2=A0=C2=A0=C2=A0IFS=3D-
> > +=C2=A0=C2=A0=C2=A0=C2=A0set -- $tail
> > +=C2=A0=C2=A0=C2=A0=C2=A0type=3D$1
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ "${type}" =3D "UTF" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D1
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
>=20
> What about LANG=3Den_US.utf8? You probably want "locale charmap" here=
=2E

In my opinion, that will just increase the size (and complexity) of the
initramfs. Also, I am just following the existing code (the same is
done elsewhere).

> > +fi
> > +
> > =C2=A0dev_open ${dev}
> > =C2=A0
> > =C2=A0for fd in 6 7; do
> > @@ -84,9 +96,19 @@ for fd in 6 7; do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0done
> > =C2=A0
> > +# Immediately after booting up, the
> > +# display driver needs to settle,
> > +# otherwise the Unicode mode cannot
> > +# be enabled and the non latin
> > +# characters do not render properly.
> > +if [ -d /usr/share/locale ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [ ! -e /tmp/dracut-vga-init-complete ];=
 then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sleep 2 && :> /tmp=
/dracut-vga-init-complete
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +fi
> > +
> > =C2=A0set_keyboard
> > -set_terminal ${dev}
> > -set_font ${dev}
> > +set_terminal
> > =C2=A0set_keymap
> > =C2=A0
> > =C2=A0dev_close
> > diff -pru dracut-git-orig/modules.d/10i18n/module-setup.sh dracut-
> > git-10i18n-full-support-for-localisation/modules.d/10i18n/module-
> > setup.sh
> > --- dracut-git-orig/modules.d/10i18n/module-setup.sh	2016-
> > 04-22 14:25:26.949983919 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/10i18n/module-setup.sh	2016-04-22
> > 15:42:18.988741282 +0200
> > @@ -4,7 +4,11 @@
> > =C2=A0check() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ "$mount_needs" ]] && return 1
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0require_binaries setfont loadkeys kbd_mode=
 || return 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localisation =3D=3D "yes" ]]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0require_binaries s=
etfont loadkeys kbd_mode unicode_start
> > unicode_stop stty tty tset reset sleep || return 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0require_binaries s=
etfont loadkeys kbd_mode unicode_start
> > unicode_stop || return 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
>=20
> Well, you should move common stuff that is always required outside of
> "if". As soon as you need to modify the same item in two places, you
> are
> bound to make mistakes.

Done, thanks for the suggestion.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0
> > =C2=A0}
> > @@ -27,6 +31,11 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I18N_CONF=3D"/etc/locale.conf"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VCONFIG_CONF=3D"/etc/vconsole.conf"
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0# Core packages: always install the messag=
e-based localisation
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localisation =3D=3D "yes" ]]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CORE_PACKAGES=3D"l=
ibc bash coreutils util-linux e2fsprogs
> > grep sed kbd"
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
>=20
> How custom modules are supposed to extend this list?
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# This is from 10redhat-i18n.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0findkeymap () {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0local MAP=3D$=
1
> > @@ -93,7 +102,11 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install_base() {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple setf=
ont loadkeys kbd_mode stty
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localis=
ation =3D=3D "yes" ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_multiple setfont loadkeys kbd_mode unicode_start
> > unicode_stop stty tty tset reset sleep
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_multiple setfont loadkeys kbd_mode unicode_start
> > unicode_stop
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
>=20
> Same here.

Done.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! dracut_m=
odule_included "systemd"; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst ${moddir}/console_init.sh /lib/udev/console_init
> > @@ -212,11 +225,132 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_simple ${kbddir}/unimaps/${FONT_UNIMAP}.uni
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localis=
ation =3D=3D "yes" ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_ALL} || ${LANG} || ${LC_MESSAGES} ]] &&
> > inst_dir /usr/lib/locale
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Check if we can compile locale definitions
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0command -v localedef > /dev/null && HAS_LOCALEDEF=3Dtrue
> > || HAS_LOCALEDEF=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ ${LC_ALL} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LC_ALL_LOCALE LC_ALL_CHARMAP < <(ech=
o
> > ${LC_ALL//./ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ ${LANG} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LANG_LOCALE LANG_CHARMAP < <(echo ${=
LANG//./
> > })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ ${LC_MESSAGES} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read LC_MESSAGES_LOCALE LC_MESSAGES_CHARM=
AP <
> > <(echo ${LC_MESSAGES//./ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [[ -e /usr/share/i18n/locales/${LC_ALL_LOCALE} ||
> > -e /usr/share/i18n/locales/${LANG_LOCALE} || -e
> > /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HAS_LOCALE_SOURCES=3Dtrue
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HAS_LOCALE_SOURCES=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [[ ${HAS_LOCALEDEF} =3D=3D true &&
> > ${HAS_LOCALE_SOURCES} =3D=3D true ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CAN_BUILD_LOCALE=3Dtrue
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CAN_BUILD_LOCALE=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Generate locale definitions for LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [[ ${LC_ALL} && ${LC_ALL_LOCALE} &&
> > ${LC_ALL_CHARMAP} ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e
> > /usr/share/i18n/locales/${LC_ALL_LOCALE} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0localedef --prefix=3D"${initdir}" -i
> > ${LC_ALL_LOCALE} -f ${LC_ALL_CHARMAP} ${LC_ALL}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Generate locale definitions for LANG
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [[ ${LANG} && ${LANG_LOCALE} && ${LANG_CHARMAP} ]];
> > then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e /usr/shar=
e/i18n/locales/${LANG_LOCALE}
> > ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0localedef --prefix=3D"${initdir}" -i
> > ${LANG_LOCALE} -f ${LANG_CHARMAP} ${LANG}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Generate locale definitions for LC_MESSAGES
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [[ ${LC_MESSAGES} && ${LC_MESSAGES_LOCALE} &&
> > ${LC_MESSAGES_CHARMAP} ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e
> > /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0localedef --prefix=3D"${initdir}" -i
> > ${LC_MESSAGES_LOCALE} -f ${LC_MESSAGES_CHARMAP} ${LC_MESSAGES}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# If locale definitions cannot be built, but compiled
> > split definitions are
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# available, then install them
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ ${CAN_BUILD_LOCALE} =3D=3D false ]; then
>=20
> You set CAN_BUILD_LOCALE if *any* source is found. If some sources
> are
> missing they will be neither compiled nor installed. So you really
> need
> to change logic and simply do for every LC_ALL, LANG, LC_MESSAGES
>=20
> if source exists
> =C2=A0compile
> else if binary exists
> =C2=A0install
>=20
> This actually makes code more clear.

Changed.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${LC_ALL} && -d /usr/lib/locale/${L=
C_ALL}
> > ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -prfL -t "${in=
itdir}/usr/lib/locale/"
> > /usr/lib/locale/${LC_ALL}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${LANG} && -d /usr/lib/locale/${LAN=
G} ]];
> > then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -prfL -t "${in=
itdir}/usr/lib/locale/"
> > /usr/lib/locale/${LANG}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${LC_MESSAGES} && -d
> > /usr/lib/locale/${LC_MESSAGES} ]]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -prfL -t "${in=
itdir}/usr/lib/locale/"
> > /usr/lib/locale/${LC_MESSAGES}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Install individual localisation files for core
> > packages
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[ -e /usr/share/locale/locale.alias ] && inst_simple
> > /usr/share/locale/locale.alias
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_ALL_LOCALE} ]] && inst_dir
> > "/usr/share/locale/${LC_ALL_LOCALE}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LANG_LOCALE} ]] && inst_dir
> > "/usr/share/locale/${LANG_LOCALE}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_MESSAGES_LOCALE} ]] && inst_dir
> > "/usr/share/locale/${LC_MESSAGES_LOCALE}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCALE_SHORT
> > LC_ALL_LOCALE_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LANG_LOCALE} ]] && read LANG_LOCALE_SHORT
> > LANG_LOCALE_COUNTRY < <(echo ${LANG_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_MESSAGES_LOCALE} ]] && read
> > LC_MESSAGES_LOCALE_SHORT LC_MESSAGES_LOCALE_COUNTRY < <(echo
> > ${LC_MESSAGES_LOCALE//_/ })
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_ALL_LOCALE_SHORT} ]] && inst_dir
> > "/usr/share/locale/${LC_ALL_LOCALE_SHORT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LANG_LOCALE_SHORT} ]] && inst_dir
> > "/usr/share/locale/${LANG_LOCALE_SHORT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[[ ${LC_MESSAGES_LOCALE_SHORT} ]] && inst_dir
> > "/usr/share/locale/${LC_MESSAGES_LOCALE_SHORT}"
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0locale_dirs=3D"${LC_ALL_LOCALE} ${LANG_LOCALE}
> > ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT}
> > {LC_MESSAGES_LOCALE_SHORT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0for dir in ${locale_dirs}; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ -d "/usr/share/locale/${dir}" ] && for =
pkg in
> > ${CORE_PACKAGES}; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for file in `find=
 "/usr/share/locale/${dir}"
> > -type f -name "${pkg}.mo"`; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_simple "${file}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0done
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# Install ISO-8859 and Unicode charmap modules from
> > GNU libc
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ -e "${initdir}/lib/ld-linux.so.*" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LIBDIR=3Dlib
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LIBDIR=3Dlib64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
>=20
> What about multi-arch and non-x86 systems? I have both
> /lib/ld-linus.so.* and /lib64/ld-linux.so.* on 64 bit Ubuntu here.

It doesn't matter what you have on the system. What counts here is what
is installed in the initramfs. Initramfs doesn't support both, so it's
either "lib" or "lib64".

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_multiple /usr/${LIBDIR}/gconv/ISO8859-*.so
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if [ ${UNICODE} =3D=3D 1 ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple /usr/${LIBDIR}/gconv/UTF-*.=
so
> > /usr/${LIBDIR}/gconv/UNICODE.so
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
>=20
> And I have none of these files (assuming those files are required,
> can
> you explain where they are used)? I have /usr/lib/x86_64-linux-
> gnu/gconv
> and /usr/lib/i386-linux-gnu/gconv (and /usr/lib32/gconv, not sure how
> they two are related to each other).

If you have a non-standard installation, then it's up to you to submit
a patch to support it. I cannot test your installation and I cannot add
support for all different custom names, so please just wait that the
patch is committed and then submit a patch.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if command -v iconvconfig > /dev/null; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e /usr/${LIBDIR}/gconv/gconv-module=
s ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E "^[[:spac=
e:]]*alias[[:space:]]*ISO[-
> > ]*8859-" /usr/${LIBDIR}/gconv/gconv-modules > /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ ${UNICODE} =3D=
=3D 1 ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0grep -E "^[[:space:]]*alias.*UTF-"
> > /usr/${LIBDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0grep -E "^[[:space:]]*alias.*UNICODE"
> > /usr/${LIBDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E "^[[:spac=
e:]]*module[[:space:]]*ISO[-
> > ]*8859-" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >>
> > /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ ${UNICODE} =3D=
=3D 1 ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0grep -E
> > "^[[:space:]]*module[[:space:]]*UTF-" /usr/${LIBDIR}/gconv/gconv-
> > modules | grep INTERNAL >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0grep -E
> > "^[[:space:]]*module[[:space:]]*UNICODE"
> > /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-
> > modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e /tmp/gcon=
v-modules ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst /tmp/gconv-modules
> > /usr/${LIBDIR}/gconv/gconv-modules && rm -f /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iconvconfig --prefix=3D"${initdir}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -e /usr/${LIBDIR}/gconv/gconv-module=
s.cache
> > ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_simple /usr/=
${LIBDIR}/gconv/gconv-
> > modules.cache
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if dracut_mod=
ule_included "systemd" && [[ -f ${I18N_CONF}
> > ]]; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_simple ${I18N_CONF}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0mksubdirs ${initdir}${I18N_CONF}
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0print_vars LANG LC_ALL LC_MESSAGES >>
> > ${initdir}${I18N_CONF}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if dracut_mod=
ule_included "systemd" && [[ -f
> > ${VCONFIG_CONF} ]]; then
> > diff -pru dracut-git-orig/modules.d/10i18n/parse-i18n.sh dracut-
> > git-10i18n-full-support-for-localisation/modules.d/10i18n/parse-
> > i18n.sh
> > --- dracut-git-orig/modules.d/10i18n/parse-i18n.sh	2016-04-
> > 20 14:11:02.825944933 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/10i18n/parse-i18n.sh	2016-04-19
> > 02:26:46.617644187 +0200
> > @@ -23,11 +23,13 @@ inst_key_val /etc/vconsole.conf FONT_UNI
> > =C2=A0inst_key_val /etc/vconsole.conf UNICODE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A01
> > rd.vconsole.font.unicode UNICODE vconsole.unicode
> > =C2=A0inst_key_val /etc/vconsole.conf EXT_KEYMAP=C2=A0=C2=A0''
> > rd.vconsole.keymap.ext=C2=A0=C2=A0=C2=A0EXT_KEYMAP
> > =C2=A0
> > -inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LANG=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0LANG
> > -inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_ALL=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0LC_ALL
> > -
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LANG=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANG
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_ALL=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_ALL
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_MESSAGES=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_MESSAGES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
LC_MESSAGES
> > +=C2=A0
> > =C2=A0if [ -f /etc/locale.conf ]; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0. /etc/locale.conf
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0export LANG
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0export LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0export LC_MESSAGES
> > =C2=A0fi
> > diff -pru dracut-git-orig/modules.d/10i18n/README dracut-git-
> > 10i18n-full-support-for-localisation/modules.d/10i18n/README
> > --- dracut-git-orig/modules.d/10i18n/README	2016-04-20
> > 14:11:02.826944946 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/10i18n/README	2016-04-19
> > 02:26:46.617644187 +0200
> > @@ -65,6 +65,7 @@ I'm leaving it in case...=C2=A0=C2=A0The followin=
g
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANG
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0LC_MESSAGES
> > =C2=A0
> > =C2=A0If UNICODE variable is not provided, script indicates if UTF-=
8
> > should be
> > =C2=A0used on the basis of LANG value (if it ends with ".utf8" or
> > similar).
> > diff -pru dracut-git-orig/modules.d/90crypt/module-setup.sh dracut-
> > git-10i18n-full-support-for-localisation/modules.d/90crypt/module-
> > setup.sh
> > --- dracut-git-orig/modules.d/90crypt/module-setup.sh	2016-
> > 04-19 02:19:10.662042554 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/90crypt/module-setup.sh	2016-04-21
> > 22:26:38.113859320 +0200
> > @@ -88,6 +88,10 @@ install() {
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_simple "$moddir/crypt-lib.sh" "/=
lib/dracut-crypt-lib.sh"
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localisation =3D=3D "yes" ]]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_i18n cryptset=
up
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
>=20
> Oh, no, you should check for enabled l10n inside of inst_l10n and
> just
> let other modules always install stuff they need. Let core logic
> handle
> enabled stuff.

I have added the check you suggest.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if dracut_module_included "systemd"; =
then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple=
 -o \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$s=
ystemdutildir/system-generators/systemd-
> > cryptsetup-generator \
> > diff -pru dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh
> > dracut-git-10i18n-full-support-for-localisation/modules.d/91crypt-
> > gpg/module-setup.sh
> > --- dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh	20
> > 16-04-19 02:19:10.667042618 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/91crypt-gpg/module-setup.sh	2016-04-
> > 22 18:06:54.504926340 +0200
> > @@ -17,4 +17,8 @@ depends() {
> > =C2=A0install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple gpg
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst "$moddir/crypt-gpg-lib.sh" "/lib=
/dracut-crypt-gpg-lib.sh"
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [[ $msg_localisation =3D=3D "yes" ]]; t=
hen
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_i18n gnupg
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0}
> > diff -pru dracut-git-orig/modules.d/99base/init.sh dracut-git-
> > 10i18n-full-support-for-localisation/modules.d/99base/init.sh
> > --- dracut-git-orig/modules.d/99base/init.sh	2016-04-20
> > 14:11:02.826944946 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/99base/init.sh	2016-04-20
> > 14:02:01.578137511 +0200
> > @@ -8,6 +8,8 @@
> > =C2=A0
> > =C2=A0export -p > /tmp/export.orig
> > =C2=A0
> > +[ -f /etc/locale.conf ] && . /etc/locale.conf
> > +
> > =C2=A0NEWROOT=3D"/sysroot"
> > =C2=A0[ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
> > =C2=A0
> > @@ -323,7 +325,7 @@ for i in $(export -p); do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=3D${i%%=3D*}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ -z "$i" ] && continue
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case $i in
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0root|PATH|HOME|TER=
M|PS4|RD_*)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0root|PATH|HOME|TER=
M|PS4|RD_*|LANG|LC_*)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0:;;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0unset "$i";;
> > diff -pru dracut-git-orig/modules.d/99base/module-setup.sh dracut-
> > git-10i18n-full-support-for-localisation/modules.d/99base/module-
> > setup.sh
> > --- dracut-git-orig/modules.d/99base/module-setup.sh	2016-
> > 04-20 14:11:02.827944958 +0200
> > +++ dracut-git-10i18n-full-support-for-
> > localisation/modules.d/99base/module-setup.sh	2016-04-21
> > 20:01:54.611592039 +0200
> > @@ -26,6 +26,10 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ln -s bash "=
${initdir}/bin/sh" || :)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0if dracut_module_included "i18n"; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst ${moddir}/profile /=
etc/profile
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
>=20
> Where this file comes from? It is not part of this patch?

I have included the file in the latest patch that I am going to post
shortly.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#add common users in /etc/passwd, it =
will be used by nfs/ssh
> > currently
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep '^root:' "$initdir/etc/passwd" 2=
>/dev/null ||
> > echo=C2=A0=C2=A0'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd=
"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep '^nobody:' /etc/passwd >> "$init=
dir/etc/passwd"
> > =CE=9C=CF=8C=CE=BD=CE=BF =CF=83=CF=84=CE=BF dracut-git-10i18n-full-=
support-for-
> > localisation/modules.d/99base: profile
> > diff -pru dracut-git-orig/NEWS dracut-git-10i18n-full-support-for-
> > localisation/NEWS
> > --- dracut-git-orig/NEWS	2016-04-19 02:19:10.648042373 +0200
> > +++ dracut-git-10i18n-full-support-for-localisation/NEWS	201
> > 6-04-21 17:00:46.436792093 +0200
> > @@ -6,6 +6,7 @@ dracut now requires libkmod for the drac
> > =C2=A0dracut.sh:
> > =C2=A0- restorecon final image file
> > =C2=A0- fail hard, if we find modules and modules.dep is missing
> > +- add an option to disable the new full localisation support
> > =C2=A0
> > =C2=A0dracut-functions.sh:
> > =C2=A0- fix check_vol_slaves() volume group name stripping
> > @@ -34,6 +35,9 @@ general initramfs fixes:
> > =C2=A0- call dracut-cmdline-ask.service, if /etc/cmdline.d/*.conf e=
xists
> > =C2=A0- break at switch_root only for bare rd.break
> > =C2=A0
> > +i18n:
> > +- add full localisation support (includes message-based
> > localisation)
> > +
> > =C2=A0dmsquash-live:
> > =C2=A0- fixed livenet-generator execution flag
> > =C2=A0=C2=A0=C2=A0and include only, if systemd is used

Regards,

Guido
