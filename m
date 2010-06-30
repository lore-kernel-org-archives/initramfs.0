From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Makefile: installing configs from dracut.conf.d and README
 files
Date: Wed, 30 Jun 2010 21:39:46 +0200
Message-ID: <20100630213946.1dd59b45@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/X/6H0nX7GFOohQVsb2u+1Vj"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/X/6H0nX7GFOohQVsb2u+1Vj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Install configs from dracut.conf.d (in source tree) into
/usr/share/doc/dracut-$(VERSION).  It is so, because the package
maintainer or user should decide which configs should be included by
Dracut.  The configs in dracut.conf.d need to have suffix ".example".
This is so, because we'd like to use configs in Dracut local mode and
not including them all.  Just create symlink like
foo.conf.example -> foo.conf to load it when calling dracut with '-l'.

I've also provided READMEs install for, I hope, users convenience.

(I'm using configs in this way in i18n module.  If it's OK, I'll
prepare final patch with i18n module.)

---
 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index a009b97..8e26b00 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,6 @@
 VERSION=3D006
 GITVERSION=3D$(shell [ -d .git ] && git rev-list  --abbrev-commit  -n 1 HE=
AD  |cut -b 1-8)
+COMPRESS=3Dbzip2 -f
=20
 prefix ?=3D /usr
 datadir ?=3D ${prefix}/share
@@ -7,6 +8,7 @@ pkglibdir ?=3D ${datadir}/dracut
 sysconfdir ?=3D ${prefix}/etc
 sbindir ?=3D ${prefix}/sbin
 mandir ?=3D ${prefix}/share/man
+docdir ?=3D ${prefix}/share/doc/dracut-$(VERSION)
=20
=20
 .PHONY: install clean archive rpm testimage test all check AUTHORS
@@ -28,6 +30,7 @@ install:
 	mkdir -p $(DESTDIR)$(sysconfdir)
 	mkdir -p $(DESTDIR)$(pkglibdir)/modules.d
 	mkdir -p $(DESTDIR)$(mandir)/man{5,8}
+	mkdir -p $(DESTDIR)$(docdir)
 	install -m 0755 dracut $(DESTDIR)$(sbindir)/dracut
 	install -m 0755 dracut-gencmdline $(DESTDIR)$(sbindir)/dracut-gencmdline
 	install -m 0755 dracut-catimages $(DESTDIR)$(sbindir)/dracut-catimages
@@ -38,12 +41,14 @@ ifeq (1,${WITH_SWITCH_ROOT})
 endif
 	install -m 0644 dracut.conf $(DESTDIR)$(sysconfdir)/dracut.conf
 	mkdir -p $(DESTDIR)$(sysconfdir)/dracut.conf.d
+	[ -d dracut.conf.d ] && for f in dracut.conf.d/*.conf.example; do [ -f $$=
f ] && install -m 0644 $$f $(DESTDIR)$(docdir) && $(COMPRESS) $(DESTDIR)$(d=
ocdir)/$$(basename $$f); done || true
 	install -m 0755 dracut-functions $(DESTDIR)$(pkglibdir)/dracut-functions
 	cp -arx modules.d $(DESTDIR)$(pkglibdir)
 	install -m 0644 dracut.8 $(DESTDIR)$(mandir)/man8
 	install -m 0644 dracut-catimages.8 $(DESTDIR)$(mandir)/man8
 	install -m 0644 dracut-gencmdline.8 $(DESTDIR)$(mandir)/man8
 	install -m 0644 dracut.conf.5 $(DESTDIR)$(mandir)/man5
+	for f in README*; do [ -f $$f ] && install -m 0644 $$f $(DESTDIR)$(docdir=
) && $(COMPRESS) $(DESTDIR)$(docdir)/$$(basename $$f); done
 ifeq (1,${WITH_SWITCH_ROOT})
 	rm $(DESTDIR)$(pkglibdir)/modules.d/99base/switch_root
 endif
--=20
1.7.1


--Sig_/X/6H0nX7GFOohQVsb2u+1Vj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwrnYIACgkQ+hU8EsKEdQ1rSQCguXwcW06RNu+KFEZKrv592/mZ
dpwAn1uQuaHUqamk4/GLecBygxpAF2tl
=UBP2
-----END PGP SIGNATURE-----

--Sig_/X/6H0nX7GFOohQVsb2u+1Vj--
