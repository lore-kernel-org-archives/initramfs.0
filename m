From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] add target for "dist" and "gitrpm"
Date: Fri, 19 Jun 2009 14:01:19 +0200
Message-ID: <1245412879-4418-5-git-send-email-harald@redhat.com>
References: <1245412879-4418-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245412879-4418-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

"make gitrpm" creates an rpm from the last git checkin
"make rpm" creates an rpm for the version tagged with $VERSION
"make dist" creates a tarball for the version tagged with $VERSION
---
 Makefile |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e70f309..ae4a9d4 100644
--- a/Makefile
+++ b/Makefile
@@ -37,10 +37,20 @@ clean:
 
 archive: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 
+dist: dracut-$(VERSION).tar.bz2
+
+dracut-$(VERSION).tar.bz2:
+	git archive --format=tar $(VERSION) --prefix=dracut-$(VERSION)/ |bzip2 > dracut-$(VERSION).tar.bz2
+
 dracut-$(VERSION)-$(GITVERSION).tar.bz2:
 	git archive --format=tar HEAD --prefix=dracut-$(VERSION)-$(GITVERSION)/ |bzip2 > dracut-$(VERSION)-$(GITVERSION).tar.bz2
 
-rpm: dracut-$(VERSION)-$(GITVERSION).tar.bz2
+
+rpm: dracut-$(VERSION).tar.bz2
+	rpmbuild --define "_topdir $$PWD" --define "_sourcedir $$PWD" --define "_specdir $$PWD" --define "_srcrpmdir $$PWD" --define "_rpmdir $$PWD" -ba dracut.spec 
+	rm -fr BUILD BUILDROOT
+
+gitrpm: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 	rpmbuild --define "_topdir $$PWD" --define "_sourcedir $$PWD" --define "_specdir $$PWD" --define "_srcrpmdir $$PWD" --define "_rpmdir $$PWD" --define "gittag $(GITVERSION)" -ba dracut.spec 
 	rm -fr BUILD BUILDROOT
 
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
