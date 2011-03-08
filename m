From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] Make dmsquash-live install the squashfs driver
Date: Tue,  8 Mar 2011 18:35:13 -0500
Message-ID: <1299627317-11145-4-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dmsquash-live uses squashfs, so let's make sure the driver is installed
---
 modules.d/90dmsquash-live/module-setup.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/modules.d/90dmsquash-live/module-setup.sh b/modules.d/90dmsquash-live/module-setup.sh
index 2f46f67..40ec0c1 100755
--- a/modules.d/90dmsquash-live/module-setup.sh
+++ b/modules.d/90dmsquash-live/module-setup.sh
@@ -15,6 +15,10 @@ depends() {
     return 0
 }
 
+installkernel() {
+    instmods squashfs
+}
+
 install() {
     dracut_install umount
     inst dmsetup
-- 
1.7.4
