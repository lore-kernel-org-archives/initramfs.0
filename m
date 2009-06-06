From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 0/9] Enhance NFS test suite (plus one other bug)
Date: Sat,  6 Jun 2009 05:23:21 -0400
Message-ID: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

This series adds functionality to the NFS test suite, and fixes an issue
with root parsing that was found during the work. Follow-on work will include
adding some rules to the NFS server during the test to verify that the correct
server IP is being used, and to test NFS mount options and nfsroot=.

These patches can also be pulled from http://thedillows.org/dracut.git

David Dillow (9):
  Have the test framework always run the cleanup script
  NFS testing: add forgotten hard-off hook
  NFS test: rearrange code to test multiple client configurations
  NFS test: switch the ISC dhcpd server
  NFS test: re-add the fix for the terminal
  NFS test: rearrange the server tree so we can differentiate NFSv3 vs
    NFSv4
  root option parsing belongs in 99base now
  NFS test: allow emergency shell while debugging
  NFS test: additional option tests

 modules.d/95rootfs-block/install            |    1 -
 modules.d/95rootfs-block/parse-root-opts.sh |   14 ---
 modules.d/99base/install                    |    1 +
 modules.d/99base/parse-root-opts.sh         |   14 +++
 test/TEST-20-NFS/dhcpd.conf                 |   73 ++++++++++++++
 test/TEST-20-NFS/exports                    |    2 +
 test/TEST-20-NFS/hard-off.sh                |    2 +
 test/TEST-20-NFS/hosts                      |    6 +
 test/TEST-20-NFS/server-init                |    9 +-
 test/TEST-20-NFS/test.sh                    |  140 ++++++++++++++++++---------
 test/test-functions                         |   30 ++++---
 11 files changed, 214 insertions(+), 78 deletions(-)
 delete mode 100755 modules.d/95rootfs-block/parse-root-opts.sh
 create mode 100755 modules.d/99base/parse-root-opts.sh
 create mode 100644 test/TEST-20-NFS/dhcpd.conf
 create mode 100644 test/TEST-20-NFS/exports
 create mode 100755 test/TEST-20-NFS/hard-off.sh
 create mode 100644 test/TEST-20-NFS/hosts

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
