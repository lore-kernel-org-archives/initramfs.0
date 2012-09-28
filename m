From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Please help: dracut arbitrary mount patches
Date: Fri, 28 Sep 2012 18:02:18 +0200
Message-ID: <1372852.Im5eztC4Lj@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2825322.aCvemeSjdA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2825322.aCvemeSjdA
Content-Type: multipart/mixed; boundary="nextPart6277176.bu1h6jfJQX"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart6277176.bu1h6jfJQX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hello everyone!

I wrote some patches [1] to allow mounting arbitrary devices to arbitra=
ry=20
locations using the cmdline. The master branch contains a merge of all=20=

branches, of which there are 4:
* fstab-mount: Framework to allow mounting via cmdline
* tmpfs: Add support for non-root tmpfs mounts
* nfsmounts: Support for non-root nfs mounts
* aufs: Support for root aufs mounts

During the cmdline hook I create a /run/fstab.early file (various parse=
-*.sh=20
scripts, calling into fs-lib.sh), which I mount during the pre-mount ho=
ok (fs-
lib/mount-early.sh).

So far the theory. In practice this does not work at all, because my pr=
e-mount=20
hook is being executed way too early =E2=80=94 during the cmdline hook =
phase.

In the attached log this is the part starting from:
[    9.924763] dracut: Mounting from /run/fstab.early
It even seems that it tries to execute the mount hook during the cmdlin=
e=20
phase:
[   10.447205] dracut Warning: /sysroot has no proper rootfs layout, ig=
noring=20
and removing offending mount hook

It further does not seem as if an IP address is ever requested via DHCP=
, which=20
I would expect from the ip=3D cmdline parameter.

I have absolutely no idea why that happens and am stuck since a while. =
If you=20
have the time, it would be nice if you could have a look at the patches=
 and=20
maybe give me a hint why this happens.

Best regards,
Dennis

[1] https://github.com/devurandom/dracut
--nextPart6277176.bu1h6jfJQX
Content-Disposition: attachment; filename="blade-02-boot.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="blade-02-boot.log"

Please wait, loading kernel...

 Bootloader 2.0
  Reading MAC address from device: 00:1a:64:b8:06:f2
  Requesting IP address via DHCP: 192.168.100.52
  Requesting file "/images/gentoo-ppc64/vmlinux-3.5.3-gentoo" via TFTP from 192.168.100.1
  Receiving data:  8615 KBytes
  TFTP: Received /images/gentoo-ppc64/vmlinux-3.5.3-gentoo (8615 KBytes)
   Elf64 kernel loaded...
Loading ramdisk...

 Bootloader 2.0
  Reading MAC address from device: 00:1a:64:b8:06:f2
  Requesting IP address via DHCP: 192.168.100.52
  Requesting file "/images/gentoo-ppc64/initramfs-3.5.3-gentoo.img" via TFTP from 192.168.100.1
  Receiving data:  6911 KBytes
  TFTP: Received /images/gentoo-ppc64/initramfs-3.5.3-gentoo.img (6911 KBytes)
