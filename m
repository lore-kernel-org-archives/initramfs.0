From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: small 90mdraid fixups, v2 info update
Date: Fri, 23 Sep 2011 01:12:53 +0200
Message-ID: <1316733173-21157-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Before v2 (which is in large part a rewrite), these 3 fixes:

1) *_raid_member checks are too generic, as blkid can report many more than
   just ddf/isw/linux native raid members - so go back to older approach
2) more thorough removal of incremental assembly from stock
   rules
3) include md_d devices in loops

The following changes since commit 08769b7f8a9efc57cd95d1f81e8aaf1a48db0d28:

  dracut-functions: inst_rules() add missing "" (2011-09-22 16:14:38 +0200)

are available in the git repository at:
  git://git.hasevolq.net/dracut.git fixup

Michal Soltys (3):
      90mdraid: check precisely for supported contaiers
      90mdraid: more thorough 64-md-raid.rules edit
      90mdraid: adjust /dev/md loops

 modules.d/90mdraid/65-md-incremental-imsm.rules |    7 +++++--
 modules.d/90mdraid/mdraid-cleanup.sh            |    2 +-
 modules.d/90mdraid/mdraid_start.sh              |    2 +-
 modules.d/90mdraid/module-setup.sh              |    4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)


As for v2 info:

Most functionality was moved to pre-trigger parse script, with rules relying on
udev properties. Where possible "modern" approach is used (-I assembly,
blocking by AUTO= with further limiting by udev properties), otherwise staged
assembly is used.

New options include rd.md.{force,part,name} - so user can control if
force-degraded-mode assembly is permitted, md_d / md devices are used
(regardless of kernel version) or one can specify names to assemble arrays
(for supporting metadata, so 1.x and ddf).

The general behaviour is based on mdadm version, kernel version, command line
overrides and 3 basic cases (in order of importance): explicit uuids/names
given, mdadm.conf inhibited, mdadm.conf provided. blkid/vol_id variation will
also be handled internally, probably along with dracut-only provided rules
(which would free few lines from udev module and keep things in one place).

I should post the RFC in nearby future.


 modules.d/90dmraid/61-dmraid-imsm.rules            |    2 +-
 modules.d/90dmraid/parse-dm.sh                     |    4 +-
 modules.d/90mdraid/65-md-dracut.rules              |   35 ++++
 modules.d/90mdraid/65-md-incremental-imsm.rules    |   49 -----
 modules.d/90mdraid/{mdadm_auto.sh => md-asm.sh}    |    4 +-
 modules.d/90mdraid/md-cleanup.sh                   |    5 +
 .../90mdraid/{mdraid_start.sh => md-force.sh}      |    7 +-
 modules.d/90mdraid/md-noddf.sh                     |    5 -
 modules.d/90mdraid/md-noimsm.sh                    |    5 -
 modules.d/90mdraid/md-parse.sh                     |  185 ++++++++++++++++++++
 modules.d/90mdraid/md-shutdown.sh                  |   13 +-
 modules.d/90mdraid/mdmon-pre-udev.sh               |    6 -
 modules.d/90mdraid/mdraid-cleanup.sh               |   23 ---
 modules.d/90mdraid/module-setup.sh                 |   78 +++++----
 modules.d/90mdraid/parse-md.sh                     |   53 ------

-- 
1.7.5.3
