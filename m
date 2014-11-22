From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Order root fsck after dracut-pre-mount.service
Date: Sat, 22 Nov 2014 19:43:40 +0300
Message-ID: <1416674620-1024-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=ZxekjW41HIiIKHXJp+W8sQDp4IaxoYsL6KNNW+kzqGc=;
        b=IYUE10lyT9Ie75uyUmjw6EZW05cOzprBGDC5kLbiGA3oUhSSZCKfyD9e0YlsUbTziK
         dka0JrjKqx7MbT7rHr2ku907XiO1/394WoRhyClTPphkX2tt5d0aaeorDrG8ItATyFGX
         /CzlUcEGcmoJ8tsytPFvC2xUpLaosinU/qIaV/N4HHkkUbg1e/PxpML6FMzdr1G80vVP
         4DRGzawKPI1yte3KC8sMI3oDFC9eh7vy/Sbxd4M6ekwhLULl38DEIBfJeA3M/qYQdLx6
         cA/a4AtH8aflZG9sPYKIpIsr/Tq2eSk8Vd1ovTFrWat1aLQWAKjETGpBiPb8TPHpLqKR
         SDMA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently root fsck runs concurrently with dracut-pre-mount and so
races with resume from disk (started by dracut-pre-mount). This leads
to data corruption if fsck changes filesystem.

Make sure root fsck runs after dracut-pre-mount.service.

Details including console logs:
https://bugzilla.suse.com/show_bug.cgi?id=906592

Signed-off-by: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/98systemd/rootfs-generator.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/modules.d/98systemd/rootfs-generator.sh b/modules.d/98systemd/rootfs-generator.sh
index 9523729..a2d26b9 100755
--- a/modules.d/98systemd/rootfs-generator.sh
+++ b/modules.d/98systemd/rootfs-generator.sh
@@ -32,6 +32,22 @@ generator_wait_for_dev()
     fi
 }
 
+generator_fsck_after_pre_mount()
+{
+    local _name
+
+    [ -z "$1" ] && return 0
+
+    _name=$(dev_unit_name "$1")
+    [ -d /run/systemd/generator/systemd-fsck@${_name}.service.d ] || mkdir -p /run/systemd/generator/systemd-fsck@${_name}.service.d
+    if ! [ -f /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mount.conf ]; then
+        {
+            echo "[Unit]"
+            echo "After=dracut-pre-mount.service"
+        } > /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mount.conf
+    fi
+}
+
 root=$(getarg root=)
 case "$root" in
     block:LABEL=*|LABEL=*)
@@ -58,6 +74,9 @@ case "$root" in
         rootok=1 ;;
 esac
 
-[ "${root%%:*}" = "block" ] && generator_wait_for_dev "${root#block:}"
+if [ "${root%%:*}" = "block" ]; then
+    generator_wait_for_dev "${root#block:}"
+    generator_fsck_after_pre_mount "${root#block:}"
+fi
 
 exit 0
-- 
tg: (778b354..) u/root-fsck-after-pre-mount (depends on: master)
