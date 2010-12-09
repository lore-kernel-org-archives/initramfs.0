From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 50plymouth: remove crypt dependency
Date: Thu,  9 Dec 2010 11:42:16 +0100
Message-ID: <1291891336-28128-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Plymouth is merged into 90crypt.  We don't need crypt dependency in
plymouth module anymore.
---
 modules.d/50plymouth/check |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/modules.d/50plymouth/check b/modules.d/50plymouth/check
index f11c9fd..f7011d5 100755
--- a/modules.d/50plymouth/check
+++ b/modules.d/50plymouth/check
@@ -1,5 +1,4 @@
 #!/bin/bash
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
-[[ $1 = -d ]] && type -P cryptsetup >/dev/null && echo crypt
 [[ -x /sbin/plymouthd && -x /bin/plymouth && -x /usr/sbin/plymouth-set-default-theme ]]
-- 
1.7.3.2
