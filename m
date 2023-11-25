Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="Fcpv2gMO"
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B8FD
	for <initramfs@vger.kernel.org>; Sat, 25 Nov 2023 07:40:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285b3a14b12so124149a91.1
        for <initramfs@vger.kernel.org>; Sat, 25 Nov 2023 07:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1700926851; x=1701531651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nsUkgjmoq7Byvwvy8w0huFW1rDVMsLxiY79yljXPu0c=;
        b=Fcpv2gMOd3LOl8eb1BBjocC/5LgFeovUBDrITJp+ix5u4wKJxjDEeho++8za5a8yux
         eRCqWxRBSu76Rtx9Eye0OC8ZuNcIb/HiqhqQAB01WBsKiK6oqDr2eLjKVE5gtn3mzjkF
         /5W0CiOjt0DMSjWca0lEKiDIinu0m6xgd51cf8eo1xcNjwQcOlDxbhgceQZ9lZ1QGpNc
         ofm7/j9y9zWHIC+F7MWtTqIrV+gmbNZg/TtolggosZ7Ec7SMrb5C7PnbrEZZaxjQsQOv
         5e+uqjAp0rTbyjaWH2wWMw3SwGVm6LHosGggUdbyM6pAfe/hD7+pRg5zwsdieX81kZoN
         xxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700926851; x=1701531651;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsUkgjmoq7Byvwvy8w0huFW1rDVMsLxiY79yljXPu0c=;
        b=xHtT+CMz8skX1AikTfKpvWT1XyiGbheLJz3s2nFDtpathe+wE1IEnDRHcgnuFsRNOV
         6q76DfTjrXcNJ6vEN0WdbThQ4R3mDggMJPvpYIzMI/sR+57t1mrYQWc43wxbR9of+zwF
         5oE1R5MBRX9E+pOaUGrwu4aaJeG49QmLqhJ8KsD6aSSS0DR+rz0SOCfym3D9W3RzAS95
         ivupE83rFAM3UcCOAe76T/SQ+L/76VGijsrTiNSuwUEDs2T/lsFL9tBAOYHZnP1gDblH
         6hHa1Xn/4DGVuQ+lTve0CY/smKWSbz7/e0WyYgmLh0AVqAaUw2wLh8tTlnIWrZbS8upN
         o5HQ==
X-Gm-Message-State: AOJu0YxDjTPNEoHPQjGQt/uqu3zjM1o8iLKkKKHU/x+ivz9TMiatnNKA
	SLOdS2gDalwqfjW0Y4gZOmUvSLB9e6wjewhGJgDdEjXY4TOv20vu
X-Google-Smtp-Source: AGHT+IFM1UFGJgYHOmDygSHTm+O2WvOfWKksWlBbu2kfy0ge4zdIo3R5OVKw7snqky7tibezMloZUpMGHvyUZ9PPNrw=
X-Received: by 2002:a17:90b:3504:b0:280:5b33:d30 with SMTP id
 ls4-20020a17090b350400b002805b330d30mr6641850pjb.44.1700926851215; Sat, 25
 Nov 2023 07:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shepherd <emily@redcoat.dev>
Date: Sat, 25 Nov 2023 15:40:40 +0000
Message-ID: <CACHV8XpuC=RsvCqB3LMzxQFRnQB15-0fb4gr7b_EzUpOisrLsA@mail.gmail.com>
Subject: [PATCH] initramfs: Support unpacking directly to tmpfs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For systems which run directly from initramfs, it is not possible to use
pivot_root without first changing root. This is because of the
intentional design choice that rootfs, which is where initramfs is
unpacked to, cannot be unmounted.

pivot_root is an important feature for creating containers and the
alternative (mounting the new root over the top of the old with MS_MOVE
and then calling chroot) is not favoured by most container runtimes
[1][2].

