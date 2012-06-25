From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/4] man pages: hostonly mode generates host-specific configuration
Date: Mon, 25 Jun 2012 18:32:01 +0200
Message-ID: <1340641923-14477-2-git-send-email-aidecoe@aidecoe.name>
References: <1340641923-14477-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340641923-14477-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

This fact hasn't been mentioned.
---
 dracut.8.asc      |    4 ++--
 dracut.conf.5.asc |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/dracut.8.asc b/dracut.8.asc
index cadd740..bab5996 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -232,8 +232,8 @@ Default:
     This is useful when running dracut from a git checkout.
 
 **-H, --hostonly**::
-    Host-Only mode: Install only what is needed for booting
-    the local host instead of a generic host.
+    Host-Only mode: Install only what is needed for booting the local host
+    instead of a generic host and generate host-specific configuration.
 +
 [WARNING]
 ====
diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index 017a221..d17477d 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -65,7 +65,8 @@ line are not interpreted.
     Strip binaries in the initramfs (default=yes)
 
 *hostonly=*"__{yes|no}__"::
-    Host-Only mode: Install only what is needed for booting the local host instead of a generic host.
+    Host-Only mode: Install only what is needed for booting the local host
+    instead of a generic host and generate host-specific configuration.
 
 *tmpdir=*"__<temporary directory>__"::
     Specify temporary directory to use.
-- 
1.7.8.6
