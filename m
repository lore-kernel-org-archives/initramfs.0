From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Makefile: use $(MAKE) and $(RM) instead of make and rm -f
Date: Fri, 6 Aug 2010 11:49:50 +0200
Message-ID: <20100806114950.20f8468e@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=Zkd2sUYupnioa7jBaKkicY"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/=Zkd2sUYupnioa7jBaKkicY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

See: http://www.gnu.org/software/make/manual/make.html#MAKE-Variable
---
 Makefile |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index c177275..99044d7 100644
--- a/Makefile
+++ b/Makefile
@@ -54,14 +54,14 @@ ifeq (1,${WITH_SWITCH_ROOT})
 endif
=20
 clean:
-	rm -f *~
-	rm -f */*~
-	rm -f */*/*~
-	rm -f modules.d/99base/switch_root
-	rm -f test-*.img
-	rm -f dracut-*.rpm dracut-*.tar.bz2
-	rm -f $(manpages)
-	make -C test clean
+	$(RM) *~
+	$(RM) */*~
+	$(RM) */*/*~
+	$(RM) modules.d/99base/switch_root
+	$(RM) test-*.img
+	$(RM) dracut-*.rpm dracut-*.tar.bz2
+	$(RM) $(manpages)
+	$(MAKE) -C test clean
=20
 archive: dracut-$(VERSION)-$(GITVERSION).tar.bz2
=20
@@ -91,7 +91,7 @@ check: all
 	@ret=3D0;for i in modules.d/99base/init modules.d/*/*.sh; do \
 		dash -n "$$i" ; ret=3D$$(($$ret+$$?)); \
 	done;exit $$ret
-	make -C test check
+	$(MAKE) -C test check
=20
 testimage: all
 	./dracut -l -a debug -f test-$(shell uname -r).img $(shell uname -r)
--=20
1.7.2

--Sig_/=Zkd2sUYupnioa7jBaKkicY
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxb2sQACgkQ+hU8EsKEdQ2rAgCdGv7A7Gd0H0mGxNSm5WT59UU+
EuMAnRD+ohx/GfRwkmMklVkagcMMDOsj
=JyNk
-----END PGP SIGNATURE-----

--Sig_/=Zkd2sUYupnioa7jBaKkicY--
