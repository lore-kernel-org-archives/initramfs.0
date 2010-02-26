From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] debian: Add xen and uswsusp module
Date: Fri, 26 Feb 2010 15:39:32 +0100
Message-ID: <1267195175-15554-4-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The xen module doesn't yet work on debian unstable. But let's make
sure it gets included.
---
 debian/dracut.dirs    |    2 ++
 debian/dracut.install |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/debian/dracut.dirs b/debian/dracut.dirs
index 87682f0..38462bf 100644
--- a/debian/dracut.dirs
+++ b/debian/dracut.dirs
@@ -1,6 +1,7 @@
 usr/share/dracut
 usr/share/dracut/modules.d/00dash
 usr/share/dracut/modules.d/01fips
+usr/share/dracut/modules.d/60xen
 usr/share/dracut/modules.d/90crypt
 usr/share/dracut/modules.d/90dm
 usr/share/dracut/modules.d/90dmraid
@@ -15,6 +16,7 @@ usr/share/dracut/modules.d/95resume
 usr/share/dracut/modules.d/95rootfs-block
 usr/share/dracut/modules.d/95terminfo
 usr/share/dracut/modules.d/95udev-rules
+usr/share/dracut/modules.d/95uswsusp
 usr/share/dracut/modules.d/95zfcp
 usr/share/dracut/modules.d/95znet
 usr/share/dracut/modules.d/98syslog
diff --git a/debian/dracut.install b/debian/dracut.install
index 75b5fd1..fdb69d2 100644
--- a/debian/dracut.install
+++ b/debian/dracut.install
@@ -5,6 +5,7 @@ dracut-functions	usr/share/dracut
 dracut.conf		etc
 modules.d/00dash		usr/share/dracut/modules.d
 modules.d/01fips		usr/share/dracut/modules.d
+modules.d/60xen			usr/share/dracut/modules.d
 modules.d/90crypt		usr/share/dracut/modules.d
 modules.d/90dm			usr/share/dracut/modules.d
 modules.d/90dmraid		usr/share/dracut/modules.d
@@ -19,6 +20,7 @@ modules.d/95resume		usr/share/dracut/modules.d
 modules.d/95rootfs-block	usr/share/dracut/modules.d
 modules.d/95terminfo		usr/share/dracut/modules.d
 modules.d/95udev-rules		usr/share/dracut/modules.d
+modules.d/95uswsusp		usr/share/dracut/modules.d
 modules.d/95zfcp		usr/share/dracut/modules.d
 modules.d/95znet		usr/share/dracut/modules.d
 modules.d/98syslog		usr/share/dracut/modules.d
-- 
1.7.0
