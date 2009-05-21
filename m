From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] Make running qemu a little more generic
Date: Wed, 20 May 2009 19:55:04 -0700 (PDT)
Message-ID: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=phEyhY8G3WUqroFmRPE0ev5WnRCC3AAuUAbtnoY/6sU=;
        b=oioK1wV2zF8Brf+wYOOEwtRvlpbxbMqOSdvN2cZLq67x1qtQ077PyO3Rnwskp77FZD
         JYsPsPtkqnTF8Od0qnPG7FohzMkoufwxmmJb776KoBjCYX05TkfnbRunW5TU5iywIzm2
         coYNY2P+4NBIAKxWb7mZQlS9hMuCw84AlLlfE=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Also create the root filesystem from within the virtual env, this way there
will be no nasty suprises w.r.t interactions with the host machine.  This
is important when we test booting to LVM, LUKS, and mdraid.

---
 test/make-test-root |   13 ++++++++-----
 test/run-qemu       |    9 +++++++++
 test/test-initramfs |   19 ++++++++-----------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/test/make-test-root b/test/make-test-root
index de03762..d79153d 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -1,9 +1,6 @@
 #!/bin/bash
 
 dd if=/dev/zero of=test/root.ext2 bs=1M count=20
-mke2fs -F test/root.ext2
-mkdir test/mnt
-mount -o loop test/root.ext2 test/mnt
 
 initdir=test/mnt
 kernel=$(uname -r)
@@ -21,6 +18,12 @@ kernel=$(uname -r)
 targetfs="$initdir"
 unset initdir
 
+./dracut -l -i "$targetfs" /source \
+    -m "dash kernel-modules test crypt lvm udev-rules base rootfs-block" \
+    -d "ata_piix ext2 sd_mod" \
+    -f test/initramfs.makeroot
 
-umount test/mnt
-rm -fr test/mnt
+test/run-qemu -hda test/root.ext2 -m 512M -nographic -net none \
+    -kernel "/boot/vmlinuz-$kernel" \
+    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
+    -initrd test/initramfs.makeroot
diff --git a/test/run-qemu b/test/run-qemu
new file mode 100755
index 0000000..c1068e5
--- /dev/null
+++ b/test/run-qemu
@@ -0,0 +1,9 @@
+#!/bin/bash
+for f in kvm qemu-kvm qemu; do
+    type $f >/dev/null 2>&1 || continue
+    $f "$@"
+    exit
+done
+echo "Could not find a working KVM or QEMU to test with!"
+echo "Please install kvm or qemu."
+exit 1
\ No newline at end of file
diff --git a/test/test-initramfs b/test/test-initramfs
dissimilarity index 84%
index f828307..3c75553 100755
--- a/test/test-initramfs
+++ b/test/test-initramfs
@@ -1,11 +1,8 @@
-#!/bin/bash
-[[ -f test/root.ext2 ]] || test/make-test-root
-
-./dracut $DRACUTOPTS -c test/dracut.conf.test -l -f test/initramfs.testing || exit
-
-qemu-kvm -hda test/root.ext2 -m 512M -nographic  \
-	-net nic,macaddr=52:54:00:12:34:57 -net socket,mcast=230.0.0.1:1234 \
-	-kernel /boot/vmlinuz-$(uname -r) \
-	-initrd test/initramfs.testing \
-	-append "root=/dev/sda rw console=ttyS0,115200n81 $APPEND"   
-
+#!/bin/bash
+[[ -f test/root.ext2 ]] || test/make-test-root
+
+test/run-qemu -hda test/root.ext2 -m 512M -nographic \
+    -net nic,macaddr=52:54:00:12:34:57 -net socket,mcast=230.0.0.1:1234 \
+    -kernel /boot/vmlinuz-$(uname -r) \
+    -append "root=/dev/sda rw console=ttyS0,115200n81 $APPEND" \
+    -initrd test/initramfs.testing
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
