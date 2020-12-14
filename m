From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 051
Date: Mon, 14 Dec 2020 15:58:21 +0100
Message-ID: <fcc18374-c3fa-a47a-b8a7-c661bb9b25f1@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607957909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pdwnm/pSnLu8nH4G4LxAuRM34SGxaiUO0fesk2iCaZ0=;
        b=A3LGgFocIf39awr53+cIPvx0WbXilxIAZIyKeWXJYQmSDJ/1rIuzs7EN1GwuZhd3vkGdZL
        7wr0mlp7Z75EY9oBpYyIhYLvKZiLV9dYqvHg34vQT2DXh9KkHMVmga+g6TUYnzIHhzV++G
        Q9FAe5JDhItSINfFd0riteClWXs2Z8k=
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Long time, no release...

Here comes a new dracut version. Thanks to all who have contributed to this
release.

Special thanks to Daniel Molkentin and Jóhann B. Guðmundsson taking over
maintenance while I was busy with other projects.

Additional thanks to Daniel Molkentin for writing the release notes.

The tarball can be found here:
        http://www.kernel.org/pub/linux/utils/boot/dracut/
        ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
        https://github.com/dracutdevs/dracut/releases/

Report Issues:
        https://github.com/dracutdevs/dracut/issues

File Pull Requests:
        https://github.com/dracutdevs/dracut/pulls

Git:
        git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
        https://github.com/dracutdevs/dracut.git

        git://git.kernel.org/pub/scm/boot/dracut/dracut.git
        https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS


dracut-051
==========

dracut:
- allow running on a cross-compiled rootfs

  dracutsysrootdir is the root directory, file existence checks use it.

  DRACUT_LDCONFIG can override ldconfig with a different one that works
  on the sysroot with foreign binaries.

  DRACUT_LDD can override ldd with a different one that works
  with foreign binaries.

  DRACUT_TESTBIN can override /bin/sh. A cross-compiled sysroot
  may use symlinks that are valid only when running on the target
  so a real file must be provided that exist in the sysroot.

  DRACUT_INSTALL now supports debugging dracut-install in itself
  when run by dracut but without debugging the dracut scripts.
  E.g. DRACUT_INSTALL="valgrind dracut-install or
  DRACUT_INSTALL="dracut-install --debug".

  DRACUT_COMPRESS_BZIP2, DRACUT_COMPRESS_LBZIP2, DRACUT_COMPRESS_LZMA,
  DRACUT_COMPRESS_XZ, DRACUT_COMPRESS_GZIP, DRACUT_COMPRESS_PIGZ,
  DRACUT_COMPRESS_LZOP, DRACUT_COMPRESS_ZSTD, DRACUT_COMPRESS_LZ4,
  DRACUT_COMPRESS_CAT: All of the compression utilities may be
  overridden, to support the native binaries in non-standard places.

  DRACUT_ARCH overrides "uname -m".

  SYSTEMD_VERSION overrides "systemd --version".

  The dracut-install utility was overhauled to support sysroot via
  a new option -r and fixes for clang-analyze. It supports
  cross-compiler-ldd from
  https://gist.github.com/jerome-pouiller/c403786c1394f53f44a3b61214489e6f

  DRACUT_INSTALL_PATH was introduced so dracut-install can work with
  a different PATH. In a cross-compiled environment (e.g. Yocto), PATH
  points to natively built binaries that are not in the host's /bin,
  /usr/bin, etc. dracut-install still needs plain /bin and /usr/bin
  that are relative to the cross-compiled sysroot.

  DRACUT_INSTALL_LOG_TARGET and DRACUT_INSTALL_LOG_LEVEL were
  introduced so dracut-install can use different settings from
  DRACUT_LOG_TARGET and DRACUT_LOG_LEVEL.

- don't call fsfreeze on subvol of root file system
- Use TMPDIR (typically /run/user/$UID) if available
- dracut.sh: add check for invalid configuration files
  Emit a warning about possible misconfigured configuration files, where
  the spaces around values are missing for +=""
- dracut-functions: fix find_binary() to return full path
- dracut.sh: FIPS workaround for openssl-libs on Fedora/RHEL
- dracut.sh: fix early microcode detection logic
- dracut.sh: fix ia32 detection for uefi executables
- dracut.sh: Add --version
- dracut.sh: Add --hostonly-nics option
- EFI Mode: only write kernel cmdline to UEFI binary
- Allow $DRACUT_INSTALL to be not an absolute path
- Don't print when a module is explicitly omitted (by default)
- Remove uses of bash (and bash specific syntax) in runtime scripts
- dracut-init.sh: Add a helper for detect device kernel modules
- dracut-functions.sh: Fix check_block_and_slaves_all
- dracut-functions.sh: add a helper to check if kernel module is available

Documentation
- dracut.cmdline.7.asc: clarify usage of `rd.lvm.vg` and `rd.lvm.lv`
- dracut.conf.5.asc: document how to config --no-compress in the config
- fix CI badges in README.md and fix dracut description
- dracut.modules.7.asc: fix typos
- dracut.modules.7.asc: fix reference to insmodpost module
- Add --version to man page
- Adding code of conduct
- Document initqueue/online hook


