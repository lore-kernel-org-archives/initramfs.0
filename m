Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907478;
	b=b00s1GKshQg8SeCayjeImmqaUh8ISwE3S9QwUY9Co7sdhQFIn4flOWqkYnTEvOndZ+CV
	 DH0Ux6UcZ0ZbLW5qfLL/g5TPFHMPl2qQVeRxsuPGvZcA/EzZPZ1R4QXKCbEta9W2ON1T4
	 j2ue1elFDhdATHHIqLZKzK/g3D53N4IVZO0oS+XRxerjDoTFnBIfuAWS67dLEL4aJzBq9
	 SG7P7t8r6eO9yMvyYkwl4B1njYy7nvsTg+bUu3H18i3QR8+CqT5/RY0BmszJDfcvMcc3K
	 OmfvmStyG1rZd2a0/eOOGtmvnJNlIv9YsnMIs9y94P8O9vAoFptJ6uNyyKDNm4UWXFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
	b=RA1XlAaJvAH+qdVA39bL9nasQ5JxbTS/GHF6EG7kc7bnuyNG9hPSO2DgQMi6Q/wN9XHp
	 vpDHdj9mhTb1mUPAGSGDNEqewlfO18Sulpa9q2cn4D1zAqOCJKqhO3iklfsWDuHD5L2+I
	 WoxcNHglTomqdTWza1+NJT/ZDuGclZ7PdgOqD8Mb5kGvffwVVYHF0OxwTNeF/zppRIilK
	 p0woH+oaLUYXAu3iCf8fv9ws9pzEfZO44+9nWhTcbL82cebLFhxjoCWX3AMi5z1B//7Lm
	 9xDbYyeVtVxPDaJLvAlqMB7RUtkb3Q7GCJorq1kKTEA3ZV83z1KqZ+ae94IbXlaQvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E28607B96A
	for <initramfs@vger.kernel.org>; Thu,  5 Nov 2026 19:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E28607B96A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36d6765756fso2917246eec.1
        for <initramfs@vger.kernel.org>; Thu, 05 Nov 2026 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793907477; x=1794512277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=cPl6L7vv4IdiTxomRsfBZyJX59O6aKePsnYBsOL+Il0TM2e7QZLMYUoor5RewSvnv7
         vLLbLRMSyMW/YKWH7JVRt+VA8awqGEfSTnb3NSI212h84khTjynO2iw5mzK2nVh11z5d
         EZ6tC6WQcQkAThRjYpVZDYHpM0IHCup/ssjDItaCiUmXD6fNSzFXuqyMXfcjXo9Y3C18
         AjZA2LqCbQEPJQKpzTHX/9JMW5k+59UhN0TUOXzSYbdIuRgq6YZLqhp3MfDyp1FFBB4n
         21C0wHgHpp9aOnGvecq21MbiLJ846BIuczpuDUnGu78BBlZgT6V+04NGwiDJ3uZbl2e6
         YlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907477; x=1794512277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=ljii6emUIdp0scse6Dc6lc/GpM/GIFG+tPXVgDyktKsjeD2jguPPAMmVbr7pHAhmOF
         /86mUF/ujSzVs927X+FoUCiVU+ykz98yFNu6eg3kvHm9zg6DK0stbDor3V8dCg6Vkg8N
         pRINtIY3QLnA/2JJdcTixH9iZ5eAhcN+nuKg1sjTCkXGlFjbFfY516sYemji0/ueVAZ7
         LwITBaISoARD+kigF2w4nTmu5+AXcJP0lZ3Wt1ulTC6Xw4zm029bR+IP+ihSaDD0EA1i
         iknLzYGtqt9ykLzMljQWB+c19K/LLqHK4kPg1l2YrfLA9tCU6yjMZPGgdf6DQa65jilx
         glvw==
X-Forwarded-Encrypted: i=1; AKwUvByq5Eo5opAx+UXFPfeIjgLMem06DhkNUzSfug9XSBepkT2DxUgXPyBgCuwWTc7svbXwX67MH5APioo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yYeOwycEjIeBbMGZWNBF7feAFaX0nA3FjFW+ErtPcDc/GTwNZ
	lrsVK8AMcTw4sjU4sLjbCxFiHY6spH4/acdvtRNTB6eb9UzV9arsFziZyZKOTyPf7g==
