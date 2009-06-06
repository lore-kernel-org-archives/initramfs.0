From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 7/9] root option parsing belongs in 99base now
Date: Sat,  6 Jun 2009 05:23:28 -0400
Message-ID: <a2810bf24a5c78df9bc9ac3e80e8c15d0fe1a79d.1244279679.git.dave@thedillows.org>
References: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

We use this for NFS root as well, and NFSv4 was getting broken when
it wasn't present.
---
 modules.d/95rootfs-block/install            |    1 -
 modules.d/95rootfs-block/parse-root-opts.sh |   14 --------------
 modules.d/99base/install                    |    1 +
 modules.d/99base/parse-root-opts.sh         |   14 ++++++++++++++
 4 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100755 modules.d/95rootfs-block/parse-root-opts.sh
 create mode 100755 modules.d/99base/parse-root-opts.sh

diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-block/install
index b977f9b..618d357 100755
--- a/modules.d/95rootfs-block/install
+++ b/modules.d/95rootfs-block/install
@@ -1,5 +1,4 @@
 #!/bin/sh
-inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
 inst_hook cmdline 95 "$moddir/parse-block.sh"
 inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/95rootfs-block/parse-root-opts.sh b/modules.d/95rootfs-block/parse-root-opts.sh
deleted file mode 100755
index 7fc4f47..0000000
--- a/modules.d/95rootfs-block/parse-root-opts.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-root=$(getarg root=)
-
-if rflags="$(getarg rootflags=)"; then
-    getarg rw && rflags="${rflags},rw" || rflags="${rflags},ro"
-else
-    getarg rw && rflags=rw || rflags=ro
-fi
-
-fstype="$(getarg rootfstype=)"
-if [ -z "$fstype" ]; then
-    fstype="auto"
-fi
-
-export fstype rflags root
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 428eaf9..97dd2d3 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -14,4 +14,5 @@ else
     inst "$moddir/switch_root" "/sbin/switch_root"
 fi
 inst "$moddir/dracut-lib" "/lib/dracut-lib"
+inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
 inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
diff --git a/modules.d/99base/parse-root-opts.sh b/modules.d/99base/parse-root-opts.sh
new file mode 100755
index 0000000..7fc4f47
--- /dev/null
+++ b/modules.d/99base/parse-root-opts.sh
@@ -0,0 +1,14 @@
+root=$(getarg root=)
+
+if rflags="$(getarg rootflags=)"; then
+    getarg rw && rflags="${rflags},rw" || rflags="${rflags},ro"
+else
+    getarg rw && rflags=rw || rflags=ro
+fi
+
+fstype="$(getarg rootfstype=)"
+if [ -z "$fstype" ]; then
+    fstype="auto"
+fi
+
+export fstype rflags root
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
