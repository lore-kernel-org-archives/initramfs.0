From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 0/4] options to configure fs-lib (fsck) and two unrelated
 fixes
Date: Fri, 30 Sep 2011 23:45:00 +0200
Message-ID: <4E86385C.6040706@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

First two patches are unreleated fixups, the other two
implement options to configure fs-lib (which fscks
to include in the image).


The following changes since commit d23159a69c818274486f1287ba6267b96f3febb7:

  dracut [PATCH]es: parallelize block_module filter and net_module_filter (2011-09-30 09:40:49 +0200)

are available in the git repository at:
  git://git.hasevolq.net/dracut.git fixup

Michal Soltys (4):
      convert_abs_rel() fixups
      dracut.8: add missing lvmconf info
      fs-lib: add ability to choose fsck tools
      manuals: add info about fs-lib (fsck) configuration

 dracut                             |   13 ++++++++++++-
 dracut-functions                   |   18 +++++++++++-------
 dracut.8.xml                       |   36 ++++++++++++++++++++++++++++++++++++
 dracut.conf                        |    9 +++++++++
 dracut.conf.5.xml                  |   22 ++++++++++++++++++++++
 modules.d/99fs-lib/fs-lib.sh       |    6 +++---
 modules.d/99fs-lib/module-setup.sh |   23 ++++++++++++++++-------
 7 files changed, 109 insertions(+), 18 deletions(-)
