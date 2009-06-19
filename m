From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/13] Changes 2009-06-19
Date: Fri, 19 Jun 2009 13:05:38 +0200
Message-ID: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Harald Hoyer (13):
  moved test-init to TEST-10-RAID
  uncomment hard-off for TEST-30-ISCSI
  do not poweroff in TEST-30-ISCSI, if rdinitdebug is set
  do not poweroff in TEST-10-RAID if rdinitdebug is set
  prepare udev rules for udev >= 143
  install rules to ignore some devices
  make iSCSI boot with root=dhcp and mount partitions labeled with
    "ROOT" or "/"
  manpage iSCSI update
  add rdblacklist command line parameter
  updated switch_root.c
  dracut.spec without switch_root
  renamed dracut-lib to dracut-lib.sh
  removed shebang from .sh and changed mode to 0644

 Makefile                                   |    2 +-
 dracut.8                                   |   10 +-
 dracut.spec                                |   10 ++
 modules.d/40network/dhclient-script        |    2 +-
 modules.d/40network/ifup                   |    2 +-
 modules.d/40network/netroot                |    2 +-
 modules.d/50plymouth/plymouth-emergency.sh |    1 -
 modules.d/90crypt/63-luks.rules            |   12 --
 modules.d/90crypt/70-luks.rules            |   12 ++
 modules.d/90crypt/install                  |    2 +-
 modules.d/90dmraid/dmraid.sh               |    1 -
 modules.d/90lvm/64-lvm-vol_id.rules        |   20 +++
 modules.d/90lvm/64-lvm.rules               |    9 +-
 modules.d/90lvm/install                    |    6 +-
 modules.d/90mdraid/65-md-incremental.rules |    8 +
 modules.d/90mdraid/install                 |    9 +-
 modules.d/95iscsi/iscsiroot                |   10 +-
 modules.d/95nbd/61-nbd-vol_id.rules        |    7 +
 modules.d/95nbd/61-nbd.rules               |    4 +-
 modules.d/95nbd/install                    |    8 +-
 modules.d/95nbd/nbdroot                    |    2 +-
 modules.d/95nfs/nfsroot                    |    2 +-
 modules.d/95udev-rules/01-ignore.rules     |    1 +
 modules.d/95udev-rules/install             |   10 +-
 modules.d/99base/dracut-lib                |   62 --------
 modules.d/99base/dracut-lib.sh             |   55 +++++++
 modules.d/99base/init                      |    2 +-
 modules.d/99base/install                   |    8 +-
 modules.d/99base/parse-blacklist.sh        |   10 ++
 switch_root.c                              |  232 ++++++++++++++--------------
 test/TEST-10-RAID/hard-off.sh              |    2 +-
 test/TEST-10-RAID/test-init                |   10 ++
 test/TEST-10-RAID/test.sh                  |    2 +-
 test/TEST-30-ISCSI/dhcpd.conf              |    2 +-
 test/TEST-30-ISCSI/hard-off.sh             |    2 +-
 test/TEST-30-ISCSI/test.sh                 |    6 +-
 test/test-init                             |   10 --
 37 files changed, 323 insertions(+), 232 deletions(-)
 delete mode 100644 modules.d/90crypt/63-luks.rules
 create mode 100644 modules.d/90crypt/70-luks.rules
 create mode 100644 modules.d/90lvm/64-lvm-vol_id.rules
 create mode 100644 modules.d/90mdraid/65-md-incremental.rules
 create mode 100644 modules.d/95nbd/61-nbd-vol_id.rules
 mode change 100755 => 100644 modules.d/95resume/resume-genrules.sh
 mode change 100755 => 100644 modules.d/95rootfs-block/block-genrules.sh
 mode change 100755 => 100644 modules.d/95rootfs-block/parse-block.sh
 create mode 100644 modules.d/95udev-rules/01-ignore.rules
 delete mode 100644 modules.d/99base/dracut-lib
 create mode 100644 modules.d/99base/dracut-lib.sh
 create mode 100755 modules.d/99base/parse-blacklist.sh
 mode change 100755 => 100644 modules.d/99base/parse-root-opts.sh
 create mode 100755 test/TEST-10-RAID/test-init
 delete mode 100755 test/test-init

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
