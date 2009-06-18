From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/7] my changes for today
Date: Thu, 18 Jun 2009 15:26:14 +0200
Message-ID: <1245331581-2453-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Ok, to be more verbose, I am posting the changes I made today to the list.

Harald Hoyer (7):
  also resume from "swsuspend" partitions
  install "basename" for path_id
  kill the server after the test_run
  use 128M for the test virtual machines instead of 512M
  add iSCSI testsuite
  add DEBUGFAIL to TEST-10-RAID
  remove redundant vol_id run from out udev rules

 modules.d/50plymouth-pre0.7/63-luks.rules |    2 -
 modules.d/50plymouth/63-luks.rules        |    1 -
 modules.d/90crypt/63-luks.rules           |    1 -
 modules.d/90lvm/64-lvm.rules              |    2 +-
 modules.d/90mdraid/61-mdadm.rules         |   12 ++
 modules.d/90mdraid/70-mdadm.rules         |   12 --
 modules.d/90mdraid/install                |    2 +-
 modules.d/95nbd/61-nbd.rules              |    6 +
 modules.d/95nbd/install                   |    1 +
 modules.d/95resume/resume-genrules.sh     |   16 ++-
 modules.d/95udev-rules/install            |    4 +-
 test/TEST-10-RAID/test.sh                 |    9 +-
 test/TEST-20-NFS/test.sh                  |    8 +-
 test/TEST-30-ISCSI/Makefile               |   10 ++
 test/TEST-30-ISCSI/Makefile.tbd           |   10 --
 test/TEST-30-ISCSI/client-init            |   13 +++
 test/TEST-30-ISCSI/create-root.sh         |   38 ++++----
 test/TEST-30-ISCSI/dhcpd.conf             |   25 +++++
 test/TEST-30-ISCSI/server-init            |   17 +++
 test/TEST-30-ISCSI/targets                |   21 ++++
 test/TEST-30-ISCSI/test.sh                |  162 ++++++++++++++++++++++++-----
 test/TEST-40-NBD/test.sh                  |   12 ++-
 22 files changed, 296 insertions(+), 88 deletions(-)
 create mode 100644 modules.d/90mdraid/61-mdadm.rules
 delete mode 100644 modules.d/90mdraid/70-mdadm.rules
 create mode 100644 modules.d/95nbd/61-nbd.rules
 create mode 100644 test/TEST-30-ISCSI/Makefile
 delete mode 100644 test/TEST-30-ISCSI/Makefile.tbd
 create mode 100755 test/TEST-30-ISCSI/client-init
 create mode 100644 test/TEST-30-ISCSI/dhcpd.conf
 create mode 100755 test/TEST-30-ISCSI/server-init
 create mode 100644 test/TEST-30-ISCSI/targets

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
