From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [RFC/PATCH] Expand fstab-sys, simplify rootfs-block
Date: Fri, 20 May 2011 17:09:22 +0200
Message-ID: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch moves code responsible for fsck'ing and determinig filesystem to
dracut-lib.sh, so it can be used by both fstab-sys and rootfs-block.

Adding fsck functionality to fstab-sys provides opportunity to move whole
separate /usr mount outside main initialization scripts - so real udev (with
different rules wanting /usr present) can work fine without any issues - having
/usr checked and mounted. At least that is the motivation behind these few
patches.

See respective commits for more details.

Note - I'm not sure if dracut-lib.sh is actually a proper place for those
functions - they were identical though, so to not repeat the code I stuffed
them there.

Haven't tested too much yet, so it's more RFC than a patch (code changes are
pretty simple though).



Michal Soltys (5):
  dracut-lib.sh: add vwarn() function
  dracut-lib.sh: Add det_fs() and wrap_fsck()
  95fstab-sys: use det_fs and wrap_fsck
  95rootfs-block/mount-root.sh: Rely on det_fs and wrap_fsck
  95rootfs-block/block-genrules.sh: Use > instead of >>

 modules.d/95fstab-sys/module-setup.sh      |    2 +
 modules.d/95fstab-sys/mount-sys.sh         |   23 +++++++++---
 modules.d/95rootfs-block/block-genrules.sh |    2 +-
 modules.d/95rootfs-block/mount-root.sh     |   47 +++++--------------------
 modules.d/99base/dracut-lib.sh             |   53 ++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 45 deletions(-)

-- 
1.7.2.1
