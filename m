From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 0/4] dracut: fix various issues with newly degraded md arrays
Date: Thu, 26 Mar 2015 15:41:44 +1100
Message-ID: <20150326043938.10121.34223.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When an md array is newly degraded at boot it will not be assembled
until mdraid_start.sh is run.
There are a few problem with the timeout handling that causes this
not to work properly in all circumstances.
These patches fix the bug I had reported.

Thanks,
NeilBrown


---

NeilBrown (4):
      mdraid/mdraid_start.sh: tell mainloop if we make progress.
      systemd/dracut-iniqueue - continue waiting if any timeout script makes progress
      dracut-systemd/rootfs-generator.sh: always create generated files.
      crypt/parse-crypt.sh: hide encrypted devices from systemd timeout warnings.


 modules.d/90crypt/parse-crypt.sh               |    4 ++
 modules.d/90mdraid/mdraid_start.sh             |    1 
 modules.d/98dracut-systemd/dracut-initqueue.sh |    1 
 modules.d/98dracut-systemd/rootfs-generator.sh |   15 ++++---
 modules.d/99base/dracut-lib.sh                 |   53 +++++++++++++++---------
 5 files changed, 48 insertions(+), 26 deletions(-)

--
Signature
