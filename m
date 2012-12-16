From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] gentoo.conf: let udevdir= be handled by pkg-config and use udevaltdirs
Date: Sun, 16 Dec 2012 20:05:20 +0100
Message-ID: <1355684720-25274-2-git-send-email-aidecoe@aidecoe.name>
References: <1355684720-25274-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355684720-25274-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

To avoid need of rebuild after udev update/downgrade let udevdir= be set
dynamically with pkg-config.  Use udevaltdirs to search for rules both
in old and new locations.
---
 dracut.conf.d/gentoo.conf.example | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.example
index 1361a30..b78e5c6 100644
--- a/dracut.conf.d/gentoo.conf.example
+++ b/dracut.conf.d/gentoo.conf.example
@@ -1,7 +1,8 @@
 # /etc/dracut.conf.d/gentoo.conf
 # dracut config file customized for Gentoo Base System release 2
 
-udevdir=/lib/udev
+udevdir=
+udevaltdirs="/lib/udev /usr/lib/udev"
 ro_mnt=yes
 
 #
-- 
1.8.0.2
