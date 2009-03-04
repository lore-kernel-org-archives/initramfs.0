From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fixes for specfile and Makefile
Date: Wed, 04 Mar 2009 14:48:01 +0100
Message-ID: <49AE8691.60406@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050701040409030309050904"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------050701040409030309050904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050701040409030309050904
Content-Type: text/plain;
 name="0003-fixes-for-specfile-and-Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-fixes-for-specfile-and-Makefile.patch"

From aef710e6c8b749e0931ef5eed5e8588ea83005ea Mon Sep 17 00:00:00 2001
From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 4 Mar 2009 14:23:02 +0100
Subject: [PATCH] fixes for specfile and Makefile

---
 Makefile    |    6 +++---
 dracut.spec |   11 +++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 9441bbe..96cc15c 100644
--- a/Makefile
+++ b/Makefile
@@ -13,9 +13,9 @@ install: all
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
-	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
-	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
-	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
+	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
+	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut/hooks ; done
+	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut/modules ; done
 clean:
 	rm -f *~
 	rm -f switch_root
diff --git a/dracut.spec b/dracut.spec
index 04590cd..ec19f1b 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -1,4 +1,4 @@
-%define gittag c0815e4e
+%define gittag 711c732b
 Name: dracut
 Version: 0.0
 Release: 1.git%{gittag}%{?dist}
@@ -22,7 +22,6 @@ Requires: mount
 Requires: bash
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
-BuildArch: noarch
 
 %description
 dracut is an attempt to build a new, event-driven initramfs infrastructure 
@@ -59,8 +58,12 @@ rm -rf $RPM_BUILD_ROOT
 /usr/libexec/dracut/functions
 /usr/libexec/dracut/init
 /usr/libexec/dracut/switch_root
-/usr/libexec/dracut/rules.d
-
+%dir /usr/libexec/dracut/rules.d
+/usr/libexec/dracut/rules.d/*.rules
+%dir /usr/libexec/dracut/modules
+/usr/libexec/dracut/modules/*.sh
+%dir /usr/libexec/dracut/hooks
+/usr/libexec/dracut/hooks/*.sh
 
 
 %changelog
-- 
1.6.0.6



--------------050701040409030309050904--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
