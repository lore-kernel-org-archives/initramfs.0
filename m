From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/6] Enhancements and bug fixes for --mount
Date: Tue, 20 Dec 2011 14:09:55 +0800
Message-ID: <1324361401-6908-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patchset is based on "usrmove" branch, contains several bug fixes
and some enhancements for the new option '--mount'.

With these patches applied, kdump works well with dracut (the lvm case).

All patches are available at:

	git://github.com/congwang/dracut.git #kdump

Cong Wang (6):
  Add mount points even not in hostonly mode
  Check module dependencies of mount points
  Fix get_maj_min() to follow symlink
  Pass device name instead of major:minor in for_each_host_dev_fs()
  nfs: fix regex patterns in check()
  lvm: pass the correct rd.lvm.lv parameter

 dracut                                  |   83 ++++++++++++++++---------------
 dracut-functions                        |   81 ++++++++++++++++++++++++++---
 modules.d/00bootchart/module-setup.sh   |    1 +
 modules.d/10i18n/module-setup.sh        |    1 +
 modules.d/10rpmversion/module-setup.sh  |    1 +
 modules.d/50plymouth/module-setup.sh    |    1 +
 modules.d/90btrfs/module-setup.sh       |    2 +-
 modules.d/90crypt/module-setup.sh       |    2 +-
 modules.d/90dmraid/module-setup.sh      |    2 +-
 modules.d/90lvm/module-setup.sh         |   17 ++----
 modules.d/90mdraid/module-setup.sh      |    2 +-
 modules.d/95fcoe/module-setup.sh        |    2 +-
 modules.d/95nfs/module-setup.sh         |    8 ++--
 modules.d/97biosdevname/module-setup.sh |    1 +
 modules.d/98usrmount/module-setup.sh    |    1 +
 15 files changed, 135 insertions(+), 70 deletions(-)

-- 
1.7.7.4
