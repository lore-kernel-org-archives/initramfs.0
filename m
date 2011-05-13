From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools 0.99 release
Date: Fri, 13 May 2011 12:35:10 +0000
Message-ID: <20110513123510.GF3252@vostochny.stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: debian-release-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org

Hello everyone,

we just uploaded initramfs-tools release 0.99 "scarpe rotte e pur bisogna andar"
to Debian/unstable on this lovely Friday the 13th.

Users will most notably notice /run usage and xz support.
update-initramfs now has enhanced linux-2.6 hook scripts support,
so it no longer has to invoke bootloaders by itself. The initramfs
building process got enhanced to no longer rely on a symlinking mess.
As a consequence lib search paths can be properly configured.

The interesting question is the release numbering for the upcoming release.
Feel free to voice your preference of 1.0, 100 or 0.100? (:

Big thanks to the various contributions.

happy hacking
maks

Git repository:
git://git.debian.org/kernel/initramfs-tools.git

Git web:
http://git.debian.org/?p=kernel/initramfs-tools.git;a=summary

The shortlog has the details:

Aad dame (1):
      initramfs-tools: Fix MODULES=dep on an AOE device

Ben Hutchings (5):
      initramfs-tools: Handle hidden dependency of libcrc32c on crc32c
      kernel hooks: Treat missing version argument as an error
      kernel hooks: Enable error-exit (sh -e)
      update-initramfs: Depend on kernel hook scripts rather than $ramdisk invocation
      update-initramfs: Remove support for 'do_bootloader' and specific boot loaders

Christian Hofstaedtler (1):
      init: move /proc after moving other filesystems

Evan Broder (1):
      initramfs-tools: Fix handling of numeric root= arguments to be udev-friendly

Gianluigi Tiesi (1):
      mkinitramfs: misleading message in verbose mode (gzip not found, using gzip)

Michael Prokop (5):
      hidden_dep_add_modules(): make it dynamically to support more than 3 arguments as well
      Use --check=crc32 option for xz compression.
      Use -8 for compression with xz.
      docs: fix wording ("allows *one* to") to make lintian happy.
      Bump Standards-Version to 3.9.2.

Michael Tokarev (1):
      mkinitramfs: No need to warn about md-root busybox dep.

Milan Kupcevic (1):
      initramfs-tools: Load PowerMac G5 thermal modules

Roger Leigh (1):
      init: Don't use "none" as a mount fsname

Tim Small (1):
      Add Documentation for modules=list in initramfs.conf(5)

Timo Juhani Lindfors (2):
      initramfs-tools: Make panic message visible even if panic= is used
      initramfs-tools: Inform the user about reboot on panic=

maximilian attems (33):
      fix path to nfsroot documentation
      mkinitramfs: Enhance error warning
      bug script: detect any MODULES=dep setting
      initramfs-tools: cryptsetup dist upgrade fix
      MODULES=dep Fix partitioned raid setup
      initramfs-tools: MODULES=dep fix for ubifs /
      mkinitramfs: Fix noexec /tmp detection for long device names
      Merge branch 'squeeze'
      update-initramfs: Show the mkinitramfs on error message.
      maintainer-notes.html: Fix email to send patches to.
      mkinitramfs: Nuke MIN_VERSION handling.
      doc: s/ressources/resources/
      initramfs-tools: preinst use blkid for uuid generation if around.
      postinst cleanup very old dpkg trigger comparison.
      mkinitramfs: Add support for xz compression.
      hook-functions: Cleanup ref to ide-disk
      initramfs-tools: cleanup any usplash traces
      initramfs-tools: Remove mkinitramfs-kpkg
      initramfs-tools: add hid_sunplus to listed keyboard drivers
      init: load netconsole after loading network drivers
      debian/copyright: Update authorlist and year attribution
      maintainer-notes: Use git dch --multimaint-merge on examples
      dep_add_modules: Use hidden_dep_add_modules for ubifs
      hidden_dep_add: Use mika's variadic function from $2 on
      mkinitramfs: copy over on build instead of using symlink tree
      mkinitramfs: Add lib search path + run full ldconfig in initramfs
      mkinitramfs: creat /run initramfs directory
      initramfs-tools: init mount /run tmpfs
      init: No need to touch /dev/.initramfs
      hook-functions: xhci-hcd got renamed
      Merge branch 'maks/xhci'
      Revert "mkinitramfs: Nuke MIN_VERSION handling."
      Releasing version 0.99

rleigh (2):
      init: Preserve state on old boxes without /run on rootfs
      init: sync mount options with the defaults in initscripts

