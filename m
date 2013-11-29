From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCHv2 00/13] SUSE S/390 integration
Date: Fri, 29 Nov 2013 13:13:41 +0100
Message-ID: <1385727234-5001-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

SUSE is keeping the S/390 device configuration in udev rules,
on rule per device.
And it doesn't have the RH-specific configuration scripts (obviously).
This patchset abstracts away the RH-specific configuration and
adds modules to make dracut boot on SLES installations.

I've also added a new SUSE-specific mkinitrd compability script,
as the SUSE mkinitrd is quite different.

And some minor fixes which came up during package build.

Please apply.

Hannes Reinecke (13):
  95dasd: Install kernel modules only once
  95dasd: Only install module if normalize_dasd_arg is present
  95dasd_mod: make dasd_cio_free optional
  95zfcp: Make installation optional
  95znet: Make installation optional
  Add DASD configuration for SuSE
  Add zfcp scripts for SUSE
  Make logfile configurable
  mkinitrd-suse: Add SUSE compability wrapper for dracut
  mkinitrd-suse.8.asc: Add manpage for SUSE compat mkinitrd
  Fixup keymap setting for openSUSE
  Fixup script permissions
  Remove shebang from shell-completion files

 Makefile                                 |   1 +
 dracut-bash-completion.sh                |   2 +-
 dracut-functions.sh                      |  28 +++
 dracut.8.asc                             |   6 +
 dracut.sh                                |   4 +
 lsinitrd-bash-completion.sh              |   2 +-
 mkinitrd-suse.8.asc                      | 106 +++++++++
 mkinitrd-suse.sh                         | 354 +++++++++++++++++++++++++++++++
 modules.d/03modsign/load-modsign-keys.sh |   0
 modules.d/03modsign/module-setup.sh      |   0
 modules.d/10i18n/module-setup.sh         |   3 +
 modules.d/40network/net-lib.sh           |   0
 modules.d/40network/parse-vlan.sh        |   0
 modules.d/50drm/module-setup.sh          |   0
 modules.d/91crypt-loop/crypt-loop-lib.sh |   0
 modules.d/95dasd/module-setup.sh         |   7 +-
 modules.d/95dasd_mod/module-setup.sh     |   3 +-
 modules.d/95dasd_mod/parse-dasd-mod.sh   |   4 +-
 modules.d/95dasd_rules/module-setup.sh   |  27 +++
 modules.d/95dasd_rules/parse-dasd.sh     |  56 +++++
 modules.d/95zfcp/module-setup.sh         |   4 +-
 modules.d/95zfcp_rules/module-setup.sh   |  25 +++
 modules.d/95zfcp_rules/parse-zfcp.sh     |  65 ++++++
 modules.d/95znet/module-setup.sh         |   1 +
 modules.d/98pollcdrom/pollcdrom.sh       |   0
 25 files changed, 686 insertions(+), 12 deletions(-)
 create mode 100644 mkinitrd-suse.8.asc
 create mode 100755 mkinitrd-suse.sh
 mode change 100644 => 100755 modules.d/03modsign/load-modsign-keys.sh
 mode change 100644 => 100755 modules.d/03modsign/module-setup.sh
 mode change 100644 => 100755 modules.d/40network/net-lib.sh
 mode change 100644 => 100755 modules.d/40network/parse-vlan.sh
 mode change 100644 => 100755 modules.d/50drm/module-setup.sh
 mode change 100644 => 100755 modules.d/91crypt-loop/crypt-loop-lib.sh
 create mode 100755 modules.d/95dasd_rules/module-setup.sh
 create mode 100755 modules.d/95dasd_rules/parse-dasd.sh
 create mode 100755 modules.d/95zfcp_rules/module-setup.sh
 create mode 100755 modules.d/95zfcp_rules/parse-zfcp.sh
 mode change 100644 => 100755 modules.d/98pollcdrom/pollcdrom.sh

-- 
1.8.1.4
