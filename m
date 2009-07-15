From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/14] For review
Date: Wed, 15 Jul 2009 18:50:32 +0200
Message-ID: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Here the latest patches for review.

Highlights: 
- LVM, LUKS, MD, DM handling can be specified on the command line
- redhat-i18n now supports all languages and keyboard layouts 
  in the generic case and can be set on the kernel command line
- testsuite for booting from degenerated raid arrays
- command line hook scripts should extend initrdargs for later 
  stripping
- generated lvm filters
- info() vinfo() getargs() in dracut-lib

Hans de Goede (3):
  10redhat-i18n: Fix handling of kbd maps which are a symlink
  Make Intel BIOS raid use mdraid instead of dmraid when mdadm 3.0 is
    available
  Fix lvm on top of dmraid

Harald Hoyer (11):
  dracut-lib add getargs()
  dmraid.rules changed comment in header
  change the way init arguments are stripped from the command line
  limit the devices for which lvm vgscan will scan
  remove partitions from raid devices before they are used for
    something else
  add info() and vinfo() to dracut-lib
  add command line parameters to specify exact actions for root
    assembly
  extend TEST-12-RAID-DEG to check for UUID command line parameters
  Makefile: add debug module to the testimage target
  install all /lib/kbd to initramfs, if not host only
  dracut-lib: if "quiet" is specified, do not print info() to console

 Makefile                                        |    2 +-
 dracut.8                                        |   53 ++++++++
 modules.d/10redhat-i18n/install                 |  148 +++++++++++++----------
 modules.d/10redhat-i18n/parse-i18n.sh           |   14 ++
 modules.d/50plymouth/cryptroot-ask.sh           |   28 ++++-
 modules.d/90crypt/cryptroot-ask.sh              |   25 +++-
 modules.d/90crypt/install                       |    1 +
 modules.d/90crypt/parse-crypt.sh                |    6 +
 modules.d/90dmraid/61-dmraid-imsm.rules         |   21 +++
 modules.d/90dmraid/61-dmraid.rules              |    9 +-
 modules.d/90dmraid/dmraid.sh                    |   14 ++-
 modules.d/90dmraid/install                      |    6 +-
 modules.d/90dmraid/parse-dm.sh                  |    5 +
 modules.d/90lvm/64-lvm-vol_id.rules             |    3 +-
 modules.d/90lvm/64-lvm.rules                    |    3 +-
 modules.d/90lvm/install                         |    1 +
 modules.d/90lvm/lvm_scan.sh                     |   27 ++++-
 modules.d/90lvm/parse-lvm.sh                    |    6 +
 modules.d/90mdraid/61-mdadm.rules               |   16 +---
 modules.d/90mdraid/65-md-incremental-imsm.rules |   21 +++
 modules.d/90mdraid/65-md-incremental.rules      |   32 ++++--
 modules.d/90mdraid/install                      |   10 ++-
 modules.d/90mdraid/mdraid_start.sh              |   14 ++-
 modules.d/90mdraid/parse-md.sh                  |   27 ++++
 modules.d/99base/dracut-lib.sh                  |   42 ++++++-
 modules.d/99base/init                           |   14 +--
 test/TEST-12-RAID-DEG/create-root.sh            |    9 ++-
 test/TEST-12-RAID-DEG/test.sh                   |   39 ++++++-
 28 files changed, 471 insertions(+), 125 deletions(-)
 rewrite modules.d/10redhat-i18n/install (62%)
 create mode 100644 modules.d/10redhat-i18n/parse-i18n.sh
 create mode 100755 modules.d/90crypt/parse-crypt.sh
 create mode 100644 modules.d/90dmraid/61-dmraid-imsm.rules
 create mode 100644 modules.d/90dmraid/parse-dm.sh
 create mode 100644 modules.d/90lvm/parse-lvm.sh
 rewrite modules.d/90mdraid/61-mdadm.rules (100%)
 create mode 100644 modules.d/90mdraid/65-md-incremental-imsm.rules
 rewrite modules.d/90mdraid/65-md-incremental.rules (70%)
 create mode 100644 modules.d/90mdraid/parse-md.sh

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
