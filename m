From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 00/10] All recent patches linearly
Date: Tue, 18 Oct 2011 20:33:16 +0200
Message-ID: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

As they kind of slowly started piling up and messing with each other.

Only new things are (last two patches):

- thorough checks for chosen/fallback terminal before calling shell
- emergency_shell moved into single place in dracut-lib, with two simple knobs
- added documentation for --ctty

Additionally,

The following changes since commit d239b550ce9e6a80342965974c4503cfde736fbe:

  explicitly verify bash version (2011-10-11 09:37:02 +0200)

  are available in the git repository at:
    git://git.hasevolq.net/dracut.git fixup


Michal Soltys (10):
  features: RUNDIR, imgdir, prefix, prefix_mnt and related changes
  features: RUNDIR, imgdir, ... [update 1]
  minor changes
  dracut: remove duplicate options
  dracut: detect lib paths more carefully
  check root candidates more carefully
  introduce optional job control
  job control fixup
  prepare common emergency_shell function (1), shell job control fixups (2)
  optional shell job control - add documentation

 dracut                           |  130 ++++++++++++++----------
 dracut-functions                 |   71 +++++++++-----
 dracut.8.xml                     |    9 ++
 dracut.kernel.7.xml              |   15 +++
 modules.d/10i18n/console_init    |    1 +
 modules.d/99base/dracut-lib.sh   |  109 ++++++++++++++++++++
 modules.d/99base/init            |  205 ++++++++++++++++++--------------------
 modules.d/99base/module-setup.sh |   14 ++-
 modules.d/99shutdown/shutdown    |   29 +-----
 9 files changed, 363 insertions(+), 220 deletions(-)

-- 
1.7.5.3