ramdisk loaded at 03000000, size: 6911 Kbytes
OF stdout device is: /axon@10000000000/plb5/plb4/opb/serial@40000200
Preparing to boot Linux version 3.5.3-gentoo (root@blade00) (gcc version 4.6.3 (Gentoo 4.6.3 p1.6, pie-0.5.2) ) #2 SMP Sat Sep 15 15:34:12 CEST 2012
Detected machine type: 0000000000000500
command line:  ksdevice=bootif lang=  ip=eth0:dhcp text root=aufs:/run/rw:/run/ro rd.debug rd.mount.early=/run/rw:tmpfs:size=1g rd.mount.early=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000036c0000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000200000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000200000000
instantiating rtas at 0x000000002fff3000... done
boot cpu hw idx 0
starting cpu hw idx 2... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000037c1000 -> 0x00000000037c18e3
Device tree struct  0x00000000037c2000 -> 0x00000000037cb000
[    0.000000] Using Cell machine description
[    0.000000] Found initrd at 0xc000000003000000:0xc0000000036bfda0
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 2 threads per core
[    0.000000] Starting Linux PPC64 #2 SMP Sat Sep 15 15:34:12 CEST 2012
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000078000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 3.5.3-gentoo (root@blade00) (gcc version 4.6.3 (Gentoo 4.6.3 p1.6, pie-0.5.2) ) #2 SMP Sat Sep 15 15:34:12 CEST 2012
[    0.000000] *** 0000 : CF000012
[    0.000000]
[    0.000000] *** 0000 : Setup Arch
[    0.000000] [boot]0012 Setup Arch
[    0.000000] mmio NVRAM, 1020k at 0x14502000000 mapped to d000080080008000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x1ffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0xffffffff]
[    0.000000]   node   1: [mem 0x100000000-0x1ffffffff]
[    0.000000] *** 0000 : CF000015
[    0.000000]
[    0.000000] *** 0000 : Setup Done
[    0.000000] [boot]0015 Setup Done
[    0.000000] PERCPU: Embedded 11 pages/cpu @c000000000700000 s13568 r0 d31488 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 2068480
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line:  ksdevice=bootif lang=  ip=eth0:dhcp text root=aufs:/run/rw:/run/ro rd.debug rd.mount.early=/run/rw:tmpfs:size=1g rd.mount.early=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] freeing bootmem node 0
[    0.000000] freeing bootmem node 1
[    0.000000] Memory: 8128036k/8388608k available (5880k kernel code, 260572k reserved, 648k data, 422k bss, 1996k init)
[    0.000000] SLUB: Genslabs=15, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] IIC for CPU 0 target id 0xe : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 1 target id 0xf : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 2 target id 0x1e : /be@20100000000/interrupt-controller@508400
[    0.000000] IIC for CPU 3 target id 0x1f : /be@20100000000/interrupt-controller@508400
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@10000000000/interrupt-controller: hooking up to IRQ 43
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@30000000000/interrupt-controller: hooking up to IRQ 299
[    0.000000] clocksource: timebase mult[2580c564] shift[24] registered
[    0.000000] Console: colour dummy device 80x25
[    0.065080] pid_max: default: 32768 minimum: 301
[    0.095094] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.150696] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.198524] Mount-cache hash table entries: 256
[    0.227207] Brought up 4 CPUs
[    0.245124] devtmpfs: initialized
[    0.292417] NET: Registered protocol family 16
[    0.320285] IOMMU: Using strong ordering for fixed mapping
[    0.354760] IOMMU table initialized, virtual merging enabled
[    0.390536] IOMMU: Using strong ordering for fixed mapping
[    0.448200] PCI: Probing PCI hardware
[    0.482697] iommu: missing iommu for ? (node -1)
[    0.509912] iommu: missing iommu for ? (node -1)
[    0.538980] bio: create slab <bio-0> at 0
[    0.562876] vgaarb: loaded
[    0.579035] Switching to clocksource timebase
[    0.611167] NET: Registered protocol family 2
[    0.637526] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.685242] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.737194] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.779117] TCP: Hash tables configured (established 524288 bind 65536)
[    0.818283] TCP: reno registered
[    0.837604] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.874158] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.913518] Unpacking initramfs...
[    3.629841] Freeing initrd memory: 6912k freed
[    3.657276] iommu: missing iommu for ? (node -1)
[    3.684675] Setting up PCI bus /axon@10000000000/plb5/plb4/pcix@4000004600000000
[    3.728761] PCI host bridge /axon@10000000000/plb5/plb4/pcix@4000004600000000  ranges:
[    3.776121]   IO 0x0000014608000000..0x000001460800ffff -> 0x0000000000000000
[    3.818829]  MEM 0x0000014780000000..0x00000147bfffffff -> 0x0000000080000000
[    3.862059]  MEM 0x00000147c0000000..0x00000147ffffffff -> 0x00000000c0000000 Prefetch
[    3.909560] of-pci 14600000000.pcix: PCI host bridge to bus 0000:00
[    3.946960] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    4.000603] pci_bus 0000:00: root bus resource [mem 0x14780000000-0x147bfffffff] (bus address [0x80000000-0xbfffffff])
[    4.064667] pci_bus 0000:00: root bus resource [mem 0x147c0000000-0x147ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    4.133133] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a000000000
[    4.174897] PCI host bridge /axon@10000000000/plb5/pciex@a00000a000000000  ranges:
[    4.220199]   IO 0x000001a100000000..0x000001a10000ffff -> 0x0000000000000000
[    4.262903]  MEM 0x000001c080000000..0x000001c0bfffffff -> 0x0000000080000000
[    4.306133]  MEM 0x000001c0c0000000..0x000001c0ffffffff -> 0x00000000c0000000 Prefetch
[    4.353615] of-pci D18000002400.pciex: PCI host bridge to bus 0001:00
[    4.392073] pci_bus 0001:00: root bus resource [io  0x21000-0x30fff] (bus address [0x0000-0xffff])
[    4.445720] pci_bus 0001:00: root bus resource [mem 0x1c080000000-0x1c0bfffffff] (bus address [0x80000000-0xbfffffff])
[    4.509787] pci_bus 0001:00: root bus resource [mem 0x1c0c0000000-0x1c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    4.577133] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a000004000 !
[    4.627473] pci 0001:00:00.0: PCI bridge to [bus 01-01]
[    4.658711] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a200000000
[    4.700686] PCI host bridge /axon@10000000000/plb5/pciex@a00000a200000000  ranges:
[    4.745991]   IO 0x000001a300000000..0x000001a30000ffff -> 0x0000000000000000
[    4.788703]  MEM 0x000001d080000000..0x000001d0bfffffff -> 0x0000000080000000
[    4.831930]  MEM 0x000001d0c0000000..0x000001d0ffffffff -> 0x00000000c0000000 Prefetch
[    4.879405] of-pci D18000002800.pciex: PCI host bridge to bus 0002:00
[    4.917869] pci_bus 0002:00: root bus resource [io  0x32000-0x41fff] (bus address [0x0000-0xffff])
[    4.971517] pci_bus 0002:00: root bus resource [mem 0x1d080000000-0x1d0bfffffff] (bus address [0x80000000-0xbfffffff])
[    5.035582] pci_bus 0002:00: root bus resource [mem 0x1d0c0000000-0x1d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    5.102921] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a200004000 !
[    5.153270] pci 0002:00:00.0: PCI bridge to [bus 01-01]
[    5.184527] Setting up PCI bus /axon@30000000000/plb5/plb4/pcix@4000004600000000
[    5.228574] PCI host bridge /axon@30000000000/plb5/plb4/pcix@4000004600000000  ranges:
[    5.275955]   IO 0x0000034608000000..0x000003460800ffff -> 0x0000000000000000
[    5.318665]  MEM 0x0000034780000000..0x00000347bfffffff -> 0x0000000080000000
[    5.361898]  MEM 0x00000347c0000000..0x00000347ffffffff -> 0x00000000c0000000 Prefetch
[    5.409395] of-pci 34600000000.pcix: PCI host bridge to bus 0003:00
[    5.446792] pci_bus 0003:00: root bus resource [io  0x43000-0x52fff] (bus address [0x0000-0xffff])
[    5.500440] pci_bus 0003:00: root bus resource [mem 0x34780000000-0x347bfffffff] (bus address [0x80000000-0xbfffffff])
[    5.564503] pci_bus 0003:00: root bus resource [mem 0x347c0000000-0x347ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    5.633217] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a000000000
[    5.674993] PCI host bridge /axon@30000000000/plb5/pciex@a00000a000000000  ranges:
[    5.720291]   IO 0x000003a100000000..0x000003a10000ffff -> 0x0000000000000000
[    5.763000]  MEM 0x000003c080000000..0x000003c0bfffffff -> 0x0000000080000000
[    5.806231]  MEM 0x000003c0c0000000..0x000003c0ffffffff -> 0x00000000c0000000 Prefetch
[    5.853713] of-pci D38000002400.pciex: PCI host bridge to bus 0004:00
[    5.892175] pci_bus 0004:00: root bus resource [io  0x54000-0x63fff] (bus address [0x0000-0xffff])
[    5.945817] pci_bus 0004:00: root bus resource [mem 0x3c080000000-0x3c0bfffffff] (bus address [0x80000000-0xbfffffff])
[    6.009881] pci_bus 0004:00: root bus resource [mem 0x3c0c0000000-0x3c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    6.077270] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a000004000 !
[    6.127640] pci 0004:00:00.0: PCI bridge to [bus 01-01]
[    6.158876] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a200000000
[    6.200836] PCI host bridge /axon@30000000000/plb5/pciex@a00000a200000000  ranges:
[    6.246157]   IO 0x000003a300000000..0x000003a30000ffff -> 0x0000000000000000
[    6.288851]  MEM 0x000003d080000000..0x000003d0bfffffff -> 0x0000000080000000
[    6.332079]  MEM 0x000003d0c0000000..0x000003d0ffffffff -> 0x00000000c0000000 Prefetch
[    6.379570] of-pci D38000002800.pciex: PCI host bridge to bus 0005:00
[    6.418023] pci_bus 0005:00: root bus resource [io  0x65000-0x74fff] (bus address [0x0000-0xffff])
[    6.471666] pci_bus 0005:00: root bus resource [mem 0x3d080000000-0x3d0bfffffff] (bus address [0x80000000-0xbfffffff])
[    6.535731] pci_bus 0005:00: root bus resource [mem 0x3d0c0000000-0x3d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[    6.603122] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a200004000 !
[    6.654989] pci 0005:00:00.0: PCI bridge to [bus 01-01]
[    6.686422] iommu: missing iommu for ? (node -1)
[    6.721963] iommu: missing iommu for ? (node -1)
[    6.755449] msgmni has been set to 15888
[    6.778625] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    6.822723] io scheduler noop registered
[    6.846156] io scheduler deadline registered
[    6.871873] io scheduler cfq registered (default)
[    6.989527] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    7.027371] iommu: missing iommu for ? (node -1)
[    7.077334] serial8250.0: ttyS0 at MMIO 0x14540000200 (irq = 16) is a U6_16550A
[    7.120760] console [ttyS0] enabled, bootconsole disabled
[    7.120760] console [ttyS0] enabled, bootconsole disabled
[    7.207011] serial8250.0: ttyS1 at MMIO 0x14540000300 (irq = 17) is a U6_16550A
[    7.272658] serial8250.0: ttyS2 at MMIO 0x34540000200 (irq = 18) is a U6_16550A
[    7.338099] serial8250.0: ttyS3 at MMIO 0x34540000300 (irq = 19) is a U6_16550A
[    7.382641] mousedev: PS/2 mouse device common for all mice
[    7.416102] cpuidle: using governor ladder
[    7.440664] cpuidle: using governor menu
[    7.464599] TCP: cubic registered
[    7.484523] Key type dns_resolver registered
[    7.512392] /usr/src/linux-3.5.3-gentoo/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    7.569478] Freeing unused kernel memory: 1996k freed
+ ismounted /dev
+ findmnt /dev
+ mount -t devtmpfs -o mode=0755,nosuid,strictatime devtmpfs /dev
+ ismounted /dev
+ findmnt /dev
+ [ ! -h /dev/fd ]
+ ln -s /proc/self/fd /dev/fd
+ [ ! -h /dev/stdin ]
+ ln -s /proc/self/fd/0 /dev/stdin
+ [ ! -h /dev/stdout ]
+ ln -s /proc/self/fd/1 /dev/stdout
+ [ ! -h /dev/stderr ]
+ ln -s /proc/self/fd/2 /dev/stderr
+ ismounted /dev/pts
+ findmnt /dev/pts
+ mkdir -m 0755 /dev/pts
+ mount -t devpts -o gid=5,mode=620,noexec,nosu[    7.884538] dracut: dracut-dracut-
id devpts /dev/pts
+ ismounted /dev/shm
+ findmnt /dev/shm
+ mkdir -m 0755 /dev/shm
+ mount -t tmpfs -o mode=1777,nosuid,nodev,strictatime tmpfs /dev/shm
+ ismounted /run
+ findmnt /run
+ mkdir -m 0755 /newrun
+ mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs /newrun
+ cp -a /run/initramfs /run/lock /run/udev /newrun
+ mount --move /newrun /run
+ rm -fr /newrun
+ trap emergency_shell Signal caught! 0
+ [ -d /run/initramf[    8.122566] aufs 3.5-20120813
s ]
+ udevadm --version
+ UDEVVERSION=171
+ [ 171 -gt 166 ]
+ export UDEVRULESD=/run/udev/rules.d
+ [ -d /run/udev ]
+ [ -d /run/udev/rules.d ]
+ [ yes = yes ]
+ mkfifo /run/initramfs/loginit.pipe
+ + exec
loginit
dracut: + [ -f /etc/initrd-rele[    8.273704] NET: Registered protocol family 1
ase ]
dracut: + . /etc/initrd-release
dracut: + NAME=Dracut
dracut: + VERSION=dracut-
dracut: + ID=dracut
dracut: + VERSION[    8.368534] NET: Registered protocol family 10
_ID=
dracut: + PRETTY_NAME=dracut- (Initramfs)
dracut: + ANSI_COLOR=0;34
dracut: + [ -n dracut- ]
dracut: + info dracut-drac[    8.468424] RPC: Registered named UNIX socket transport module.
ut-
dracut: + check_quiet
dracut: + [ -z  ]
dracut: + DRACUT_[    8.519554] RPC: Registered udp transport module.
QUIET=yes
dracut: + getargbool 0 rd.info -d -y rdinfo
dracut: [    8.581105] RPC: Registered tcp transport module.
+ local _b
dracut: + unset _b
dracut: + local _default
dracut[    8.642663] RPC: Registered tcp NFSv4.1 backchannel transport module.
: + _default=0
dracut: + shift
dracut: + getarg rd.info -d -y rdinfo
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=0
dracut: + [ -n 0 ]
dracut: + [ 0 = 0 ]
dracut: + return 1
dra[    8.829554] udevd[137]: starting version 171
cut: + getargbool 0 rd.debug -d -y rdinitdebug
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=0
dracut: + shift
dracut: + getarg rd.debug -d -y rdinitdebug
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + _b=
dracut: + [ 0 -ne 0 -a -z  ]
dracut: + [ -n  ]
dracut: + return 0
dracut: + DRACUT_QUIET=no
dracut: + getarg quiet
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + DRACUT_QUIET=yes
dracut: + getarg loglevel=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + a=
dracut: + [ -n  ]
dracut: + export DRACUT_QUIET
dracut: + echo <30>dracut: dracut-dracut-
dracut: + [ yes != yes ]
dracut: + source_conf /etc/conf.d
dracut: + local f
dracut: + [ /etc/conf.d ]
dracut: + [ -d //etc/conf.d ]
dracut: + return
dracut: + getarg rd.break=cmdline -d rdbreak=cmdline
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + source_hook cmdline
dracut: + local _dir
dracut: + _dir=cmdline
dracut: + shift
dracut: + source_all /lib/dracut/hooks/cmdline
dracut: + local f
dracut: + local _dir
dracut: + _dir=/lib/dracut/hooks/cmdline
dracut: + shift
dracut: + [ /lib/dracut/hooks/cmdline ]
dracut: + [ -d //lib/dracut/hooks/cmdline ]
dracut: + [ -e //lib/dracut/hooks/cmdline/00-wait-host-devs.sh ]
dracut: + . //lib/dracut/hooks/cmdline/00-wait-host-devs.sh
dracut: + type getarg
dracut: + [ -f /etc/host_devs ]
dracut: + [ -e //lib/dracut/hooks/cmdline/01-parse-kernel.sh ]
dracut: + . //lib/dracut/hooks/cmdline/01-parse-kernel.sh
dracut: + getargs rd.driver.pre -d rdloaddriver=
dracut: + debug_off
[    9.722105] tg3.c:v3.123 (March 21, 2012)

dracut: + return 1
dracut: + getargs rd.driver.blacklist -d rd[    9.764905] tg3 0000:00:01.0: enabling device (0140 -> 0142)
blacklist=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + getargs rd.driver.post -d rdinsmodpost=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [[    9.924763] dracut: Mounting from /run/fstab.early
 -n  ]
dracut: + unset _do_insmodpost
dracut: + [ -e //lib/dra[    9.974922] usbcore: registered new interface driver usbfs
[   10.008261] tg3 0000:00:01.0: eth0: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:06:f2
[   10.008277] tg3 0000:00:01.0: eth0: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   10.008291] tg3 0000:00:01.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
cut/hooks/cmdline/10-parse-resume.sh ]
dracut: + . //lib/dracut[   10.008303] tg3 0000:00:01.0: eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[   10.011475] tg3 0000:00:01.1: enabling device (0140 -> 0142)
[   10.022689] tg3 0000:00:01.1: eth1: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:06:f3
[   10.022706] tg3 0000:00:01.1: eth1: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   10.022717] tg3 0000:00:01.1: eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   10.022728] tg3 0000:00:01.1: eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[   10.056028] dracut: Mounting 192.168.100.1:/export/gentoo/root-ppc64
[   10.142400] FS-Cache: Loaded
[   10.243196] NFS: Registering the id_resolver key type
[   10.243349] Key type id_resolver registered
[   10.243355] Key type id_legacy registered
[   10.243607] FS-Cache: Netfs 'nfs' registered for caching
[   10.255315] dracut: mount.nfs: mount(2): Invalid argument
[   10.256080] dracut: mount.nfs: an incorrect mount option was specified
[   10.256858] dracut: mount.nfs: timeout set for Tue Sep 25 09:07:59 2012
[   10.257607] dracut: mount.nfs: trying text-based options '0,vers=4,addr=192.168.100.1,clientaddr=0.0.0.0'
[   10.293213] dracut: Mounting none
[   10.312938] dracut: none on /run/rw type tmpfs (rw,size=1g)
[   10.415282] aufs test_add:261:mount[248]: uid/gid/perm /run/ro 0/0/0755, 0/0/01777
[   10.447205] dracut Warning: /sysroot has no proper rootfs layout, ignoring and removing offending mount hook
/hooks/cmdline/10-parse-resume.sh
dracut: + getarg resume=
dra[   11.008731] usbcore: registered new interface driver hub
cut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: [   11.096045] usbcore: registered new device driver usb
+ resume=
dracut: + unset resume
dracut: + getarg splash=
dra[   11.137807] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
cut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + splash=
dracut: + unset splash
dracut: + [ -e //lib/dracut/hooks/cmdline/10-parse-root-opts.sh ]
dracut: + . //lib/dracut/hooks/cmdline/10-parse-root-opts.sh
dracut: + getarg root=
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: +[   11.345257] ehci_hcd 0003:00:01.2: enabling device (0140 -> 0142)
 root=aufs:/run/rw:/run/ro
dracut: + getarg rootflags=
dracut:[   11.412370] ehci_hcd 0003:00:01.2: EHCI Host Controller
 + debug_off
dracut: + set +x
dracut: + return 1
dracut: + rf[   11.474568] ehci_hcd 0003:00:01.2: new USB bus registered, assigned bus number 1
lags=
dracut: + getargbool 0 ro
dracut: + local _b
dracut: + [   11.573026] ehci_hcd 0003:00:01.2: irq 21, io mem 0x34780002000
unset _b
dracut: + local _default
dracut: + _default=0
dracut[   11.626861] ehci_hcd 0003:00:01.2: USB 2.0 started, EHCI 1.00
: + shift
dracut: + getarg ro
dracut: + debug_off
dracut: + s[   11.689670] hub 1-0:1.0: USB hub found
et +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a[   11.744488] hub 1-0:1.0: 5 ports detected
 -z  ]
dracut: + _b=0
dracut: + [ -n 0 ]
[   11.826903] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver

dracut: + return 1
dracut: + getargbool 0 rw
dracut: + local [   11.893251] ohci_hcd 0003:00:01.0: OHCI Host Controller
_b
dracut: + unset _b
dracut: + local _default
dracut: + _def[   11.937107] ohci_hcd 0003:00:01.0: new USB bus registered, assigned bus number 2
ault=0
dracut: + shift
dracut: + getarg rw
dracut: + debug_of[   12.014803] ohci_hcd 0003:00:01.0: irq 21, io mem 0x34780000000
f
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=0
dracut: + [ -n 0 ]
dracut: + [ 0 = 0 ]
dracut: + return 1
dracut: + rflags=
dracut: + [   12.164600] hub 2-0:1.0: USB hub found
getarg rootfstype=
dracut: + debug_off
dracut: + set +x
dracu[   12.206075] hub 2-0:1.0: 3 ports detected
t: + return 1
dracut: + fstype=
dracut: + [ -z  ]
dracut: + f[   12.264080] ohci_hcd 0003:00:01.1: OHCI Host Controller
stype=auto
dracut: + [ -e //lib/dracut/hooks/cmdline/20-parse-i[   12.328165] ohci_hcd 0003:00:01.1: new USB bus registered, assigned bus number 3
[   12.346222] dracut Warning: Can't mount root filesystem
18n.sh ]
dracut: + . //lib/dracut/hooks/cmdline/20-parse-i18n.s[   12.437339] ohci_hcd 0003:00:01.1: irq 21, io mem 0x34780001000
h
dracut: + inst_key_val  /etc/vconsole.conf KEYMAP vconsole.ke[   12.520474] hub 3-0:1.0: USB hub found
ymap -d KEYTABLE
dracut: + local _value
[   12.562164] hub 3-0:1.0: 2 ports detected

dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg KEYMAP vconsole.keymap -d KEYTABLE
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/vconsole.conf FONT vconsole.font -d SYSFONT
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg FONT vconsole.font -d SYSFONT
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/vconsole.conf FONT_MAP vconsole.font.map -d CONTRANS
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg FONT_MAP vconsole.font.map -d CONTRANS
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/vconsole.conf FONT_UNIMAP vconsole.font.unimap -d UNIMAP
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg FONT_UNIMAP vconsole.font.unimap -d UNIMAP
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val 1 /etc/vconsole.conf UNICODE vconsole.unicode vconsole.font.unicode
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=1
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg UNICODE vconsole.unicode vconsole.font.unicode
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=1
dracut: + [ -n 1 ]
dracut: + printf %s="%s"n UNICODE 1
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/vconsole.conf EXT_KEYMAP vconsole.keymap.ext
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/vconsole.conf
dracut: + shift
dracut: + getarg EXT_KEYMAP vconsole.keymap.ext
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/locale.conf LANG locale.LANG
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
dracut: + shift
dracut: + _file=/etc/locale.conf
dracut: + shift
dracut: + getarg LANG locale.LANG
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + inst_key_val  /etc/locale.conf LC_ALL locale.LC_ALL
dracut: + local _value
dracut: + local _file
dracut: + local _default
dracut: + _default=
/bin/sh: 0: can't access tty; job control turned off
dracut: + shift
dracut:/# dracut: + _file=/etc/locale.conf
dracut: + shift
dracut: + getarg LC_ALL locale.LC_ALL
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _value=
dracut: + [ -z  ]
dracut: + _value=
dracut: + [ -n  ]
dracut: + unset _file
dracut: + unset _value
dracut: + [ -f /etc/locale.conf ]
dracut: + [ -n  ]
dracut: + [ -e //lib/dracut/hooks/cmdline/30-parse-lvm.sh ]
dracut: + . //lib/dracut/hooks/cmdline/30-parse-lvm.sh
dracut: + [ -e /etc/lvm/lvm.conf ]
dracut: + getargbool 1 rd.lvm.conf -d -n rd_NO_LVMCONF
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=1
dracut: + shift
dracut: + getarg rd.lvm.conf -d -n rd_NO_LVMCONF
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=1
dracut: + [ -n 1 ]
dracut: + [ 1 = 0 ]
dracut: + [ 1 = no ]
dracut: + [ 1 = off ]
dracut: + return 0
dracut: + getargbool 1 rd.lvm -d -n rd_NO_LVM
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=1
dracut: + shift
dracut: + getarg rd.lvm -d -n rd_NO_LVM
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=1
dracut: + [ -n 1 ]
dracut: + [ 1 = 0 ]
dracut: + [ 1 = no ]
dracut: + [ 1 = off ]
dracut: + return 0
dracut: + getargs rd.lvm.vg -d rd_LVM_VG=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + getargs rd.lvm.lv -d rd_LVM_LV=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [ -e //lib/dracut/hooks/cmdline/90-parse-nfsroot.sh ]
dracut: + . //lib/dracut/hooks/cmdline/90-parse-nfsroot.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + . /lib/fs-lib.sh
dracut: + type getarg
dracut: + getargs rd.mount.early
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + mount_to_var /run/rw:tmpfs:size=1g
dracut: + local arg=/run/rw:tmpfs:size=1g
dracut: + options=/run/rw:tmpfs:size=1g
dracut: + [ /run/rw:tmpfs:size=1g = /run/rw:tmpfs:size=1g ]
dracut: + unset options
dracut: + arg=/run/rw:tmpfs:size=1g
dracut: + mountpoint=/run/rw
dracut: + [ /run/rw = /run/rw:tmpfs:size=1g ]
dracut: + arg=tmpfs:size=1g
dracut: + [ /run/rw = run/rw ]
dracut: + fstype=tmpfs
dracut: + [ tmpfs = tmpfs:size=1g ]
dracut: + arg=size=1g
dracut: + fs=size=1g
dracut: + [ tmpfs = nfs ]
dracut: + [ tmpfs = nfs4 ]
dracut: + continue
dracut: + mount_to_var /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + local arg=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + options=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 = /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + unset options
dracut: + arg=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + mountpoint=/run/ro
dracut: + [ /run/ro = /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + arg=nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ /run/ro = run/ro ]
dracut: + fstype=nfs
dracut: + [ nfs = nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + arg=192.168.100.1:/export/gentoo/root-ppc64
dracut: + fs=192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ nfs = nfs ]
dracut: + [ -n  ]
dracut: + nfsroot=nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + nfsroot_to_var nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + local arg=nfs:192.168.100.1:/export/gentoo/root-ppc64:
dracut: + nfs=nfs
dracut: + arg=192.168.100.1:/export/gentoo/root-ppc64:
dracut: + strstr 192.168.100.1:/export/gentoo/root-ppc64: :/*
dracut: + [ export/gentoo/root-ppc64: != 192.168.100.1:/export/gentoo/root-ppc64: ]
dracut: + server=192.168.100.1
dracut: + arg=/export/gentoo/root-ppc64:
dracut: + path=/export/gentoo/root-ppc64
dracut: + options=:
dracut: + options=
dracut: + options=
dracut: + [ -n  ]
dracut: + [ /export/gentoo/root-ppc64 != /export/gentoo/root-ppc64 ]
dracut: + [ /export/gentoo/root-ppc64 = error ]
dracut: + [ -z 192.168.100.1 ]
dracut: + echo Adding early mount of nfs:192.168.100.1:/export/gentoo/root-ppc64 to /run/ro
dracut: Adding early mount of nfs:192.168.100.1:/export/gentoo/root-ppc64 to /run/ro
dracut: + add_early_mount 192.168.100.1:/export/gentoo/root-ppc64 /run/ro nfs  0 0
dracut: + local fs=192.168.100.1:/export/gentoo/root-ppc64 mountpoint=/run/ro fstype=nfs options= dump=0 pass=0
dracut: + echo 192.168.100.1:/export/gentoo/root-ppc64 /run/ro nfs  0 0
dracut: + unset nfsroot nfs server path fstype mountpoint fs options
dracut: + [ -n  ]
dracut: + [ -z aufs:/run/rw:/run/ro ]
dracut: + [ -z  ]
dracut: + getarg netroot=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + netroot=
dracut: + [ -z  ]
dracut: + getarg nfsroot=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + nfsroot=
dracut: + [ -n  ]
dracut: + netroot=aufs:/run/rw:/run/ro
dracut: + [ -n  ]
dracut: + unset netroot
dracut: + return
dracut: + [ -e //lib/dracut/hooks/cmdline/91-dhcp-root.sh ]
dracut: + . //lib/dracut/hooks/cmdline/91-dhcp-root.sh
dracut: + [ -n  ]
dracut: + [ -z aufs:/run/rw:/run/ro ]
dracut: + [ -z  ]
dracut: + getarg netroot=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + netroot=
dracut: + [ aufs:/run/rw:/run/ro = dhcp ]
dracut: + [ aufs:/run/rw:/run/ro = dhcp6 ]
dracut: + [  = dhcp ]
dracut: + [ -e //lib/dracut/hooks/cmdline/95-parse-aufsroot.sh ]
dracut: + . //lib/dracut/hooks/cmdline/95-parse-aufsroot.sh
dracut: + type getarg
dracut: + . /lib/aufs-lib.sh
dracut: + type getarg
dracut: + [ -n  ]
dracut: + [ -z aufs:/run/rw:/run/ro ]
dracut: + [ aufs = aufs ]
dracut: + aufs_to_var aufs:/run/rw:/run/ro
dracut: + local branches
dracut: + branches=/run/rw:/run/ro
dracut: + branches=/run/rw:/run/ro
dracut: + aufsrwbranch=/run/rw
dracut: + aufsrobranch=/run/ro
dracut: + [ -n /run/rw ]
dracut: + [ -n /run/ro ]
dracut: + modprobe aufs
dracut: + mkdir /run/rw /run/ro
dracut: + rootok=1
dracut: + [ -e //lib/dracut/hooks/cmdline/95-parse-block.sh ]
dracut: + . //lib/dracut/hooks/cmdline/95-parse-block.sh
dracut: + [ -e //lib/dracut/hooks/cmdline/95-parse-tmpfs.sh ]
dracut: + . //lib/dracut/hooks/cmdline/95-parse-tmpfs.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + getargs rd.mount.early
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + mount_to_var /run/rw:tmpfs:size=1g
dracut: + local arg=/run/rw:tmpfs:size=1g
dracut: + options=/run/rw:tmpfs:size=1g
dracut: + [ /run/rw:tmpfs:size=1g = /run/rw:tmpfs:size=1g ]
dracut: + unset options
dracut: + arg=/run/rw:tmpfs:size=1g
dracut: + mountpoint=/run/rw
dracut: + [ /run/rw = /run/rw:tmpfs:size=1g ]
dracut: + arg=tmpfs:size=1g
dracut: + [ /run/rw = run/rw ]
dracut: + fstype=tmpfs
dracut: + [ tmpfs = tmpfs:size=1g ]
dracut: + arg=size=1g
dracut: + fs=size=1g
dracut: + [ tmpfs = tmpfs ]
dracut: + [ -n  ]
dracut: + unset options
dracut: + echo Adding early mount of tmpfs on /run/rw
dracut: Adding early mount of tmpfs on /run/rw
dracut: + add_early_mount none /run/rw tmpfs size=1g 0 0
dracut: + local fs=none mountpoint=/run/rw fstype=tmpfs options=size=1g dump=0 pass=0
dracut: + echo none /run/rw tmpfs size=1g 0 0
dracut: + mount_to_var /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + local arg=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + options=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 = /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + unset options
dracut: + arg=/run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + mountpoint=/run/ro
dracut: + [ /run/ro = /run/ro:nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + arg=nfs:192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ /run/ro = run/ro ]
dracut: + fstype=nfs
dracut: + [ nfs = nfs:192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + arg=192.168.100.1:/export/gentoo/root-ppc64
dracut: + fs=192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ nfs = tmpfs ]
dracut: + continue
dracut: + [ -e //lib/dracut/hooks/cmdline/95-parse-virtfs.sh ]
dracut: + . //lib/dracut/hooks/cmdline/95-parse-virtfs.sh
dracut: + [ aufs = virtfs ]
dracut: + [ -e //lib/dracut/hooks/cmdline/95-parse-vlan.sh ]
dracut: + . //lib/dracut/hooks/cmdline/95-parse-vlan.sh
dracut: + [ -n  ]
dracut: + getarg vlan=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + unset vlanname phydevice
dracut: + getarg vlan
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [ -e //lib/dracut/hooks/cmdline/96-parse-bond.sh ]
dracut: + . //lib/dracut/hooks/cmdline/96-parse-bond.sh
dracut: + [ -n  ]
dracut: + getarg bond=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + unset bondname bondslaves bondoptions
dracut: + getarg bond
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [ -e //lib/dracut/hooks/cmdline/97-parse-bridge.sh ]
dracut: + . //lib/dracut/hooks/cmdline/97-parse-bridge.sh
dracut: + [ -n  ]
dracut: + getarg bridge=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + unset bridgename ethnames
dracut: + iface=eth0
dracut: + [ -e /tmp/bond.info ]
dracut: + getarg bridge
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + bridge=
dracut: + [ -e //lib/dracut/hooks/cmdline/98-parse-ip-opts.sh ]
dracut: + . //lib/dracut/hooks/cmdline/98-parse-ip-opts.sh
dracut: + command -v getarg
dracut: + command -v ibft_to_cmdline
dracut: + . /lib/net-lib.sh
dracut: + getarg ip=
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + getarg BOOTIF=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + getarg BOOTIF
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [ -n  ]
dracut: + [ -n  ]
dracut: + [ -z  ]
dracut: + count=0
dracut: + getargs ip=
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + count=1
dracut: + [ 1 -gt 1 ]
dracut: + unset count
dracut: + [ -n  ]
dracut: + getarg ip=
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + [ ibft = eth0:dhcp ]
dracut: + getargs ip=
dracut: + debug_off
dracut: + set +x
dracut: + return 0
dracut: + ip_to_var eth0:dhcp
dracut: + local v=eth0:dhcp:
dracut: + local i
dracut: + set --
dracut: + [ -n eth0:dhcp: ]
dracut: + [ eth0:dhcp: != eth0:dhcp: ]
dracut: + set -- eth0
dracut: + v=dhcp:
dracut: + [ -n dhcp: ]
dracut: + [ dhcp: != dhcp: ]
dracut: + set -- eth0 dhcp
dracut: + v=
dracut: + [ -n  ]
dracut: + unset ip srv gw mask hostname dev autoconf macaddr mtu
dracut: + dev=eth0
dracut: + autoconf=dhcp
dracut: + strstr dhcp *.*.*.*
dracut: + [ dhcp != dhcp ]
dracut: + [ dhcp = ibft ]
dracut: + [ -n  ]
dracut: + [ -z dhcp ]
dracut: + [ -n  ]
dracut: + [ -n  ]
dracut: + [ -n eth0 ]
dracut: + [ -n  ]
dracut: + IFACES= eth0
dracut: + [ -z  ]
dracut: + [ -n eth0 ]
dracut: + BOOTDEV=eth0
dracut: + [ -n  ]
dracut: + [ -n  ]
dracut: + [ -n eth0 ]
dracut: + [ -n  eth0 ]
dracut: + IFACES=
dracut: + IFACES=eth0
dracut: + [ -n eth0 ]
dracut: + echo eth0
dracut: + [ -n eth0    ]
dracut: + echo eth0
dracut: + [ -n  ]
dracut: + [ -e //lib/dracut/hooks/cmdline/99-parse-ifname.sh ]
dracut: + . //lib/dracut/hooks/cmdline/99-parse-ifname.sh
dracut: + getarg ifname=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + return
dracut: + [ -z aufs:/run/rw:/run/ro ]
dracut: + [ -z 1 ]
dracut: + export root rflags fstype netroot NEWROOT
dracut: + getarg rd.break=pre-udev -d rdbreak=pre-udev
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + source_hook pre-udev
dracut: + local _dir
dracut: + _dir=pre-udev
dracut: + shift
dracut: + source_all /lib/dracut/hooks/pre-udev
dracut: + local f
dracut: + local _dir
dracut: + _dir=/lib/dracut/hooks/pre-udev
dracut: + shift
dracut: + [ /lib/dracut/hooks/pre-udev ]
dracut: + [ -d //lib/dracut/hooks/pre-udev ]
dracut: + [ -e //lib/dracut/hooks/pre-udev/30-block-genrules.sh ]
dracut: + . //lib/dracut/hooks/pre-udev/30-block-genrules.sh
dracut: + [ aufs = block ]
dracut: + [ -e //lib/dracut/hooks/pre-udev/30-resume-genrules.sh ]
dracut: + . //lib/dracut/hooks/pre-udev/30-resume-genrules.sh
dracut: + a_splash=-P splash=n
dracut: + [ -n  ]
dracut: + getarg noresume
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + [ -x /usr/sbin/resume ]
dracut: + echo SUBSYSTEM=="block", ACTION=="add|change", ENV{ID_FS_TYPE}=="suspend|swsuspend|swsupend",  RUN+="/sbin/initqueue --finished --unique --name 00resume echo %M:%m > /sys/power/resume"
dracut: + [ -e //lib/dracut/hooks/pre-udev/50-ifname-genrules.sh ]
dracut: + . //lib/dracut/hooks/pre-udev/50-ifname-genrules.sh
dracut: + getarg ifname=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + return
dracut: + [ -e //lib/dracut/hooks/pre-udev/60-net-genrules.sh ]
dracut: + . //lib/dracut/hooks/pre-udev/60-net-genrules.sh
dracut: + [ -z  ]
dracut: + [ ! -e /tmp/net.ifaces ]
dracut: + [ -e /tmp/bridge.info ]
dracut: + [ -e /tmp/bond.info ]
dracut: + [ -e /tmp/vlan.info ]
dracut: + ifup=/sbin/ifup $env{INTERFACE}
dracut: + [ -z  ]
dracut: + ifup=/sbin/ifup $env{INTERFACE} -m
dracut: + getarg BOOTIF=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + BOOTIF=
dracut: + [ -n  ]
dracut: + [ -n eth0    ]
dracut: + printf SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="%s"n eth0 /sbin/initqueue --onetime /sbin/ifup $env{INTERFACE} -m
dracut: + [ -e //lib/dracut/hooks/pre-udev/99-nfs-start-rpc.sh ]
dracut: + . //lib/dracut/hooks/pre-udev/99-nfs-start-rpc.sh
dracut: + command -v portmap
dracut: + command -v rpcbind
dracut: + pidof rpcbind
dracut: + [ -z  ]
dracut: + rpcbind
dracut: + [ ! -d /var/lib/nfs/rpc_pipefs/nfs ]
dracut: + mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
dracut: + pidof rpc.statd
dracut: + [ -z  ]
dracut: + rpc.statd
dracut: + pidof rpc.idmapd
dracut: + [ -z  ]
dracut: + rpc.idmapd
dracut: rpc.idmapd: libnfsidmap: using domain: gdv.uni-hannover.de
dracut:
dracut: rpc.idmapd: libnfsidmap: loaded plugin /usr/lib64/libnfsidmap/nsswitch.so for method nsswitch
dracut:
dracut: + /lib/systemd/systemd-udevd --daemon --resolve-names=never
dracut: + UDEV_LOG_PRIO_ARG=--log-priority
dracut: + UDEV_QUEUE_EMPTY=udevadm settle --timeout=0
dracut: + [ 171 -lt 140 ]
dracut: + getargbool 0 rd.udev.info -d -y rdudevinfo
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=0
dracut: + shift
dracut: + getarg rd.udev.info -d -y rdudevinfo
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=0
dracut: + [ -n 0 ]
dracut: + [ 0 = 0 ]
dracut: + return 1
dracut: + getargbool 0 rd.udev.debug -d -y rdudevdebug
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=0
dracut: + shift
dracut: + getarg rd.udev.debug -d -y rdudevdebug
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=0
dracut: + [ -n 0 ]
dracut: + [ 0 = 0 ]
dracut: + return 1
dracut: + udevproperty hookdir=/lib/dracut/hooks
dracut: + [ -z 171 ]
dracut: + [ 171 -ge 143 ]
dracut: + udevadm control --property=hookdir=/lib/dracut/hooks
dracut: + getarg rd.break=pre-trigger -d rdbreak=pre-trigger
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + source_hook pre-trigger
dracut: + local _dir
dracut: + _dir=pre-trigger
dracut: + shift
dracut: + source_all /lib/dracut/hooks/pre-trigger
dracut: + local f
dracut: + local _dir
dracut: + _dir=/lib/dracut/hooks/pre-trigger
dracut: + shift
dracut: + [ /lib/dracut/hooks/pre-trigger ]
dracut: + [ -d //lib/dracut/hooks/pre-trigger ]
dracut: + [ -e //lib/dracut/hooks/pre-trigger/*.sh ]
dracut: + udevadm control --reload
dracut: + udevadm trigger --type=subsystems --action=add
dracut: + udevadm trigger --type=devices --action=add
dracut: + getarg rd.break=initqueue -d rdbreak=initqueue
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + getarg rd.retry -d rd_retry=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + RDRETRY=
dracut: + RDRETRY=30
dracut: + RDRETRY=60
dracut: + export RDRETRY
dracut: + main_loop=0
dracut: + export main_loop
dracut: + :
dracut: + check_finished
dracut: + local f
dracut: + [ /lib/dracut/hooks/initqueue/finished/*.sh = /lib/dracut/hooks/initqueue/finished/*.sh ]
dracut: + return 0
dracut: + break
dracut: + unset job
dracut: + unset queuetriggered
dracut: + unset main_loop
dracut: + unset RDRETRY
dracut: + getarg rd.break=pre-mount -d rdbreak=pre-mount
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + source_hook pre-mount
dracut: + local _dir
dracut: + _dir=pre-mount
dracut: + shift
dracut: + source_all /lib/dracut/hooks/pre-mount
dracut: + local f
dracut: + local _dir
dracut: + _dir=/lib/dracut/hooks/pre-mount
dracut: + shift
dracut: + [ /lib/dracut/hooks/pre-mount ]
dracut: + [ -d //lib/dracut/hooks/pre-mount ]
dracut: + [ -e //lib/dracut/hooks/pre-mount/99-mount-early.sh ]
dracut: + . //lib/dracut/hooks/pre-mount/99-mount-early.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -f /run/fstab.early ]
dracut: + fstab_mount /run/fstab.early
dracut: + local _dev _mp _fs _opts _dump _pass _rest
dracut: + test -e /run/fstab.early
dracut: + info Mounting from /run/fstab.early
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: Mounting from /run/fstab.early
dracut: + [ yes != yes ]
dracut: + read _dev _mp _fs _opts _dump _pass _rest
dracut: + [ -z 192.168.100.1:/export/gentoo/root-ppc64 ]
dracut: + [ ismounted /run/ro ]
dracut: /init: 214: [: ismounted: unexpected operator
dracut: + [  -gt 0 ]
dracut: /init: 215: [: Illegal number:
dracut: + det_fs 192.168.100.1:/export/gentoo/root-ppc64 nfs
dracut: + local _dev=192.168.100.1:/export/gentoo/root-ppc64
dracut: + local _orig=nfs
dracut: + local _fs
dracut: + read line
dracut: + udevadm info --query=env --name=192.168.100.1:/export/gentoo/root-ppc64
dracut: device node not found
dracut: + _fs=
dracut: + _fs=auto
dracut: + [ auto = auto ]
dracut: + _fs=nfs
dracut: + echo nfs
dracut: + _fs=nfs
dracut: + info Mounting 192.168.100.1:/export/gentoo/root-ppc64
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: Mounting 192.168.100.1:/export/gentoo/root-ppc64
dracut: + [ yes != yes ]
dracut: + [ -d /sysroot//run/ro ]
dracut: + [ -d /run/ro ]
dracut: + vinfo
dracut: + read line
dracut: + mount -v -t nfs -o 0 192.168.100.1:/export/gentoo/root-ppc64 /run/ro
dracut: + info mount.nfs: mount(2): Invalid argument
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: mount.nfs: mount(2): Invalid argument
dracut: + [ yes != yes ]
dracut: + read line
dracut: + info mount.nfs: an incorrect mount option was specified
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: mount.nfs: an incorrect mount option was specified
dracut: + [ yes != yes ]
dracut: + read line
dracut: + info mount.nfs: timeout set for Tue Sep 25 09:07:59 2012
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: mount.nfs: timeout set for Tue Sep 25 09:07:59 2012
dracut: + [ yes != yes ]
dracut: + read line
dracut: + info mount.nfs: trying text-based options '0,vers=4,addr=192.168.100.1,clientaddr=0.0.0.0'
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: mount.nfs: trying text-based options '0,vers=4,addr=192.168.100.1,clientaddr=0.0.0.0'
dracut: + [ yes != yes ]
dracut: + read line
dracut: + read _dev _mp _fs _opts _dump _pass _rest
dracut: + [ -z none ]
dracut: + [ ismounted /run/rw ]
dracut: /init: 214: [: ismounted: unexpected operator
dracut: + [ 0 -gt 0 ]
dracut: + det_fs none tmpfs
dracut: + local _dev=none
dracut: + local _orig=tmpfs
dracut: + local _fs
dracut: + read line
dracut: + udevadm info --query=env --name=none
dracut: device node not found
dracut: + _fs=
dracut: + _fs=auto
dracut: + [ auto = auto ]
dracut: + _fs=tmpfs
dracut: + echo tmpfs
dracut: + _fs=tmpfs
dracut: + info Mounting none
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: Mounting none
dracut: + [ yes != yes ]
dracut: + [ -d /sysroot//run/rw ]
dracut: + [ -d /run/rw ]
dracut: + vinfo
dracut: + read line
dracut: + mount -v -t tmpfs -o size=1g none /run/rw
dracut: + info none on /run/rw type tmpfs (rw,size=1g)
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <30>dracut: none on /run/rw type tmpfs (rw,size=1g)
dracut: + [ yes != yes ]
dracut: + read line
dracut: + read _dev _mp _fs _opts _dump _pass _rest
dracut: + return 0
dracut: + getarg rd.break=mount -d rdbreak=mount
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + i=0
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-aufs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-aufs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z  ]
dracut: + mount_root
dracut: + rootfs=aufs
dracut: + rflags=br=/run/rw:/run/ro
dracut: + modprobe aufs
dracut: + mount -t aufs -o br=/run/rw:/run/ro none /sysroot
dracut: + [ -f /sysroot/forcefsck ]
dracut: + [ -f /sysroot/.autofsck ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + usable_root /sysroot
dracut: + local _d
dracut: + [ -d /sysroot ]
dracut: + [ -e /sysroot/proc ]
dracut: + return 1
dracut: + warn /sysroot has no proper rootfs layout, ignoring and removing offending mount hook
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <28>dracut Warning: /sysroot has no proper rootfs layout, ignoring and removing offending mount hook
dracut: + echo dracut Warning: /sysroot has no proper rootfs layout, ignoring and removing offending mount hook
dracut: dracut Warning: /sysroot has no proper rootfs layout, ignoring and removing offending mount hook
dracut: + umount /sysroot
dracut: + rm -f /lib/dracut/hooks/mount/99-mount-aufs.sh
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=1
dracut: + [ 1 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=2
dracut: + [ 2 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=3
dracut: + [ 3 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=4
dracut: + [ 4 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=5
dracut: + [ 5 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=6
dracut: + [ 6 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=7
dracut: + [ 7 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=8
dracut: + [ 8 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=9
dracut: + [ 9 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=10
dracut: + [ 10 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=11
dracut: + [ 11 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=12
dracut: + [ 12 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=13
dracut: + [ 13 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=14
dracut: + [ 14 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=15
dracut: + [ 15 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=16
dracut: + [ 16 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=17
dracut: + [ 17 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=18
dracut: + [ 18 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=19
dracut: + [ 19 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=20
dracut: + [ 20 -gt 20 ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/10-resume.sh ]
dracut: + . /lib/dracut/hooks/mount/10-resume.sh
dracut: + PATH=/usr/sbin:/usr/bin:/sbin:/bin
dracut: + [ -s /.resume -a -b  ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-root.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-root.sh
dracut: + type getarg
dracut: + type det_fs
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + [ -f /lib/dracut/hooks/mount/99-mount-virtfs.sh ]
dracut: + . /lib/dracut/hooks/mount/99-mount-virtfs.sh
dracut: + type getarg
dracut: + [ -n aufs:/run/rw:/run/ro -a -z aufs:/run/rw:/run/ro ]
dracut: + :
dracut: + ismounted /sysroot
dracut: + findmnt /sysroot
dracut: + i=21
dracut: + [ 21 -gt 20 ]
dracut: + flock -s 9
dracut: + emergency_shell Can't mount root filesystem
dracut: + local _ctty
dracut: + set +e
dracut: + local _rdshell_name=dracut action=Boot hook=emergency
dracut: + [ Can't mount root filesystem = -n ]
dracut: + [ Can't mount root filesystem = --shutdown ]
dracut: + echo
dracut:
dracut: + echo
dracut:
dracut: + warn Can't mount root filesystem
dracut: + check_quiet
dracut: + [ -z yes ]
dracut: + echo <28>dracut Warning: Can't mount root filesystem
dracut: + echo dracut Warning: Can't mount root filesystem
dracut: dracut Warning: Can't mount root filesystem
dracut: + source_hook emergency
dracut: + local _dir
dracut: + _dir=emergency
dracut: + shift
dracut: + source_all /lib/dracut/hooks/emergency
dracut: + local f
dracut: + local _dir
dracut: + _dir=/lib/dracut/hooks/emergency
dracut: + shift
dracut: + [ /lib/dracut/hooks/emergency ]
dracut: + [ -d //lib/dracut/hooks/emergency ]
dracut: + [ -e //lib/dracut/hooks/emergency/*.sh ]
dracut: + echo
dracut:
dracut: + getargbool 1 rd.shell -d -y rdshell
dracut: + local _b
dracut: + unset _b
dracut: + local _default
dracut: + _default=1
dracut: + shift
dracut: + getarg rd.shell -d -y rdshell
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _b=
dracut: + [ 1 -ne 0 -a -z  ]
dracut: + _b=1
dracut: + [ -n 1 ]
dracut: + [ 1 = 0 ]
dracut: + [ 1 = no ]
dracut: + [ 1 = off ]
dracut: + return 0
dracut: + _emergency_shell dracut
dracut: + local _name=dracut
dracut: + [ -n  ]
dracut: + echo Dropping to debug shell.
dracut: Dropping to debug shell.
dracut: + echo
dracut:
dracut: + export PS1=dracut:${PWD}#
dracut: + [ -e /.profile ]
dracut: +
dracut: + getarg rd.ctty=
dracut: + debug_off
dracut: + set +x
dracut: + return 1
dracut: + _ctty=
dracut: + [ -z  ]
dracut: + _ctty=console
dracut: + [ -f /sys/class/tty/console/active ]
dracut: + cat /sys/class/tty/console/active
dracut: + _ctty=ttyS0
dracut: + _ctty=ttyS0
dracut: + [ -f /sys/class/tty/ttyS0/active ]
dracut: + _ctty=/dev/ttyS0
dracut: + [ -c /dev/ttyS0 ]
dracut: + /usr/bin/setsid --help
dracut: + setsid /bin/sh -i -l
--nextPart6277176.bu1h6jfJQX--

--nextPart2825322.aCvemeSjdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlBlygoACgkQjqfyF1DtJW6JiwCfTXpXngp8t4m6dfXkqlwHp/BH
7d8An2NjnYvoa03VpKgSLowXw8BwzgPm
=64bw
-----END PGP SIGNATURE-----

--nextPart2825322.aCvemeSjdA--
