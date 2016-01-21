From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] Correctly handle module aliases
Date: Thu, 21 Jan 2016 17:13:07 +0100
Message-ID: <40374262.eB5p3XdtTH@linux-lm3i.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Handle module aliases correctly to not generate unbootable
initrds with different kernel versions when modules were renamed
or replaced.

Signed-off-by: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>
---

This is the case for mpt3sas -> mpt2sas migration in kernel 4.4,
which caused issues like https://bugzilla.opensuse.org/show_bug.cgi?id=962694

 dracut.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/dracut.sh b/dracut.sh
index 98dbe0b..ae8772b 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1195,6 +1195,27 @@ if [[ $hostonly ]]; then
     while read m rest || [ -n "$m" ]; do
         host_modules["$m"]=1
     done </proc/modules
+
+    # Explanation of the following section:
+    # Since kernel 4.4, mpt3sas is a complete replacement for mpt2sas.
+    # mpt3sas has an alias to mpt2sas now, but since mpt3sas isn't loaded
+    # when generating the initrd from kernel < 4.4, it's not included.
+    # The other direction has the same issue:
+    # When generating the initrd from kernel >= 4.4, mpt2sas isn't loaded,
+    # so it's not included.
+    # Both ways result in an unbootable initrd.
+
+    # also add aliases of loaded modules
+    for mod in "${!host_modules[@]}"; do
+        aliases=$(modinfo -F alias "$mod" 2>&1)
+        for alias in $aliases; do
+            host_modules["$alias"]=1
+        done
+        # mod might be an alias in the target kernel, find the real module
+        mod_filename=$(modinfo -k "$kernel" "$mod" -F filename)
+        [ $? -ne 0 ] && continue
+        host_modules["$(basename -s .ko "$mod_filename")"]=1
+    done
 fi
 
 unset m
-- 
2.7.0
