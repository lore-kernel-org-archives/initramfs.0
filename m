From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] Move content of 00test module into the test subdir
Date: Sat, 23 May 2009 22:29:46 -0700 (PDT)
Message-ID: <167cc2025588aad52f4bf1874445fb88f98a5446.1243142925.git.victor.lowther@gmail.com>
References: <91424b14939cf148aa51b49c93f0476f59d5b186.1243142925.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=t0lTmP9DbcqD9DVuxWcYav2NHMkirvA79Ou8hP3NM+c=;
        b=mql/oKkgwqsFzgl9KGHqvtnQM0mA0oEDeUEaRYhMySlcMKvtp8PbjLM/RQaHu8aGl3
         e+m9eYMOngvWKkVN+LfMGjV1lXVOF46FyMiQ6CuDKC6rYP5b5eBU2HA07t2qpgpEbehn
         XpNa0Sr6Snx5xJ7fb9JB/OLUDMyprZ3zgnc6A=
In-Reply-To: <91424b14939cf148aa51b49c93f0476f59d5b186.1243142925.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The last changes made the 00test module really awkward anyways, so just
hack the test module into the initramfs in a slight more brutal fashion.
---
 modules.d/00test/check                    |    2 --
 modules.d/00test/install                  |    5 -----
 {modules.d/00test => test}/copy-root.sh   |    0
 {modules.d/00test => test}/create-root.sh |    0
 {modules.d/00test => test}/halt.sh        |    0
 test/make-test-root                       |   20 ++++++++++++++------
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/modules.d/00test/check b/modules.d/00test/check
deleted file mode 100755
index afe8ade..0000000
--- a/modules.d/00test/check
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-exit 1
diff --git a/modules.d/00test/install b/modules.d/00test/install
deleted file mode 100755
index 46a83af..0000000
--- a/modules.d/00test/install
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-dracut_install sfdisk mke2fs poweroff cp umount
-inst_hook pre-pivot 02 "$moddir/halt.sh"
-inst_hook pre-pivot 01 "$moddir/copy-root.sh"
-inst_hook pre-mount 01 "$moddir/create-root.sh"
\ No newline at end of file
diff --git a/modules.d/00test/copy-root.sh b/test/copy-root.sh
similarity index 100%
rename from modules.d/00test/copy-root.sh
rename to test/copy-root.sh
diff --git a/modules.d/00test/create-root.sh b/test/create-root.sh
similarity index 100%
rename from modules.d/00test/create-root.sh
rename to test/create-root.sh
diff --git a/modules.d/00test/halt.sh b/test/halt.sh
similarity index 100%
rename from modules.d/00test/halt.sh
rename to test/halt.sh
diff --git a/test/make-test-root b/test/make-test-root
index e7f5276..6bc2b5a 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -4,9 +4,10 @@
 
 dd if=/dev/zero of=test/root.ext2 bs=1M count=20
 
-initdir=test/mnt
 kernel=$(uname -r)
+# first, make the root filesystem
 (
+    initdir=test/overlay/source
     . ./dracut-functions
     dracut_install sh df free ls shutdown poweroff stty cat ps ln ip route \
 	/lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
@@ -18,16 +19,23 @@ kernel=$(uname -r)
     find_binary plymouth >/dev/null && dracut_install plymouth
     (cd "$initdir"; mkdir -p dev sys proc etc var/run tmp )
 )
-targetfs="$initdir"
-unset initdir
+
+# second, install the files needed to make the root filesystem
+(
+    initdir=test/overlay
+    . ./dracut-functions
+    dracut_install sfdisk mke2fs poweroff cp umount
+    inst_simple test/halt.sh /pre-pivot/02halt.sh
+    inst_simple test/copy-root.sh /pre-pivot/01copy-root.sh
+    inst_simple test/create-root.sh /pre-mount/01create-root.sh
+)
 
 # create an initramfs that will create the target root filesystem.
 # We do it this way because creating it directly in the host OS
 # results in cryptsetup not being able to unlock the LVM PV.
 # Probably a bug in cryptsetup, but...
-./dracut -l -i "$targetfs" /source \
-    -i test/overlay / \
-    -m "dash kernel-modules test crypt lvm mdraid udev-rules base rootfs-block" \
+./dracut -l -i test/overlay / \
+    -m "dash kernel-modules crypt lvm mdraid udev-rules base rootfs-block" \
     -d "ata_piix ext2 sd_mod" \
     -f test/initramfs.makeroot
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
