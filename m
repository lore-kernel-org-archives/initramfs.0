From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/10] *** SUBJECT HERE ***
Date: Fri,  3 Jul 2009 18:45:10 +0200
Message-ID: <1246639520-3094-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Some important things I changed today.

Harald Hoyer (10):
  add binutiles requirement to specfile (because of nm)
  output everything to /dev/kmesg and add dmesg for the emergency_shell
  Defer mount to the real mount loop
  remove 50plymouth-pre0.7 module
  add firmware packages to be required by the dracut-generic package
  add rm to be installed for initqueue
  fail iscsiroot, if iscsistart fails
  put back the nfs mount in the udev event
  initqueue now loops until /dev/root exists or root is mounted
  add "rdshell" command line argument

 dracut.8                                           |    3 +
 dracut.spec                                        |    8 ++-
 modules.d/40network/net-genrules.sh                |    8 +-
 modules.d/50plymouth-pre0.7/63-luks.rules          |   11 --
 modules.d/50plymouth-pre0.7/check                  |    3 -
 modules.d/50plymouth-pre0.7/cryptroot-ask.sh       |    4 -
 modules.d/50plymouth-pre0.7/install                |    8 --
 modules.d/50plymouth-pre0.7/plymouth-newroot.sh    |    4 -
 .../50plymouth-pre0.7/plymouth-populate-initrd     |   25 -----
 modules.d/50plymouth-pre0.7/plymouth-start.sh      |   31 ------
 modules.d/50plymouth/63-luks.rules                 |    2 +-
 modules.d/90crypt/70-luks.rules                    |    2 +-
 modules.d/90dmraid/61-dmraid.rules                 |   12 ++
 modules.d/90dmraid/dmraid.sh                       |    3 -
 modules.d/90dmraid/dmraid_scan                     |    8 ++
 modules.d/90dmraid/install                         |    3 +-
 modules.d/95debug/install                          |    2 +-
 modules.d/95iscsi/iscsiroot                        |    4 +-
 modules.d/95nbd/nbdroot                            |    7 +-
 modules.d/95nfs/nfsroot                            |   22 ++--
 modules.d/95rootfs-block/block-genrules.sh         |   12 ++-
 modules.d/95rootfs-block/install                   |    1 +
 modules.d/99base/init                              |  111 ++++++++++++--------
 modules.d/99base/initqueue                         |   11 ++-
 modules.d/99base/install                           |    3 +-
 test/TEST-10-RAID/test.sh                          |    4 +-
 test/TEST-20-NFS/test.sh                           |    2 +-
 test/TEST-30-ISCSI/test.sh                         |    4 +-
 test/TEST-40-NBD/test.sh                           |    4 +-
 29 files changed, 153 insertions(+), 169 deletions(-)
 delete mode 100644 modules.d/50plymouth-pre0.7/63-luks.rules
 delete mode 100755 modules.d/50plymouth-pre0.7/check
 delete mode 100755 modules.d/50plymouth-pre0.7/cryptroot-ask.sh
 delete mode 100755 modules.d/50plymouth-pre0.7/install
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-newroot.sh
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-populate-initrd
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-start.sh
 create mode 100644 modules.d/90dmraid/61-dmraid.rules
 delete mode 100644 modules.d/90dmraid/dmraid.sh
 create mode 100755 modules.d/90dmraid/dmraid_scan

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
