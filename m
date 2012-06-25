From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 4/4] 90dmsquash-live: don't source fs-lib.sh as it is not used
Date: Mon, 25 Jun 2012 18:32:03 +0200
Message-ID: <1340641923-14477-4-git-send-email-aidecoe@aidecoe.name>
References: <1340641923-14477-1-git-send-email-aidecoe@aidecoe.name>
 <1340641923-14477-2-git-send-email-aidecoe@aidecoe.name>
 <1340641923-14477-3-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340641923-14477-3-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90dmsquash-live/dmsquash-live-root.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 990a55b..08f2381 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -3,7 +3,6 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
-type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
 
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 
-- 
1.7.8.6
