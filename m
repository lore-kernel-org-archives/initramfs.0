From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 23/33] Align dev_unit_name() with systemd's function.
Date: Thu, 20 Nov 2014 15:56:58 +0100
Message-ID: <1416495428-36978-24-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

Add more corner cases from systemd's
unit_name_from_path_instance() C function.

Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 7080f1a..405e3c7 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -862,18 +862,30 @@ wait_for_mount()
     } >> "$hookdir/emergency/90-${_name}.sh"
 }
 
+# get a systemd-compatible unit name from a path
+# (mimicks unit_name_from_path_instance())
 dev_unit_name()
 {
+    local dev="$1"
+
     if command -v systemd-escape >/dev/null; then
-        systemd-escape -p  "$1"
+        systemd-escape -p  "$dev"
         return
     fi
 
-    _name="${1%%/}"
-    _name="${_name##/}"
-    _name="$(str_replace "$_name" '-' '\x2d')"
-    _name="$(str_replace "$_name" '/' '-')"
-    echo "$_name"
+    if [ "$dev" = "/" -o -z "$dev" ]; then
+        printf -- "-"
+        exit 0
+    fi
+
+    dev="${1%%/}"
+    dev="${dev##/}"
+    dev="$(str_replace "$dev" '\' '\x5c')"
+    dev="$(str_replace "$dev" '-' '\x2d')"
+    dev=${dev/#\./\\x2e}
+    dev="$(str_replace "$dev" '/' '-')"
+
+    printf -- "%s" "$dev"
 }
 
 # wait_for_dev <dev>
-- 
1.8.5.2
