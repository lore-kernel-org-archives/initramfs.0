From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 5/8] Use the uncompressed kernel file on arm and aarch to detect kernel version
Date: Fri, 26 Jun 2015 16:55:54 +0200
Message-ID: <1435330557-17685-6-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

This is due to file cannot read out the kernel version on these.

Many thanks to Alexander Graf finding this in old SUSE mkinitrd code.
Converted by Thomas Renninger.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

https://bugzilla.suse.com/show_bug.cgi?id=908454
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-suse.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mkinitrd-suse.sh b/mkinitrd-suse.sh
index c2b314f..0f2b3c4 100755
--- a/mkinitrd-suse.sh
+++ b/mkinitrd-suse.sh
@@ -145,6 +145,33 @@ is_xen_kernel() {
     return
 }
 
+# kernel_image_gz_from_image() and kernel_version_from_image() are helpers
+# for arm* kernels which produce zImage files which cannot be read from
+# get_kernel_version -> get rid of this workaround if possible
+kernel_image_gz_from_image() {
+    local arch=$(uname -i)
+    local r=${1}.gz
+
+    # uImage kernels can't be extracted directly. Use the vmlinux.gz instead
+    r=${r//uImage/vmlinux}
+
+    # on ARM a zImage can't be extracted directly. Other platforms define it
+    # as a gzipped vmlinux file, but not ARM. So only on ARM, use vmlinux.gz.
+    if [[ $arch =~ arm ]] || [[ $arch =~ aarch ]]; then
+        r=${r//zImage/vmlinux}
+    fi
+
+    echo $r
+}
+
+kernel_version_from_image() {
+    local kernel_image="$1" kernel_image_gz=$(kernel_image_gz_from_image "$1")
+
+    if get_kernel_version "$kernel_image" 2>/dev/null; then
+        return
+    fi
+    get_kernel_version "$kernel_image_gz" 2>/dev/null
+}
 
 # Taken over from SUSE mkinitrd
 default_kernel_images() {
@@ -183,7 +210,8 @@ default_kernel_images() {
 
         [ -L "$boot_dir/$kernel_image" ] && continue
         [ "${kernel_image%%.gz}" != "$kernel_image" ] && continue
-        kernel_version=$(/usr/bin/get_kernel_version \
+
+        kernel_version=$(kernel_version_from_image \
                          $boot_dir/$kernel_image 2> /dev/null)
         initrd_image=$(echo $kernel_image | sed -e "s|${regex}|initrd|")
         if [ "$kernel_image" != "$initrd_image" -a \
-- 
2.1.4
