From: Brandon Philips <brandon-J/aRLfwL2k0@public.gmane.org>
Subject: [PATCH] 95rootfs-block: fix PARTUUID parsing
Date: Mon, 22 Jul 2013 18:17:02 -0700
Message-ID: <CAEm7KtxJhmN-p0b9UVq162d5=OEV35tVpJ7hLgpiLaOU90So2Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ifup.co; s=google;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type;
        bh=E8E7cdp43FosWDjC3Dc1elsY71eWbJ4/doicUew3gsw=;
        b=L4W8FvJA+G68VhT9TKG+D8Ep2950hrwTwoxtoCRF4SvOka5ZOaF+VJvg6zKz2ot4lu
         B0HdDW8iDICYixG5/fapMaIAE0WuO+pF3liX4wFcpDaVKlSJQ7d/MZ4N0h2ZvNDmlheh
         QO4JZ31d8E3kyVVRDKvCAJJnHjdcCcoE/Hro4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

In the kernel comments PARTUUID is shown using uppercase A-F:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/init/do_mounts.c?id=HEAD#n183

However, dracut tries to use the value of PARTUUID directly in
/dev/disks/by-partuuid/ which expects the hex to be lowercase. This will
cause root to never be found, oops!

Fix dracut so it can, like the Kernel, accept either casing.

Untested but I added a hack on my local system that was similar.

---
 modules.d/95rootfs-block/module-setup.sh | 1 +
 modules.d/95rootfs-block/parse-block.sh  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/modules.d/95rootfs-block/module-setup.sh
b/modules.d/95rootfs-block/module-setup.sh
index 0c7701d..6167beb 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -31,6 +31,7 @@ depends() {

 install() {
     dracut_install umount
+    dracut_install tr
     if ! dracut_module_included "systemd"; then
         inst_hook cmdline 95 "$moddir/parse-block.sh"
         inst_hook pre-udev 30 "$moddir/block-genrules.sh"
diff --git a/modules.d/95rootfs-block/parse-block.sh
b/modules.d/95rootfs-block/parse-block.sh
index 0a23ac7..1d88ceb 100755
--- a/modules.d/95rootfs-block/parse-block.sh
+++ b/modules.d/95rootfs-block/parse-block.sh
@@ -10,11 +10,15 @@ case "$root" in
         rootok=1 ;;
     block:UUID=*|UUID=*)
         root="${root#block:}"
+        root="${root#UUID=}"
+        root="$(echo $root | tr "[:upper:]" "[:lower:]")"
         root="block:/dev/disk/by-uuid/${root#UUID=}"
         rootok=1 ;;
     block:PARTUUID=*|PARTUUID=*)
         root="${root#block:}"
-        root="block:/dev/disk/by-partuuid/${root#PARTUUID=}"
+        root="${root#PARTUUID=}"
+        root="$(echo $root | tr "[:upper:]" "[:lower:]")"
+        root="block:/dev/disk/by-partuuid/${root}"
         rootok=1 ;;
     block:PARTLABEL=*|PARTLABEL=*)
         root="${root#block:}"
--
1.7.12.4
