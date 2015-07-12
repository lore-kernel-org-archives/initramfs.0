From: "Ali H. Caliskan" <ali.h.caliskan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Timeout failure with rd.live.image boot option.
Date: Sun, 12 Jul 2015 13:22:04 +0200
Message-ID: <CAFO=TmXxiYjsnkB3_=PUij4on8kJu+CcE-HU9pzkVvjvyjwSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=G+3+GW+6mIbkv/5JbCyj0JYI570rOmJYDgENBhiNCXc=;
        b=m+owHyjyppFmLguk9COY0x9y400aJJYZ5iRGZDZNtIGRi8R3IhFGO/0eRUhkAoZkkH
         BSbRc1dTMp7HISC8Xq7FAvPJQ4SNlULdSEVG2fA4Ejbl4FbxqCmtGsIUFnZwNwq4cYxp
         gRdODUEtPyIhEoxVpZw2ikFCkkEEDeIBp6HFTf0keULocnX3HL3zUWiaYZEr8ye0oGFc
         mgCuerfSYm7VbhogwLdnCu6Eh8Lt6cxEnt/WK7AOFl3jIn37SB196bPfyJ/Kbh7oyoS6
         VOQwD8aS8rV3xx/Z+5YYMFNMjqUI54nzazBvZrifljsy2Fv2sV6msthyXmaDxTYIPAGo
         ijTA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

While dracut version 041 boots fine, dracut 042/043 or the latest git
version doesn't boot at all. Systemd complains about:

localhost systemd[1]: dev-mapper-live\x2drw.device: Job
dev-mapper-live\x2drw.device/start failed with result 'timeout'.

Here is the entire rdsosreport.txt:

+ cat /lib/dracut/dracut-043-42-gee44f62
dracut-043-42-gee44f62
+ cat /proc/cmdline
BOOT_IMAGE=3Dboot/vmlinuz rd.live.image rd.live.overlay.size=3D1024
root=3DLABEL=3DGNURAMALINUX_201507 initrd=3Dboot/initramfs
+ '[' -f /etc/cmdline ']'
+ for _i in '/etc/cmdline.d/*.conf'
+ '[' -f '/etc/cmdline.d/*.conf' ']'
+ break
+ cat /proc/self/mountinfo
0 0 0:1 / / rw shared:1 - rootfs rootfs rw
16 0 0:16 / /sys rw,nosuid,nodev,noexec,relatime shared:2 - sysfs sysfs=
 rw
17 0 0:4 / /proc rw,nosuid,nodev,noexec,relatime shared:7 - proc proc r=
w
18 0 0:6 / /dev rw,nosuid shared:8 - devtmpfs devtmpfs
rw,size=3D6054656k,nr_inodes=3D1513664,mode=3D755
19 16 0:17 / /sys/kernel/security rw,nosuid,nodev,noexec,relatime
shared:3 - securityfs securityfs rw
20 18 0:18 / /dev/shm rw,nosuid,nodev shared:9 - tmpfs tmpfs rw
21 18 0:13 / /dev/pts rw,nosuid,noexec,relatime shared:10 - devpts
devpts rw,gid=3D5,mode=3D620,ptmxmode=3D000
22 0 0:19 / /run rw,nosuid,nodev shared:11 - tmpfs tmpfs rw,mode=3D755
23 16 0:20 / /sys/fs/cgroup ro,nosuid,nodev,noexec shared:4 - tmpfs
tmpfs ro,mode=3D755
24 23 0:21 / /sys/fs/cgroup/systemd rw,nosuid,nodev,noexec,relatime
shared:5 - cgroup cgroup
rw,xattr,release_agent=3D/usr/lib/systemd/systemd-cgroups-agent,name=3D=
systemd
25 16 0:22 / /sys/fs/pstore rw,nosuid,nodev,noexec,relatime shared:6 -
pstore pstore rw
26 23 0:23 / /sys/fs/cgroup/memory rw,nosuid,nodev,noexec,relatime
shared:12 - cgroup cgroup rw,memory
27 23 0:24 / /sys/fs/cgroup/cpu,cpuacct
rw,nosuid,nodev,noexec,relatime shared:13 - cgroup cgroup
rw,cpu,cpuacct
28 23 0:25 / /sys/fs/cgroup/blkio rw,nosuid,nodev,noexec,relatime
shared:14 - cgroup cgroup rw,blkio
29 23 0:26 / /sys/fs/cgroup/freezer rw,nosuid,nodev,noexec,relatime
shared:15 - cgroup cgroup rw,freezer
30 23 0:27 / /sys/fs/cgroup/devices rw,nosuid,nodev,noexec,relatime
shared:16 - cgroup cgroup rw,devices
31 23 0:28 / /sys/fs/cgroup/cpuset rw,nosuid,nodev,noexec,relatime
shared:17 - cgroup cgroup rw,cpuset
32 23 0:29 / /sys/fs/cgroup/net_cls rw,nosuid,nodev,noexec,relatime
shared:18 - cgroup cgroup rw,net_cls
51 16 0:30 / /sys/kernel/config rw,relatime shared:19 - configfs config=
fs rw
53 22 8:33 / /run/initramfs/live ro,relatime shared:20 - iso9660 /dev/s=
dc1 ro
+ cat /proc/mounts
rootfs / rootfs rw 0 0
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
devtmpfs /dev devtmpfs rw,nosuid,size=3D6054656k,nr_inodes=3D1513664,mo=
de=3D755 0 0
securityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relat=
ime 0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=3D5,mode=3D620,ptm=
xmode=3D000 0 0
tmpfs /run tmpfs rw,nosuid,nodev,mode=3D755 0 0
tmpfs /sys/fs/cgroup tmpfs ro,nosuid,nodev,noexec,mode=3D755 0 0
cgroup /sys/fs/cgroup/systemd cgroup
rw,nosuid,nodev,noexec,relatime,xattr,release_agent=3D/usr/lib/systemd/=
systemd-cgroups-agent,name=3Dsystemd
0 0
pstore /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0
cgroup /sys/fs/cgroup/memory cgroup rw,nosuid,nodev,noexec,relatime,mem=
ory 0 0
cgroup /sys/fs/cgroup/cpu,cpuacct cgroup
rw,nosuid,nodev,noexec,relatime,cpu,cpuacct 0 0
cgroup /sys/fs/cgroup/blkio cgroup rw,nosuid,nodev,noexec,relatime,blki=
o 0 0
cgroup /sys/fs/cgroup/freezer cgroup rw,nosuid,nodev,noexec,relatime,fr=
eezer 0 0
cgroup /sys/fs/cgroup/devices cgroup rw,nosuid,nodev,noexec,relatime,de=
vices 0 0
cgroup /sys/fs/cgroup/cpuset cgroup rw,nosuid,nodev,noexec,relatime,cpu=
set 0 0
cgroup /sys/fs/cgroup/net_cls cgroup rw,nosuid,nodev,noexec,relatime,ne=
t_cls 0 0
configfs /sys/kernel/config configfs rw,relatime 0 0
/dev/sdc1 /run/initramfs/live iso9660 ro,relatime 0 0
+ blkid
/dev/disk/by-label/GNURAMALINUX_201507: UUID=3D"2015-07-12-10-41-00-00"
LABEL=3D"GNURAMALINUX_201507" TYPE=3D"iso9660" PTUUID=3D"1424678c"
PTTYPE=3D"dos" PARTUUID=3D"1424678c-01"
/dev/loop0: TYPE=3D"squashfs"
/dev/loop1: UUID=3D"b2cfc819-72e1-495b-b4db-a2aef8cea24e" TYPE=3D"ext4"
/dev/loop2: TYPE=3D"DM_snapshot_cow"
/dev/sdb1: UUID=3D"EE34422B3441F6DD" TYPE=3D"ntfs" PARTUUID=3D"000889ab=
-01"
/dev/sdb2: LABEL=3D"New Volume" UUID=3D"74E04D4AE04D13B0" TYPE=3D"ntfs"
PARTUUID=3D"000889ab-02"
/dev/sda1: UUID=3D"5967fd78-c429-47e1-b5d7-e5e4989e47ee" TYPE=3D"ext4"
PARTUUID=3D"b9e7996d-01"
/dev/sda3: UUID=3D"5f2fa8af-6b53-4dc7-a7e5-cfef660880a7" TYPE=3D"ext4"
PARTUUID=3D"b9e7996d-03"
/dev/sda4: UUID=3D"e1a222dd-eae5-4788-8b0f-3b515e5e2c7c" TYPE=3D"ext4"
PARTUUID=3D"b9e7996d-04"
/dev/sdc2: SEC_TYPE=3D"msdos" LABEL=3D"LIVEISO_EFI" UUID=3D"43C5-927A"
TYPE=3D"vfat" PARTUUID=3D"1424678c-02"
/dev/mapper/live-rw: UUID=3D"b2cfc819-72e1-495b-b4db-a2aef8cea24e" TYPE=
=3D"ext4"
/dev/mapper/live-base: UUID=3D"b2cfc819-72e1-495b-b4db-a2aef8cea24e" TY=
PE=3D"ext4"
+ blkid -o udev
ID_FS_TYPE=3Dsquashfs

ID_FS_UUID=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_UUID_ENC=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_TYPE=3Dext4

ID_FS_TYPE=3DDM_snapshot_cow

ID_FS_UUID=3DEE34422B3441F6DD
ID_FS_UUID_ENC=3DEE34422B3441F6DD
ID_FS_TYPE=3Dntfs
ID_FS_PARTUUID=3D000889ab-01

ID_FS_LABEL=3DNew_Volume
ID_FS_LABEL_ENC=3DNew\x20Volume
ID_FS_UUID=3D74E04D4AE04D13B0
ID_FS_UUID_ENC=3D74E04D4AE04D13B0
ID_FS_TYPE=3Dntfs
ID_FS_PARTUUID=3D000889ab-02

ID_FS_UUID=3D5967fd78-c429-47e1-b5d7-e5e4989e47ee
ID_FS_UUID_ENC=3D5967fd78-c429-47e1-b5d7-e5e4989e47ee
ID_FS_TYPE=3Dext4
ID_FS_PARTUUID=3Db9e7996d-01

ID_FS_UUID=3D5f2fa8af-6b53-4dc7-a7e5-cfef660880a7
ID_FS_UUID_ENC=3D5f2fa8af-6b53-4dc7-a7e5-cfef660880a7
ID_FS_TYPE=3Dext4
ID_FS_PARTUUID=3Db9e7996d-03

ID_FS_UUID=3De1a222dd-eae5-4788-8b0f-3b515e5e2c7c
ID_FS_UUID_ENC=3De1a222dd-eae5-4788-8b0f-3b515e5e2c7c
ID_FS_TYPE=3Dext4
ID_FS_PARTUUID=3Db9e7996d-04

ID_FS_SEC_TYPE=3Dmsdos
ID_FS_LABEL=3DLIVEISO_EFI
ID_FS_LABEL_ENC=3DLIVEISO_EFI
ID_FS_UUID=3D43C5-927A
ID_FS_UUID_ENC=3D43C5-927A
ID_FS_TYPE=3Dvfat
ID_FS_PARTUUID=3D1424678c-02

ID_FS_UUID=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_UUID_ENC=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_TYPE=3Dext4

ID_FS_UUID=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_UUID_ENC=3Db2cfc819-72e1-495b-b4db-a2aef8cea24e
ID_FS_TYPE=3Dext4

