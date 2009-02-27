From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Fix Makefile naming dracut-functions wrong
Date: Fri, 27 Feb 2009 11:44:42 +0100
Message-ID: <49A7C41A.40904@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

dracut functions are install as /dracut/functions instead
as /dracut/dracut-functions.

This patch fixes this.

--
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c63dddf..7874958 100644
--- a/Makefile
+++ b/Makefile
@@ -10,7 +10,7 @@ install:
 	install -m 0755 dracut $(DESTDIR)/sbin/dracut
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
-	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
+	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/dracut-functions
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
 	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut/hooks ; done
 	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut/modules ; done
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
