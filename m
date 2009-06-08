From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 00/11] More test suite stuff (and bug fixes)
Date: Mon,  8 Jun 2009 00:40:13 -0400
Message-ID: <cover.1244435634.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

This add more comprehensive tests to the NFS test suite, such as
verifying that we used the right server IP address, and that we
added mount options appropriately. It may be a bit too comprehensive,
as it takes over 7 minutes to run for me.

Also of note, I addded support for a default NFS path and %s
substitution as done by the kernel's nfsroot handling.

This also has the first round of testing for NBD root, and a fix
for a bug found by the test suite.

David Dillow (11):
  NFS test: verify that we used the right IP to get to the server
  NFS test: add support for checking mount options used
  NFS test: renumber MAC addresses to ease adding new test cases
  NFS root: add missing DHCP root-path/nfsroot=[IP:]/path[,options]
    format
  NFS test: add test cases for DHCP/nfsroot=[IP:]/path[,options]
  NFS test: separate NFSv3 and NFSv4 tests into their own functions
  NFS root: add support for default root path and %s substitution
  dracut init: add rdnetdebug to exclude list
  NFS test: add test for nfs[4]:srv:/path syntax
  NBD: fix parsing of Debian-style nbdroot config
  NBD: add test suite

 modules.d/95nbd/parse-nbdroot.sh |    2 +-
 modules.d/95nfs/nfs-netroot.sh   |   17 ++++
 modules.d/95nfs/nfsroot          |   14 +++
 modules.d/99base/init            |    1 +
 test/TEST-20-NFS/client-init     |    6 +-
 test/TEST-20-NFS/dhcpd.conf      |  118 +++++++++++++++++++++++--
 test/TEST-20-NFS/exports         |    3 +
 test/TEST-20-NFS/hosts           |    2 +
 test/TEST-20-NFS/server-init     |    5 +
 test/TEST-20-NFS/test.sh         |  180 ++++++++++++++++++++++++++++++++------
 test/TEST-40-NBD/Makefile        |   10 ++
 test/TEST-40-NBD/client-init     |   10 ++
 test/TEST-40-NBD/dhcpd.conf      |   29 ++++++
 test/TEST-40-NBD/hard-off.sh     |    2 +
 test/TEST-40-NBD/hosts           |    8 ++
 test/TEST-40-NBD/server-init     |   18 ++++
 test/TEST-40-NBD/test.sh         |  179 +++++++++++++++++++++++++++++++++++++
 17 files changed, 569 insertions(+), 35 deletions(-)
 create mode 100644 test/TEST-40-NBD/Makefile
 create mode 100755 test/TEST-40-NBD/client-init
 create mode 100644 test/TEST-40-NBD/dhcpd.conf
 create mode 100755 test/TEST-40-NBD/hard-off.sh
 create mode 100644 test/TEST-40-NBD/hosts
 create mode 100755 test/TEST-40-NBD/server-init
 create mode 100755 test/TEST-40-NBD/test.sh

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