ID_FS_UUID=3D2015-07-12-10-41-00-00
ID_FS_UUID_ENC=3D2015-07-12-10-41-00-00
ID_FS_LABEL=3DGNURAMALINUX_201507
ID_FS_LABEL_ENC=3DGNURAMALINUX_201507
ID_FS_TYPE=3Diso9660
ID_PART_TABLE_UUID=3D1424678c
ID_PART_TABLE_TYPE=3Ddos
ID_FS_PARTUUID=3D1424678c-01
+ ls -l /dev/disk/by-id /dev/disk/by-label /dev/disk/by-path /dev/disk/=
by-uuid
/dev/disk/by-id:
total 0
lrwxrwxrwx 1 root 0  9 Jul 12 10:52
ata-KINGSTON_SV300S37A120G_50026B723402EFF5 -> ../../sda
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
ata-KINGSTON_SV300S37A120G_50026B723402EFF5-part1 -> ../../sda1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
ata-KINGSTON_SV300S37A120G_50026B723402EFF5-part3 -> ../../sda3
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
ata-KINGSTON_SV300S37A120G_50026B723402EFF5-part4 -> ../../sda4
lrwxrwxrwx 1 root 0  9 Jul 12 10:52 ata-SAMSUNG_HD753LJ_S13UJ1DQ307952
-> ../../sdb
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
ata-SAMSUNG_HD753LJ_S13UJ1DQ307952-part1 -> ../../sdb1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
ata-SAMSUNG_HD753LJ_S13UJ1DQ307952-part2 -> ../../sdb2
lrwxrwxrwx 1 root 0  9 Jul 12 10:52
usb-_USB_Flash_Memory_001D92A85D0AB940D34F014C-0:0 -> ../../sdc
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
usb-_USB_Flash_Memory_001D92A85D0AB940D34F014C-0:0-part1 -> ../../sdc1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
usb-_USB_Flash_Memory_001D92A85D0AB940D34F014C-0:0-part2 -> ../../sdc2
lrwxrwxrwx 1 root 0  9 Jul 12 10:52 wwn-0x972509030f005000 -> ../../sdb
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 wwn-0x972509030f005000-part1 -> ../=
=2E./sdb1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 wwn-0x972509030f005000-part2 -> ../=
=2E./sdb2
lrwxrwxrwx 1 root 0  9 Jul 12 10:52 wwn-0xeff534026b725002 -> ../../sda
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 wwn-0xeff534026b725002-part1 -> ../=
=2E./sda1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 wwn-0xeff534026b725002-part3 -> ../=
=2E./sda3
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 wwn-0xeff534026b725002-part4 -> ../=
=2E./sda4

/dev/disk/by-label:
total 0
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 GNURAMALINUX_201507 -> ../../sdc1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 LIVEISO_EFI -> ../../sdc2
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 New\x20Volume -> ../../sdb2

/dev/disk/by-path:
total 0
lrwxrwxrwx 1 root 0  9 Jul 12 10:52
pci-0000:00:16.2-usb-0:3:1.0-scsi-0:0:0:0 -> ../../sdc
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
pci-0000:00:16.2-usb-0:3:1.0-scsi-0:0:0:0-part1 -> ../../sdc1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
pci-0000:00:16.2-usb-0:3:1.0-scsi-0:0:0:0-part2 -> ../../sdc2

/dev/disk/by-uuid:
total 0
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 2015-07-12-10-41-00-00 -> ../../sdc=
1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 43C5-927A -> ../../sdc2
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
5967fd78-c429-47e1-b5d7-e5e4989e47ee -> ../../sda1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
5f2fa8af-6b53-4dc7-a7e5-cfef660880a7 -> ../../sda3
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 74E04D4AE04D13B0 -> ../../sdb2
lrwxrwxrwx 1 root 0 10 Jul 12 10:52 EE34422B3441F6DD -> ../../sdb1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
b2cfc819-72e1-495b-b4db-a2aef8cea24e -> ../../dm-1
lrwxrwxrwx 1 root 0 10 Jul 12 10:52
e1a222dd-eae5-4788-8b0f-3b515e5e2c7c -> ../../sda4
+ for _i in '/etc/conf.d/*.conf'
+ '[' -f /etc/conf.d/systemd.conf ']'
+ echo /etc/conf.d/systemd.conf
/etc/conf.d/systemd.conf
+ cat /etc/conf.d/systemd.conf
systemdutildir=3D"/usr/lib/systemd"
systemdsystemunitdir=3D"/usr/lib/systemd/system"
systemdsystemconfdir=3D"/etc/systemd/system"
+ command -v lvm
+ command -v dmsetup
+ dmsetup ls --tree
live-base (254:1)
 `- (7:1)
live-rw (254:0)
 |- (7:2)
 `- (7:1)
+ cat /proc/mdstat
cat: /proc/mdstat: No such file or directory
+ command -v ip
+ command -v journalctl
+ journalctl -ab --no-pager -o short-monotonic
-- Logs begin at Sun 2015-07-12 10:52:28 UTC, end at Sun 2015-07-12
10:53:58 UTC. --
[    0.881109] localhost systemd-journal[136]: Runtime journal is
using 8.0M (max allowed 595.9M, trying to leave 893.9M free of 5.8G
available =E2=86=92 current limit 595.9M).
[    0.881284] localhost systemd-journal[136]: Runtime journal is
using 8.0M (max allowed 595.9M, trying to leave 893.9M free of 5.8G
available =E2=86=92 current limit 595.9M).
[    0.000000] localhost kernel: Initializing cgroup subsys cpuset
[    0.000000] localhost kernel: Initializing cgroup subsys cpu
[    0.000000] localhost kernel: Initializing cgroup subsys cpuacct
[    0.000000] localhost kernel: Linux version 4.1.2 (root@gnurama)
(gcc version 5.1.0 (GCC) ) #1 SMP PREEMPT Fri Jul 10 20:55:30 CEST
2015
[    0.000000] localhost kernel: Command line: BOOT_IMAGE=3Dboot/vmlinu=
z
rd.live.image rd.live.overlay.size=3D1024 root=3DLABEL=3DGNURAMALINUX_2=
01507
initrd=3Dboot/initramfs
[    0.000000] localhost kernel: tseg: 00bd800000
[    0.000000] localhost kernel: e820: BIOS-provided physical RAM map:
[    0.000000] localhost kernel: BIOS-e820: [mem
0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] localhost kernel: BIOS-e820: [mem
0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x0000000000100000-0x00000000ba630fff] usable
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000ba631000-0x00000000baa64fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000baa65000-0x00000000baa74fff] ACPI data
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000baa75000-0x00000000bb87bfff] ACPI NVS
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bb87c000-0x00000000bca33fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bca34000-0x00000000bca34fff] usable
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bca35000-0x00000000bcc3afff] ACPI NVS
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bcc3b000-0x00000000bd082fff] usable
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bd083000-0x00000000bd7f3fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000bd7f4000-0x00000000bd7fffff] usable
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] localhost kernel: BIOS-e820: [mem
0x0000000100001000-0x000000033effffff] usable
[    0.000000] localhost kernel: NX (Execute Disable) protection: activ=
e
[    0.000000] localhost kernel: SMBIOS 2.7 present.
[    0.000000] localhost kernel: DMI: To be filled by O.E.M. To be
filled by O.E.M./SABERTOOTH 990FX R2.0, BIOS 2301 01/06/2014
[    0.000000] localhost kernel: e820: update [mem
0x00000000-0x00000fff] usable =3D=3D> reserved
[    0.000000] localhost kernel: e820: remove [mem 0x000a0000-0x000ffff=
f] usable
[    0.000000] localhost kernel: AGP: No AGP bridge found
[    0.000000] localhost kernel: e820: last_pfn =3D 0x33f000
max_arch_pfn =3D 0x400000000
[    0.000000] localhost kernel: MTRR default type: uncachable
[    0.000000] localhost kernel: MTRR fixed ranges enabled:
[    0.000000] localhost kernel:   00000-9FFFF write-back
[    0.000000] localhost kernel:   A0000-BFFFF write-through
[    0.000000] localhost kernel:   C0000-CFFFF write-protect
[    0.000000] localhost kernel:   D0000-EBFFF uncachable
[    0.000000] localhost kernel:   EC000-FFFFF write-protect
[    0.000000] localhost kernel: MTRR variable ranges enabled:
[    0.000000] localhost kernel:   0 base 000000000000 mask
=46FFF80000000 write-back
[    0.000000] localhost kernel:   1 base 000080000000 mask
=46FFFC0000000 write-back
[    0.000000] localhost kernel:   2 base 0000BD800000 mask
=46FFFFF800000 uncachable
[    0.000000] localhost kernel:   3 base 0000BE000000 mask
=46FFFFE000000 uncachable
[    0.000000] localhost kernel:   4 disabled
[    0.000000] localhost kernel:   5 disabled
[    0.000000] localhost kernel:   6 disabled
[    0.000000] localhost kernel:   7 disabled
[    0.000000] localhost kernel: TOM2: 000000033f000000 aka 13296M
[    0.000000] localhost kernel: PAT configuration [0-7]: WB  WC  UC-
UC  WB  WC  UC- UC
[    0.000000] localhost kernel: e820: update [mem
0xbd800000-0xffffffff] usable =3D=3D> reserved
[    0.000000] localhost kernel: e820: last_pfn =3D 0xbd800 max_arch_pf=
n
=3D 0x400000000
[    0.000000] localhost kernel: Scanning 1 areas for low memory corrup=
tion
[    0.000000] localhost kernel: Base memory trampoline at
[ffff880000098000] 98000 size 24576
[    0.000000] localhost kernel: Using GB pages for direct mapping
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x00000000-0x000fffff]
[    0.000000] localhost kernel:  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] localhost kernel: BRK [0x01b2f000, 0x01b2ffff] PGTABLE
[    0.000000] localhost kernel: BRK [0x01b30000, 0x01b30fff] PGTABLE
[    0.000000] localhost kernel: BRK [0x01b31000, 0x01b31fff] PGTABLE
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x33ee00000-0x33effffff]
[    0.000000] localhost kernel:  [mem 0x33ee00000-0x33effffff] page 2M
[    0.000000] localhost kernel: BRK [0x01b32000, 0x01b32fff] PGTABLE
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x320000000-0x33edfffff]
[    0.000000] localhost kernel:  [mem 0x320000000-0x33edfffff] page 2M
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x300000000-0x31fffffff]
[    0.000000] localhost kernel:  [mem 0x300000000-0x31fffffff] page 2M
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x00100000-0xba630fff]
[    0.000000] localhost kernel:  [mem 0x00100000-0x001fffff] page 4k
[    0.000000] localhost kernel:  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000] localhost kernel:  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000] localhost kernel:  [mem 0x80000000-0xba5fffff] page 2M
[    0.000000] localhost kernel:  [mem 0xba600000-0xba630fff] page 4k
[    0.000000] localhost kernel: init_memory_mapping: [mem
0xbca34000-0xbca34fff]
[    0.000000] localhost kernel:  [mem 0xbca34000-0xbca34fff] page 4k
[    0.000000] localhost kernel: BRK [0x01b33000, 0x01b33fff] PGTABLE
[    0.000000] localhost kernel: init_memory_mapping: [mem
0xbcc3b000-0xbd082fff]
[    0.000000] localhost kernel:  [mem 0xbcc3b000-0xbcdfffff] page 4k
[    0.000000] localhost kernel:  [mem 0xbce00000-0xbcffffff] page 2M
[    0.000000] localhost kernel:  [mem 0xbd000000-0xbd082fff] page 4k
[    0.000000] localhost kernel: BRK [0x01b34000, 0x01b34fff] PGTABLE
[    0.000000] localhost kernel: init_memory_mapping: [mem
0xbd7f4000-0xbd7fffff]
[    0.000000] localhost kernel:  [mem 0xbd7f4000-0xbd7fffff] page 4k
[    0.000000] localhost kernel: init_memory_mapping: [mem
0x100001000-0x2ffffffff]
[    0.000000] localhost kernel:  [mem 0x100001000-0x1001fffff] page 4k
[    0.000000] localhost kernel:  [mem 0x100200000-0x13fffffff] page 2M
[    0.000000] localhost kernel:  [mem 0x140000000-0x2ffffffff] page 1G
[    0.000000] localhost kernel: RAMDISK: [mem 0x7e476000-0x7fffffff]
[    0.000000] localhost kernel: ACPI: Early table checksum
verification disabled
[    0.000000] localhost kernel: ACPI: RSDP 0x00000000000F0490 000024
(v02 ALASKA)
[    0.000000] localhost kernel: ACPI: XSDT 0x00000000BAA6D070 00005C
(v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] localhost kernel: ACPI: FACP 0x00000000BAA74110 00010C
(v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] localhost kernel: ACPI BIOS Warning (bug): Optional
=46ADT field Pm2ControlBlock has zero address or length:
0x0000000000000000/0x1 (20150410/tbfadt-649)
[    0.000000] localhost kernel: ACPI: DSDT 0x00000000BAA6D168 006FA8
(v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] localhost kernel: ACPI: FACS 0x00000000BB876F80 000040
[    0.000000] localhost kernel: ACPI: APIC 0x00000000BAA74220 00009E
(v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] localhost kernel: ACPI: FPDT 0x00000000BAA742C0 000044
(v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] localhost kernel: ACPI: MCFG 0x00000000BAA74308 00003C
(v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] localhost kernel: ACPI: HPET 0x00000000BAA74348 000038
(v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] localhost kernel: ACPI: SSDT 0x00000000BAA74410 000304
(v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] localhost kernel: ACPI: BGRT 0x00000000BAA743D8 000038
(v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] localhost kernel: ACPI: Local APIC address 0xfee00000
[    0.000000] localhost kernel: No NUMA configuration found
[    0.000000] localhost kernel: Faking a node at [mem
0x0000000000000000-0x000000033effffff]
[    0.000000] localhost kernel: NODE_DATA(0) allocated [mem
0x33eff6000-0x33eff9fff]
[    0.000000] localhost kernel:  [ffffea0000000000-ffffea000cffffff]
PMD -> [ffff880332600000-ffff88033e5fffff] on node 0
[    0.000000] localhost kernel: Zone ranges:
[    0.000000] localhost kernel:   DMA      [mem
0x0000000000001000-0x0000000000ffffff]
[    0.000000] localhost kernel:   DMA32    [mem
0x0000000001000000-0x00000000ffffffff]
[    0.000000] localhost kernel:   Normal   [mem
0x0000000100000000-0x000000033effffff]
[    0.000000] localhost kernel: Movable zone start for each node
[    0.000000] localhost kernel: Early memory node ranges
[    0.000000] localhost kernel:   node   0: [mem
0x0000000000001000-0x000000000009dfff]
[    0.000000] localhost kernel:   node   0: [mem
0x0000000000100000-0x00000000ba630fff]
[    0.000000] localhost kernel:   node   0: [mem
0x00000000bca34000-0x00000000bca34fff]
[    0.000000] localhost kernel:   node   0: [mem
0x00000000bcc3b000-0x00000000bd082fff]
[    0.000000] localhost kernel:   node   0: [mem
0x00000000bd7f4000-0x00000000bd7fffff]
[    0.000000] localhost kernel:   node   0: [mem
0x0000000100001000-0x000000033effffff]
[    0.000000] localhost kernel: Initmem setup node 0 [mem
0x0000000000001000-0x000000033effffff]
[    0.000000] localhost kernel: On node 0 totalpages: 3119650
[    0.000000] localhost kernel:   DMA zone: 64 pages used for memmap
[    0.000000] localhost kernel:   DMA zone: 21 pages reserved
[    0.000000] localhost kernel:   DMA zone: 3997 pages, LIFO batch:0
[    0.000000] localhost kernel:   DMA32 zone: 11883 pages used for mem=
map
[    0.000000] localhost kernel:   DMA32 zone: 760454 pages, LIFO batch=
:31
[    0.000000] localhost kernel:   Normal zone: 36800 pages used for me=
mmap
[    0.000000] localhost kernel:   Normal zone: 2355199 pages, LIFO bat=
ch:31
[    0.000000] localhost kernel: ACPI: PM-Timer IO Port: 0x808
[    0.000000] localhost kernel: ACPI: Local APIC address 0xfee00000
[    0.000000] localhost kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high
edge lint[0x1])
[    0.000000] localhost kernel: IOAPIC[0]: apic_id 9, version 33,
address 0xfec00000, GSI 0-23
[    0.000000] localhost kernel: IOAPIC[1]: apic_id 10, version 33,
address 0xfec20000, GSI 24-55
[    0.000000] localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
[    0.000000] localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
[    0.000000] localhost kernel: ACPI: IRQ0 used by override.
[    0.000000] localhost kernel: ACPI: IRQ9 used by override.
[    0.000000] localhost kernel: Using ACPI (MADT) for SMP
configuration information
[    0.000000] localhost kernel: ACPI: HPET id: 0x43538210 base: 0xfed0=
0000
[    0.000000] localhost kernel: smpboot: Allowing 8 CPUs, 0 hotplug CP=
Us
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x0009e000-0x0009efff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x0009f000-0x0009ffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x000a0000-0x000dffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x000e0000-0x000fffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xba631000-0xbaa64fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbaa65000-0xbaa74fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbaa75000-0xbb87bfff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbb87c000-0xbca33fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbca35000-0xbcc3afff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbd083000-0xbd7f3fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xbd800000-0xfebfffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec00000-0xfec00fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec01000-0xfec0ffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec10000-0xfec10fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec11000-0xfec1ffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec20000-0xfec20fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfec21000-0xfecfffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed01000-0xfed60fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed61000-0xfed70fff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed71000-0xfed7ffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed80000-0xfed8ffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfed90000-0xfeefffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xfef00000-0xffffffff]
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0x100000000-0x100000fff]
[    0.000000] localhost kernel: e820: [mem 0xbd800000-0xfebfffff]
available for PCI devices
[    0.000000] localhost kernel: Booting paravirtualized kernel on bare=
 hardware
