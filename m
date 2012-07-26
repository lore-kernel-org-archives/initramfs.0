From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/3] gentoo.conf: set udevdir
Date: Thu, 26 Jul 2012 09:35:58 +0200
Message-ID: <1343288158-12343-3-git-send-email-aidecoe@aidecoe.name>
References: <1343288158-12343-1-git-send-email-aidecoe@aidecoe.name>
 <1343288158-12343-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343288158-12343-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.conf.d/gentoo.conf.example |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.example
index f5aa8ed..411f9a0 100644
--- a/dracut.conf.d/gentoo.conf.example
+++ b/dracut.conf.d/gentoo.conf.example
@@ -1,6 +1,8 @@
 # /etc/dracut.conf.d/gentoo-openrc.conf
 # Dracut config file customized for Gentoo Base System release 2
 
+udevdir=/lib/udev
+
 #
 # Modules
 #
-- 
1.7.8.6
