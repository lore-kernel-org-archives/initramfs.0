From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 044
Date: Wed, 25 Nov 2015 14:28:38 +0100
Message-ID: <5655B786.3000508@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to this
release.

The tarball can be found here:
        http://www.kernel.org/pub/linux/utils/boot/dracut/
        ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/

Git:
        git://git.kernel.org/pub/scm/boot/dracut/dracut.git
        http://git.kernel.org/pub/scm/boot/dracut/dracut.git
        https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
        http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS


dracut-044
==========
creation:
- better udev & systemd dir detection
- split dracut-functions.sh in dracut-init.sh and dracut-functions.sh
  dracut-functions.sh can now be sourced by external tools
- detect all btrfs devices needed
- added flag file if initqueue is needed
- don't overwrite anything, if initramfs image file creation failed
- if no compressor is specified, try to find a suitable one
- drop scanning kernel config for CONFIG_MICROCODE_*_EARLY
- remove "_EARLY" from CONFIG_MICROCODE_* checks
- dracut.sh: add command line option for install_i18_all
  --no-hostonly-i18n -> install_i18n_all=yes
  --hostonly-i18n -> install_i18n_all=no
- --no-reproducible to turn off reproducible mode
- dracut-function.sh can now be sourced from outside of dracut
- dracut-init.sh contains all functions, which only can be used from
  within the dracut infrastructure
- support --mount with just mountpoint as a parameter
- removed action_on_fail support
- removed host_modalias concept
- do not create microcode, if no firmware is available
- skip gpg files in microcode generation

initramfs:
- ensure pre-mount (and resume) run before root fsck
- add --online option to initqueue

qemu:
- fixed virtual machine detection

lvm:
- remove all quirk arguments for lvm >= 2.2.221

dmsquash:
- fixup for checkisomd5
- increase timeout for checkisomd5
- use non-persistent metadata snapshots for transient overlays.
- overflow support for persistent snapshot.
- use non-persistent metadata snapshots.
- avoid an overlay for persistent, uncompressed, read-write live installations.

multipath:
- multipath.conf included in hostonly mode
- install all multipath path selector kernel modules

iSCSI:
- use the iBFT initiator name, if found and set
- iscsid now present in the initramfs
- iscsistart is done with systemd-run asynchrone to do things in
  paralllel. Also restarted for every new interface which shows up.
- If rd.iscsi.waitnet (default) is set, iscsistart is done only
  after all interfaces are up.
- If not all interfaces are up and rd.iscsi.testroute (default) is set,
  the route to a iscsi target IP is checked and skipped, if there is none.
- If all things fail, we issue a "dummy" interface iscsiroot to retry
  everything in the initqueue/timeout.

network:
- added DHCP RENEW/REBIND
- IPv4 DHCP lease time now optional (bootp)
- IPv6 nfs parsing
- fixed IPv6 route parsing
- rd.peerdns=0 parameter to disable DHCP nameserver setting
- detect duplicate IPv4 addresses for static addresses
- if interfaces are specified with its enx* name, bind the correspondent MAC
  to the interface name
- if multiple "ip=" are present on the kernel command line "rd.neednet=1"
  is assumed
- add options to tweak timeouts
     rd.net.dhcp.retry=<cnt>
         If this option is set, dracut will try to connect via dhcp
         <cnt> times before failing. Default is 1.

     rd.net.timeout.dhcp=<arg>
         If this option is set, dhclient is called with "-timeout <arg>".

     rd.net.timeout.iflink=<seconds>
         Wait <seconds> until link shows up. Default is 60 seconds.

     rd.net.timeout.ifup=<seconds>
         Wait <seconds> until link has state "UP". Default is 20 seconds.

     rd.net.timeout.route=<seconds>
         Wait <seconds> until route shows up. Default is 20 seconds.

     rd.net.timeout.ipv6dad=<seconds>
         Wait <seconds> until IPv6 DAD is finished. Default is 50 seconds.

     rd.net.timeout.ipv6auto=<seconds>
         Wait <seconds> until IPv6 automatic addresses are assigned.
         Default is 40 seconds.

     rd.net.timeout.carrier=<seconds>
         Wait <seconds> until carrier is recognized. Default is 5 seconds.

IMA:
- load signed certificates in the IMA keyring, see modules.d/98integrity/README
- load EVM public key in the kernel _evm keyring

FCoE:
- start with fcoemon instead of fipvlan
