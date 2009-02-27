From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Fix Makefile installing in wrong directories
Date: Fri, 27 Feb 2009 11:41:21 +0100
Message-ID: <49A7C351.6060900@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

rules, hooks and modules are installed in $(DESTDIR)/usr/libexec/dracut/
instead of their corresponding sub-directories.

This patch fixes this.

--
 Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index dbc2a7d..c63dddf 100644
--- a/Makefile
+++ b/Makefile
@@ -6,14 +6,14 @@ install:
 	mkdir -p $(DESTDIR)/sbin
 	mkdir -p $(DESTDIR)/usr/libexec/dracut/hooks
 	mkdir -p $(DESTDIR)/usr/libexec/dracut/modules
+	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	install -m 0755 dracut $(DESTDIR)/sbin/dracut
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
-	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
-	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
-	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
-	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
+	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
+	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut/hooks ; done
+	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut/modules ; done
 clean:
 	rm -f *~
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
