From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 0/9] netroot: modular support for network root devices
Date: Mon, 1 Jun 2009 01:24:42 -0400
Message-ID: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This builds on the NFS root work to allow other network methods to hook
into the parsing and network infrastructure. One network interface is
configured at a time, but if we don't find a root there, it may not be
unconfigured -- this should probably be added.

I implemented some of the legacy formats we talked about, but not all of
them, and I may not have them 100% correct. That handling has seen less
testing than the NFS methods I usually use. I have verified that this set
will work with root=dhcp w/ NFS, and no root, but nbdroot= for NBD.

I think we can offer some support for LVM/LUKS over NBD, but that's low
on my list at the moment -- it was more important to shine some light
on this to see if it gets burned up. Documentation would be another high
priority, as in the formats supported as well as the interfaces and
expectations of the handlers.


David Dillow (9):
  nfsroot: move to same sort order as block methods
  block root: split out resume parsing and udev rules
  dracut: add cmdline hook
  cmdline: cleanup handling and block: handler
  resume: add support for labeled resume devices
  dracut-lib: add source_all to library
  netroot: add common handler for network root devices
  nfsroot: move to netroot framework
  Add NBD support

 dracut                                            |    2 +-
 modules.d/40network/60-net.rules                  |    1 +
 modules.d/40network/dhcp-fallback.sh              |   14 +++
 modules.d/40network/ifup                          |    8 +-
 modules.d/40network/install                       |    2 +
 modules.d/40network/netroot                       |   52 +++++++++
 modules.d/40nfsroot/60-nfsroot.rules              |    1 -
 modules.d/40nfsroot/nfsroot                       |  125 ---------------------
 modules.d/{40nfsroot => 95nbd}/check              |    4 +-
 modules.d/95nbd/install                           |    7 +
 modules.d/95nbd/nbd-netroot.sh                    |   11 ++
 modules.d/95nbd/nbdroot                           |   96 ++++++++++++++++
 modules.d/95nbd/parse-nbdroot.sh                  |   49 ++++++++
 modules.d/{40nfsroot => 95nfs}/check              |    0
 modules.d/{40nfsroot => 95nfs}/install            |   10 +--
 modules.d/95nfs/nfs-netroot.sh                    |   52 +++++++++
 modules.d/95nfs/nfsroot                           |   82 ++++++++++++++
 modules.d/{40nfsroot => 95nfs}/nfsroot-cleanup.sh |    0
 modules.d/95nfs/parse-nfsroot.sh                  |   48 ++++++++
 modules.d/95resume/install                        |    4 +-
 modules.d/95resume/parse-resume.sh                |    8 ++
 modules.d/95resume/resume-genrules.sh             |    8 ++
 modules.d/95rootfs-block/block-genrules.sh        |   10 ++
 modules.d/95rootfs-block/genrules.sh              |   14 ---
 modules.d/95rootfs-block/install                  |    6 +-
 modules.d/95rootfs-block/parse-block.sh           |   16 +++
 modules.d/95rootfs-block/parse-root-opts.sh       |   21 +---
 modules.d/99base/dracut-lib                       |   22 ++++
 modules.d/99base/init                             |   31 ++++-
 29 files changed, 522 insertions(+), 182 deletions(-)
 create mode 100755 modules.d/40network/dhcp-fallback.sh
 create mode 100755 modules.d/40network/netroot
 delete mode 100644 modules.d/40nfsroot/60-nfsroot.rules
 delete mode 100755 modules.d/40nfsroot/nfsroot
 copy modules.d/{40nfsroot => 95nbd}/check (61%)
 create mode 100755 modules.d/95nbd/install
 create mode 100755 modules.d/95nbd/nbd-netroot.sh
 create mode 100755 modules.d/95nbd/nbdroot
 create mode 100755 modules.d/95nbd/parse-nbdroot.sh
 rename modules.d/{40nfsroot => 95nfs}/check (100%)
 rename modules.d/{40nfsroot => 95nfs}/install (83%)
 create mode 100755 modules.d/95nfs/nfs-netroot.sh
 create mode 100755 modules.d/95nfs/nfsroot
 rename modules.d/{40nfsroot => 95nfs}/nfsroot-cleanup.sh (100%)
 create mode 100755 modules.d/95nfs/parse-nfsroot.sh
 create mode 100755 modules.d/95resume/resume-genrules.sh
 create mode 100755 modules.d/95rootfs-block/block-genrules.sh
 delete mode 100755 modules.d/95rootfs-block/genrules.sh
 create mode 100755 modules.d/95rootfs-block/parse-block.sh

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
