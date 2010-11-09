From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 14:00:29 +0000
Message-ID: <20101109140028.GP19612@vostochny.stro.at>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com> <4CD9102B.7030702@bfh.ch> <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com> <20101109125820.GO19612@vostochny.stro.at> <AANLkTinfZNiQ14XD3OAC8WasnGXi6bcD9WJipvKS0f1S@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinfZNiQ14XD3OAC8WasnGXi6bcD9WJipvKS0f1S-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

[ Please keep mailing list on cc otherwise might get lost or deleted
  in personal mails, thanks. ]

On Tue, Nov 09, 2010 at 02:51:16PM +0100, Jon Ander Hernandez wrote:
> 2010/11/9 maximilian attems <max-U9r9yeDMy7A@public.gmane.org>:
> > On Tue, Nov 09, 2010 at 12:11:58PM +0100, Jon Ander Hernandez wrote=
:
> >> diff -urN dracut/dracut-postinst.d dracut-007/dracut-postinst.d
> >> --- dracut/dracut-postinst.d =A01970-01-01 01:00:00.000000000 +010=
0
> >> +++ dracut-007/dracut-postinst.d =A0 =A0 =A02010-10-21 02:49:45.71=
4564995 +0200
> >> @@ -0,0 +1,4 @@
> >> +#!/bin/bash
> >> +
> >> +version=3D$1
> >> +dracut-update-initramfs -c -k ${version}
> >
> > please have a look at /etc/kernel/postinst.d/initramfs-tools this
> > is far from complete.
>=20
> Ops, I'm sorry I didn't know about those files, I wrote my scripts
> from scratch. I will complete them.

ok cool, if you have questions for them please just ask on mailinglist.

the redirect to stderr is needed as linux images might use debconf.
=20
=20
> >> - Create the man files when building the package. Make
> >> dpkg-buildpackage execute make all, instead of just make.
> >> The override_dh_auto_test line, prevents dpkg-buildpackage from
> >> executing make test.
> >>
> >> diff -urN dracut/debian/rules dracut-007/debian/rules
> >> --- dracut/debian/rules =A0 =A0 =A0 2010-08-09 16:13:51.000000000 =
+0200
> >> +++ dracut-007/debian/rules =A0 2010-10-21 02:49:45.714564995 +020=
0
> >> @@ -1,3 +1,10 @@
> >> =A0#!/usr/bin/make -f
> >>
> >> -include /usr/share/cdbs/1/rules/debhelper.mk
> >> +%:
> >> + =A0 =A0 dh $@
> >> +
> >> +override_dh_auto_build:
> >> + =A0 =A0 dh_auto_build -- all
> >> +
> >> +override_dh_auto_test:
> >> +
> >
> > the changelog vor this change is very confusing,
> > essentialy you change here from a cdbs source package to a dh one.
>=20
> What I'm trying to do is to avoid this error :
>=20
> dh_installman -pdracut
> dracut.8: No such file or directory at /usr/bin/dh_installman line 12=
7.
> make: *** [binary-install/dracut] Error 2
> dpkg-buildpackage: error: fakeroot debian/rules binary gave error exi=
t status 2
>=20
>=20
> From what I understand (I don't have much experience with debian
> packages), dpkg executes "make binary", which doesn't create the man
> files. So I found that using dh and overriding the dh_auto_build I
> could get it to call "make all" instead.

ufff, please look at b5c928d159623f617f872323b7064ebfbf19a269 from
initramfs-tools for a similar switch, you need to fix the control
appropriately:
http://git.debian.org/?p=3Dkernel/initramfs-tools.git;a=3Dcommit;h=3Db5=
c928d159623f617f872323b7064ebfbf19a269


--=20
maks
