Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="uoSFseTq"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D2F5
	for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 01:00:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so80215731fa.3
        for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 01:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701248435; x=1701853235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJhSDilczB5Njps3/+KlXnzMsWxpXs596km+TxKB3QA=;
        b=uoSFseTqhbjy08HgZIV+b303JLrOkD/Ngo2PuM1vl/IC4e5NWheG3GkrYPBtuipRC7
         r9UzG9WuOYzToPrjS7iwAU4T7ef1npZ8uQX0hl1u/KeemtSBKGuL5SbJR1bD4GbYB70P
         yBhlDTqSB+yMbh/bY+mC1fPoN78fQ02RlaMmuasd7aGCb6h9dKnFNQ79pkdA0Vgg6Taj
         XwVHQkIsO2lw5cPK1M3IW5Kj3ME81hb/D7uAJiiOqO7d8zgNhW+be2I9wD5nLMvQIoXS
         puoHlNW8gBDpOLx+ewUDdGmaSWmf3AOsoSEAfdxKXf/yZ4xTtoyh9q5FXCty+mDLNH+w
         PBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248435; x=1701853235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJhSDilczB5Njps3/+KlXnzMsWxpXs596km+TxKB3QA=;
        b=CJcLIzvk7ZPSoPd0EmfLPTqFgNhadXX9QGGK8XNL/uJWc5R6hUe1hvmEcOkhj5Ssfl
         g/MzOnoGQ36LNuUKOSRoOfTXbpKCK3gLwqSC8cDZpp9T27rnd52W7MPzT6b5bEUD1xYW
         zaQ0FE7oN0+rCQErlwM3a83fWe8sBblzho60gq/kGIQ8h94ZtYm94Ktwm5qXoKcJkPhs
         gFGFJNhcLi2tuZAdEANkvm2SEZN99VbQji/ZT9PdU1Qqr07InEC0pow0/chdqaNoBnc0
         8b81yPQUM3yUeJG6TcE9hENUTho5i6GTnpgI7rOcVOpPlT46IUl9ROfYC5VsqtugjGVl
         V/Vw==
X-Gm-Message-State: AOJu0YxWXvRCZ856kswzk3NwoJcn8VOFHRszuizNSgXKD714nmFSx0kM
	zcLF8keW4JSgK7Ipq3S6o0FnuQ==
X-Google-Smtp-Source: AGHT+IFTCbb8RLIHpvoNHcK2kIKbcZRdcU7xXhZpJldc4J8M4HbL5tXtV7BeLV64yoFJGS1/PqPUHw==
X-Received: by 2002:a05:651c:210f:b0:2c9:98b5:c285 with SMTP id a15-20020a05651c210f00b002c998b5c285mr9175809ljq.19.1701248435352;
        Wed, 29 Nov 2023 01:00:35 -0800 (PST)
Received: from test ([2a00:23c7:1fab:4e01:c2b7:df94:a888:e053])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm1413410wmq.18.2023.11.29.01.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:00:34 -0800 (PST)
Date: Wed, 29 Nov 2023 09:00:33 +0000
From: Emily Shepherd <emily@redcoat.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: initramfs@vger.kernel.org, 
	Thomas =?utf-8?Q?Str=C3=B6mberg?= <t+github@chainguard.dev>, Anders =?utf-8?Q?Bj=C3=B6rklund?= <anders.f.bjorklund@gmail.com>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Rob Landley <rob@landley.net>
Subject: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Message-ID: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For systems which run directly from initramfs, it is not possible to use
pivot_root without first changing root. This is because of the
intentional design choice that rootfs, which is where initramfs is
unpacked to, cannot be unmounted.

pivot_root is an important feature for creating containers and the
alternative (mounting the new root over the top of the old with MS_MOVE
and then calling chroot) is not favoured by most container runtimes
[1][2] as it does not completely remove the host system mounts from the
mount namespace.

