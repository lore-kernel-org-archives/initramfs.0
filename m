From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] We create our test image with root as an LVM menber.
Date: Wed, 20 May 2009 19:55:06 -0700 (PDT)
Message-ID: <21e5b98500a58b6aa6c9bf290870993c18ed87cc.1242874219.git.victor.lowther@gmail.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Lc/9N7/t0fHZffHpzfoEhYtEUDxEQOrOb5cThpuULoY=;
        b=Yzeu+trD3TIP0DUrJAx2xcWeyjArUYk9YIzK6pFI+TXV7sBDKiwNpSYORdmrVyrHmi
         gIibqcN29bx2tClisnlcZzfO76CfwSWm6TkHWfuLLd3JGC7NADBZ8Vbg0sbLt/vHWAtz
         Qwsk8Wbq79iIchCvNWsDoAwUREBzStNxROtkA=
In-Reply-To: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We purport to support booting off an encrypted LVM PV, may as well test it.
---
 modules.d/00test/create-root.sh |   10 ++++------
 test/make-test-root             |    2 +-
 test/test-initramfs             |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/modules.d/00test/create-root.sh b/modules.d/00test/create-root.sh
index ce9f40b..c756f4f 100755
--- a/modules.d/00test/create-root.sh
+++ b/modules.d/00test/create-root.sh
@@ -5,12 +5,10 @@ sfdisk /dev/sda <<EOF
 ;
 ;
 EOF
-cryptsetup -q luksFormat /dev/sda1 <<EOF
-test
-EOF
-cryptsetup luksOpen /dev/sda1 dracut_crypt_test <<EOF
-test
-EOF
+echo -n test >keyfile
+cryptsetup -q luksFormat /dev/sda1 /keyfile
+echo "The passphrase is test"
+cryptsetup luksOpen /dev/sda1 dracut_crypt_test </keyfile
 lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test
 lvm vgcreate dracut /dev/mapper/dracut_crypt_test
 lvm lvcreate -l 100%FREE -n root dracut
diff --git a/test/make-test-root b/test/make-test-root
index d79153d..84f2105 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -25,5 +25,5 @@ unset initdir
 
 test/run-qemu -hda test/root.ext2 -m 512M -nographic -net none \
     -kernel "/boot/vmlinuz-$kernel" \
-    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
+    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81i" \
     -initrd test/initramfs.makeroot
diff --git a/test/test-initramfs b/test/test-initramfs
index 3c75553..5ee0336 100755
--- a/test/test-initramfs
+++ b/test/test-initramfs
@@ -4,5 +4,5 @@
 test/run-qemu -hda test/root.ext2 -m 512M -nographic \
     -net nic,macaddr=52:54:00:12:34:57 -net socket,mcast=230.0.0.1:1234 \
     -kernel /boot/vmlinuz-$(uname -r) \
-    -append "root=/dev/sda rw console=ttyS0,115200n81 $APPEND" \
+    -append "root=/dev/dracut/root rw console=ttyS0,115200n81 $APPEND" \
     -initrd test/initramfs.testing
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
