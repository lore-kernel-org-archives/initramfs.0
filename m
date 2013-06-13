From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 90lvm/module-setup.sh: redirect error message of lvs to /dev/null
Date: Thu, 13 Jun 2013 16:07:44 +0800
Message-ID: <310a3dc08b00e27f60b6a0b57fed52ccec800e46.1371110823.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90lvm/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index a51bb05..abec1de 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -41,7 +41,7 @@ install() {
             push _activated "${DM_VG_NAME}/${DM_LV_NAME}"
         fi
         if ! [[ $_needthin ]]; then
-            [[ $(lvs --noheadings -o segtype ${DM_VG_NAME}) == *thin* ]] && _needthin=1
+            [[ $(lvs --noheadings -o segtype ${DM_VG_NAME} 2>/dev/null) == *thin* ]] && _needthin=1
         fi
 
         return 0
-- 
1.7.1
