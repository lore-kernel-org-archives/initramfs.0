From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] Fix wrong keymap inclusion
Date: Fri, 17 Jun 2016 14:25:13 +0200
Message-ID: <1711921.0d4JtWs6XN@linux-lm3i.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

For MAP=lt, dracut would choose lt.std.map instead of lt.map.

Signed-off-by: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module-setup.sh
index 9618aa7..2eae5d0 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -30,8 +30,9 @@ install() {
     # This is from 10redhat-i18n.
     findkeymap () {
         local MAP=$1
+        local MAPNAME=${1%.map*}
         [[ ! -f $MAP ]] && \
-            MAP=$(find ${kbddir}/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
+            MAP=$(find ${kbddir}/keymaps -type f -name ${MAPNAME} -o -name ${MAPNAME}.map -o -name ${MAPNAME}.map.\* | head -n1)
         [[ " $KEYMAPS " = *" $MAP "* ]] && return
         KEYMAPS="$KEYMAPS $MAP"
         case $MAP in
-- 
2.8.4

