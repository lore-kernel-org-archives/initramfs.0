From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools 0.95 release
Date: Sat, 29 May 2010 06:48:33 +0200
Message-ID: <20100529044833.GC9869@baikonur.stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org

most notably a license change to GPL in order to ease collaboration
with dracut. LZO compression and xHCI boot support may stick out for users.
pxelinux BOOTIF saw fixes. thanks for the patches.

shortlog tells it all, mostly small bugfixes all over the place:

Axel Beckert (1):
      mkinitramfs.8: Add information about $TMPDIR environment variable

Claus Herwig (1):
      mkinitramfs: fix MODULES=dep on mylex raid devices (DAC960)

Michael Prokop (1):
      Support booting from USB 3 xHCI-based controllers

Vagrant Cascadian (2):
      configure_networking: pxelinux BOOTIF fixes
      init: add BOOTIF bootarg

bert schulze (2):
      mkinitramfs: add LZO support
      mkinitramfs: use -9 for lzop

maximilian attems (33):
      update TODO list
      hook-functions: refactor copy_exec
      mkinitramfs: check only once for existing ldd
      mkinitramfs: Use TMPDIR definition
      mkinitramfs: guard against empty EXTRA_CONF
      update-initramfs: Use nounset
      mkinitramfs: Fix several unbound variables
      mkinitramfs: On verbose indication what we rm
      bug script: include sizes of generated initramfs
      debian/script: add generated resume param to bug
      init: fix hardcoded resume handling
      hook-functions: manual_add_modules simplify
      hook-functions: copy_modules_dir() small simplifications
      mkinitramfs.8: Fix wrong sourcing in boot script
      initramfs-tools.8: Mention /scritps/functions
      initramfs-tools.8: cryptopts param gone
      initramfs-tools.8: document BOOTIF variable
      configure_networking(): work with empty DEVICE string
      hook-functions: add hid-apple
      Revert "mkinitramfs: only copy modprobe conf files"
      initramfs-tools: change license to GPL
      hook-functions: re-add hid-microsoft
      Merge branch 'sid'
      debian/copyright: add boilerplate to keep lintian happy.
      hook-functions: Fix copy_modules_dir()
      release 0.95

