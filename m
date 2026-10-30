Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394614;
	b=40CQpWpPguyCA78tdJuzTIwW51Ej6eD8MLqeIlkV4JtaMy/O4Lgx0dc7XwY4wccR7zjR
	 8Fmngi2/ijh9bxsaXWXGpPr+dNmWEef1ckoBg/eGwmexJ1p+zPwXUvqCkaT0Ru8uKUmcp
	 50zY4mVx/1VgeaDoz9+pOgaZaUnbXuI3/xj0i0FuzYLgUmmyL3mYZlrwWdMmvS4JkRFhh
	 /MxRNtoI318PisXAyMgBm7HXV0wj63+H0teKc9s4chekRsgKa2ay1Qj2Df0D71tPUsw8N
	 Gr/sXGDJZMHkNtw7FqD6hEO4vxj29kgZZtLZ/IQHxIPK/79jEKo4NGw9KczMc5Ofj+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
	b=dLydHnesLal5JeyIlzUvazKWIYg0pWFe1jYc62elWvbrhTP/P8nMgMi+v2QqkHLsuTl/
	 uMUR9RqOHTV2kGspIl8XXrLAQF1k2HOJPDlMaIZJ8DrHNfkses925v2AhYfekR9SHbe0z
	 8Bf5Lj6oOjCGP298dAiLbDSlVb9MYpCcib4/rjRZCNVWk6S4JTUNnFzRg1BCMh+6IwfhT
	 RPXEQz+Wffrbk7B0nulGXfDOH5ZbqXtPxzBbR8ZSS23ZWQV3yVCBGUPUFCjcY/wsa0YBZ
	 UxjDkWPHx945toV3KBZrp/M1d6CN3GasWXR9AJa8hc28VDogkOQmhOMGwy3R/wtqr5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=ivo2T3XK;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E386606A321
	for <initramfs@vger.kernel.org>; Fri, 30 Oct 2026 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E386606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=ivo2T3XK
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1096913c88.0
        for <initramfs@vger.kernel.org>; Fri, 30 Oct 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793394613; x=1793999413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=ivo2T3XKqnoTABezZSv1AgcxO9h6PJ7Qopg7cUS65dXJFysagwyPqQGUk8hWhqHvpK
         71FOoOHiaTT+wsagSGZ2Psrdkzxniqz7Otz9mwCH040rLqxkpyZTi86b/Kp8dUqOOSVq
         seujfQwMyQWx7L481DgAeN6tGyeAaoGE6gZJrCgPB17QtI+G2xshds41s36d1gEicJyo
         XMsooceQR8/4pAi1nRLpgGi0xsdp6LvVo0dIhHhkPbVE9X4lccFrRbDx5d/x/SgkttxW
         2+6w0zIDkSSuXAOGFD3P+iPwCda2DWqfqeOYS+cbnOyhRaYEzu1i6OARqGJxaIQdlhL7
         /OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394613; x=1793999413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=rT0x1Eu5vkPrrx4clZKqLFnj2fWDZkDDoV0by8siiXc8RUb7JDl5Q4zgN/iDPOC9NK
         euBuviYx7DftOIo5Cc6YhU5LvqyNEKNwdpvI8v9WvUZAUaOsl5uc1kUj+dyzZ6gWyVbK
         MxG02WsAv1fIhniIB3CBDbE6tl1ZMnk2NhhLcuIVe+Z5e7sUrBPxow/9v2meqSqsVxKQ
         wiT2U55RLeaTeCAMCGiiFnBOAle6COeKZQLOsfw24e6Bhc7/GbmgB8AtJiYZfJOzgh5w
         /vnWroEnzymtQfsSYoh9A+70oI4XZWmu6wuFWvW4WsemMj9aP3Z2Ir/f/+VBnGEul7CN
         4VQA==
X-Forwarded-Encrypted: i=1; AKwUvBxDyOMJRKFljahjYI2Muhsv/kOA1r5IDr6XooEsuOw4vox5Rs/1sko4O3UDp0muQsrzQMH/ZipkNwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1nBocJOJinKi3HNd90h6KUL6RRJwh8CoH+Yk6v3Bnry3U+vim
	5Q4qVoqCzRFhklN+TizRc/DtrRnmaeIlIIVkLi3647Z3CPLN/+2+K8EhKvSFOBu81g==
X-Gm-Gg: AYBFou0Rt/5U9dt2Px0x43a1qvxgsHBBi4XhvlehgwFomXPy8SWBuquBmisWA3UM5Sv
	RisnGvPG/NsNMFxZz89LxuoaplK4g3NxOisGts5eads/OCh4DIXyTZUqjLACUHjJjuvsaFTXKFP
	cWeKfZJeOT3O/uz4fn73/yXHR2IINdefL+GvRhmvylr9k/mQAogS1iWnJa0s71FMmIWdS69jqlN
	T1u95NFn16lVauOlTy4B3R9Y8hOZydjmmF+b0s2Xch8fmQb/cmQ2GIuMfBdbz+KWrykIKVPK4j2
	Zr5eZIg3+cySUjnYRorfKN63NckNwGIO8ugcpXhYYM7GnWFGtLTrOHY2VvoB8YSj/OAm7nuQBFo
	1Q6A9Q/XqqZU7WkwYKEkuwIMrV58T43+W8/LjvqInBMAFOAWMeU0G/vxJt1PNvrfIQrDYBlT7AF
	TJkk31G5lFSB7J8SkLu2sT74I7Az2F63TAjLP8p7O+go9yyDFl7yEzSBxtU5Y+tKV3s6nlUgzCb
	8gSiBw2YGtepwzyZGxMaa1v1wltNgHmWBoZtbJlVrMMLm5qAZyY4Qp9tDMZa/ZgQfLYdIetmxoA
	DZzFSdM17QWUDaY8dRx0EBm2umumw/t4YaXP0KF9S95Raob5avUJuxOESwpQwO1tG2nSROJntRO
	RWq5S7s6zaQcKMU4WJh10BW4=
