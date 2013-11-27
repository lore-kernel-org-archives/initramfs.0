From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 08/10] Check for plymouth lib directories
Date: Wed, 27 Nov 2013 16:44:19 +0100
Message-ID: <1385567061-13247-9-git-send-email-hare@suse.de>
References: <1385567061-13247-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385567061-13247-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

SUSE installs plymount files in /usr/lib, not /usr/libexec.
So check for both when including plymouth support.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/50plymouth/module-setup.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/modules.d/50plymouth/module-setup.sh b/modules.d/50plymouth/module-setup.sh
index 1360924..7ccf9e4 100755
--- a/modules.d/50plymouth/module-setup.sh
+++ b/modules.d/50plymouth/module-setup.sh
@@ -15,12 +15,19 @@ depends() {
 
 # called by dracut
 install() {
-    if grep -q nash /usr/libexec/plymouth/plymouth-populate-initrd \
-        || [ ! -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
+    if [ -d /usr/libexec/plymouth ] ; then
+        _plymouth=/usr/libexec/plymouth;
+    elif [ -d /usr/lib/plymouth ] ; then
+        _plymouth=/usr/lib/plymouth
+    fi
+    if [ -n "$_plymouth" ] ; then
+        if grep -q nash ${_plymouth}/plymouth-populate-initrd \
+        || [ ! -x ${_plymouth}/plymouth-populate-initrd ]; then
         . "$moddir"/plymouth-populate-initrd.sh
-    else
-        PLYMOUTH_POPULATE_SOURCE_FUNCTIONS="$dracutfunctions" \
-            /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir"
+        else
+            PLYMOUTH_POPULATE_SOURCE_FUNCTIONS="$dracutfunctions" \
+                ${_plymouth}/plymouth-populate-initrd -t "$initdir"
+        fi
     fi
 
     inst_hook emergency 50 "$moddir"/plymouth-emergency.sh
-- 
1.8.1.4