dracut-install:
- install: also install post weak dependencies of kernel modules
- install: Globbing support for resolving "firmware:"

mkinitrd:
- use vmlinux regex for ppc*, vmlinuz for i686

mkinitrd-suse:
- fix i586 platform detection

modules:

00systemd:
- skip dependency add for non-existent units
- add missing cryptsetup-related targets

05busybox:
- simplify listing of supported utilities

06rngd:
- install dependant libs too
- Do not start inside container

10i18n:
- i18n: Always install /etc/vconsole.conf

35network-legacy:
- dhclient-script: Fix typo in output of  BOUND & BOUND6 cases
- simplify fallback dhcp setup

35network-manager:
- ensure that nm-run.sh is executed when needed
- install libnss DNS and mDNS plugins
- always pull in machinery to read ifcfg files
- set kernel hostname from the command line
- move connection generation to a lib file

40network:
- fix glob matching ipv6 addresses
- net-lib.sh: support infiniband network mac addresses

45url-lib:
- drop NSS if it's not in curl --version

80cms:
- regenerate NetworkManager connections

90btrfs:
- force preload btrfs module
- Install crypto modules in 90kernel-modules

90crypt:
- cryptroot-ask: no warn if /run/cryptsetup exist
- install crypto modules in 90kernel-modules
- try to catch kernel config changes
- fix force on multiple lines
- pull in remote-cryptsetup.target enablement
- cryptroot-ask: unify /etc/crypttab and rd.luks.key

90dmsquash-live:
- iso-scan.sh: Provide an easy reference to iso-scan device

90kernel-modules:
- remove nfit from static module list (see nvdimm module)
- install crypto modules in 90kernel-modules
- add sg kernel module
- add pci_hyperv
- install block drivers more strictly
- install less modules for hostonly mode
- arm: add drivers/hwmon for arm/arm64

90kernel-network-modules
- on't install iscsi related module (use 95iscsi)

90lvm:
- remove unnecessary ${initdir} from lvm_scan.sh
- fix removal of pvscan from udev rules
- do not add newline to cmdline

90multipath:
- add automatic configuration for multipath
  (adds 'rd.multipath=default' to use the default config)
- install kpartx's 11-dm-parts.rules

90nvdimm:
- new module for NVDIMM support

90ppcmac:
- respect DRACUT_ARCH, don't exclude ppcle

90qemu-net:
- in hostonly mode, only install if network is needed
- install less module for strict hostonly mode

91zipl:
- parse-zipl.sh: honor SYSTEMD_READY

95cifs:
- pass rootflags to mount
- install new softdeps (sha512, gcm, ccm, aead2)

95dasd:
- only install /etc/dasd.conf if present

95dcssblk:
- fix script permissions

95fcoe:
- fix pre-trigger stage by replacing exit with return in lldpad.sh
- default rd.nofcoe to false
- don't install if there is no FCoE hostonly devices

95iscsi:
- fix missing space when compiling cmdline args
- fix ipv6 target discovery

95nfs:
- only install rpc services for NFS < 4 when hostonly is strict
- Change the order of NFS servers during the boot
  (next-server option has higher priority than DHCP-server itself)
- install less module if hostonly mode is strict

95nvmf:
- add module for NVMe-oF
- add NVMe over TCP support

95resume:
- do not resume on iSCSI, FCoE or NBD

95rootfs-block:
- mount-root.sh: fix writing fstab file with missing fsck flag
- only write root argument for block device

95zfcp:
- match simplified rd.zfcp format too

95zfcp_rules:
- parse-zfcp.sh: remove rule existence check

95znet:
- add a rd.znet_ifname= option

98dracut-systemd:
- remove memtrace-ko and rd.memdebug=4 support in dracut
- remove cleanup_trace_mem calls
- dracut-initqueue: Print more useful info in case of timeout
- as of v246 of systemd "syslog" and "syslog-console" switches have been deprecated
- don't wait for root device if remote cryptsetup active

99base:
- dracut-lib.sh: quote variables in parameter expansion patterns
- remove memtrace-ko and rd.memdebug=4 support in dracut
- remove cleanup_trace_mem calls
- see new module 99memstrack
- prevent creating unexpected files on the host when running dracut

99memstrack:
- memstrack is a new tool to track the overall memory usage and
  allocation, which can help off load the improve the builtin module
  memory tracing function in dracut.

99squash:
- don't hardcode the squash sub directories
- improve pre-requirements check
- check require module earlier, and properly

new modules:
- nvmf
- watchdog-modules
- dbus
- network-wicked

removed modules:
- stratis

test suite:
- use dd from /dev/zero, instead of creating files with a hole
- TEST-03-USR-MOUNT/test.sh: increase loglevel
- TEST-12-RAID-DEG/create-root.sh: more udevadm settle
- TEST-35-ISCSI-MULTI: bump disk space
- TEST-41-NBD-NM/Makefile: should be based on TEST-40-NBD not TEST-20-NFS
- TEST-99: exclude /etc/dnf/* from check