X-Gm-Gg: AYBFou2f9LWyOm0Skww6YPFHdYN+PPRY35JAeSY8gxaQi/dMFKYyT8M3ien0F2xBQuQ
	PkVPcC76cIFhEEzop5NrLZdaNx4OD+YnLi32n/bd/IU+u4lyaIr6134qYsleY0NKW6klZb/frz3
	15EXz2pdh2v+KJPY9cKM6Utgob2S0H6C93qO409nAPyDZrbRmb33famSqFHw7Ax2zCTcg78yNO9
	wPD+3bNLQUcuZyJ+hc2okWDqVa/mm45ClHlmvOUMACgGX8hKCnyGwOMlwqp+CR2ttOJSHJwiSUT
	m1fIEadpT0P5BigNYBa66x4fbIR0LzdXZpiMJRrhteUeLXDJnN6okPZUtSt634SurnzborwUC3O
	ocv+5qfeWMKYyiIQXIKb+8NSeTzK4MK2vzh/lnYoIAX3Dx89JSLinAPkGwFPg18Rcw5EjJyixHL
	izaQ49rp9N/jexwZDEqivurcPk4Qpv7r7VNMt2vunnSJT1lU7CG7ZJlVitO9ucjJP2oEi9vT1wz
	iZSw2M0cb/F47LcEerkLTFnw1roWhxTz++PiTno7awfr9e5z04IUXONhamyD/xviHMl1UL9AWOP
	6U5AiRsO5/XhC3jShlVCw3hDTEJeY7bRa1uzWGZf00pxmHdWVOaw35l5XA+Pw91Zsozt0205XkE
	S/Eqojhp/gZzUHz+WVXYoT8M=
X-Received: by 2002:a05:7301:6285:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36f76f0e752mr142560eec.38.1793907476899;
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f72ec8a02sm326134eec.11.2026.11.05.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
From: Danny Hu <dannyhu@arista.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Victor Kamensky <kamensky@cisco.com>,
	Taras Kondratiuk <takondra@cisco.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	alexandr.lobakin@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v6 2/4] initramfs: add file metadata
Date: Thu,  5 Nov 2026 11:37:41 -0800
Message-ID: <20261105193743.2654656-3-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261105193743.2654656-1-dannyhu@arista.com>
References: <20261105193743.2654656-1-dannyhu@arista.com>
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Post: <mailto:initramfs@vger.kernel.org>
List-Help: <mailto:initramfs+help@vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:initramfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch adds metadata to a file from a supplied buffer. The buffer might
contains multiple metadata records. The format of each record is:

<metadata len (ASCII, 8 chars)><version><type><metadata>

For now, only the TYPE_XATTR metadata type is supported. The specific
format of this metadata type is:

<xattr #N name>\0<xattr #N value>

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

[sassu: removed state management, kept only do_setxattrs(), added support
        for generic file metadata, replaced sys_lsetxattr() with
        vfs_setxattr(), added check for entry_size, added check for
        hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
        before do_name()]

[zhangguangzhi: fix checkpatch warning EMBEDDED_FILENAME in
                include/linux/initramfs.h]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Tianxing Zhang <zhangtianxing3@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Signed-off-by: zhoushuiqing <zhoushuiqing2@huawei.com>
Signed-off-by: zhangguangzhi <zhangguangzhi3@huawei.com>
Signed-off-by: Danny Hu <dannyhu@arista.com>
---
Changes in v6:
 - Document lack of support for POSIX ACL restoration. The main use case is to
   restore security.ima xattr for IMA use. POSIX ACL support is out of scope
   for this patchset
 - Check xattr name and value lengths to ensure they are valid and do not
   exceed the limit
 - Compare metadata header and record sizes against the remaining buffer
   length to avoid pointer arithmetic overflow in bounds checks
 - Use the kernel u32 type instead of uint32_t

Changes in v5:
 - For debug print in do_setxattrs(), use print_hex_dump_debug() rather
   than printing the xattr value as a string
 - Use u32 metadata record lengths and reject records smaller than their
   header

 include/linux/initramfs.h |  19 +++++++
 init/initramfs.c          | 103 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/initramfs.h