[    0.000000] localhost kernel: clocksource refined-jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] localhost kernel: setup_percpu: NR_CPUS:128
nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] localhost kernel: PERCPU: Embedded 33 pages/cpu
@ffff88033ec00000 s95576 r8192 d31400 u262144
[    0.000000] localhost kernel: pcpu-alloc: s95576 r8192 d31400
u262144 alloc=3D1*2097152
[    0.000000] localhost kernel: pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] localhost kernel: Built 1 zonelists in Node order,
mobility grouping on.  Total pages: 3070882
[    0.000000] localhost kernel: Policy zone: Normal
[    0.000000] localhost kernel: Kernel command line:
BOOT_IMAGE=3Dboot/vmlinuz rd.live.image rd.live.overlay.size=3D1024
root=3DLABEL=3DGNURAMALINUX_201507 initrd=3Dboot/initramfs
[    0.000000] localhost kernel: PID hash table entries: 4096 (order:
3, 32768 bytes)
[    0.000000] localhost kernel: xsave: enabled xstate_bv 0x7, cntxt
size 0x340 using standard form
[    0.000000] localhost kernel: AGP: Checking aperture...
[    0.000000] localhost kernel: AGP: No AGP bridge found
[    0.000000] localhost kernel: AGP: Node 0: aperture [bus addr
0x00000000-0x01ffffff] (32MB)
[    0.000000] localhost kernel: AGP: Your BIOS doesn't leave a
aperture memory hole
[    0.000000] localhost kernel: AGP: Please enable the IOMMU option
in the BIOS setup
[    0.000000] localhost kernel: AGP: This costs you 64MB of RAM
[    0.000000] localhost kernel: AGP: Mapping aperture over RAM [mem
0xb0000000-0xb3ffffff] (65536KB)
[    0.000000] localhost kernel: PM: Registered nosave memory: [mem
0xb0000000-0xb3ffffff]
[    0.000000] localhost kernel: Memory: 12109296K/12478600K available
(5696K kernel code, 893K rwdata, 1728K rodata, 1180K init, 1152K bss,
369304K reserved, 0K cma-reserved)
[    0.000000] localhost kernel: SLUB: HWalign=3D64, Order=3D0-3,
MinObjects=3D0, CPUs=3D8, Nodes=3D1
[    0.000000] localhost kernel: Preemptible hierarchical RCU implement=
ation.
[    0.000000] localhost kernel:     RCU dyntick-idle grace-period
acceleration is enabled.
[    0.000000] localhost kernel:     RCU restricting CPUs from
NR_CPUS=3D128 to nr_cpu_ids=3D8.
[    0.000000] localhost kernel: RCU: Adjusting geometry for
rcu_fanout_leaf=3D16, nr_cpu_ids=3D8
[    0.000000] localhost kernel: NR_IRQS:8448 nr_irqs:1032 16
[    0.000000] localhost kernel: Console: colour VGA+ 80x25
[    0.000000] localhost kernel: console [tty0] enabled
[    0.000000] localhost kernel: clocksource hpet: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] localhost kernel: hpet clockevent registered
[    0.000000] localhost kernel: tsc: Fast TSC calibration using PIT
[    0.000000] localhost kernel: tsc: Detected 4013.495 MHz processor
[    0.000021] localhost kernel: Calibrating delay loop (skipped),
value calculated using timer frequency.. 8030.44 BogoMIPS
(lpj=3D13378316)
[    0.000023] localhost kernel: pid_max: default: 32768 minimum: 301
[    0.000028] localhost kernel: ACPI: Core revision 20150410
[    0.002808] localhost kernel: ACPI: All ACPI Tables successfully acq=
uired
[    0.271207] localhost kernel: Security Framework initialized
[    0.271215] localhost kernel: Yama: becoming mindful.
[    0.272187] localhost kernel: Dentry cache hash table entries:
2097152 (order: 12, 16777216 bytes)
[    0.276096] localhost kernel: Inode-cache hash table entries:
1048576 (order: 11, 8388608 bytes)
[    0.277848] localhost kernel: Mount-cache hash table entries: 32768
(order: 6, 262144 bytes)
[    0.277865] localhost kernel: Mountpoint-cache hash table entries:
32768 (order: 6, 262144 bytes)
[    0.278128] localhost kernel: Initializing cgroup subsys blkio
[    0.278130] localhost kernel: Initializing cgroup subsys memory
[    0.278137] localhost kernel: Initializing cgroup subsys devices
[    0.278139] localhost kernel: Initializing cgroup subsys freezer
[    0.278141] localhost kernel: Initializing cgroup subsys net_cls
[    0.278157] localhost kernel: CPU: Physical Processor ID: 0
[    0.278158] localhost kernel: CPU: Processor Core ID: 0
[    0.278160] localhost kernel: mce: CPU supports 7 MCE banks
[    0.278165] localhost kernel: LVT offset 1 assigned for vector 0xf9
[    0.278169] localhost kernel: Last level iTLB entries: 4KB 512, 2MB
1024, 4MB 512
[    0.278170] localhost kernel: Last level dTLB entries: 4KB 1024,
2MB 1024, 4MB 512, 1GB 0
[    0.278251] localhost kernel: Freeing SMP alternatives memory: 20K
(ffffffff81a08000 - ffffffff81a0d000)
[    0.278846] localhost kernel: ftrace: allocating 21545 entries in 85=
 pages
