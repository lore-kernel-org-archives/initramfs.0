From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/3] Config file for systemd on Gentoo.
Date: Thu, 26 Jul 2012 09:35:57 +0200
Message-ID: <1343288158-12343-2-git-send-email-aidecoe@aidecoe.name>
References: <1343288158-12343-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343288158-12343-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.conf.d/gentoo-systemd.conf.example |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 dracut.conf.d/gentoo-systemd.conf.example

diff --git a/dracut.conf.d/gentoo-systemd.conf.example b/dracut.conf.d/gentoo-systemd.conf.example
new file mode 100644
index 0000000..00af70b
--- /dev/null
+++ b/dracut.conf.d/gentoo-systemd.conf.example
@@ -0,0 +1,5 @@
+# /etc/dracut.conf.d/gentoo-systemd.conf
+
+# Paths of systemd dirs on Gentoo
+systemdutildir=/usr/lib/systemd
+systemdsystemunitdir=/usr/lib/systemd/system
-- 
1.7.8.6
