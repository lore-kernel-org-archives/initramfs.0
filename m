From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Makefile: Append target files names for man pages.
Date: Wed, 16 Nov 2011 15:17:35 +0100
Message-ID: <1321453055-373-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 Makefile |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 80173a3..454cd8e 100644
--- a/Makefile
+++ b/Makefile
@@ -40,11 +40,11 @@ install: doc
 	install -m 0755 dracut-functions $(DESTDIR)$(pkglibdir)/dracut-functions
 	install -m 0755 dracut-logger $(DESTDIR)$(pkglibdir)/dracut-logger
 	cp -arx modules.d $(DESTDIR)$(pkglibdir)
-	install -m 0644 dracut.8 $(DESTDIR)$(mandir)/man8
-	install -m 0644 dracut-catimages.8 $(DESTDIR)$(mandir)/man8
-	install -m 0644 dracut-gencmdline.8 $(DESTDIR)$(mandir)/man8
-	install -m 0644 dracut.conf.5 $(DESTDIR)$(mandir)/man5
-	install -m 0644 dracut.kernel.7 $(DESTDIR)$(mandir)/man7
+	install -m 0644 dracut.8 $(DESTDIR)$(mandir)/man8/dracut.8 
+	install -m 0644 dracut-catimages.8 $(DESTDIR)$(mandir)/man8/dracut-catimages.8 
+	install -m 0644 dracut-gencmdline.8 $(DESTDIR)$(mandir)/man8/dracut-gencmdline.8 
+	install -m 0644 dracut.conf.5 $(DESTDIR)$(mandir)/man5/dracut.conf.5 
+	install -m 0644 dracut.kernel.7 $(DESTDIR)$(mandir)/man7/dracut.kernel.7 
 
 clean:
 	$(RM) *~
-- 
1.7.8.rc1