[    0.285145] localhost kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D=
2
apic2=3D-1 pin2=3D-1
[    0.422156] localhost kernel: smpboot: CPU0: AMD FX(tm)-8350
Eight-Core Processor (fam: 15, model: 02, stepping: 00)
[    0.422174] localhost kernel: Performance Events: Fam15h core
perfctr, AMD PMU driver.
[    0.422178] localhost kernel: ... version:                0
[    0.422179] localhost kernel: ... bit width:              48
[    0.422180] localhost kernel: ... generic registers:      6
[    0.422180] localhost kernel: ... value mask:             0000ffffff=
ffffff
[    0.422181] localhost kernel: ... max period:             00007fffff=
ffffff
[    0.422182] localhost kernel: ... fixed-purpose events:   0
[    0.422183] localhost kernel: ... event mask:             0000000000=
00003f
[    0.438870] localhost kernel: NMI watchdog: enabled on all CPUs,
permanently consumes one hw-PMU counter.
[    0.442199] localhost kernel: x86: Booting SMP configuration:
[    0.442201] localhost kernel: .... node  #0, CPUs:      #1 #2 #3 #4 =
#5 #6 #7
[    0.548583] localhost kernel: x86: Booted up 1 node, 8 CPUs
[    0.548587] localhost kernel: smpboot: Total of 8 processors
activated (64241.58 BogoMIPS)
[    0.558511] localhost kernel: devtmpfs: initialized
[    0.561816] localhost kernel: PM: Registering ACPI NVS region [mem
0xbaa75000-0xbb87bfff] (14708736 bytes)
[    0.562000] localhost kernel: PM: Registering ACPI NVS region [mem
0xbca35000-0xbcc3afff] (2121728 bytes)
[    0.562113] localhost kernel: clocksource jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.562207] localhost kernel: pinctrl core: initialized pinctrl subs=
ystem
[    0.562236] localhost kernel: RTC time: 10:52:28, date: 07/12/15
[    0.562337] localhost kernel: NET: Registered protocol family 16
[    0.575411] localhost kernel: cpuidle: using governor ladder
[    0.588736] localhost kernel: cpuidle: using governor menu
[    0.588786] localhost kernel: ACPI: bus type PCI registered
[    0.588788] localhost kernel: acpiphp: ACPI Hot Plug PCI Controller
Driver version: 0.5
[    0.588853] localhost kernel: PCI: MMCONFIG for domain 0000 [bus
00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.588855] localhost kernel: PCI: not using MMCONFIG
[    0.588856] localhost kernel: PCI: Using configuration type 1 for ba=
se access
[    0.588857] localhost kernel: PCI: Using configuration type 1 for
extended access
[    0.602426] localhost kernel: ACPI: Added _OSI(Module Device)
[    0.602427] localhost kernel: ACPI: Added _OSI(Processor Device)
[    0.602428] localhost kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.602429] localhost kernel: ACPI: Added _OSI(Processor Aggregator =
Device)
[    0.604137] localhost kernel: ACPI: Executed 2 blocks of
module-level executable AML code
[    0.606469] localhost kernel: ACPI : EC: EC started
[    0.606475] localhost kernel: ACPI: Interpreter enabled
[    0.606480] localhost kernel: ACPI Exception: AE_NOT_FOUND, While
evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.606483] localhost kernel: ACPI Exception: AE_NOT_FOUND, While
evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.606497] localhost kernel: ACPI: (supports S0 S3 S4 S5)
[    0.606498] localhost kernel: ACPI: Using IOAPIC for interrupt routi=
ng
[    0.606628] localhost kernel: PCI: MMCONFIG for domain 0000 [bus
00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.606664] localhost kernel: PCI: MMCONFIG at [mem
0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.606978] localhost kernel: PCI: Using host bridge windows from
ACPI; if necessary, use "pci=3Dnocrs" and report a bug
[    0.613069] localhost kernel: ACPI: PCI Root Bridge [PCI0] (domain
0000 [bus 00-ff])
[    0.613074] localhost kernel: acpi PNP0A03:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI]
[    0.613078] localhost kernel: acpi PNP0A03:00: _OSC failed
(AE_NOT_FOUND); disabling ASPM
[    0.613432] localhost kernel: PCI host bridge to bus 0000:00
[    0.613435] localhost kernel: pci_bus 0000:00: root bus resource [bu=
s 00-ff]
[    0.613437] localhost kernel: pci_bus 0000:00: root bus resource
[io  0x0000-0x03af window]
[    0.613438] localhost kernel: pci_bus 0000:00: root bus resource
[io  0x03e0-0x0cf7 window]
[    0.613440] localhost kernel: pci_bus 0000:00: root bus resource
[io  0x03b0-0x03df window]
[    0.613441] localhost kernel: pci_bus 0000:00: root bus resource
[io  0x0d00-0xffff window]
[    0.613443] localhost kernel: pci_bus 0000:00: root bus resource
[mem 0x000a0000-0x000bffff window]
[    0.613444] localhost kernel: pci_bus 0000:00: root bus resource
[mem 0x000c0000-0x000dffff window]
[    0.613446] localhost kernel: pci_bus 0000:00: root bus resource
[mem 0xc0000000-0xffffffff window]
[    0.613456] localhost kernel: pci 0000:00:00.0: [1002:5a14] type 00
class 0x060000
[    0.613589] localhost kernel: pci 0000:00:02.0: [1002:5a16] type 01
class 0x060400
[    0.613631] localhost kernel: pci 0000:00:02.0: PME# supported from
D0 D3hot D3cold
[    0.613680] localhost kernel: pci 0000:00:02.0: System wakeup
disabled by ACPI
[    0.613718] localhost kernel: pci 0000:00:04.0: [1002:5a18] type 01
class 0x060400
[    0.613758] localhost kernel: pci 0000:00:04.0: PME# supported from
D0 D3hot D3cold
[    0.613806] localhost kernel: pci 0000:00:04.0: System wakeup
disabled by ACPI
[    0.613843] localhost kernel: pci 0000:00:05.0: [1002:5a19] type 01
class 0x060400
[    0.613883] localhost kernel: pci 0000:00:05.0: PME# supported from
D0 D3hot D3cold
[    0.613930] localhost kernel: pci 0000:00:05.0: System wakeup
disabled by ACPI
[    0.613971] localhost kernel: pci 0000:00:09.0: [1002:5a1c] type 01
class 0x060400
[    0.614011] localhost kernel: pci 0000:00:09.0: PME# supported from
D0 D3hot D3cold
[    0.614058] localhost kernel: pci 0000:00:09.0: System wakeup
disabled by ACPI
[    0.614095] localhost kernel: pci 0000:00:0a.0: [1002:5a1d] type 01
class 0x060400
[    0.614135] localhost kernel: pci 0000:00:0a.0: PME# supported from
D0 D3hot D3cold
[    0.614182] localhost kernel: pci 0000:00:0a.0: System wakeup
disabled by ACPI
[    0.614219] localhost kernel: pci 0000:00:0b.0: [1002:5a1f] type 01
class 0x060400
[    0.614260] localhost kernel: pci 0000:00:0b.0: PME# supported from
D0 D3hot D3cold
[    0.614307] localhost kernel: pci 0000:00:0b.0: System wakeup
disabled by ACPI
[    0.614346] localhost kernel: pci 0000:00:0d.0: [1002:5a1e] type 01
class 0x060400
[    0.614386] localhost kernel: pci 0000:00:0d.0: PME# supported from
D0 D3hot D3cold
[    0.614433] localhost kernel: pci 0000:00:0d.0: System wakeup
disabled by ACPI
[    0.614475] localhost kernel: pci 0000:00:11.0: [1002:4391] type 00
class 0x010601
[    0.614491] localhost kernel: pci 0000:00:11.0: reg 0x10: [io  0xf04=
0-0xf047]
[    0.614500] localhost kernel: pci 0000:00:11.0: reg 0x14: [io  0xf03=
0-0xf033]
[    0.614509] localhost kernel: pci 0000:00:11.0: reg 0x18: [io  0xf02=
0-0xf027]
[    0.614517] localhost kernel: pci 0000:00:11.0: reg 0x1c: [io  0xf01=
0-0xf013]
[    0.614525] localhost kernel: pci 0000:00:11.0: reg 0x20: [io  0xf00=
0-0xf00f]
[    0.614534] localhost kernel: pci 0000:00:11.0: reg 0x24: [mem
0xfeb0b000-0xfeb0b3ff]
[    0.614641] localhost kernel: pci 0000:00:12.0: [1002:4397] type 00
class 0x0c0310
[    0.614654] localhost kernel: pci 0000:00:12.0: reg 0x10: [mem
0xfeb0a000-0xfeb0afff]
[    0.614749] localhost kernel: pci 0000:00:12.0: System wakeup
disabled by ACPI
[    0.614790] localhost kernel: pci 0000:00:12.2: [1002:4396] type 00
class 0x0c0320
[    0.614804] localhost kernel: pci 0000:00:12.2: reg 0x10: [mem
0xfeb09000-0xfeb090ff]
[    0.614873] localhost kernel: pci 0000:00:12.2: supports D1 D2
[    0.614874] localhost kernel: pci 0000:00:12.2: PME# supported from
D0 D1 D2 D3hot
[    0.614922] localhost kernel: pci 0000:00:12.2: System wakeup
disabled by ACPI
[    0.614964] localhost kernel: pci 0000:00:13.0: [1002:4397] type 00
class 0x0c0310
[    0.614976] localhost kernel: pci 0000:00:13.0: reg 0x10: [mem
0xfeb08000-0xfeb08fff]
[    0.615069] localhost kernel: pci 0000:00:13.0: System wakeup
disabled by ACPI
[    0.615109] localhost kernel: pci 0000:00:13.2: [1002:4396] type 00
class 0x0c0320
[    0.615124] localhost kernel: pci 0000:00:13.2: reg 0x10: [mem
0xfeb07000-0xfeb070ff]
[    0.615192] localhost kernel: pci 0000:00:13.2: supports D1 D2
[    0.615193] localhost kernel: pci 0000:00:13.2: PME# supported from
D0 D1 D2 D3hot
[    0.615241] localhost kernel: pci 0000:00:13.2: System wakeup
disabled by ACPI
[    0.615282] localhost kernel: pci 0000:00:14.0: [1002:4385] type 00
class 0x0c0500
[    0.615418] localhost kernel: pci 0000:00:14.2: [1002:4383] type 00
class 0x040300
[    0.615436] localhost kernel: pci 0000:00:14.2: reg 0x10: [mem
0xfeb00000-0xfeb03fff 64bit]
[    0.615493] localhost kernel: pci 0000:00:14.2: PME# supported from
D0 D3hot D3cold
[    0.615540] localhost kernel: pci 0000:00:14.2: System wakeup
disabled by ACPI
[    0.615577] localhost kernel: pci 0000:00:14.3: [1002:439d] type 00
class 0x060100
[    0.615708] localhost kernel: pci 0000:00:14.4: [1002:4384] type 01
class 0x060401
[    0.615782] localhost kernel: pci 0000:00:14.4: System wakeup
disabled by ACPI
[    0.615817] localhost kernel: pci 0000:00:14.5: [1002:4399] type 00
class 0x0c0310
[    0.615856] localhost kernel: pci 0000:00:14.5: reg 0x10: [mem
0xfeb06000-0xfeb06fff]
[    0.615950] localhost kernel: pci 0000:00:14.5: System wakeup
disabled by ACPI
[    0.615992] localhost kernel: pci 0000:00:15.0: [1002:43a0] type 01
class 0x060400
[    0.616051] localhost kernel: pci 0000:00:15.0: supports D1 D2
[    0.616099] localhost kernel: pci 0000:00:15.0: System wakeup
disabled by ACPI
[    0.616138] localhost kernel: pci 0000:00:15.1: [1002:43a1] type 01
class 0x060400
[    0.616196] localhost kernel: pci 0000:00:15.1: supports D1 D2
[    0.616245] localhost kernel: pci 0000:00:15.1: System wakeup
disabled by ACPI
[    0.616284] localhost kernel: pci 0000:00:15.2: [1002:43a2] type 01
class 0x060400
[    0.616343] localhost kernel: pci 0000:00:15.2: supports D1 D2
[    0.616391] localhost kernel: pci 0000:00:15.2: System wakeup
disabled by ACPI
[    0.616431] localhost kernel: pci 0000:00:15.3: [1002:43a3] type 01
class 0x060400
[    0.616490] localhost kernel: pci 0000:00:15.3: supports D1 D2
[    0.616538] localhost kernel: pci 0000:00:15.3: System wakeup
disabled by ACPI
[    0.616578] localhost kernel: pci 0000:00:16.0: [1002:4397] type 00
class 0x0c0310
[    0.616590] localhost kernel: pci 0000:00:16.0: reg 0x10: [mem
0xfeb05000-0xfeb05fff]
[    0.616685] localhost kernel: pci 0000:00:16.0: System wakeup
disabled by ACPI
[    0.616725] localhost kernel: pci 0000:00:16.2: [1002:4396] type 00
class 0x0c0320
[    0.616740] localhost kernel: pci 0000:00:16.2: reg 0x10: [mem
0xfeb04000-0xfeb040ff]
[    0.616808] localhost kernel: pci 0000:00:16.2: supports D1 D2
[    0.616809] localhost kernel: pci 0000:00:16.2: PME# supported from
D0 D1 D2 D3hot
[    0.616860] localhost kernel: pci 0000:00:16.2: System wakeup
disabled by ACPI
[    0.616902] localhost kernel: pci 0000:00:18.0: [1022:1600] type 00
class 0x060000
[    0.616989] localhost kernel: pci 0000:00:18.1: [1022:1601] type 00
class 0x060000
[    0.617071] localhost kernel: pci 0000:00:18.2: [1022:1602] type 00
class 0x060000
[    0.617153] localhost kernel: pci 0000:00:18.3: [1022:1603] type 00
class 0x060000
[    0.617239] localhost kernel: pci 0000:00:18.4: [1022:1604] type 00
class 0x060000
[    0.617321] localhost kernel: pci 0000:00:18.5: [1022:1605] type 00
class 0x060000
[    0.617612] localhost kernel: pci 0000:00:02.0: PCI bridge to [bus 0=
1]
[    0.617816] localhost kernel: pci 0000:02:00.0: [1b21:0612] type 00
class 0x010601
[    0.617830] localhost kernel: pci 0000:02:00.0: reg 0x10: [io  0xe05=
0-0xe057]
[    0.617839] localhost kernel: pci 0000:02:00.0: reg 0x14: [io  0xe04=
0-0xe043]
[    0.617848] localhost kernel: pci 0000:02:00.0: reg 0x18: [io  0xe03=
0-0xe037]
[    0.617856] localhost kernel: pci 0000:02:00.0: reg 0x1c: [io  0xe02=
0-0xe023]
[    0.617865] localhost kernel: pci 0000:02:00.0: reg 0x20: [io  0xe00=
0-0xe01f]
[    0.617873] localhost kernel: pci 0000:02:00.0: reg 0x24: [mem
0xfea00000-0xfea001ff]
[    0.622060] localhost kernel: pci 0000:00:04.0: PCI bridge to [bus 0=
2]
[    0.622064] localhost kernel: pci 0000:00:04.0:   bridge window [io
 0xe000-0xefff]
