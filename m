From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 00/10] SUSE S/390 integration
Date: Wed, 27 Nov 2013 16:44:11 +0100
Message-ID: <1385567061-13247-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Hi all,

SUSE is keeping the S/390 device configuration in udev rules,
on rule per device.
And it doesn't have the RH-specific configuration scripts (obviously).
This patchset abstracts away the RH-specific configuration and
adds modules to make dracut boot on SLES installations.

Please apply.

Hannes Reinecke (10):
  95dasd: Install kernel modules only once
  95dasd: Only install module if normalize_dasd_arg is present
  95dasd_mod: make dasd_cio_free optional
  95zfcp: Make installation optional
  95znet: Make installation optional
  Install /bin/mount
  Fixup keymap setting for openSUSE
  Check for plymouth lib directories
  Add DASD configuration for SuSE
  Add zfcp scripts for SUSE

 dracut-functions.sh                    | 37 ++++++++++++++++++++++
 modules.d/10i18n/module-setup.sh       |  3 ++
 modules.d/50plymouth/module-setup.sh   | 17 ++++++++---
 modules.d/95dasd/module-setup.sh       |  7 ++---
 modules.d/95dasd_mod/module-setup.sh   |  3 +-
 modules.d/95dasd_mod/parse-dasd-mod.sh |  4 ++-
 modules.d/95dasd_rules/module-setup.sh | 27 ++++++++++++++++
 modules.d/95dasd_rules/parse-dasd.sh   | 56 ++++++++++++++++++++++++++++++++++
 modules.d/95zfcp/module-setup.sh       |  4 +--
 modules.d/95zfcp_rules/module-setup.sh | 25 +++++++++++++++
 modules.d/95zfcp_rules/parse-zfcp.sh   | 54 ++++++++++++++++++++++++++++++++
 modules.d/95znet/module-setup.sh       |  1 +
 modules.d/99fs-lib/module-setup.sh     |  1 +
 13 files changed, 224 insertions(+), 15 deletions(-)
 create mode 100755 modules.d/95dasd_rules/module-setup.sh
 create mode 100755 modules.d/95dasd_rules/parse-dasd.sh
 create mode 100755 modules.d/95zfcp_rules/module-setup.sh
 create mode 100755 modules.d/95zfcp_rules/parse-zfcp.sh

-- 
1.8.1.4
