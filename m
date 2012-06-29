From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/4] 99base: don't require fs-lib to detect rootfstype
Date: Fri, 29 Jun 2012 13:58:19 +0200
Message-ID: <1340971101-1729-2-git-send-email-aidecoe@aidecoe.name>
References: <1340971101-1729-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340971101-1729-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

If fs-lib is not included, no rootfs autodetection is performed.
---
 modules.d/99base/mount-hook.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/mount-hook.sh b/modules.d/99base/mount-hook.sh
index dcf1415..db07866 100755
--- a/modules.d/99base/mount-hook.sh
+++ b/modules.d/99base/mount-hook.sh
@@ -4,7 +4,9 @@
 
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
-type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
+type det_fs >/dev/null 2>&1 || [ -f /lib/fs-lib.sh ] && . /lib/fs-lib.sh
+# If fs-lib is not included use following det_fs replacement.
+type det_fs >/dev/null 2>&1 || det_fs() { echo "${2:-auto}"; }
 
 mountpoint="$1"
 ismounted "$mountpoint" && exit 0
-- 
1.7.8.6