[    0.622066] localhost kernel: pci 0000:00:04.0:   bridge window
[mem 0xfea00000-0xfeafffff]
[    0.622117] localhost kernel: pci 0000:03:00.0: [1b21:0612] type 00
class 0x010601
[    0.622131] localhost kernel: pci 0000:03:00.0: reg 0x10: [io  0xd05=
0-0xd057]
[    0.622140] localhost kernel: pci 0000:03:00.0: reg 0x14: [io  0xd04=
0-0xd043]
[    0.622149] localhost kernel: pci 0000:03:00.0: reg 0x18: [io  0xd03=
0-0xd037]
[    0.622157] localhost kernel: pci 0000:03:00.0: reg 0x1c: [io  0xd02=
0-0xd023]
[    0.622165] localhost kernel: pci 0000:03:00.0: reg 0x20: [io  0xd00=
0-0xd01f]
[    0.622174] localhost kernel: pci 0000:03:00.0: reg 0x24: [mem
0xfe900000-0xfe9001ff]
[    0.628720] localhost kernel: pci 0000:00:05.0: PCI bridge to [bus 0=
3]
[    0.628724] localhost kernel: pci 0000:00:05.0:   bridge window [io
 0xd000-0xdfff]
[    0.628727] localhost kernel: pci 0000:00:05.0:   bridge window
[mem 0xfe900000-0xfe9fffff]
[    0.628782] localhost kernel: pci 0000:04:00.0: [1b21:1042] type 00
class 0x0c0330
[    0.628804] localhost kernel: pci 0000:04:00.0: reg 0x10: [mem
0xfe800000-0xfe807fff 64bit]
[    0.628900] localhost kernel: pci 0000:04:00.0: PME# supported from
D3hot D3cold
[    0.635384] localhost kernel: pci 0000:00:09.0: PCI bridge to [bus 0=
4]
[    0.635389] localhost kernel: pci 0000:00:09.0:   bridge window
[mem 0xfe800000-0xfe8fffff]
[    0.635585] localhost kernel: pci 0000:00:0a.0: PCI bridge to [bus 0=
5]
[    0.635774] localhost kernel: pci 0000:00:0b.0: PCI bridge to [bus 0=
6]
[    0.635972] localhost kernel: pci 0000:07:00.0: [1002:683f] type 00
class 0x030000
[    0.635987] localhost kernel: pci 0000:07:00.0: reg 0x10: [mem
0xc0000000-0xcfffffff 64bit pref]
[    0.635997] localhost kernel: pci 0000:07:00.0: reg 0x18: [mem
0xfe700000-0xfe73ffff 64bit]
[    0.636004] localhost kernel: pci 0000:07:00.0: reg 0x20: [io  0xc00=
0-0xc0ff]
[    0.636016] localhost kernel: pci 0000:07:00.0: reg 0x30: [mem
0xfe740000-0xfe75ffff pref]
[    0.636052] localhost kernel: pci 0000:07:00.0: supports D1 D2
[    0.636053] localhost kernel: pci 0000:07:00.0: PME# supported from
D1 D2 D3hot
[    0.636108] localhost kernel: pci 0000:07:00.1: [1002:aab0] type 00
class 0x040300
[    0.636122] localhost kernel: pci 0000:07:00.1: reg 0x10: [mem
0xfe760000-0xfe763fff 64bit]
[    0.636181] localhost kernel: pci 0000:07:00.1: supports D1 D2
[    0.642046] localhost kernel: pci 0000:00:0d.0: PCI bridge to [bus 0=
7]
[    0.642051] localhost kernel: pci 0000:00:0d.0:   bridge window [io
 0xc000-0xcfff]
[    0.642053] localhost kernel: pci 0000:00:0d.0:   bridge window
[mem 0xfe700000-0xfe7fffff]
[    0.642057] localhost kernel: pci 0000:00:0d.0:   bridge window
[mem 0xc0000000-0xcfffffff 64bit pref]
[    0.642131] localhost kernel: pci 0000:00:14.4: PCI bridge to [bus
08] (subtractive decode)
[    0.642139] localhost kernel: pci 0000:00:14.4:   bridge window [io
 0x0000-0x03af window] (subtractive decode)
[    0.642140] localhost kernel: pci 0000:00:14.4:   bridge window [io
 0x03e0-0x0cf7 window] (subtractive decode)
[    0.642143] localhost kernel: pci 0000:00:14.4:   bridge window [io
 0x03b0-0x03df window] (subtractive decode)
[    0.642145] localhost kernel: pci 0000:00:14.4:   bridge window [io
 0x0d00-0xffff window] (subtractive decode)
[    0.642146] localhost kernel: pci 0000:00:14.4:   bridge window
[mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.642148] localhost kernel: pci 0000:00:14.4:   bridge window
[mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.642149] localhost kernel: pci 0000:00:14.4:   bridge window
[mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.642349] localhost kernel: pci 0000:00:15.0: PCI bridge to [bus 0=
9]
[    0.642418] localhost kernel: pci 0000:0a:00.0: [10ec:8168] type 00
class 0x020000
[    0.642438] localhost kernel: pci 0000:0a:00.0: reg 0x10: [io  0xb00=
0-0xb0ff]
[    0.642466] localhost kernel: pci 0000:0a:00.0: reg 0x18: [mem
0xd0004000-0xd0004fff 64bit pref]
[    0.642484] localhost kernel: pci 0000:0a:00.0: reg 0x20: [mem
0xd0000000-0xd0003fff 64bit pref]
[    0.642562] localhost kernel: pci 0000:0a:00.0: supports D1 D2
[    0.642563] localhost kernel: pci 0000:0a:00.0: PME# supported from
D0 D1 D2 D3hot D3cold
[    0.648717] localhost kernel: pci 0000:00:15.1: PCI bridge to [bus 0=
a]
[    0.648723] localhost kernel: pci 0000:00:15.1:   bridge window [io
 0xb000-0xbfff]
[    0.648730] localhost kernel: pci 0000:00:15.1:   bridge window
[mem 0xd0000000-0xd00fffff 64bit pref]
[    0.648797] localhost kernel: pci 0000:0b:00.0: [1b21:1042] type 00
class 0x0c0330
[    0.648825] localhost kernel: pci 0000:0b:00.0: reg 0x10: [mem
0xfe600000-0xfe607fff 64bit]
[    0.648945] localhost kernel: pci 0000:0b:00.0: PME# supported from
D3hot D3cold
[    0.655374] localhost kernel: pci 0000:00:15.2: PCI bridge to [bus 0=
b]
[    0.655381] localhost kernel: pci 0000:00:15.2:   bridge window
[mem 0xfe600000-0xfe6fffff]
[    0.655451] localhost kernel: pci 0000:0c:00.0: [1b21:1042] type 00
class 0x0c0330
[    0.655479] localhost kernel: pci 0000:0c:00.0: reg 0x10: [mem
0xfe500000-0xfe507fff 64bit]
[    0.655599] localhost kernel: pci 0000:0c:00.0: PME# supported from
D3hot D3cold
[    0.662037] localhost kernel: pci 0000:00:15.3: PCI bridge to [bus 0=
c]
[    0.662044] localhost kernel: pci 0000:00:15.3:   bridge window
[mem 0xfe500000-0xfe5fffff]
[    0.662148] localhost kernel: pci_bus 0000:00: on NUMA node 0
[    0.662508] localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
4 7 10 11 14 15) *0
[    0.662574] localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs
4 7 10 11 14 15) *0
[    0.662640] localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
4 7 10 11 14 15) *0
[    0.662705] localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
3 4 10 11 14 15) *0
[    0.662756] localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs
4 7 10 11 14 15) *0
[    0.662798] localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs
4 7 10 11 14 15) *0
[    0.662839] localhost kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs
4 7 10 11 14 15) *0
[    0.662880] localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs
4 7 10 11 14 15) *0
[    0.662986] localhost kernel: ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.663006] localhost kernel: ACPI : EC: GPE =3D 0xa, I/O:
command/status =3D 0x66, data =3D 0x62
[    0.663100] localhost kernel: vgaarb: setting as boot device:
PCI:0000:07:00.0
[    0.663102] localhost kernel: vgaarb: device added:
PCI:0000:07:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.663103] localhost kernel: vgaarb: loaded
[    0.663104] localhost kernel: vgaarb: bridge control possible 0000:0=
7:00.0
[    0.663186] localhost kernel: PCI: Using ACPI for IRQ routing
[    0.670882] localhost kernel: PCI: pci_cache_line_size set to 64 byt=
es
[    0.670962] localhost kernel: e820: reserve RAM buffer [mem
0x0009e800-0x0009ffff]
[    0.670964] localhost kernel: e820: reserve RAM buffer [mem
0xba631000-0xbbffffff]
[    0.670965] localhost kernel: e820: reserve RAM buffer [mem
0xbca35000-0xbfffffff]
[    0.670966] localhost kernel: e820: reserve RAM buffer [mem
0xbd083000-0xbfffffff]
[    0.670967] localhost kernel: e820: reserve RAM buffer [mem
0xbd800000-0xbfffffff]
[    0.670969] localhost kernel: e820: reserve RAM buffer [mem
0x33f000000-0x33fffffff]
[    0.671066] localhost kernel: NetLabel: Initializing
[    0.671067] localhost kernel: NetLabel:  domain hash size =3D 128
[    0.671068] localhost kernel: NetLabel:  protocols =3D UNLABELED CIP=
SOv4
[    0.671078] localhost kernel: NetLabel:  unlabeled traffic allowed b=
y default
[    0.671096] localhost kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, =
0
[    0.671099] localhost kernel: hpet0: 3 comparators, 32-bit
14.318180 MHz counter
[    0.673160] localhost kernel: Switched to clocksource hpet
[    0.679042] localhost kernel: pnp: PnP ACPI init
[    0.679136] localhost kernel: system 00:00: [mem
0xe0000000-0xefffffff] has been reserved
[    0.679140] localhost kernel: system 00:00: Plug and Play ACPI
device, IDs PNP0c01 (active)
[    0.679409] localhost kernel: system 00:01: [io  0x040b] has been re=
served
[    0.679411] localhost kernel: system 00:01: [io  0x04d6] has been re=
served
[    0.679413] localhost kernel: system 00:01: [io  0x0c00-0x0c01] has
been reserved
[    0.679415] localhost kernel: system 00:01: [io  0x0c14] has been re=
served
[    0.679416] localhost kernel: system 00:01: [io  0x0c50-0x0c51] has
been reserved
[    0.679418] localhost kernel: system 00:01: [io  0x0c52] has been re=
served
[    0.679419] localhost kernel: system 00:01: [io  0x0c6c] has been re=
served
[    0.679421] localhost kernel: system 00:01: [io  0x0c6f] has been re=
served
[    0.679422] localhost kernel: system 00:01: [io  0x0cd0-0x0cd1] has
been reserved
[    0.679424] localhost kernel: system 00:01: [io  0x0cd2-0x0cd3] has
been reserved
[    0.679425] localhost kernel: system 00:01: [io  0x0cd4-0x0cd5] has
been reserved
[    0.679427] localhost kernel: system 00:01: [io  0x0cd6-0x0cd7] has
been reserved
[    0.679428] localhost kernel: system 00:01: [io  0x0cd8-0x0cdf] has
been reserved
[    0.679430] localhost kernel: system 00:01: [io  0x0800-0x089f]
could not be reserved
[    0.679431] localhost kernel: system 00:01: [io  0x0b20-0x0b3f] has
been reserved
[    0.679433] localhost kernel: system 00:01: [io  0x0900-0x090f] has
been reserved
[    0.679434] localhost kernel: system 00:01: [io  0x0910-0x091f] has
been reserved
[    0.679436] localhost kernel: system 00:01: [io  0xfe00-0xfefe] has
been reserved
[    0.679438] localhost kernel: system 00:01: [mem
0xfec00000-0xfec00fff] could not be reserved
[    0.679440] localhost kernel: system 00:01: [mem
0xfee00000-0xfee00fff] has been reserved
[    0.679442] localhost kernel: system 00:01: [mem
0xfed80000-0xfed8ffff] has been reserved
[    0.679443] localhost kernel: system 00:01: [mem
0xfed61000-0xfed70fff] has been reserved
[    0.679445] localhost kernel: system 00:01: [mem
0xfec10000-0xfec10fff] has been reserved
[    0.679447] localhost kernel: system 00:01: [mem
0xfed00000-0xfed00fff] could not be reserved
[    0.679449] localhost kernel: system 00:01: [mem
0xff800000-0xffffffff] has been reserved
[    0.679451] localhost kernel: system 00:01: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.679584] localhost kernel: system 00:02: [io  0x0290-0x02af] has
been reserved
[    0.679586] localhost kernel: system 00:02: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.679617] localhost kernel: pnp 00:03: Plug and Play ACPI device,
IDs PNP0b00 (active)
[    0.679677] localhost kernel: system 00:04: [io  0x04d0-0x04d1] has
been reserved
[    0.679680] localhost kernel: system 00:04: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.679718] localhost kernel: system 00:05: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.679893] localhost kernel: pnp 00:06: [dma 0 disabled]
[    0.679938] localhost kernel: pnp 00:06: Plug and Play ACPI device,
IDs PNP0501 (active)
[    0.680065] localhost kernel: system 00:07: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.680172] localhost kernel: system 00:08: [mem
0xfec20000-0xfec200ff] could not be reserved
[    0.680174] localhost kernel: system 00:08: Plug and Play ACPI
device, IDs PNP0c02 (active)
[    0.680301] localhost kernel: pnp: PnP ACPI: found 9 devices
[    0.686880] localhost kernel: clocksource acpi_pm: mask: 0xffffff
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.686940] localhost kernel: pci 0000:00:02.0: PCI bridge to [bus 0=
1]
[    0.686947] localhost kernel: pci 0000:00:04.0: PCI bridge to [bus 0=
2]
[    0.686949] localhost kernel: pci 0000:00:04.0:   bridge window [io
 0xe000-0xefff]