diff --git a/include/linux/initramfs.h b/include/linux/initramfs.h
new file mode 100644
index 000000000000..9b3839dc88a1
--- /dev/null
+++ b/include/linux/initramfs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Include file for file metadata in the initial ram disk.
+ */
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+#define METADATA_FILENAME "METADATA!!!"
+
+enum metadata_types { TYPE_NONE, TYPE_XATTR, TYPE__LAST };
+
+struct metadata_hdr {
+	char c_size[8];     /* total size including c_size field */
+	char c_version;     /* header version */
+	char c_type;        /* metadata type */
+	char c_metadata[];  /* metadata */
+} __packed;
+
+#endif /*LINUX_INITRAMFS_H*/
diff --git a/init/initramfs.c b/init/initramfs.c
index ebddde9c8f0d..d206624d1160 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,7 +10,9 @@
 #include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
+#include <linux/initramfs.h>
 #include <linux/kstrtox.h>
+#include <linux/limits.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
@@ -22,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/umh.h>
 #include <linux/utime.h>
+#include <linux/xattr.h>
 
 #include <asm/byteorder.h>
 
@@ -189,7 +192,7 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata unsigned long body_len, name_len, metadata_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -264,6 +267,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 }
 
 static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *metadata_buf;
 
 static int __init do_start(void)
 {
@@ -365,6 +369,103 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+static int __init do_setxattrs(char *pathname, char *buf, size_t size)
+{
+	struct path path;
+	char *xattr_name, *xattr_value;
+	u32 xattr_name_size, xattr_value_size;
+	int ret;
+
+	xattr_name = buf;
+	xattr_name_size = strnlen(xattr_name, size);
+	if (xattr_name_size == size) {
+		error("malformed xattrs");
+		return -EINVAL;
+	}
+
+	if (!xattr_name_size || xattr_name_size > XATTR_NAME_MAX) {
+		error("invalid xattr name length");
+		return -EINVAL;
+	}
+
+	xattr_value = xattr_name + xattr_name_size + 1;
+	xattr_value_size = buf + size - xattr_value;
+	if (xattr_value_size > XATTR_SIZE_MAX) {
+		error("xattr value exceeds size limit");
+		return -EINVAL;
+	}
+
+	ret = kern_path(pathname, 0, &path);
+	if (!ret) {
+		/*
+		 * POSIX ACL restoration is currently unsupported.
+		 * vfs_setxattr() rejects POSIX ACL xattrs with -EOPNOTSUPP.
+		 */
+		ret = vfs_setxattr(&nop_mnt_idmap, path.dentry, xattr_name, xattr_value,
+				   xattr_value_size, 0);
+
+		path_put(&path);
+	}
+
+	pr_debug("%s: %s size: %u (ret: %d)\n", pathname, xattr_name,
+		 xattr_value_size, ret);
+	print_hex_dump_debug("xattr value: ", DUMP_PREFIX_OFFSET,
+			     16, 1, xattr_value, xattr_value_size, false);
+
+	return ret;
+}
+
+static int __init __maybe_unused do_parse_metadata(char *pathname)
+{
+	char *buf = metadata_buf;
+	char *bufend = metadata_buf + metadata_len;
+	struct metadata_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+	u32 entry_size;
+
+	if (!metadata_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		int ret;
+
+		if (bufend - buf < sizeof(*hdr)) {
+			error("malformed metadata");
+			break;
+		}
+
+		hdr = (struct metadata_hdr *)buf;
+		if (hdr->c_version != 1) {
+			pr_debug("Unsupported header version\n");
+			break;
+		}
+
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtou32(str, 16, &entry_size);
+		if (ret || entry_size < sizeof(*hdr) ||
+		    entry_size > bufend - buf) {
+			error("malformed xattrs");
+			break;
+		}
+
+		switch (hdr->c_type) {
+		case TYPE_XATTR:
+			do_setxattrs(pathname, buf + sizeof(*hdr),
+				     entry_size - sizeof(*hdr));
+			break;
+		default:
+			pr_debug("Unsupported metadata type\n");
+			break;
+		}
+
+		buf += entry_size;
+	}
+
+	return 0;
+}
+
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
 
-- 
2.51.0

