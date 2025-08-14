Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C3262FDC
	for <initramfs@vger.kernel.org>; Thu, 14 Aug 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167961; cv=none; b=RMp9FK15tqX5fdPE2Kmq3Nn095yPf3eUGSVc0d+gvimT27/UBlcE7E2WPAVoQYrFtrQC8hko7p5k3fgfj3RYEFXkLFPMZ7T5i2Vviy95ABebmFZpdNHDcyIo1ej+I2TybgfhV0zjKuN/4m2iKd7q62IsP7KqpTAXvSUhUhoioCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167961; c=relaxed/simple;
	bh=vy/kbyBLqEKNnDXX9JSY4JStM3dRhA0LlMTcKbNGUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5mH3eVaH/pZcJdkQFK5AoEagWRLVxSHlnGCCWMuP4O4+3tQb/FImkwx7ZburREgLmSo9ZbcUqVcEsKmwWB9TXcIJeJiXAiSJHvD/p+egELQHFt632LYcIqKWKxt0asgUhezzlWTmbjbg2Y6AaMhJ1xo5aWIuERIms9ngGsT+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2LXt2og; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2LXt2og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755167958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
	b=h2LXt2ogwT+r32Npyoy3tw4PnCCuX1EhkMpTpbgydS1cOw6kXyKnLLfHbuvny2WQbbvNvx
	fdKBG316TUiUoMGTfod/MjNCk7MuCaDh1hAmtKCPrd0hUwkrH0d7/dDzDsYy8IVpeqhV9x
	g0UEv+hXRLL9x7ifbigm+JGl4bNMAfs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-whh7ybDPMBKgd8eUbwU3SA-1; Thu, 14 Aug 2025 06:39:17 -0400
X-MC-Unique: whh7ybDPMBKgd8eUbwU3SA-1
X-Mimecast-MFC-AGG-ID: whh7ybDPMBKgd8eUbwU3SA_1755167956
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47174b3427so544483a12.2
        for <initramfs@vger.kernel.org>; Thu, 14 Aug 2025 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167956; x=1755772756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
        b=nEC3MhX+VRdmSM2SQVs2VEt0+BlYKFOvSJG5YveFXMdf44MXI+6Dljv+OOGrg9DlGd
         3qtnbTZr4qgRYNEcdQdHKFsT0PzeDQ5DRNc7W8KaC4QVEotv082OjlqekSCSJ0CRLQEj
         uGp4GYxVgtQoJX9zq8nF4mAputldEHFNtA7NTTp+scbf00Dp4WOgBiIYbu+iPJ4AQdZd
         j7xDs8yLBcC2KWelNrZ476+0ILOX6IHlSQLa7rfVhWmY+/5phj1x24b76Mzk8cFXXHCg
         LzTyoku53ifAfZiAqO8ty2bl8AMtador8LLm6czpVbQ22qGw1Y+2/D4iMU6pD4qTyAsn
         xsXA==
X-Forwarded-Encrypted: i=1; AJvYcCVI+4z7u3CRPhyv9LuM1iCBODsaxj/bA9pQV3tU85i1F7bVZk6yStwTHzOOMGtoArJtmDJWErJQ01o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlDMr4yuqrFNMdpPC5F/+DJkgGll/bWXm3RunJsou3slPRwzZ
	HqkqUDTRBHtDzyFR9NlntCjlAcw1yh++E4aOy/QlQj+r00XSD7pRUgd0qkBnDOi5SwkEGeCGz/6
	87pyeyCVng/D4PwK7mXKbiooTGss3TYr7o1XdyaVq6GdcKiWZFdY1h9RvLGcCnA==
X-Gm-Gg: ASbGncuFFJpdtm6nebEYm7EFaA0XPLz0c4cfve5VH0DJrCtWlY9Skf2HHfd64PJjFHe
	QtBCwl0m2nAmiU7cQs2H2rY6DFCj9jsqWGvhhDqZbyvG8vbKK00GX16gmPFOcakFSI6jr8AuQNs
	aKEW7JC1rTKjBMQdf2yRCmDHQaVP6fvs/VDVRxbwamUKNKSUehFmR3JGkFuXlsOl47jFQNGR8n9
	B9xlPCVfPLfIGuFNFha3PS5Mz8ebL2kzeoIJx4faQTX8LbN1Eo8bx5I8S9jG9rPuiknffKA/0DC
	chUjsCRbRt2C3KNk2XXxTSDDR1/7KZ9OXJ4EaPreAuu6AvjuYA==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875752637.17.1755167956031;
        Thu, 14 Aug 2025 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0qcRzLZjEIlriBSOpvCVTTIlZIky5VrZnbpwFkW4qbY9gLvkwJS1z02pXRiF8AX+jnTsQoQ==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875724637.17.1755167955635;
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:a40:5c04:f864:9735:818c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6eesm34424189b3a.22.2025.08.14.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	safinaskar@zohomail.com,
	kexec@lists.infradead.org,
	rob@landley.net,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-api@vger.kernel.org,
	zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	initramfs@vger.kernel.org,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 14 Aug 2025 18:34:25 +0800
Message-ID: <20250814103424.3287358-2-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
By default, a tmpfs mount is limited to using 50% of the available RAM
for its content. This can be problematic in memory-constrained
environments, particularly during a kdump capture.

In a kdump scenario, the capture kernel boots with a limited amount of
memory specified by the 'crashkernel' parameter. If the initramfs is
large, it may fail to unpack into the tmpfs rootfs due to insufficient
space. This is because to get X MB of usable space in tmpfs, 2*X MB of
memory must be available for the mount. This leads to an OOM failure
during the early boot process, preventing a successful crash dump.

This patch introduces a new kernel command-line parameter, rootfsflags,
which allows passing specific mount options directly to the rootfs when
it is first mounted. This gives users control over the rootfs behavior.

For example, a user can now specify rootfsflags=size=75% to allow the
tmpfs to use up to 75% of the available memory. This can significantly
reduce the memory pressure for kdump.

Consider a practical example:

To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
the default 50% limit, this requires a memory pool of 96MB to be
available for the tmpfs mount. The total memory requirement is therefore
approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) ≈ 220MB.

By using rootfsflags=size=75%, the memory pool required for the 48MB
tmpfs is reduced to 48MB / 0.75 = 64MB. This reduces the total memory
requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
smaller crashkernel size, such as 192MB.

An alternative approach of reusing the existing rootflags parameter was
considered. However, a new, dedicated rootfsflags parameter was chosen
to avoid altering the current behavior of rootflags (which applies to
the final root filesystem) and to prevent any potential regressions.

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
Tested-by: Rob Landley <rob@landley.net>
---
Hi VFS maintainers,

Resending this patch as it did not get picked up.
This patch is intended for the VFS tree.

 fs/namespace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8f1000f9f3df..e484c26d5e3f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
 }
 __setup("mphash_entries=", set_mphash_entries);
 
+static char * __initdata rootfs_flags;
+static int __init rootfs_flags_setup(char *str)
+{
+	rootfs_flags = str;
+	return 1;
+}
+
+__setup("rootfsflags=", rootfs_flags_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-- 
2.47.0

