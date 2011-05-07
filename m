From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut.conf: explain dracutmodules option better
Date: Sat,  7 May 2011 15:28:00 +0200
Message-ID: <1304774880-10312-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.conf |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/dracut.conf b/dracut.conf
index 89ceaab..8684328 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -3,7 +3,9 @@
 logfile=/var/log/dracut.log
 fileloglvl=6
 
-# Specific list of dracut modules to use
+# Exact list of dracut modules to use.  Modules not listed here are not going
+# to be included.  If you only want to add some optional modules use
+# add_dracutmodules option instead.
 #dracutmodules+=""
 
 # Dracut modules to omit
-- 
1.7.5.rc3
