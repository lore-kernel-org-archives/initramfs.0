From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: "Little Bang 0.94" initramfs-tools release
Date: Tue, 6 Apr 2010 00:11:08 +0200
Message-ID: <20100405221108.GK32211@baikonur.stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


Newer initramfs comes with lots of fixes and new features:

* Faster boot thanks to Ubuntu merged patches using pre-cached boot scripts.

* Support for several compression schemes as set in initramfs.conf or
  overridden by appropriate mkinitramfs call.

* Better MODULES=dep support /sys parsing (Still needs fixes for md).

* Hooks for out of linux-2.6 make deb-pkg generated linux-images.

* Call ipconfig with increasing timeouts to better fit with large scale
  clusters.

* Use BOOTIF mac address passed from gpxe in setup_networking.

* Out of the box support for devtmpfs. Hurra for devfs 2.0.

* Loading of the netconsole module together with the specified args,
  when netconsole is set as bootarg.

* Adds available, built network drivers in a dynamic way without need
  of hardcoded list.

* Smaller and thus faster MODULES=most generated initramfs due to
  kicking the video part out of generic initramfs.

git repo:
git clone git://git.debian.org/kernel/initramfs-tools.git

http view of it:
http://git.debian.org/?p=kernel/initramfs-tools.git;a=summary

thanks for everyone involved.

-- 
maks

PS shortlog follows

Anna Jonna Armannsdottir (1):
      configure_networking: Try repeatedly ipconfig with increasing timeout

Avi Rozen (1):
      mkinitramfs: add all usb storage devices

Ben Collins (1):
      update-initramfs: Default to not keep .bak backups

Ben Hutchings (2):
      copy_modules_dir: Take a list of exclusions after the base directory
      auto_add_modules: Copy all modules from net, excluding some subdirectories

Bert Schulze (1):
      mkinitramfs: -c compression support / commandline override

Colin Watson (2):
      mkinitramfs: Filter out looping or broken symlinks from the initramfs
      mkinitramfs: set initramfs root to 755

Ferenc Wagner (1):
      initramfs-tools: make the panic argument available in the rescue shell

Joey Hess (1):
      scripts/local: avoid mount -t unknown

Martin Michlmayr (1):
      MODULES=dep fix boot with MMC

Maximilian Gass (1):
      mkinitramfs: KEYMAP option fails to work due to missing keymap

Michael Prokop (2):
      Fix path to nfsroot.txt in documentation.
      hook-functions: Avoid firmware copy error.

Nikolaus Schulz (1):
      hook-functions: let dep_add_modules() recurse into lvm slave devices

Piotr Lewandowski (1):
      update-initramfs breaks if /etc/mtab is a symlink to /proc/mounts

Scott James Remnant (5):
      init: Mount devtmpfs on /dev
      mkinitramfs: Call depmod before packing the initramfs.
      init: load the netconsole module with netconsole bootarg
      init: mount /dev/pts as well as /dev
      mkinitramfs: generate pre-cached boot order file

Tormod Volden (1):
      blacklist boot hook write to /etc/modprobe.d/initramfs.conf

Vagrant Cascadian (1):
      configure_networking: support BOOTIF variable set by pxelinux

bert schulze (1):
      initramfs-tools: support different compression tools in mkinitramfs

maximilian attems (56):
      nuke thermal hooks
      create a klibc hook script
      Redefinde MODULES=most to not carry any fb driver per default.
      nuke kernelextras hook
      nuke framebuffer boot script
      Revert "hook-functions: Add hid_* modules."
      klibc remove zcat and gunzip
      move busybox addition to a hook script
      mkinitramfs fix comment
      hook-functions: Fix mounted /sys check for openvz container.
      initramfs-tools.8: fix boot example script to execute scripts/functions
      fix out-of-date-standards-version
      /etc/kernel hook script support newer kernel-package
      update-initramfs: allow -t takeover on delete
      /etc/kernel/postrm.d/i-t: use now takeover on delete
      Nuke useless unused dir.
      kernel hook scripts: Fix typo
      kernel hook scripts: add comments
      hook-funcitions: Only warn about missing firmware if /proc/modules exists
      mkinitramfs: Be opportunistic when calling modprobe thus showing errors
      copy_exec: Check if ldd is around
      scripts/local: Use blkid as backup fstype detection
      mkinitramfs: only copy modprobe conf files
      blacklist earlier at init-top stage
      scripts/local: fix blkid invocation
      init: export and unset BOOTIF
      init: rexport resume to reallow it's hardcoded usage
      update-initramfs: -d delete .bak file
      control: bump standards version without changes.
      control: Clean up Uploaders field
      switch from cdbs to debhelper 7
      update-initramfs: Stop second guessing lilo usage.
      mkinitramfs: allow to build initramfs for unmodular linux images
      initramfs.conf.5: document UMASK variable for sensitive initramfs
      update-initramfs: only run elilo if configured
      update-initramfs: fix previous elilo commit
      MODULES=DEP Use driver/module syfs attribute
      panic: quote variable
      MODULES=DEP: Check superblock on initramfs block
      Use ata_generic driver on all_generic_ide bootarg
      scripts/functions: add get_fstype() from scripts/local
      mkinitramfs.8: update date
      Keep acpi modules in initramfs so that udev can load them early
      mkinitramfs: no longer copy depmod
      init: Silence "Loading essential drivers..." on quiet boot.
      hook-functions: Add btrfs to base modules
      init: export BOOT for casper and friends
      hooks/klibc: Keep gzip in initramfs
      modernize docs to todays standards
      examples: shipp old framebuffer boot script
      initramfs.conf.5, update-initramfs.conf.5: Add FILES section.
      mkinitramfs: be silent if no map was generated in first place
      debian/control: Add a breaks cryptsetup.
      initramfs-tools.8: Document netconsole bootparam
      prepare release 0.94
      NEWS: shorten and rephrase