X-Received: by 2002:a05:701a:c907:b0:185:33ab:4d55 with SMTP id a92af1059eb24-1ac5f1810d2mr4226717c88.29.1793394600810;
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm9471777c88.21.2026.10.30.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
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
	Tianxing Zhang <zhangtianxing3@huawei.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhoushuiqing <zhoushuiqing2@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	rob@landley.net,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	erosca@de.adit-jv.com,
	alexandr.lobakin@intel.com,
	jim_baxter@mentor.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v5 0/4] initramfs: add support for xattrs in the initial ram disk
Date: Fri, 30 Oct 2026 14:09:39 -0700
Message-ID: <20261030210944.2143778-1-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
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

This patch set aims at solving the following use case: appraise files from
the initial ram disk. To do that, IMA checks the signature/hash from the
security.ima xattr. Unfortunately, this use case cannot be implemented
currently, as the CPIO format does not support xattrs.

This proposal consists in including file metadata as additional files named
METADATA!!!, for each file added to the ram disk. The CPIO parser in the
kernel recognizes these special files from the file name, and calls the
appropriate parser to add metadata to the previously extracted file. It has
been proposed to use bit 17:16 of the file mode as a way to recognize files
with metadata, but both the kernel and the cpio tool declare the file mode
as unsigned short.

This v5 revives Roberto Sassu's v4 series posted on May 23, 2019
(https://lkml.org/lkml/2019/5/23/415). The github issue tracking the
revival of this patchset is here
(https://github.com/linux-integrity/linux/issues/11).
This revision incorporates unpublished changes
from other contributors that can be found in
(https://github.com/linux-integrity/linux/tree/initramfs-xattr-v1-devel-v1)
and adapts the implementation to newer kernel interfaces. Compared with
v4, this revision adds an IMA deadlock fix for restoring security.ima
xattrs during initramfs unpacking, switches to a Kconfig choice for
metadata type selection, and updates gen_initramfs.sh to pass source
paths to gen_init_cpio for nonregular entries, allowing their xattrs to be
read from the correct source object that will be included in the archive.
This revision also includes various improvements to error path cleanup,
debug output and tool documentation.

The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
separate files instead of a single file. Given that files with metadata
must immediately follow the files metadata will be added to, image
generators have to be modified in this version.

The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
all files have the same name. The file metadata are added to is always the
previous one, and the image generator in user space will make sure that
files are in the correct sequence.

The difference with another proposal
(https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
included in an image without changing the image format. Files with metadata
will appear as regular files. It will be task of the parser in the kernel
to process them.

This patch set extends the format of data defined in patch 9/15 of the last
proposal. It adds header version and type, so that new formats can be
defined and arbitrary metadata types can be processed.

The changes introduced by this patch set don't cause any compatibility
issue: kernels without the metadata parser simply extract the special files
and don't process metadata; kernels with the metadata parser don't process
metadata if the special files are not included in the image.

From the kernel space perspective, backporting this functionality to older
kernels should be very easy. It is sufficient to add two calls to the new
function do_process_metadata() in do_copy(), and to check the file name in
do_name(). From the user space perspective, unlike the previous version of
the patch set, it is required to modify the image generators in order to
include metadata as separate files.

Changelog

Changes in v5 relative to v4:
- Rebase onto vfs.all
- Add an IMA fix to avoid a deadlock during initramfs metadata restoration
- Use u32 metadata record lengths and reject records smaller than their
  header
- Improve debug output for binary xattr data
- Cleanup metadata buffers at the end of unpack_to_rootfs() 
- For CONFIG_INITRAMFS_FILE_METADATA, replace the metadata string prompt
  with a none/xattr choice
- Fix resource cleanup and format specifiers in gen_init_cpio
- Update gen_initramfs.sh to pass source paths to gen_init_cpio.c for
  nonregular entries (slink, dir, nod). Modify gen_init_cpio to
  properly collect xattrs from the source object. Without this change,
  xattrs will not get included for slink, dir and nod.
- Add documentation of xattr option in usage() for gen_init_cpio

v3:
- include file metadata as separate files named METADATA!!!
- add the possibility to include in the ram disk arbitrary metadata types

v2:
- replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
  (suggested by Jann Horn)
- replace ksys_open()/ksys_read()/ksys_close() with
  filp_open()/kernel_read()/fput()
  (suggested by Jann Horn)
- use path variable instead of name_buf in do_readxattrs()
- set last byte of str to 0 in do_readxattrs()
- call do_readxattrs() in do_name() before replacing an existing
  .xattr-list
- pass pathname to do_setxattrs()

v1:
- move xattr unmarshaling to CPIO parser

Danny Hu (1):
  ima: skip algorithm availability check until initramfs unpacking is
    finished

Mimi Zohar (1):
  initramfs: add file metadata

Roberto Sassu (2):
  initramfs: read metadata from special file METADATA!!!
  gen_init_cpio: add support for file metadata

 include/linux/initramfs.h             |  19 +++
 init/initramfs.c                      | 140 ++++++++++++++++-
 security/integrity/ima/ima_appraise.c |  25 +++
 usr/Kconfig                           |  19 +++
 usr/Makefile                          |   3 +-
 usr/gen_init_cpio.c                   | 216 ++++++++++++++++++++++----
 usr/gen_initramfs.sh                  |  15 +-
 7 files changed, 401 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/initramfs.h


base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
-- 
2.51.0

