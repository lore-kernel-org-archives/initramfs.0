From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 0/3] Add netroot= and LUKS/LVM support for NBD
Date: Thu, 11 Jun 2009 11:09:42 -0400
Message-ID: <1244732985-14927-1-git-send-email-dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

Now one can use root=LABEL=blah, root=UUID=blah and root=/dev/vg/lv
on top of NBD for their root. This also allows one to use LUKS to secure
the root volume. The test suite has been updated to test these
combinations as well. iSCSI has not been converted as I do not have
a way to test that yet.

There is a question of semantics for handling the fstype and fsoptions
from the NBD root info (nbdroot= or DHCP root-path) vs the command line
rootfstype= and rootflags= options. I've left that for later.

You can pick up these changes using git:
	git pull http://thedillows.org/dracut.git netroot

David Dillow (3):
  NBD test: add more option parsing tests
  network: add support for netroot=...
  NBD root: add support for LVM/LUKS

 modules.d/40network/dhcp-fallback.sh |   10 ++-
 modules.d/40network/netroot          |    2 +-
 modules.d/95nbd/nbd-netroot.sh       |    6 +-
 modules.d/95nbd/nbdroot              |   18 ++--
 modules.d/95nbd/parse-nbdroot.sh     |    8 ++-
 modules.d/95nfs/nfs-netroot.sh       |   38 ++++----
 modules.d/95nfs/parse-nfsroot.sh     |   13 +++-
 modules.d/99base/init                |    2 +-
 test/TEST-20-NFS/test.sh             |   37 ++++++++-
 test/TEST-40-NBD/client-init         |    7 ++-
 test/TEST-40-NBD/create-root.sh      |   23 +++++
 test/TEST-40-NBD/cryptroot-ask       |    6 ++
 test/TEST-40-NBD/dhcpd.conf          |   37 ++++++++
 test/TEST-40-NBD/server-init         |    1 +
 test/TEST-40-NBD/test.sh             |  151 ++++++++++++++++++++++++++++++++--
 15 files changed, 310 insertions(+), 49 deletions(-)
 create mode 100755 test/TEST-40-NBD/create-root.sh
 create mode 100755 test/TEST-40-NBD/cryptroot-ask

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
