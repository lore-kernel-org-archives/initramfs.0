From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC][PATCH 0/9] extend initramfs archive format to support xattrs
Date: Wed,  7 Jan 2015 15:52:51 -0500
Message-ID: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
xattrs in the initramfs.  The changes are limited to gen_init_cpio, the
kernel build tree tool used to generate an initramfs, and init/initramf=
s.c,
the parser, with minor changes to IMA and EVM.

Mimi


Mimi Zohar (9):
  initramfs: separate reading cpio method from header
  initramfs: add extended attribute support
  gen_init_cpio: replace inline format string with common variable
  gen_init_cpio: define new CPIO format to support xattrs
  gen_init_cpio: include the file extended attributes
  gen_initramfs_list.sh: include xattrs
  evm: make rootfs a special case
  ima: include tmpfs in ima_appraise_tcb policy
  init: remove "root=3D" command line option test for tmpfs decision

 init/do_mounts.c                    |   2 +-
 init/initramfs.c                    |  95 +++++++++++++++++++++---
 scripts/gen_initramfs_list.sh       |   2 +-
 security/integrity/evm/evm_main.c   |  12 ++-
 security/integrity/ima/ima_policy.c |   2 +
 usr/gen_init_cpio.c                 | 142 ++++++++++++++++++++++++++++=
++------
 6 files changed, 218 insertions(+), 37 deletions(-)

--=20
1.8.1.4
