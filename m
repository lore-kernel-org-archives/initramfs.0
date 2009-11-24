From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] Make sure and get all the multipath related modules.
Date: Tue, 24 Nov 2009 14:52:57 -0500
Message-ID: <1259092378-14143-4-git-send-email-pjones@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259092378-14143-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Install all modules that are any of:
- scsi device handler
- dm log handler
- dm path selector
- dm target

It would be nice if we could tell which log handlers and targets are
multipath related, but we really can't.
---
 modules.d/90multipath/installkernel |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/modules.d/90multipath/installkernel b/modules.d/90multipath/installkernel
index 50c7d6a..4a596f0 100755
--- a/modules.d/90multipath/installkernel
+++ b/modules.d/90multipath/installkernel
@@ -1 +1,8 @@
-instmods dm-multipath dm-round-robin multipath
+#!/bin/bash
+
+mp_mod_test() {
+    local mpfuncs='scsi_register_device_handler|dm_dirty_log_type_register|dm_register_path_selector|dm_register_target'
+    nm -uPA "$1" | egrep -q "$mpfuncs"
+}
+
+instmods $(filter_kernel_modules mp_mod_test)
-- 
1.6.5.2
