From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] debian: bring changelog up to speed
Date: Fri, 26 Feb 2010 15:39:35 +0100
Message-ID: <1267195175-15554-7-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

update debian changelog up to tag 004 and change the versioning
theme to use the same as the one used in git.
---
 debian/changelog |  344 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 323 insertions(+), 21 deletions(-)

diff --git a/debian/changelog b/debian/changelog
index b7a9d12..d87b8d1 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,20 +1,218 @@
-dracut (2.26) unstable; urgency=low
+dracut (004) unstable; urgency=low
+  * Closes: #558274
+
+  [ Andrey Borzenkov ]
+  * Add user suspend support
+
+  [ Harald Hoyer ]
+  * AUTHORS: updated
+  * .mailmap: updated
+  * multipath: supress warnings, if multipath not installed on system
+  * cryptroot-ask.sh:  s/==/=/g (bug #542081)
+  * plymouth-pretrigger: force initializing of console (bug #526570)
+  * multipath: check for existance before trying to install
+  * dracut-lib: prevent double log output
+  * add man pages for dracut-catimages and dracut-gencmdline
+  * cryptroot-ask.sh: fixed luks handling
+  * dmsquash: add nasty hack for cdroms
+  * dracut.spec: add Obsoletes of mkinitrd/nash/libbdevid-python
+  * s390: add call to *_cio_free and use current s390utils udev rules
+  * kernel: add rdloaddriver kernel command line parameter
+  * crypt/dm: move dmeventd to dm module
+  * install lsinitrd/mkinitrd
+  * lvm: add rd_LVM_LV and "--poll n"
+  * dracut.spec: update plymouth requirements
+  * test: remove lvm.conf in create-root.sh
+  * lvm: remove lvm-cleanup
+  * add lsinitrd
+  * dracut.spec: only obsolete for rhel >= 6 and fedora > 12
+  * dracut-lib: read multiple lines from $init/etc/cmdline
+  * test: remove lvm.conf in create-root.sh
+  * dracut-lib: do not leave debug mode in getarg and getargs
+  * version 004
+
+  [ Konrad Rzeszutek Wilk ]
+  * 60xen: add support for loading Xen modules
+
+  [ Luca Berra ]
+  * redhat-i18n: search also in /usr/lib
+  * terminfo: search also for /usr/share/terminfo
+  * dracut-functions: add support for compressed kernel modules
+  * base: do not force load policy if selinux is not installed at all
+  * install umount for the modules, which use it
+  * base: improve emergency shell
+  * dracut-functions: add additional drivers in host-only mode, too
+  * add mkinitrd-dracut.sh wrapper
+  * Ensure UNICODE keyboard layout is functional in emergency shell
+
+  [ Mike Snitzer ]
+  * lvm:  lvm.conf (locking_type = 4)
+
+  [ Munehiro Matsuda ]
+  * dmsquash: add support for loopmounted *.iso files
+
+  [ Warren Togami ]
+  * dracut.spec: nbd is Fedora only
+
+ -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 26 Feb 2010 14:45:00 +0100
+
+dracut (003) unreleased; urgency=low
+  [ Alan Jenkins ]
+  * dracut-gencmdline: fix regex quoting in findstoragedriver()
+  * Tidy up some comments
+
+  [ Dan Horak ]
+  * control filesystems included in the generic initramfs
+  * move dasd initialization script and rules to s390utils
+
+  [ David Cantrell ]
+  * Rename existing 95dasd handling to 95dasd_mod.
+  * Support new rd_DASD parameter for s390 systems.
+  * Update dracut.8 with new rd_DASD parameter information.
+
+  [ Hans de Goede ]
+  * Do not stop / start udev exec-queue around "mdadm -As --run"
+  * Recognize nodmraid and noiswmd kernel cmdline options
 
   [ Harald Hoyer ]
+  * dracut-gencmdline: add missing functions
+  * kernel-modules: force install of scsi_wait_scan in hostonly mode
+  * md/dm/lvm: install pre-pivot cleanup hooks only if actually needed
+  * lvm: add rd_NO_LVMCONF
+  * dmsquash-live: add initqueue-finished
+  * selinux: bail out if policy could not be loaded and selinux=0 not     specified
+  * devicemapper: add dmeventd and new rules for device mapper
+  * dmraid: add missing dso
+  * rename 95s390 to 95dasd
+  * 95dasd: do not install zfcp kernel module
+  * 95dasd: fixed typo in modules.conf generation
+  * 95dasd: use 'uname -m' instead of 'arch'
+  * dracut.8: fixed ifname position
+  * 95dasd: add dasd_diag_mod module
+  * dm/lvm: make usage of new udev event rules optionally
+  * Makefile: reorder targets
+  * init: mount /dev/shm
+  * init: start udevd with --resolve-names=never
+  * dracut-functions: inst_simple() with cp -p to preserver timestamps, etc.
+  * dracut-functions: let inst*() honor and handle symlinks correctly
+  * network: move netroot to initqueue
+  * nfs: specify nfs version 3 explicitly and retry with nfs version 2
+  * nbd: finish on /dev/root rather than on nbd0
+  * mdraid: do not cleanup on auto assembly with mdadm.conf
+  * nbd/nbdroot: use udevsettle to wait for /dev/nbd0
+  * nbd/nbdroot: do not redirect debug output on rdnetdebug
+  * network/netroot: do not redirect output on rdnetdebug
+  * network/netroot: remove flock
+  * nbd/nbdroot: add better check if nbd0 is ready to be mounted
+  * base/dracut-lib: add setdebug
+  * nfs/nfsroot: do not redirect output on rdnetdebug
+  * syslog: use initqueue to start syslog
+  * base/init: stop udev exec queue before killing it
+  * iscsi/iscsiroot: remove redirection on rdnetdebug
+  * base: add logger for rdinitdebug
+  * dracut: strip kernel modules which have no x bit set
+  * dmsquash: use info() and die() rather than echo
+  * updated NEWS
+  * fixed UUID= and LABEL= handling
+  * dracut-gencmdline: fixed rd_NO_LUKS case
+  * updated NEWS
+  * base: add missing loginit
+  * network: wait for interfaces to come up, before proceeding
+  * dracut.spec: update changelog and filelists
+  * test/*/hard-off.sh: poweroff, if failme specified
+  * test: add "failme" parameter for failing tests
+  * TEST-50-MULTINIC/test.sh: add selinux=0
+  * 99base/initqueue: make operations more atomic
+  * test: run all tests with rdinitdebug by default
+  * add .mailmap
+  * AUTHORS: generated by git-shortlog
+  * do not use init= arg as first argument
+  * dmsquash-live: run dmsquash-live-root after udev settle
+  * base/init: kill loginit after one second of waiting
+  * dracut.8: fixed typos
+  * base/init: make link /dev/fd, mount devpts,tmpfs with correct dev parm
+  * plymouth: suppress "find" errors
+  * dracut: exit traps with original exitcode
+  * dasd: rename dasd= to rd_DASD=
+  * add zfcp support for s390
+  * network/parse-bridge: check for bridge parameter not ip
+  * dracut.8: correct typo
+  * add s390 network support
+  * ccw: s/layer1/layer2/g
+  * dmraid: do not fail if /usr/lib/libdmraid-events-isw.so is not present
+  * dracut: if called with "-l" read only local dracut.conf
+  * dmraid: only install libdmraid-events-isw.so
+  * run-qemu: specify PATH
+  * test/*/hard-off.sh: do not powerdown on rdshell
+  * dracut-lib: fixed wait_for_if_up()
+  * test: add rdinfo
+  * test/TEST-20-NFS: kill server if pid file present on run()
+  * dracut.spec: reverse switch_root logic
+  * specfile update
+  * join $dsrc and $dracutbasedir
+  * 90dmraid,90lvm: device mapper upstream rules got renamed
+  * TEST-14-IMSM/create-root.sh: wait until md0 is ready synced
+  * dracut.spec: update
+  * specfile update
+  * kernel-modules: install all usb storage modules also
+  * udev-rules: do not run blkid on temporary device mapper devices
+  * dracut-functions: dinfo() on missing firmware, rather than dwarning()
+  * dracut-gencmdline: do not use full path for readlink
+  * crypt: refix rd_LUKS_UUID handling
+  * crypt: install /etc/crypttab and honor crypttab entries
+  * dracut.8: add more documentation to rd_LUKS_UUID
+  * 95dasd: fixed rd_DASD argument handling
+  * dracut.spec: update
+  * dracut.8: add FILES section
+  * kernel-modules: add scsi_dh scsi_dh_rdac scsi_dh_emc
+  * zfcp: only install /etc/zfcp.conf in hostonly mode
+  * dasd: only install /etc/dasd.conf in hostonly mode
+  * crypt: ignore devices in /etc/crypttab (root is not in there)
+  * renamed module 95ccw to 95znet
+  * add module fips
+  * add module 90multipath
+  * specfile update
   * multipath: install udev rules and helper tools
   * NEWS update
   * multipath: install xdr utils
   * multipath: install multipath kernel module
   * specfile update
   * dracut.8: fixed formatting for rootfs and mount options
-  * dracut: check more return codes, check for permissions and use
-    derror
+  * dracut: check more return codes, check for permissions and use derror
   * dracut: create initramfs-$(kernelversion).img by default
   * Makefile: add WITH_SWITCH_ROOT
   * fips: search different lib paths
   * kernel-modules: add firewire-ohci to hardcoded modules list
   * 90dm: install more device mapper kernel modules
   * specfile update
+  * lvm: scan without monitor
+  * lvm/dmraid: make LIBDIR depend on the binary
+  * nfs: install passwd entries for nobody and nfsnobody
+  * nfs: add rd_NFS_DOMAIN parameter to set the NFSv4 domain name
+  * dracut-functions: inst_simple(): do not bail out if target is a dir and exists
+  * dm: install dmsetup
+  * multipath: corrected initqueue parameter
+  * rootfs-block/mount-root: remount root with /etc/fstab filesystem options
+  * test: set PATH
+  * dracut: fix no_kernel typo
+  * add dracut.conf man page
+  * dracut.spec: add comment how to get source for a git snapshot
+  * changed hostonly documentation and handling
+  * fips: add shebang to fips.sh
+  * fips: more shebang
+  * fips: do not activate fips module by default
+  * dracut.spec: removed ubuntu module
+  * Makefile: gitrpm: cleanup on failed rpmbuild
+  * debian: s/dracut-net/dracut-network/g
+  * version 003
+
+  [ Lance Albertson ]
+  * custom paths
+  * dir symlinks
+  * dracut-gencmdline: check for keyboard & i18n files
+
+  [ Michal Schmidt ]
+  * dracut.8: removed switch_root relicts and changed URL
 
   [ Peter Jones ]
   * Use glob for libdir when installing multipath libraries.
@@ -25,29 +223,133 @@ dracut (2.26) unstable; urgency=low
   * This has to be executable.
   * Handle modules with hyphens in their names properly.
 
-  [ Harald Hoyer ]
-  * lvm: scan without monitor
+  [ Philippe Seewer ]
+  * Be a bit more optimistic when setting mtus
+  * Get rid of hostname utility
+  * Add simple STP timeout handler
+  * Add DAD to dhclient-script
+  * Add multinic test suite
+  * Move write-ifcfg to its own module
+  * Add old style ide drivers if available
+  * test: Add compatibility for different kernel configs
+  * Add dm_mod loader
+  * syslog-genrules.sh: Shebang should be /bin/sh not /bin/dash
+  * Module scripts should be executable
+  * initqueue: Remove trailing ;
+  * loginit: Fix shebang
+  * Fix manpage display errors
+  * All module scripts should have a shebang
+  * Remove Ubuntu 8.10 support
+  * Debian support: Add dracut-update-initramfs
+  * Debian support: Add necessary control files for packaging
+
+  [ Warren Togami ]
+  * Fix LiveCD boot regression caused by bf55e2c5d3d0c12ad9d5363fb51c29eabc9f0008     FIXME: There is still something wrong with this boot where it wants to use umount, but doing so breaks live boot.
+  * Removing umount appears to be a mistake, it seems to have been OK prior.
+  * Fix comment typo
+  * Better check if writing ifcfg files is necessary.
+  * Revert to per-device resolv.conf by Seewer's suggestion.
+  * dmsquash-live-root requires grep
 
   [ Yanko Kaneti ]
   * Wildcards need dracut_install
 
-  [ Harald Hoyer ]
-  * lvm/dmraid: make LIBDIR depend on the binary
-  * nfs: install passwd entries for nobody and nfsnobody
-  * nfs: add rd_NFS_DOMAIN parameter to set the NFSv4 domain name
-  * dracut-functions: inst_simple(): do not bail out if target is a dir
-    and exists
-  * dm: install dmsetup
-  * multipath: corrected initqueue parameter
-  * rootfs-block/mount-root: remount root with /etc/fstab filesystem
-    options
-  * test: set PATH
+ -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 27 Nov 2009 15:52:00 +0100
 
- -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 27 Nov 2009 10:58:26 +0100
+dracut (002) unreleased; urgency=low
+  [ Hans de Goede ]
+  * Add ifname= argument for persistent netdev names
+  * Document netroot=fcoe:....
+  * Document that MAC addresses must be lowercase
+  * 90dmraid: use kpartx to scan for partitions
+  * Add ifname= argument for persistent netdev names
 
-dracut (2.21) unstable; urgency=low
   [ Harald Hoyer ]
-  * fix rd_DASD argument handling (bug #531720)
-  * Resolves: rhbz#531720
+  * reordered blkid/vol_id rules
+  * mdraid: add grep for convenience
+  * {crypt,dmraid,lvm,mdraid}: cleanup with pre-pivot 30 and 31
+  * 95udev-rules: fixed c&p bug which did not install 61-persistent-storage.rules
+  * TEST-12-RAID-DEG: check with root=LABEL=root
+  * mdraid_start.sh: fixed raid activation
+  * add scp to debug module
+  * mdraid-cleanup: do not stop mdraid container
+  * added initqueue-settled and refactored code
+  * 65-md-incremental-imsm: add additional check for md-non-containers
+  * TEST-14-IMSM: no test for a isw raid array
+  * dmraid: only install 64-md-raid.rules if no vol_id present
+  * mdraid: stop udev queue until mdraid assembled
+  * TEST-14-IMSM: more test cases
+  * TEST-14-IMSM: create raid5 inside isw raid container
+  * initqueue: add --name parameter to give a name for --unique
+  * 65-md-incremental-imsm.rules: refine rules
+  * selinux-loadpolicy.sh: mount /proc and /selinux before loading the     policies
+  * base/init: add scsi_wait_scan to wait for host adapter scans
+  * selinux-loadpolicy: do not mount /proc and /selinux
+  * add parameter to specify additional kernel modules to include
+  * selinux-loadpolicy: do not mount /proc and /selinux
+  * 99base/init: output more info()
+  * dracut.spec: do not require policycoreutils
+  * dracut-functions: make inst() mkinitrd compatible
+  * plymouth: use /usr/libexec/plymouth/plymouth-populate-initrd if possible
+  * selinux-loadpolicy: set initial ret=0
+  * dracut.spec: require plymouth-scripts
+  * selinux-loadpolicy.sh: also check for /etc/selinux/config
+  * init: fixed command line handling for /sbin/init and init=<custom init>
+  * removed initrdargs from parse-*.sh
+  * plymouth: removed rd_plytheme
+  * selinux-loadpolicy: do not check for selinux config files
+  * dracut-functions: fixed inst() for mkinitrd compat
+  * 90dmraid: install parse-dm.sh
+  * add pcmcia adapter
+  * fix backwards inst() compat
+  * plymouth: grep for PLYMOUTH_POPULATE_SOURCE_FUNCTIONS
+  * dracut: determine path to dracut-functions
+  * init: add initqueue-finished
+  * switch modules to initqueue-finished
+  * 90dmraid: switch rd_NO_DM to udev ENV
+  * 95resume: simplyfy rules and also recognize blkid typo
+  * 95rootfs-block/mount-root.sh: ignore /.resume
+  * 95resume/install: give resume higher prio than mount
+  * mdraid: add rd_NO_MDADMCONF --mdadmconf --nomdadmconf
+  * plymouth: add rd_NO_PLYMOUTH
+  * 90mdraid: only switch mdmon to new root, if an instance is running
+  * initqueue: first remove the job, then execute it
+  * initqueue-finished: fail also on empty queue
+  * 95rootfs-block/block-genrules.sh: beautify code
+  * 90crypt/70-luks.rules: set unique name for initqueue job
+  * TEST-14-IMSM: "rd_NO_DM rd_NO_MDIMSM rd_NO_MDADMCONF" fails
+  * 10rpmversion: try to get the correct dracut rpm version during %post
+  * dracut-lib.sh: change -f to -e to allow symlinks
+  * 90mdraid/65-md-incremental-imsm.rules: first set initqueue-finished,     then initqueue-settled
+  * network: break udevsettle early
+  * changelog/NEWS update
+  * add udevproperty() to dracut-lib and use it
+  * 10rpmversion,dracut.spec: generate version file and install it
+  * 10rpmversion/install: fix non-rpm install
+  * dmraid: use and install kpartx for dmraids
+  * TEST-11-LVM: add rdinfo
+  * TEST-14-IMSM: rd_NO_DM rd_NO_MDIMSM rd_NO_MDADMCONF succeeds now
+  * lvm/dm/md: switch from lockfiles to $sys/$devpath/holders/*
+  * 65-md-incremental-imsm.rules: check if md raid is already running
+  * dracut.spec: update changelog
+  * dracut.spec: removed gittags
+  * create /var/run in 99base
+  * mdraid: save state dir for mdmon/mdadm for the real root
+  * dracut.spec: inc release
+  * dracut: use and export PATH=/sbin:/bin:/usr/sbin:/usr/bin
+  * version 002
+
+  [ Peter Rajnoha ]
+  * LVM/DM rules in dracut
+
+  [ Quentin Armitage ]
+  * dracut : remove extraneous output to screen during execution
+
+  [ Victor Lowther ]
+  * Made hostonly checking for fcoe fail for now.
+  * Merge commit 'origin/master'
+
+  [ Warren Togami ]
+  * dmsquash-live-root requires umount
 
- -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 06 Nov 2009 15:52:00 +0100
+ -- Philippe Seewer <philippe.seewer@.bfh.ch>  Fri, 27 Nov 2009 15:52:00 +0100
-- 
1.7.0