[    0.686952] localhost kernel: pci 0000:00:04.0:   bridge window
[mem 0xfea00000-0xfeafffff]
[    0.686957] localhost kernel: pci 0000:00:05.0: PCI bridge to [bus 0=
3]
[    0.686959] localhost kernel: pci 0000:00:05.0:   bridge window [io
 0xd000-0xdfff]
[    0.686962] localhost kernel: pci 0000:00:05.0:   bridge window
[mem 0xfe900000-0xfe9fffff]
[    0.686966] localhost kernel: pci 0000:00:09.0: PCI bridge to [bus 0=
4]
[    0.686969] localhost kernel: pci 0000:00:09.0:   bridge window
[mem 0xfe800000-0xfe8fffff]
[    0.686974] localhost kernel: pci 0000:00:0a.0: PCI bridge to [bus 0=
5]
[    0.686980] localhost kernel: pci 0000:00:0b.0: PCI bridge to [bus 0=
6]
[    0.686986] localhost kernel: pci 0000:00:0d.0: PCI bridge to [bus 0=
7]
[    0.686988] localhost kernel: pci 0000:00:0d.0:   bridge window [io
 0xc000-0xcfff]
[    0.686991] localhost kernel: pci 0000:00:0d.0:   bridge window
[mem 0xfe700000-0xfe7fffff]
[    0.686993] localhost kernel: pci 0000:00:0d.0:   bridge window
[mem 0xc0000000-0xcfffffff 64bit pref]
[    0.686997] localhost kernel: pci 0000:00:14.4: PCI bridge to [bus 0=
8]
[    0.687007] localhost kernel: pci 0000:00:15.0: PCI bridge to [bus 0=
9]
[    0.687015] localhost kernel: pci 0000:00:15.1: PCI bridge to [bus 0=
a]
[    0.687018] localhost kernel: pci 0000:00:15.1:   bridge window [io
 0xb000-0xbfff]
[    0.687023] localhost kernel: pci 0000:00:15.1:   bridge window
[mem 0xd0000000-0xd00fffff 64bit pref]
[    0.687028] localhost kernel: pci 0000:00:15.2: PCI bridge to [bus 0=
b]
[    0.687032] localhost kernel: pci 0000:00:15.2:   bridge window
[mem 0xfe600000-0xfe6fffff]
[    0.687038] localhost kernel: pci 0000:00:15.3: PCI bridge to [bus 0=
c]
[    0.687041] localhost kernel: pci 0000:00:15.3:   bridge window
[mem 0xfe500000-0xfe5fffff]
[    0.687048] localhost kernel: pci_bus 0000:00: resource 4 [io
0x0000-0x03af window]
[    0.687050] localhost kernel: pci_bus 0000:00: resource 5 [io
0x03e0-0x0cf7 window]
[    0.687051] localhost kernel: pci_bus 0000:00: resource 6 [io
0x03b0-0x03df window]
[    0.687053] localhost kernel: pci_bus 0000:00: resource 7 [io
0x0d00-0xffff window]
[    0.687054] localhost kernel: pci_bus 0000:00: resource 8 [mem
0x000a0000-0x000bffff window]
[    0.687056] localhost kernel: pci_bus 0000:00: resource 9 [mem
0x000c0000-0x000dffff window]
[    0.687057] localhost kernel: pci_bus 0000:00: resource 10 [mem
0xc0000000-0xffffffff window]
[    0.687059] localhost kernel: pci_bus 0000:02: resource 0 [io  0xe00=
0-0xefff]
[    0.687060] localhost kernel: pci_bus 0000:02: resource 1 [mem
0xfea00000-0xfeafffff]
[    0.687062] localhost kernel: pci_bus 0000:03: resource 0 [io  0xd00=
0-0xdfff]
[    0.687063] localhost kernel: pci_bus 0000:03: resource 1 [mem
0xfe900000-0xfe9fffff]
[    0.687064] localhost kernel: pci_bus 0000:04: resource 1 [mem
0xfe800000-0xfe8fffff]
[    0.687066] localhost kernel: pci_bus 0000:07: resource 0 [io  0xc00=
0-0xcfff]
[    0.687067] localhost kernel: pci_bus 0000:07: resource 1 [mem
0xfe700000-0xfe7fffff]
[    0.687069] localhost kernel: pci_bus 0000:07: resource 2 [mem
0xc0000000-0xcfffffff 64bit pref]
[    0.687070] localhost kernel: pci_bus 0000:08: resource 4 [io
0x0000-0x03af window]
[    0.687072] localhost kernel: pci_bus 0000:08: resource 5 [io
0x03e0-0x0cf7 window]
[    0.687073] localhost kernel: pci_bus 0000:08: resource 6 [io
0x03b0-0x03df window]
[    0.687074] localhost kernel: pci_bus 0000:08: resource 7 [io
0x0d00-0xffff window]
[    0.687076] localhost kernel: pci_bus 0000:08: resource 8 [mem
0x000a0000-0x000bffff window]
[    0.687077] localhost kernel: pci_bus 0000:08: resource 9 [mem
0x000c0000-0x000dffff window]
[    0.687079] localhost kernel: pci_bus 0000:08: resource 10 [mem
0xc0000000-0xffffffff window]
[    0.687080] localhost kernel: pci_bus 0000:0a: resource 0 [io  0xb00=
0-0xbfff]
[    0.687082] localhost kernel: pci_bus 0000:0a: resource 2 [mem
0xd0000000-0xd00fffff 64bit pref]
[    0.687083] localhost kernel: pci_bus 0000:0b: resource 1 [mem
0xfe600000-0xfe6fffff]
[    0.687084] localhost kernel: pci_bus 0000:0c: resource 1 [mem
0xfe500000-0xfe5fffff]
[    0.687110] localhost kernel: NET: Registered protocol family 2
[    0.687342] localhost kernel: TCP established hash table entries:
131072 (order: 8, 1048576 bytes)
[    0.687630] localhost kernel: TCP bind hash table entries: 65536
(order: 8, 1048576 bytes)
[    0.687848] localhost kernel: TCP: Hash tables configured
(established 131072 bind 65536)
[    0.687897] localhost kernel: UDP hash table entries: 8192 (order:
6, 262144 bytes)
[    0.687970] localhost kernel: UDP-Lite hash table entries: 8192
(order: 6, 262144 bytes)
[    0.688063] localhost kernel: NET: Registered protocol family 1
[    0.956679] localhost kernel: pci 0000:07:00.0: Video device with
shadowed ROM
[    0.956897] localhost kernel: PCI: CLS 64 bytes, default 64
[    0.956939] localhost kernel: Unpacking initramfs...
[    1.175171] localhost kernel: Freeing initrd memory: 28200K
(ffff88007e476000 - ffff880080000000)
[    1.175181] localhost kernel: PCI-DMA: Disabling AGP.
[    1.175259] localhost kernel: PCI-DMA: aperture base @ b0000000 size=
 65536 KB
[    1.175260] localhost kernel: PCI-DMA: using GART IOMMU.
[    1.175263] localhost kernel: PCI-DMA: Reserving 64MB of IOMMU area
in the AGP aperture
[    1.178928] localhost kernel: perf: AMD NB counters detected
[    1.179053] localhost kernel: microcode: CPU0: patch_level=3D0x06000=
822
[    1.179059] localhost kernel: microcode: CPU1: patch_level=3D0x06000=
822
[    1.179068] localhost kernel: microcode: CPU2: patch_level=3D0x06000=
822
[    1.179076] localhost kernel: microcode: CPU3: patch_level=3D0x06000=
822
[    1.179085] localhost kernel: microcode: CPU4: patch_level=3D0x06000=
822
[    1.179092] localhost kernel: microcode: CPU5: patch_level=3D0x06000=
822
[    1.179101] localhost kernel: microcode: CPU6: patch_level=3D0x06000=
822
[    1.179109] localhost kernel: microcode: CPU7: patch_level=3D0x06000=
822
[    1.179167] localhost kernel: microcode: Microcode Update Driver:
v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.179171] localhost kernel: LVT offset 0 assigned for vector 0x400
[    1.179188] localhost kernel: perf: AMD IBS detected (0x000000ff)
[    1.179210] localhost kernel: Scanning for low memory corruption
every 60 seconds
[    1.179514] localhost kernel: futex hash table entries: 2048
(order: 5, 131072 bytes)
[    1.179536] localhost kernel: Initialise system trusted keyring
[    1.179874] localhost kernel: HugeTLB registered 2 MB page size,
pre-allocated 0 pages
[    1.181462] localhost kernel: zpool: loaded
[    1.181464] localhost kernel: zbud: loaded
[    1.181607] localhost kernel: VFS: Disk quotas dquot_6.6.0
[    1.181642] localhost kernel: VFS: Dquot-cache hash table entries:
512 (order 0, 4096 bytes)
[    1.181793] localhost kernel: Key type big_key registered
[    1.182016] localhost kernel: Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 252)
[    1.182072] localhost kernel: io scheduler noop registered
[    1.182074] localhost kernel: io scheduler deadline registered
[    1.182104] localhost kernel: io scheduler cfq registered (default)
[    1.182848] localhost kernel: pci_hotplug: PCI Hot Plug PCI Core ver=
sion: 0.5
[    1.182863] localhost kernel: pciehp: PCI Express Hot Plug
Controller Driver version: 0.4
[    1.182908] localhost kernel: GHES: HEST is not enabled!
[    1.182967] localhost kernel: Serial: 8250/16550 driver, 4 ports,
IRQ sharing disabled
[    1.203472] localhost kernel: 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4,
base_baud =3D 115200) is a 16550A
[    1.203818] localhost kernel: Linux agpgart interface v0.103
[    1.204484] localhost kernel: rtc_cmos 00:03: RTC can wake from S4
[    1.204579] localhost kernel: rtc_cmos 00:03: rtc core: registered
rtc_cmos as rtc0
[    1.204600] localhost kernel: rtc_cmos 00:03: alarms up to one
month, y3k, 114 bytes nvram, hpet irqs
[    1.204612] localhost kernel: ledtrig-cpu: registered to indicate
activity on CPUs
[    1.204922] localhost kernel: NET: Registered protocol family 10
[    1.205123] localhost kernel: NET: Registered protocol family 17
[    1.205731] localhost kernel: Loading compiled-in X.509 certificates
[    1.205746] localhost kernel: registered taskstats version 1
[    1.206190] localhost kernel:   Magic number: 7:306:881
[    1.206263] localhost kernel: rtc_cmos 00:03: setting system clock
to 2015-07-12 10:52:28 UTC (1436698348)
[    1.206350] localhost kernel: PM: Hibernation image not present or
could not be loaded.
[    1.206687] localhost kernel: Freeing unused kernel memory: 1180K
(ffffffff818e1000 - ffffffff81a08000)
[    1.206688] localhost kernel: Write protecting the kernel read-only
data: 8192k
[    1.206917] localhost kernel: Freeing unused kernel memory: 436K
(ffff880001593000 - ffff880001600000)
[    1.207030] localhost kernel: Freeing unused kernel memory: 320K
(ffff8800017b0000 - ffff880001800000)
[    1.208557] localhost systemd[1]: Failed to insert module
'ip_tables': Function not implemented
[    1.208967] localhost kernel: random: systemd urandom read with 1
bits of entropy available
[    1.209460] localhost systemd[1]: systemd 222 running in system
mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP
-LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN)
[    1.209675] localhost systemd[1]: Detected architecture x86-64.
[    1.209677] localhost systemd[1]: Running in initial RAM disk.
[    1.209915] localhost systemd[1]: No hostname configured.
[    1.209918] localhost systemd[1]: Set hostname to <localhost>.
[    1.209940] localhost systemd[1]: Initializing machine ID from
random generator.
[    1.231536] localhost systemd[76]:
/usr/lib/systemd/system-generators/dracut-dmsquash-generator failed
with error code 1.
[    1.243559] localhost systemd[1]: Reached target Swap.
[    1.243567] localhost systemd[1]: Starting Swap.
[    1.243816] localhost systemd[1]: Reached target Timers.
[    1.243822] localhost systemd[1]: Starting Timers.
[    1.244038] localhost systemd[1]: Reached target Local File Systems.
[    1.244044] localhost systemd[1]: Starting Local File Systems.
[    1.244468] localhost systemd[1]: Created slice -.slice.
[    1.244474] localhost systemd[1]: Starting -.slice.
[    1.244701] localhost systemd[1]: Listening on udev Kernel Socket.
[    1.244707] localhost systemd[1]: Starting udev Kernel Socket.
[    1.245003] localhost systemd[1]: Created slice System Slice.
[    1.245010] localhost systemd[1]: Starting System Slice.
[    1.245242] localhost systemd[1]: Listening on udev Control Socket.
[    1.245248] localhost systemd[1]: Starting udev Control Socket.
[    1.245481] localhost systemd[1]: Listening on Journal Socket (/dev/=
log).
[    1.245487] localhost systemd[1]: Starting Journal Socket (/dev/log)=
=2E
[    1.245523] localhost systemd[1]: Started Dispatch Password
Requests to Console Directory Watch.
[    1.245529] localhost systemd[1]: Starting Dispatch Password
Requests to Console Directory Watch.
[    1.245744] localhost systemd[1]: Reached target Paths.
[    1.245749] localhost systemd[1]: Starting Paths.
[    1.246428] localhost systemd[1]: Listening on Journal Audit Socket.
[    1.246653] localhost systemd[1]: Reached target Slices.
[    1.246659] localhost systemd[1]: Starting Slices.
[    1.246894] localhost systemd[1]: Listening on Journal Socket.
[    1.246901] localhost systemd[1]: Starting Journal Socket.
[    1.246975] localhost systemd[1]: Started Load Kernel Modules.
[    1.246997] localhost systemd[1]: Started dracut ask for additional
cmdline parameters.
[    1.247391] localhost systemd[1]: Starting dracut cmdline hook...
[    1.247911] localhost systemd[1]: Starting Journal Service...
[    1.248457] localhost systemd[1]: Starting Create list of required
static device nodes for the current kernel...
[    1.248861] localhost systemd[1]: Reached target Sockets.
[    1.248868] localhost systemd[1]: Starting Sockets.
[    1.249186] localhost systemd[1]: Starting Apply Kernel Variables...
[    1.250572] localhost systemd[1]: Started Create list of required
static device nodes for the current kernel.
[    1.251747] localhost systemd[1]: Started Apply Kernel Variables.
[    1.252260] localhost systemd[1]: Starting Create Static Device
Nodes in /dev...
[    1.254085] localhost systemd[1]: Started Create Static Device Nodes=
 in /dev.
