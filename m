From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Fix typo in hook installation.
Date: Thu, 19 Feb 2009 05:00:01 GMT
Message-ID: <200902190500.n1J501Z0016337@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=3Dlinux/kernel/git/davej/dracut.gi=
t;a=3Dcommit;h=3D1c25acaac4f0a4a7360d61ccc76174f44aee6d60
Commit:     1c25acaac4f0a4a7360d61ccc76174f44aee6d60
Parent:     6b0daf2e25a1fcd270eb89dc6b36d7e4432b1ca8
Author:     Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
AuthorDate: Wed Feb 18 13:00:59 2009 -0500
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Wed Feb 18 13:00:59 2009 -0500

    Fix typo in hook installation.
   =20
    Spotted by Fatih A=C5=9F=C4=B1c=C4=B1 <fatih-caicS1wCkhO6A22drWdTBw@public.gmane.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5d48a5f..70d6782 100644
--- a/Makefile
+++ b/Makefile
@@ -12,7 +12,7 @@ install:
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functi=
ons
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/us=
r/libexec/dracut ; done
-	for hooks in hooks/* ; do install -m 0755 $$hook $(DESTDIR)/usr/libex=
ec/dracut ; done
+	for hook in hooks/* ; do install -m 0755 $$hook $(DESTDIR)/usr/libexe=
c/dracut ; done
 	for module in modules/*; do install -m 0755 $$module $(DESTDIR)/usr/l=
ibexec/dracut ; done
 clean:
 	rm -f *~
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
