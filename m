Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCE1DE8BB
	for <initramfs@vger.kernel.org>; Fri, 15 Aug 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260128; cv=none; b=azzYd1vCDM1xgiI1Z2pEjgj6QH9p+scaEAnRCsDGY5aM94ZCFf0C2oVVzVadTQQlpd4XIZ83/NxPj1rvqyQLWr7DxQvuUzKmCZrr+s9Rc+TOZAWVLturIj6ePgd1qdwwC6P0kt/3xGyyX02wjf6G0vx410MVau4jIHU+g6k11iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260128; c=relaxed/simple;
	bh=gEv2g7BGtpAQgouGWzFDZzg0811yav0QrVZT75lMYmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txwrnsqSk44eSARuWfQG99wCVzOjZTebJS7ZbbPFgzGOMegkMKmbBwFR8wE7TcY8oluu112ySA7bpNdPBupbxH2Omv9vmAG5j/JEMbQRh6NZtsVtCdqk7x/iujhsLJhoclafg30PAG6DtacIXm59+V7dQ0b3S75t026ypq0Tzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdItEpAC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdItEpAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755260126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aoEbLDIBvIED/1Ge3yK9oelt843+Qxf+G9/P7ezt/24=;
	b=PdItEpAC3BAJz4c9r0PYR3NIr5kuTFHBPs1blCRsaFQM7QJZ+Ld/5W8oEU7UGswxCayNJV
	8WqKkn43MiObUdoR3FNbEho50RgGqG0EGQCfktHH8ap99R+3p/rQ2npArF4cyIfyY+7muD
	be9XCjKl2wkm+DEAljEzAJZbhQLn/TM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-fttZ_d-nNDW1rXRUSqjEgA-1; Fri, 15 Aug 2025 08:15:24 -0400
X-MC-Unique: fttZ_d-nNDW1rXRUSqjEgA-1
X-Mimecast-MFC-AGG-ID: fttZ_d-nNDW1rXRUSqjEgA_1755260123
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581c62faso18975525ad.2
        for <initramfs@vger.kernel.org>; Fri, 15 Aug 2025 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260123; x=1755864923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoEbLDIBvIED/1Ge3yK9oelt843+Qxf+G9/P7ezt/24=;
        b=n4WJw/qNw08rFXMtNPATRURRTFHpLNjFyi10jNG0CpSi/TkFK7kPfv72AhU9/cZIqC
         ZvW62LKD6UDcZzJazm7jrC8R8Bqp/4BHai/2OhZ9Dr2yi/iAWmxAo+tg9PHey+i7LudS
         ejZIlWPGbzr54oo3ck9b9FTxeRdxY5/cBQvnwAIBqUSTzhN9ks+ZHQw+1mFPhiG08y0R
         F6lBglGFJ7nulOMBv0JHTJTM93hlEFvruWWLVTnhWtt/PakaxRWXapCYkGh3ELqhYToz
         hBYpcL1XGvj2rLCFLZuhs83GkzR8QdJ6NBrE6yfGV4o+Kmaf2WYRXt/Tr0MOHO775k+2
         NFsA==
X-Forwarded-Encrypted: i=1; AJvYcCVuj4JbVxPxkEfNIfgGZbnUxaxAIXekRlqGweSjGlg99UMXp8ygZYfoewkNRdWyaF+yqCvf2yC1XUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yX3/1jeue76WGOURyXKUCedtDA3cWsEftTbYB9gvtSOcPvxQ
	LwSakGG1V0rybSrcj0pjBHA3z3wVySGf5/TErF0C3LxViL+GnJ0f1wdixL4zuyAT8cEjhOwqwP6
	tmZ3sVRyv81zNRX30olNGvv6CkHkUHBfVq9adykIVuTpc42UJnJGhiCpz7IarwA==
X-Gm-Gg: ASbGnctXuNfh5JFDTP0i/0M5sqNCdWplp9H5eRKJvc3bWGx5U8B8+oQAoZ5LTrjpRIi
	9reiDhmwHK3/NScluZSMM5Yegd7fbIGT1GkaGExxjyszIL00vnWfzOyzoKhn35AqOxu3C5NUcQ/
	La/ttGd5egEcbPz2xUWkW9EHHg9FAMgTglHvfR0urQoICNIUWGRMoMdIVtCLYQdhxyT5HccvD2f
	kpl/WCim29cbKBAuP6SxDE6VSt2anH+rTJVsCX7CZhhpZANsHaoVuUC3ORtanE4/rsOgjpf3oqX
	/NsmxNQaCQYMinGGr+GzAa7s1H239AvkV4JvRpmP+dQoba3HhQ==
X-Received: by 2002:a17:903:906:b0:240:49d1:6347 with SMTP id d9443c01a7336-2446d8b1ef5mr28473065ad.35.1755260123373;
        Fri, 15 Aug 2025 05:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEGS5d2wzwEmY71Sxbu2mJGMdxqpSOcx9nx9YZK43BD2pagvwbnN2eEpAtX7LvuEgnSJ4lNw==
X-Received: by 2002:a17:903:906:b0:240:49d1:6347 with SMTP id d9443c01a7336-2446d8b1ef5mr28472675ad.35.1755260122913;
        Fri, 15 Aug 2025 05:15:22 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:a40:5c04:f864:9735:818c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d74bb8asm1157463a12.31.2025.08.15.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:15:22 -0700 (PDT)
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
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Date: Fri, 15 Aug 2025 20:14:59 +0800
Message-ID: <20250815121459.3391223-1-lichliu@redhat.com>
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

Also add documentation for the new kernel parameter "rootfsflags"

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
Tested-by: Rob Landley <rob@landley.net>
---
Changes in v2:
  - Add documentation for the new kernel parameter.

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 fs/namespace.c                                  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..0c00f651d431 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6220,6 +6220,9 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	rootfsflags=	[KNL] Set initial root filesystem mount option string
+			(e.g. tmpfs for initramfs)
+
 	rootfstype=	[KNL] Set root filesystem type
 
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
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