[    0.902077] localhost systemd-journal[136]: Journal started
[    0.902727] localhost dracut-cmdline[135]: dracut-
dracut-043-42-gee44f62 dracut-043-42-gee44f62
[    0.903031] localhost dracut-cmdline[135]: Using kernel command
line parameters:
[    0.903358] localhost dracut-cmdline[135]: BOOT_IMAGE=3Dboot/vmlinuz
rd.live.image rd.live.overlay.size=3D1024 root=3DLABEL=3DGNURAMALINUX_2=
01507
initrd=3Dboot/initramfs
[    1.275370] localhost systemd[1]: Started Journal Service.
[    1.282071] localhost kernel: loop: module loaded
[    0.911391] localhost dracut-cmdline[135]: root was
live:LABEL=3DGNURAMALINUX_201507, is now
live:/dev/disk/by-label/GNURAMALINUX_201507
[    0.920045] localhost systemd[1]: Started dracut cmdline hook.
[    0.921096] localhost systemd[1]: Starting dracut pre-udev hook...
[    1.305505] localhost kernel: device-mapper: uevent: version 1.0.3
[    1.305579] localhost kernel: device-mapper: ioctl: 4.31.0-ioctl
(2015-3-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    0.947432] localhost systemd[1]: Started dracut pre-udev hook.
[    0.947835] localhost systemd[1]: Starting udev Kernel Device Manage=
r...
[    0.950630] localhost systemd[1]: Started udev Kernel Device Manager=
=2E
[    0.951047] localhost systemd[1]: Starting dracut pre-trigger hook..=
=2E
[    0.961160] localhost systemd[1]: Started dracut pre-trigger hook.
[    0.961554] localhost systemd[1]: Starting udev Coldplug all Devices=
=2E..
[    0.969016] localhost systemd[1]: Mounting Configuration File System=
=2E..
[    0.970451] localhost systemd[1]: Mounted Configuration File System.
[    0.995124] localhost systemd[1]: Started udev Coldplug all Devices.
[    0.995424] localhost systemd[1]: Reached target System Initializati=
on.
[    0.995550] localhost systemd[1]: Starting System Initialization.
[    0.995667] localhost systemd[1]: Reached target Basic System.
[    0.995787] localhost systemd[1]: Starting Basic System.
[    0.996257] localhost systemd[1]: Starting dracut initqueue hook...
[    1.366200] localhost kernel: i8042: PNP: No PS/2 controller found.
Probing ports directly.
[    1.366613] localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq=
 1
[    1.366703] localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq=
 12
[    1.374365] localhost kernel: SCSI subsystem initialized
[    1.375340] localhost kernel: ACPI: bus type USB registered
[    1.375370] localhost kernel: usbcore: registered new interface driv=
er usbfs
[    1.375383] localhost kernel: usbcore: registered new interface driv=
er hub
[    1.375430] localhost kernel: usbcore: registered new device driver =
usb
[    1.378789] localhost kernel: QUIRK: Enable AMD PLL fix
[    1.378807] localhost kernel: xhci_hcd 0000:04:00.0: xHCI Host Contr=
oller
[    1.378813] localhost kernel: xhci_hcd 0000:04:00.0: new USB bus
registered, assigned bus number 1
[    1.379512] localhost kernel: libata version 3.00 loaded.
[    1.380087] localhost kernel: ehci_hcd: USB 2.0 'Enhanced' Host
Controller (EHCI) Driver
[    1.380364] localhost kernel: ehci-pci: EHCI PCI platform driver
[    1.383423] localhost kernel: ohci_hcd: USB 1.1 'Open' Host
Controller (OHCI) Driver
[    1.438116] localhost kernel: xhci_hcd 0000:04:00.0: hcc params
0x0200f180 hci version 0x96 quirks 0x00080000
[    1.438404] localhost kernel: hub 1-0:1.0: USB hub found
[    1.438414] localhost kernel: hub 1-0:1.0: 2 ports detected
[    1.438539] localhost kernel: xhci_hcd 0000:04:00.0: xHCI Host Contr=
oller
[    1.438547] localhost kernel: xhci_hcd 0000:04:00.0: new USB bus
registered, assigned bus number 2
[    1.438558] localhost kernel: ehci-pci 0000:00:12.2: EHCI Host Contr=
oller
[    1.438694] localhost kernel: hub 2-0:1.0: USB hub found
[    1.438703] localhost kernel: hub 2-0:1.0: 2 ports detected
[    1.438810] localhost kernel: ehci-pci 0000:00:12.2: new USB bus
registered, assigned bus number 3
[    1.438815] localhost kernel: ehci-pci 0000:00:12.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.438827] localhost kernel: ehci-pci 0000:00:12.2: debug port 1
[    1.438861] localhost kernel: ehci-pci 0000:00:12.2: irq 17, io mem
0xfeb09000
[    1.446097] localhost kernel: ehci-pci 0000:00:12.2: USB 2.0
started, EHCI 1.00
[    1.446281] localhost kernel: hub 3-0:1.0: USB hub found
[    1.446289] localhost kernel: hub 3-0:1.0: 5 ports detected
[    1.446439] localhost kernel: xhci_hcd 0000:0b:00.0: xHCI Host Contr=
oller
[    1.446446] localhost kernel: xhci_hcd 0000:0b:00.0: new USB bus
registered, assigned bus number 4
[    1.505764] localhost kernel: xhci_hcd 0000:0b:00.0: hcc params
0x0200f180 hci version 0x96 quirks 0x00080000
[    1.506039] localhost kernel: hub 4-0:1.0: USB hub found
[    1.506061] localhost kernel: hub 4-0:1.0: 2 ports detected
[    1.506177] localhost kernel: xhci_hcd 0000:0b:00.0: xHCI Host Contr=
oller
[    1.506180] localhost kernel: xhci_hcd 0000:0b:00.0: new USB bus
registered, assigned bus number 5
[    1.506195] localhost kernel: ehci-pci 0000:00:13.2: EHCI Host Contr=
oller
[    1.506382] localhost kernel: hub 5-0:1.0: USB hub found
[    1.506391] localhost kernel: hub 5-0:1.0: 2 ports detected
[    1.506505] localhost kernel: ehci-pci 0000:00:13.2: new USB bus
registered, assigned bus number 6
[    1.506510] localhost kernel: ehci-pci 0000:00:13.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.506543] localhost kernel: ehci-pci 0000:00:13.2: debug port 1
[    1.506578] localhost kernel: ehci-pci 0000:00:13.2: irq 21, io mem
0xfeb07000
[    1.516070] localhost kernel: ehci-pci 0000:00:13.2: USB 2.0
started, EHCI 1.00
[    1.516230] localhost kernel: hub 6-0:1.0: USB hub found
[    1.516236] localhost kernel: hub 6-0:1.0: 5 ports detected
[    1.516378] localhost kernel: xhci_hcd 0000:0c:00.0: xHCI Host Contr=
oller
[    1.516387] localhost kernel: xhci_hcd 0000:0c:00.0: new USB bus
registered, assigned bus number 7
[    1.575702] localhost kernel: xhci_hcd 0000:0c:00.0: hcc params
0x0200f180 hci version 0x96 quirks 0x00080000
[    1.575969] localhost kernel: hub 7-0:1.0: USB hub found
[    1.575977] localhost kernel: hub 7-0:1.0: 2 ports detected
[    1.576111] localhost kernel: xhci_hcd 0000:0c:00.0: xHCI Host Contr=
oller
[    1.576114] localhost kernel: xhci_hcd 0000:0c:00.0: new USB bus
registered, assigned bus number 8
[    1.576128] localhost kernel: ehci-pci 0000:00:16.2: EHCI Host Contr=
oller
[    1.576309] localhost kernel: hub 8-0:1.0: USB hub found
[    1.576317] localhost kernel: hub 8-0:1.0: 2 ports detected
[    1.576428] localhost kernel: ehci-pci 0000:00:16.2: new USB bus
registered, assigned bus number 9
[    1.576433] localhost kernel: ehci-pci 0000:00:16.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.576441] localhost kernel: ehci-pci 0000:00:16.2: debug port 1
[    1.576488] localhost kernel: ehci-pci 0000:00:16.2: irq 23, io mem
0xfeb04000
[    1.586016] localhost kernel: ehci-pci 0000:00:16.2: USB 2.0
started, EHCI 1.00
[    1.586179] localhost kernel: hub 9-0:1.0: USB hub found
[    1.586185] localhost kernel: hub 9-0:1.0: 4 ports detected
[    1.586326] localhost kernel: ahci 0000:00:11.0: version 3.0
[    1.586490] localhost kernel: ahci 0000:00:11.0: AHCI 0001.0200 32
slots 2 ports 6 Gbps 0x5 impl SATA mode
[    1.586493] localhost kernel: ahci 0000:00:11.0: flags: 64bit ncq
sntf ilck pm led clo pmp pio slum part
[    1.586822] localhost kernel: ohci-pci: OHCI PCI platform driver
[    1.587681] localhost kernel: scsi host0: ahci
[    1.587817] localhost kernel: scsi host1: ahci
[    1.588062] localhost kernel: scsi host2: ahci
[    1.588129] localhost kernel: ata1: SATA max UDMA/133 abar
m1024@0xfeb0b000 port 0xfeb0b100 irq 19
[    1.588130] localhost kernel: ata2: DUMMY
[    1.588132] localhost kernel: ata3: SATA max UDMA/133 abar
m1024@0xfeb0b000 port 0xfeb0b200 irq 19
[    1.588270] localhost kernel: ohci-pci 0000:00:12.0: OHCI PCI host c=
ontroller
[    1.588276] localhost kernel: ohci-pci 0000:00:12.0: new USB bus
registered, assigned bus number 10
[    1.588300] localhost kernel: ohci-pci 0000:00:12.0: irq 18, io mem
0xfeb0a000
[    1.588307] localhost kernel: ahci 0000:02:00.0: SSS flag set,
parallel bus scan disabled
[    1.588327] localhost kernel: ahci 0000:02:00.0: AHCI 0001.0200 32
slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.588329] localhost kernel: ahci 0000:02:00.0: flags: 64bit ncq
sntf stag led clo pmp pio slum part ccc sxs
[    1.588600] localhost kernel: scsi host3: ahci
[    1.588700] localhost kernel: scsi host4: ahci
[    1.588748] localhost kernel: ata4: SATA max UDMA/133 abar
m512@0xfea00000 port 0xfea00100 irq 53
[    1.588751] localhost kernel: ata5: SATA max UDMA/133 abar
m512@0xfea00000 port 0xfea00180 irq 53
[    1.588828] localhost kernel: ahci 0000:03:00.0: SSS flag set,
parallel bus scan disabled
[    1.588848] localhost kernel: ahci 0000:03:00.0: AHCI 0001.0200 32
slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.588850] localhost kernel: ahci 0000:03:00.0: flags: 64bit ncq
sntf stag led clo pmp pio slum part ccc sxs
[    1.589118] localhost kernel: scsi host5: ahci
[    1.589215] localhost kernel: scsi host6: ahci
[    1.589273] localhost kernel: ata6: SATA max UDMA/133 abar
m512@0xfe900000 port 0xfe900100 irq 55
[    1.589275] localhost kernel: ata7: SATA max UDMA/133 abar
m512@0xfe900000 port 0xfe900180 irq 55
[    1.643522] localhost kernel: hub 10-0:1.0: USB hub found
[    1.643531] localhost kernel: hub 10-0:1.0: 5 ports detected
[    1.643739] localhost kernel: ohci-pci 0000:00:13.0: OHCI PCI host c=
ontroller
[    1.643743] localhost kernel: ohci-pci 0000:00:13.0: new USB bus
registered, assigned bus number 11
[    1.643765] localhost kernel: ohci-pci 0000:00:13.0: irq 20, io mem
0xfeb08000
[    1.700160] localhost kernel: hub 11-0:1.0: USB hub found
[    1.700168] localhost kernel: hub 11-0:1.0: 5 ports detected
[    1.700377] localhost kernel: ohci-pci 0000:00:14.5: OHCI PCI host c=
ontroller
[    1.700382] localhost kernel: ohci-pci 0000:00:14.5: new USB bus
registered, assigned bus number 12
[    1.700403] localhost kernel: ohci-pci 0000:00:14.5: irq 18, io mem
0xfeb06000
[    1.756770] localhost kernel: hub 12-0:1.0: USB hub found
[    1.756778] localhost kernel: hub 12-0:1.0: 2 ports detected
[    1.756940] localhost kernel: ohci-pci 0000:00:16.0: OHCI PCI host c=
ontroller
[    1.756944] localhost kernel: ohci-pci 0000:00:16.0: new USB bus
registered, assigned bus number 13
[    1.756965] localhost kernel: ohci-pci 0000:00:16.0: irq 22, io mem
0xfeb05000
[    1.813399] localhost kernel: hub 13-0:1.0: USB hub found
[    1.813407] localhost kernel: hub 13-0:1.0: 4 ports detected
[    1.892524] localhost kernel: usb 9-3: new high-speed USB device
number 2 using ehci-pci
[    1.905878] localhost kernel: ata6: SATA link down (SStatus 0 SContr=
ol 300)
[    1.905880] localhost kernel: ata4: SATA link down (SStatus 0 SContr=
ol 300)
[    1.972478] localhost kernel: usb 10-3: new low-speed USB device
number 2 using ohci-pci
[    2.020220] localhost kernel: usb-storage 9-3:1.0: USB Mass Storage
device detected
[    2.020314] localhost kernel: scsi host7: usb-storage 9-3:1.0
[    2.020376] localhost kernel: usbcore: registered new interface
driver usb-storage
[    2.020855] localhost kernel: usbcore: registered new interface driv=
er uas
[    2.072430] localhost kernel: ata1: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
[    2.072450] localhost kernel: ata3: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
[    2.078828] localhost kernel: ata3.00: ATA-7: SAMSUNG HD753LJ,
1AA01110, max UDMA7
[    2.078830] localhost kernel: ata3.00: 1465149168 sectors, multi
16: LBA48 NCQ (depth 31/32), AA
[    2.084200] localhost kernel: ata1.00: ATA-8: KINGSTON
SV300S37A120G, 506ABBF0, max UDMA/133
[    2.084203] localhost kernel: ata1.00: 234441648 sectors, multi 16:
LBA48 NCQ (depth 31/32), AA
[    2.085265] localhost kernel: ata3.00: configured for UDMA/133
[    2.094093] localhost kernel: ata1.00: configured for UDMA/133
[    2.094217] localhost kernel: scsi 0:0:0:0: Direct-Access     ATA
   KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    2.094493] localhost kernel: scsi 2:0:0:0: Direct-Access     ATA
   SAMSUNG HD753LJ  1110 PQ: 0 ANSI: 5
