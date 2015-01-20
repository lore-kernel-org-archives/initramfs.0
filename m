From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v1 00/11] extend initramfs archive format to support xattrs
Date: Tue, 20 Jan 2015 14:12:49 -0500
Message-ID: <1421781180-24425-1-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-security-module-owner@vger.kernel.org>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs <initramfs@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage.=20

The linux kernel creates the rootfs file system and extracts the conten=
ts
of the initramfs, a compressed CPIO archive, onto it. If CONFIG_TMPFS i=
s
enabled (and "root=3D" is not specified on the boot command line), root=
fs
will use tmpfs instead of ramfs by default.  Although the tmpfs filesys=
tem
supports xattrs, the CPIO archive specification does not define a metho=
d
for including them in the archive.=C2=A0 Other archive formats have add=
ed xattr
support (eg. tar).

There are a couple of ways to include and label the rootfs filesystem:
- include a file manifest containing the xattrs in the initramfs
- extend CPIO to support xattrs
- add tar support

This patch set extends the existing newc CPIO archive format to include
xattrs in the initramfs.  This change affects usr/gen_init_cpio,
scripts/gen_initramfs_list.sh, and init/initramfs.c.  Included in this
patch set are the associated IMA and EVM policy changes.

Changelog v1:
- Patch "init: remove "root=3D" command line option test for tmpfs deci=
sion"
  was previously included for testing without userspace application (eg=
=2E
  systemd, dracut) changes.  The associated userspace changes will be
  posted to the relevant mailing lists. Patch dropped.
- replace simple_strtoul with kstrtoul
- add some input data checking
- change size of mtime and file length to 64 bits
- define new gen_initramfs_list.sh "-x" command line option
- define new IMA_APPRAISE_ROOTFS Kconfig option

Mimi

Mimi Zohar (11):
  initramfs: separate reading cpio method from header
  initramfs: replace simple_strtoul() with kstrtoul()
  initramfs: add extended attribute support
  initramfs: change size of mtime and file length to 64 bits
  gen_init_cpio: replace inline format string with common variable
  gen_init_cpio: define new CPIO format to support xattrs
  gen_init_cpio: include the file extended attributes
  gen_init_cpio: change size of mtime and file length to 64 bits
  gen_initramfs_list.sh: include xattrs
  evm: make rootfs a special case
  ima: include rootfs (tmpfs) in ima_appraise_tcb policy

 init/initramfs.c                    | 130 +++++++++++++++++++++++++---=
-
 scripts/gen_initramfs_list.sh       |   8 +-
 security/integrity/evm/evm_main.c   |  12 ++-
 security/integrity/ima/Kconfig      |  12 +++
 security/integrity/ima/ima_policy.c |   8 ++
 usr/gen_init_cpio.c                 | 159 ++++++++++++++++++++++++++++=
++------
 6 files changed, 282 insertions(+), 47 deletions(-)

--=20
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-securit=
y-module" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
