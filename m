From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/3] 95uswsusp: Gentoo path for 'resume' binary
Date: Wed, 9 Jun 2010 10:38:36 +0200
Message-ID: <20100609103836.6d14d542@etiriah.ds.pg.gda.pl>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0mbN7qP_degYZ5wdRTp0.Mh"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609103605.50a6acec-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/0mbN7qP_degYZ5wdRTp0.Mh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/95uswsusp/check   |    2 +-
 modules.d/95uswsusp/install |    7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/modules.d/95uswsusp/check b/modules.d/95uswsusp/check
index ba95479..4b3f8fb 100755
--- a/modules.d/95uswsusp/check
+++ b/modules.d/95uswsusp/check
@@ -1,2 +1,2 @@
 #!/bin/sh
-[ -x /usr/sbin/resume ]
+[ -x /usr/sbin/resume ] || [ -x /usr/lib/suspend/resume ]
diff --git a/modules.d/95uswsusp/install b/modules.d/95uswsusp/install
index f8afe3a..6830763 100755
--- a/modules.d/95uswsusp/install
+++ b/modules.d/95uswsusp/install
@@ -1,5 +1,10 @@
 #!/bin/bash
-inst /usr/sbin/resume
+for bin in /usr/sbin/resume /usr/lib/suspend/resume
+do
+    [ -x "${bin}" ] && break=20
+done
+
+inst "${bin}" /usr/sbin/resume
 [ -f /etc/suspend.conf ] && inst /etc/suspend.conf
=20
 inst_hook cmdline 10 "$moddir/parse-uswsusp.sh"
--=20
1.7.1

--Sig_/0mbN7qP_degYZ5wdRTp0.Mh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwPUwwACgkQ+hU8EsKEdQ10qgCfdPxFQ6D5P8uCxSdwhWP9a7CS
fdwAnRUDXoTbEFkqFpNHjpXyRc7ITjmo
=fufG
-----END PGP SIGNATURE-----

--Sig_/0mbN7qP_degYZ5wdRTp0.Mh--