The general work around, when running directly from initramfs, is to
have init mount a new tmpfs, copy everything out of rootfs, and then
switch_root [3]. This is only required when running directly from the
initramfs as all other methods of acquiring a root device (having the
kernel mount a root device directly via the root= parameter, or using
initramfs to mount and then switch_root to a new root) leave an empty
rootfs at the top of the mount stack.

This commit adds a new build option - EMPTY_ROOTFS, available when
initrd/initramfs is enabled. When selected, rather than unpacking the
in-built / bootloader provided initramfs directly into rootfs, the kernel
will mount a new tmpfs/ramfs over the top of the rootfs and unpack to
that instead, leaving an empty rootfs at the top of the stack. This
removes the need to have init copy everything as a workaround.

[1]: https://github.com/opencontainers/runc/blob/95a93c132cf179a017312e22a954f137e8237c4e/man/runc-create.8.md?plain=1#L27
[2]: https://github.com/containers/crun/blob/8e8d7972f738f28294cd5c16091d136ca278759e/crun.1.md?plain=1#L103
[3]: https://github.com/tinycorelinux/Core-scripts/blob/dbb24bf42a0a9935b18e66a0b936266b2244251b/init#L13

Signed-off-by: Emily Shepherd <emily@redcoat.dev>
---
 init/Kconfig     | 13 +++++++++++++
 init/do_mounts.c | 24 ++++++++++++++++++++++++
 init/do_mounts.h |  6 ++++++
 init/initramfs.c |  4 ++++
 4 files changed, 47 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2b..bf15bd08abdc2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1299,6 +1299,19 @@ config BLK_DEV_INITRD

 if BLK_DEV_INITRD

+config EMPTY_ROOTFS
+    bool "Mount initramfs over empty rootfs"
+    help
+        Normally initramfs is unpacked directly into the rootfs. When this
+        option is enabled, initramfs is instead unpacked into a tmpfs
+        mounted on top of a permanently empty rootfs.
+
+        This is mostly useful for embedded operating systems, running
+        directly from initramfs, which need to make use of pivot_root (for
+        example systems running containers).
+
+        If unsure, say N.
+
 source "usr/Kconfig"

 endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5dfd30b13f485..86008635b5098 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -514,3 +514,27 @@ void __init init_rootfs(void)
         (!root_fs_names || strstr(root_fs_names, "tmpfs")))
         is_tmpfs = true;
 }
+
+#ifdef CONFIG_EMPTY_ROOTFS
+int __init overmount_rootfs() {
+    int err;
+
+    err = init_mkdir("/root", 0700);
+    if (err != 0)
+        goto out;
+
+    err = init_mount("rootfs", "/root", is_tmpfs ? "tmpfs" : "ramfs", 0, NULL);
+    if (err != 0)
+        goto out;
+
+    init_chdir("/root");
+    init_mount(".", "/", NULL, MS_MOVE, NULL);
+    init_chroot(".");
+
+    return 0;
+
+out:
+    printk(KERN_WARNING "Failed to mount over rootfs\n");
+    return err;
+}
+#endif /* CONFIG_EMPTY_ROOTFS */
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 15e372b00ce70..7cbb8af460f22 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -41,3 +41,9 @@ static inline bool initrd_load(char *root_device_name)
     }

 #endif
+
+#ifdef CONFIG_EMPTY_ROOTFS
+int __init overmount_rootfs(void);
+#else
+static inline int __init overmount_rootfs(void) { return 0; }
+#endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 8d0fd946cdd2b..76525108a39d2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -19,6 +19,8 @@
 #include <linux/task_work.h>
 #include <linux/umh.h>

+#include "do_mounts.h"
+
 static __initdata bool csum_present;
 static __initdata u32 io_csum;

@@ -688,6 +690,8 @@ static void __init populate_initrd_image(char *err)

 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
+    overmount_rootfs();
+
     /* Load the built in initramfs */
     char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
     if (err)
--
2.42.0
