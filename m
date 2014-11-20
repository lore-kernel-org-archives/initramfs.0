From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 31/33] dracut.sh: Fix UUID= fstab parsing in case --mount option is passed
Date: Thu, 20 Nov 2014 15:57:06 +0100
Message-ID: <1416495428-36978-32-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dracut parses /etc/fstab when --mount is option is passed (e.g. kdump).

In host_devs variable the real block device must be stored, not UUID=
There are other /etc/fstab syntax possibilities we now warn that they
are not correctly parsed. This will be fixed by another patch
when there is time to test this properly.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index f384f73..3c3efc1 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1071,9 +1071,25 @@ declare -A host_fs_types
 
 for line in "${fstab_lines[@]}"; do
     set -- $line
+    dev="$1"
     #dev mp fs fsopts
-    push_host_devs "$1"
-    host_fs_types["$1"]="$3"
+    case "$dev" in
+        UUID=*)
+            dev=$(blkid -l -t UUID=${dev#UUID=} -o device)
+            ;;
+        LABEL=*)
+            dev=$(blkid -l -t LABEL=${dev#LABEL=} -o device)
+            ;;
+        PARTUUID=*)
+            dev=$(blkid -l -t PARTUUID=${dev#PARTUUID=} -o device)
+            ;;
+        PARTLABEL=*)
+            dev=$(blkid -l -t PARTLABEL=${dev#PARTLABEL=} -o device)
+            ;;
+    esac
+    [ -z "$dev" ] && dwarn "Bad fstab entry $@" && continue
+    push_host_devs "$dev"
+    host_fs_types["$dev"]="$3"
 done
 
 for f in $add_fstab; do
-- 
1.8.5.2
