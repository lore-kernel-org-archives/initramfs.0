From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 0/2] minimum bash version
Date: Mon, 10 Oct 2011 23:58:03 +0200
Message-ID: <1318283885-1792-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm not sure what is current policy on bash version, but with 2 small
adjustments, dracut can be easily made bash 3.1 compatible (if I haven't missed
anything).

If this is desirable, the first patch adjusts {var}>& redirections with eval
and explicit FDs, and ^^/,, case-modifiers with temporary shopt ajustment.

If it's not necessary, then 2nd patch can be adjusted to simply require at least
bash 4.0.

Also pullable from:
The following changes since commit 450f5d66944e4a4ae005c75a818c3cccd28836f3:

  95udev-rules/module-setup.s: fixed symlink for udevd to initdir (2011-10-10 20:17:16 +0200)

  are available in the git repository at:
    git://git.hasevolq.net/dracut.git bashfix


Michal Soltys (2):
  bash3 compat patch
  explicitly verify bash version

 dracut                                     |    7 +++++++
 dracut-functions                           |   11 +++++++----
 modules.d/10i18n/module-setup.sh           |    8 +++++---
 modules.d/40network/module-setup.sh        |   19 ++++++++++++-------
 modules.d/90kernel-modules/module-setup.sh |   19 ++++++++++++-------
 5 files changed, 43 insertions(+), 21 deletions(-)

-- 
1.7.5.3