The general work around, when running directly from initramfs, is to
have init mount a new tmpfs, copy everything out of rootfs, and then
switch_root [3][4]. This is only required when running directly from the
initramfs as all other methods of acquiring a root device (having the
kernel mount a root device directly via the root= parameter, or using
initramfs to mount and then switch_root to a new root) leave an empty
rootfs at the top of the mount stack.

This commit adds a new build option - EMPTY_ROOTFS, available when
initrd/initramfs is enabled. When selected, rather than unpacking the
inbuilt / bootloader provided initramfs directly into rootfs, the kernel
will mount a new tmpfs/ramfs over the top of the rootfs and unpack to
that instead, leaving an empty rootfs at the top of the stack. This
removes the need to have init copy everything as a workaround.

[1]: https://github.com/opencontainers/runc/blob/95a93c132cf179a017312e22a954f137e8237c4e/man/runc-create.8.md?plain=1#L27
[2]: https://github.com/containers/crun/blob/8e8d7972f738f28294cd5c16091d136ca278759e/crun.1.md?plain=1#L103
[3]: https://github.com/tinycorelinux/Core-scripts/blob/dbb24bf42a0a9935b18e66a0b936266b2244251b/init#L13
[4]: https://github.com/kubernetes/minikube/blob/master/deploy/iso/minikube-iso/board/minikube/x86_64/rootfs-overlay/init#L6

Signed-off-by: Emily Shepherd <emily@redcoat.dev>
---
v2:
  - Fix formatting error in patch
  - Update overmount_rootfs() return type to void
  - cc relevant kernel devs based on blame of init files
  - cc OCI container runtime devs who have supported no-pivot options
  - cc small / embedded linux devs who have mitigated this by copying 
    root
  - tweak to changelog: clarify why no-pivot is not recommended
  - tweak to changelog: include missing reference to minikube's rootfs 
    mitigation
---
 init/Kconfig     | 13 +++++++++++++
 init/do_mounts.c | 23 +++++++++++++++++++++++
 init/do_mounts.h |  6 ++++++
 init/initramfs.c |  4 ++++
 4 files changed, 46 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2b..bf15bd08abdc2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1299,6 +1299,19 @@ config BLK_DEV_INITRD
 
 if BLK_DEV_INITRD
 
+config EMPTY_ROOTFS
+	bool "Mount initramfs over empty rootfs"
+	help
+		Normally initramfs is unpacked directly into the rootfs. When this
+		option is enabled, initramfs is instead unpacked into a tmpfs
+		mounted on top of a permanently empty rootfs.
+
+		This is mostly useful for embedded operating systems, running
+		directly from initramfs, which need to make use of pivot_root (for
+		example systems running containers).
+
+		If unsure, say N.
+
 source "usr/Kconfig"
 
 endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5dfd30b13f485..7cf106cf976db 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -514,3 +514,26 @@ void __init init_rootfs(void)
 		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
 }
+
+#ifdef CONFIG_EMPTY_ROOTFS
+void __init overmount_rootfs(void) {
+	int err;
+
+	err = init_mkdir("/root", 0700);
+	if (err != 0)
+		goto out;
+
+	err = init_mount("rootfs", "/root", is_tmpfs ? "tmpfs" : "ramfs", 0, NULL);
+	if (err != 0)
+		goto out;
+
+	init_chdir("/root");
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
+	init_chroot(".");
+
+	return;
+
+out:
+	printk(KERN_WARNING "Failed to mount over rootfs\n");
+}
+#endif /* CONFIG_EMPTY_ROOTFS */
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 15e372b00ce70..3a261f1ae0d64 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -41,3 +41,9 @@ static inline bool initrd_load(char *root_device_name)
 	}
 
 #endif
+
+#ifdef CONFIG_EMPTY_ROOTFS
+void __init overmount_rootfs(void);
+#else
+static inline void __init overmount_rootfs(void) { return; }
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
+	overmount_rootfs();
+
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
-- 2.42.0

