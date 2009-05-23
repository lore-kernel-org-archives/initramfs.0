From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 0/5] WIP: NFS root mount from udev rules
Date: Sat, 23 May 2009 00:39:23 -0400
Message-ID: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

This is my current patch queue for mount the NFS root via the udev rules.
It worked well when I stopped activity on it in mid-April, but I've not
tested it after porting to today's HEAD.

The first two patches are bug fixes, though Victor posted a different
fix to the default config file issue in his cleanup series.

Mainly, I'm looking to see what you guys think of the direction.

Thanks for any comments you care to share!


David Dillow (5):
  dracut-funtions: fix 'instmods =XXX'
  dracut: fix fallback to default configuration file
  lib: create a library for useful shell functions
  network: prepare network configuration engine for udev-based nfsroot
  nfsroot: mount NFS root from udev rules

 dracut                                 |    7 +-
 dracut-functions                       |    2 +-
 modules.d/40network/dhclient-script    |   98 +++++++++++++++----
 modules.d/40network/ifup               |  124 +++++++++++++++++++-----
 modules.d/40network/install            |    3 +-
 modules.d/40network/kill-dhclient.sh   |    5 +-
 modules.d/40network/run-dhclient.sh    |    9 --
 modules.d/40nfsroot/60-nfsroot.rules   |    1 +
 modules.d/40nfsroot/check              |    5 +
 modules.d/40nfsroot/install            |   27 +++++
 modules.d/40nfsroot/nfsroot            |  125 ++++++++++++++++++++++++
 modules.d/40nfsroot/nfsroot-cleanup.sh |    9 ++
 modules.d/99base/dracut-lib            |   16 +++
 modules.d/99base/init                  |   12 +--
 modules.d/99base/install               |    1 +
 15 files changed, 374 insertions(+), 70 deletions(-)
 delete mode 100755 modules.d/40network/run-dhclient.sh
 create mode 100644 modules.d/40nfsroot/60-nfsroot.rules
 create mode 100755 modules.d/40nfsroot/check
 create mode 100755 modules.d/40nfsroot/install
 create mode 100755 modules.d/40nfsroot/nfsroot
 create mode 100755 modules.d/40nfsroot/nfsroot-cleanup.sh
 create mode 100644 modules.d/99base/dracut-lib

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