[    2.095537] localhost kernel: sd 0:0:0:0: [sda] 234441648 512-byte
logical blocks: (120 GB/111 GiB)
[    2.095545] localhost kernel: sd 2:0:0:0: [sdb] 1465149168 512-byte
logical blocks: (750 GB/698 GiB)
[    2.095583] localhost kernel: sd 2:0:0:0: [sdb] Write Protect is off
[    2.095586] localhost kernel: sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00=
 00
[    2.095603] localhost kernel: sd 2:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
[    2.095643] localhost kernel: sd 0:0:0:0: [sda] Write Protect is off
[    2.095646] localhost kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00=
 00
[    2.095673] localhost kernel: sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
[    2.096209] localhost kernel:  sda: sda1 sda3 sda4
[    2.096624] localhost kernel: sd 0:0:0:0: [sda] Attached SCSI disk
[    2.110896] localhost kernel:  sdb: sdb1 sdb2
[    2.111100] localhost kernel: sd 2:0:0:0: [sdb] Attached SCSI disk
[    2.135237] localhost kernel: hidraw: raw HID events driver (C) Jiri=
 Kosina
[    2.147239] localhost kernel: usbcore: registered new interface driv=
er usbhid
[    2.147241] localhost kernel: usbhid: USB HID core driver
[    2.148005] localhost kernel: input: NOVATEK USB Keyboard as
/devices/pci0000:00/0000:00:12.0/usb10/10-3/10-3:1.0/0003:0603:00F2.000=
1/input/input2
[    2.179031] localhost kernel: tsc: Refined TSC clocksource
calibration: 4013.519 MHz
[    2.179034] localhost kernel: clocksource tsc: mask:
0xffffffffffffffff max_cycles: 0x39da3f7de0b, max_idle_ns:
440795278979 ns
[    2.199066] localhost kernel: hid-generic 0003:0603:00F2.0001:
input,hidraw0: USB HID v1.10 Keyboard [NOVATEK USB Keyboard] on
usb-0000:00:12.0-3/input0
[    2.202107] localhost kernel: input: NOVATEK USB Keyboard as
/devices/pci0000:00/0000:00:12.0/usb10/10-3/10-3:1.1/0003:0603:00F2.000=
2/input/input3
[    2.252436] localhost kernel: hid-generic 0003:0603:00F2.0002:
input,hiddev0,hidraw1: USB HID v1.10 Device [NOVATEK USB Keyboard] on
usb-0000:00:12.0-3/input1
[    2.382266] localhost kernel: usb 10-4: new full-speed USB device
number 3 using ohci-pci
[    2.412246] localhost kernel: ata5: SATA link down (SStatus 0 SContr=
ol 300)
[    2.554087] localhost kernel: input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:12.0/usb10/10-4/10-4:1.0/0003:046D:C52F.000=
3/input/input4
[    2.554133] localhost kernel: hid-generic 0003:046D:C52F.0003:
input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:00:12.0-4/input0
[    2.561956] localhost kernel: input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:12.0/usb10/10-4/10-4:1.1/0003:046D:C52F.000=
4/input/input5
[    2.612219] localhost kernel: hid-generic 0003:046D:C52F.0004:
input,hiddev0,hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:12.0-4/input1
[    2.732073] localhost kernel: ata7: SATA link down (SStatus 0 SContr=
ol 300)
[    3.022683] localhost kernel: scsi 7:0:0:0: Direct-Access
   USB Flash Memory PMAP PQ: 0 ANSI: 0 CCS
[    3.024056] localhost kernel: sd 7:0:0:0: [sdc] 15667200 512-byte
logical blocks: (8.02 GB/7.47 GiB)
[    3.024671] localhost kernel: sd 7:0:0:0: [sdc] Write Protect is off
[    3.024674] localhost kernel: sd 7:0:0:0: [sdc] Mode Sense: 23 00 00=
 00
[    3.025295] localhost kernel: sd 7:0:0:0: [sdc] No Caching mode page=
 found
[    3.025331] localhost kernel: sd 7:0:0:0: [sdc] Assuming drive
cache: write through
[    3.030043] localhost kernel:  sdc: sdc1 sdc2
[    3.032547] localhost kernel: sd 7:0:0:0: [sdc] Attached SCSI remova=
ble disk
[    2.739545] localhost systemd[1]: Found device USB_Flash_Memory
GNURAMALINUX_201507.
[    3.178561] localhost kernel: Switched to clocksource tsc
[    3.347406] localhost kernel: squashfs: version 4.0 (2009/01/31)
Phillip Lougher
[    3.394284] localhost kernel: ISO 9660 Extensions: RRIP_1991A
[    3.134728] localhost systemd[1]: Started dracut initqueue hook.
[    3.134831] localhost systemd[1]: Started dracut pre-mount hook.
[    3.134969] localhost systemd[1]: Reached target Remote File Systems=
 (Pre).
[    3.135050] localhost systemd[1]: Starting Remote File Systems (Pre)=
=2E
[    3.135170] localhost systemd[1]: Reached target Remote File Systems=
=2E
[    3.135257] localhost systemd[1]: Starting Remote File Systems.
[   14.086475] localhost kernel: random: nonblocking pool is initialize=
d
[   91.008636] localhost systemd[1]: dev-mapper-live\x2drw.device: Job
dev-mapper-live\x2drw.device/start timed out.
[   91.008875] localhost systemd[1]: Timed out waiting for device
dev-mapper-live\x2drw.device.
[   91.009071] localhost systemd[1]: Dependency failed for /sysroot.
[   91.009266] localhost systemd[1]: Dependency failed for Initrd Root
=46ile System.
[   91.009489] localhost systemd[1]: Dependency failed for Reload
Configuration from the Real Root.
[   91.009571] localhost systemd[1]: initrd-parse-etc.service: Job
initrd-parse-etc.service/start failed with result 'dependency'.
[   91.009657] localhost systemd[1]: initrd-parse-etc.service:
Triggering OnFailure=3D dependencies.
[   91.009738] localhost systemd[1]: initrd-root-fs.target: Job
initrd-root-fs.target/start failed with result 'dependency'.
[   91.009817] localhost systemd[1]: initrd-root-fs.target: Triggering
OnFailure=3D dependencies.
[   91.009895] localhost systemd[1]: sysroot.mount: Job
sysroot.mount/start failed with result 'dependency'.
[   91.009977] localhost systemd[1]: dev-mapper-live\x2drw.device: Job
dev-mapper-live\x2drw.device/start failed with result 'timeout'.
[   91.010072] localhost systemd[1]: Stopped dracut pre-pivot and clean=
up hook.
[   91.010154] localhost systemd[1]: Stopped target Initrd Default Targ=
et.
[   91.010237] localhost systemd[1]: Reached target Initrd File Systems=
=2E
[   91.010316] localhost systemd[1]: Starting Initrd File Systems.
[   91.010395] localhost systemd[1]: Stopped dracut mount hook.
[   91.010576] localhost systemd[1]: Stopped target Basic System.
[   91.010662] localhost systemd[1]: Stopping Basic System.
[   91.010807] localhost systemd[1]: Stopped target System Initializati=
on.
[   91.010888] localhost systemd[1]: Stopping System Initialization.
[   91.011201] localhost systemd[1]: Starting Setup Virtual Console...
[   91.012717] localhost systemd[1]: Started Setup Virtual Console.
[   91.013090] localhost systemd[1]: Starting Emergency Shell...
