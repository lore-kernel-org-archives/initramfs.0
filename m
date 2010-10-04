From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Mon, 04 Oct 2010 22:24:20 +1100
Message-ID: <20101004222420.11791ue5kephey5c@webmail.zoltak.com>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com>
 <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com>
 <4CA9998F.7060701@redhat.com>
 <20101004222036.53485185m6mhh11c@webmail.zoltak.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_1skqgr8setls"
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101004222036.53485185m6mhh11c-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This message is in MIME format.

--=_1skqgr8setls
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org:
> I've attached a new init.log.

Correct init.log attached!


--=_1skqgr8setls
Content-Type: text/x-log;
 charset=UTF-8;
 name="init.log"
Content-Disposition: attachment;
 filename="init.log"
Content-Transfer-Encoding: 7bit

+ mkdir /dev/shm
+ mkdir /dev/pts
+ mount -t devpts -o gid=5,mode=620 devpts /dev/pts
+ mount -t tmpfs tmpfs /dev/shm
+ mkdir -m 0755 /dev/.udev
+ mkdir -m 0755 /dev/.udev/rules.d
+ udevadm --version
+ UDEVVERSION=151
+ source_conf /etc/conf.d
+ local f
+ [ /etc/conf.d ]
+ [ -d //etc/conf.d ]
+ return
+ getarg rdbreak=cmdline
+ set +x
+ return 1
+ source_all cmdline
+ local f
+ [ cmdline ]
+ [ -d /cmdline ]
+ [ -e /cmdline/01parse-kernel.sh ]
+ . /cmdline/01parse-kernel.sh
+ getargs rdloaddriver=
+ set +x
+ return 1
+ [ -e /cmdline/10parse-resume.sh ]
+ . /cmdline/10parse-resume.sh
+ getarg resume=
+ set +x
+ return 1
+ resume=
+ unset resume
+ [ -e /cmdline/10parse-root-opts.sh ]
+ . /cmdline/10parse-root-opts.sh
+ getarg root=
+ set +x
+ return 0
+ root=10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ getarg rootflags=
+ set +x
+ return 1
+ rflags=
+ getarg rw
+ set +x
+ return 0
+ rflags=rw
+ getarg rootfstype=
+ set +x
+ return 1
+ fstype=
+ [ -z  ]
+ fstype=auto
+ [ -e /cmdline/20parse-blacklist.sh ]
+ . /cmdline/20parse-blacklist.sh
+ getargs rdblacklist=
+ set +x
+ return 1
+ [ -e /cmdline/20parse-i18n.sh ]
+ . /cmdline/20parse-i18n.sh
+ mkdir -p /etc/sysconfig
+ inst_key_val KEYMAP /etc/sysconfig/keyboard
+ local value
+ getarg KEYMAP
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val EXT_KEYMAPS /etc/sysconfig/keyboard
+ local value
+ getarg EXT_KEYMAPS
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val UNICODE /etc/sysconfig/i18n
+ local value
+ getarg UNICODE
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val SYSFONT /etc/sysconfig/i18n
+ local value
+ getarg SYSFONT
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val CONTRANS /etc/sysconfig/i18n
+ local value
+ getarg CONTRANS
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val UNIMAP /etc/sysconfig/i18n
+ local value
+ getarg UNIMAP
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val LANG /etc/sysconfig/i18n
+ local value
+ getarg LANG
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ inst_key_val LC_ALL /etc/sysconfig/i18n
+ local value
+ getarg LC_ALL
+ set +x
+ return 1
+ value=
+ [ -n  ]
+ [ -f /etc/sysconfig/i18n ]
+ [ -e /cmdline/30parse-crypt.sh ]
+ . /cmdline/30parse-crypt.sh
+ getarg rd_NO_LUKS
+ set +x
+ return 1
+ echo SUBSYSTEM!="block", GOTO="luks_end"
+ echo ACTION!="add|change", GOTO="luks_end"
+ getargs rd_LUKS_UUID
+ set +x
+ return 1
+ LUKS=
+ unset settled
+ getargs rd_LUKS_KEYPATH
+ set +x
+ return 1
+ [ -n  ]
+ [ -n  ]
+ echo ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue --unique --onetime --name cryptroot-ask-%k /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
+ echo LABEL="luks_end"
+ [ -e /cmdline/90parse-nfsroot.sh ]
+ . /cmdline/90parse-nfsroot.sh
+ . /lib/dracut-lib.sh
+ setdebug
+ [ -z yes ]
+ [ yes = yes ]
+ set -x
+ [ -n  ]
+ [ -z 10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
+ [ -z  ]
+ getarg netroot=
+ set +x
+ return 1
+ netroot=
+ [ -z  ]
+ getarg nfsroot=
+ set +x
+ return 1
+ nfsroot=
+ [ -n  ]
+ netroot=10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ [ -n  ]
+ netroot=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ getarg rd_NFS_DOMAIN
+ set +x
+ return 1
+ nfsdomain=
+ nfsroot_to_var nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ local arg=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw:
+ nfs=nfs
+ arg=10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw:
+ strstr 10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw: :/*
+ [ vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw: != 10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw: ]
+ server=10.197.170.5
+ arg=/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw:
+ path=/vol/filerboot/linux/images/live-mon-test
+ options=:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw:
+ options=fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw:
+ options=fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ [ -n  ]
+ [ /vol/filerboot/linux/images/live-mon-test != /vol/filerboot/linux/images/live-mon-test ]
+ [ /vol/filerboot/linux/images/live-mon-test = error ]
+ fstype=nfs
+ incol2 /proc/filesystems nfs
+ local dummy check
+ local file=/proc/filesystems
+ local str=nfs
+ [ -z /proc/filesystems ]
+ [ -z nfs ]
+ read dummy check restofline
+ [ sysfs = nfs ]
+ read dummy check restofline
+ [ rootfs = nfs ]
+ read dummy check restofline
+ [ bdev = nfs ]
+ read dummy check restofline
+ [ proc = nfs ]
+ read dummy check restofline
+ [ cgroup = nfs ]
+ read dummy check restofline
+ [ cpuset = nfs ]
+ read dummy check restofline
+ [ tmpfs = nfs ]
+ read dummy check restofline
+ [ sockfs = nfs ]
+ read dummy check restofline
+ [ pipefs = nfs ]
+ read dummy check restofline
+ [ anon_inodefs = nfs ]
+ read dummy check restofline
+ [ rpc_pipefs = nfs ]
+ read dummy check restofline
+ [ configfs = nfs ]
+ read dummy check restofline
+ [ devpts = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [ ramfs = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [  = nfs ]
+ read dummy check restofline
+ [ nfs = nfs ]
+ return 0
+ netroot=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
+ [ -z 10.197.170.5 ]
+ rootok=1
+ root=nfs
+ echo [ -e $NEWROOT/proc ]
+ [ -e /cmdline/91dhcp-root.sh ]
+ . /cmdline/91dhcp-root.sh
+ [ -n 1 ]
+ return
+ [ -e /cmdline/95parse-block.sh ]
+ . /cmdline/95parse-block.sh
+ [ -e /cmdline/98parse-bridge.sh ]
+ . /cmdline/98parse-bridge.sh
+ [ -n  ]
+ getarg bridge=
+ set +x
+ return 1
+ unset bridgename ethname
+ getarg bridge
+ set +x
+ return 1
+ [ -e /cmdline/99parse-ifname.sh ]
+ . /cmdline/99parse-ifname.sh
+ getarg ifname=
+ set +x
+ return 1
+ return
+ [ -e /cmdline/99parse-ip-opts.sh ]
+ . /cmdline/99parse-ip-opts.sh
+ . /lib/dracut-lib.sh
+ setdebug
+ [ -z yes ]
+ [ yes = yes ]
+ set -x
+ getarg ip=
+ set +x
+ return 0
+ [ -z nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
+ getarg ip=
+ set +x
+ return 0
+ getarg BOOTIF=
+ set +x
+ return 1
+ getarg BOOTIF
+ set +x
+ return 1
+ [ -n  ]
+ [ -n nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
+ getarg ip=
+ set +x
+ return 0
+ [ -z dhcp ]
+ [ -z  ]
+ local count=0
+ getargs ip=
+ set +x
+ return 0
+ count=1
+ [ 1 -gt 1 ]
+ [ -n  ]
+ getargs ip=
+ set +x
+ return 0
+ ip_to_var dhcp
+ local v=dhcp:
+ local i
+ set --
+ [ -n dhcp: ]
+ [ dhcp: != dhcp: ]
+ set -- dhcp
+ v=
+ [ -n  ]
+ unset ip srv gw mask hostname dev autoconf
+ autoconf=dhcp
+ [ -n  ]
+ [ -z dhcp ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -z  ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -n  ]
+ [ -z nfs ]
+ [ -z 1 ]
+ echo root='nfs'
+ echo rflags='rw'
+ echo fstype='nfs'
+ echo netroot='nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw'
+ echo NEWROOT='/sysroot'
+ getarg rdbreak=pre-udev
+ set +x
+ return 1
+ source_all pre-udev
+ local f
+ [ pre-udev ]
+ [ -d /pre-udev ]
+ [ -e /pre-udev/30block-genrules.sh ]
+ . /pre-udev/30block-genrules.sh
+ [ nfs = block ]
+ [ -e /pre-udev/30dm-pre-udev.sh ]
+ . /pre-udev/30dm-pre-udev.sh
+ cat /proc/misc
+ strstr  60 network_throughput
61 network_latency
62 cpu_dma_latency
1 psaux
231 snapshot
227 mcelog
63 vga_arbiter device-mapper
+ [  60 network_throughput
61 network_latency
62 cpu_dma_latency
1 psaux
231 snapshot
227 mcelog
63 vga_arbiter !=  60 network_throughput
61 network_latency
62 cpu_dma_latency
1 psaux
231 snapshot
227 mcelog
63 vga_arbiter ]
+ modprobe dm_mod
+ [ -e /pre-udev/30resume-genrules.sh ]
+ . /pre-udev/30resume-genrules.sh
+ [ -n  ]
+ getarg noresume
+ set +x
+ return 1
+ echo SUBSYSTEM=="block", ACTION=="add|change", ENV{ID_FS_TYPE}=="suspend|swsuspend|swsupend",  RUN+="/bin/sh -c 'echo %M:%m > /sys/power/resume'"
+ [ -e /pre-udev/50ifname-genrules.sh ]
+ . /pre-udev/50ifname-genrules.sh
+ getarg ifname=
+ set +x
+ return 1
+ return
+ [ -e /pre-udev/60net-genrules.sh ]
+ . /pre-udev/60net-genrules.sh
+ [ -z nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
+ [ -e /tmp/bridge.info ]
+ getarg BOOTIF=
+ set +x
+ return 1
+ BOOTIF=
+ [ -n  ]
+ [ -n  ]
+ printf ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"n
+ udevd --daemon --resolve-names=never
+ UDEV_LOG_PRIO_ARG=--log-priority
+ UDEV_QUEUE_EMPTY=udevadm settle --timeout=0
+ [ 151 -lt 140 ]
+ getarg rdudevinfo
+ set +x
+ return 1
+ getarg rdudevdebug
+ set +x
+ return 1
+ getarg rdbreak=pre-trigger
+ set +x
+ return 1
+ source_all pre-trigger
+ local f
+ [ pre-trigger ]
+ [ -d /pre-trigger ]
+ return
+ udevadm trigger --action=add
ifup.eth0.778 + . /lib/dracut-lib.sh
ifup.eth0.778 + setdebug
ifup.eth0.778 + [ -z yes ]
ifup.eth0.778 + [ yes = yes ]
ifup.eth0.778 + set -x
ifup.lo.780 + . /lib/dracut-lib.sh
ifup.lo.780 + ifup.eth0.778 + [ -zsetdebug
eth0ifup.lo.780 + [ ]
ifup.eth0.778 + netif=eth0 -z yes ]

ifup.eth0.778 + [ -eifup.lo.780 +  /tmp/bridge.info[ ]
yes = yesifup.eth0.778 +  ][ -f /tmp/net.eth0.up ]

ifup.lo.780 + ifup.eth0.778 + [set -f /tmp/root.info ]
ifup.eth0.778 + . -x
/tmp/root.info
ifup.eth0.778 + root=nfs
ifup.eth0.778 + rflags=rw
ifup.eth0.778 + fstype=nfs
ifup.eth0.778 + netroot=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
ifup.eth0.778 + NEWROOT=/sysroot
ifup.eth0.778 + [ -z nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
ifup.eth0.778 + [ eth0 = lo ]
ifup.eth0.778 + [ eth0 =  ]
ifup.lo.780 + [ -z lo ]ifup.eth0.778 +
ifup.lo.780 + netif=logetarg
ip
ifup.lo.780 + [ -e /tmp/bridge.info ]
ifup.eth0.778 + setifup.lo.780 + [ +x
-f /tmp/net.lo.up ]
ifup.lo.780 + [ -f /tmp/root.info ]
ifup.lo.780 + . /tmp/root.info
ifup.lo.780 + root=nfs
ifup.lo.780 + rflags=rw
ifup.lo.780 + fstype=nfs
ifup.lo.780 + netroot=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
ifup.lo.780 + NEWROOT=/sysroot
ifup.lo.780 + [ -zifup.eth0.778 + return nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw ]
0
ifup.lo.780 + [ lo = lo ]
ifup.lo.780 + ip link setifup.eth0.778 +  lo upip=dhcp

ifup.eth0.778 + [ -z dhcp ]
ifup.eth0.778 + getargs ip=
ifup.eth0.778 + set +x
ifup.eth0.778 + return 0
ifup.eth0.778 + ip_to_var dhcp
ifup.eth0.778 + local v=dhcp:
ifup.eth0.778 + localifup.lo.780 +  i
ipifup.eth0.778 +  addrset add -- 127.0.0.1/8
devifup.eth0.778 +  lo[
-n dhcp: ]
ifup.eth0.778 + [ dhcp: != dhcp: ]
ifup.eth0.778 + set -- dhcp
ifup.eth0.778 + v=
ifup.eth0.778 + [ -n  ]
ifup.eth0.778 + unset ip srv gw mask hostname dev autoconf
ifup.eth0.778 + autoconf=dhcp
ifup.eth0.778 + [ -n  ]
ifup.eth0.778 + eval [ "$ip" ] && echo ip="$ip"
ifup.eth0.778 + [  ]
ifup.eth0.778 + eval [ "$srv" ] && echo srv="$srv"
ifup.eth0.778 + [  ]
ifup.eth0.778 + eval [ "$gw" ] && echo gw="$gw"
ifup.eth0.778 + [  ]
ifup.eth0.778 + eval [ "$mask" ] && echo mask="$mask"
ifup.eth0.778 + [  ]
ifup.eth0.778 + eval [ "$hostname" ] && echo hostname="$hostname"
ifup.eth0.778 + [  ]
ifup.eth0.778 + do_dhcp -4
ifup.eth0.778 + echo Starting dhcp for interface eth0
Starting dhcp for interface eth0
ifup.eth0.778 + dhclient -4 -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.eth0.pid -lf /tmp/dhclient.eth0.lease eth0
RTNETLINK answers: File exists
ifup.lo.780 +
ifup.lo.780 + exit 0
ifup.eth0.778 + echo dhcp failed
dhcp failed
ifup.eth0.778 + break
ifup.eth0.778 + exit 0
+ getarg rdbreak=initqueue
+ set +x
+ return 1
+ getarg rd_retry=
+ set +x
+ return 1
+ RDRETRY=
+ RDRETRY=20
+ RDRETRY=40
+ i=0
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=1
+ [ 1 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=2
+ [ 2 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=3
+ [ 3 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=4
+ [ 4 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=5
+ [ 5 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=6
+ [ 6 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=7
+ [ 7 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=8
+ [ 8 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=9
+ [ 9 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=10
+ [ 10 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=11
+ [ 11 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=12
+ [ 12 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=13
+ [ 13 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=14
+ [ 14 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=15
+ [ 15 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=16
+ [ 16 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=17
+ [ 17 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=18
+ [ 18 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=19
+ [ 19 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=20
+ [ 20 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=21
+ [ 21 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=22
+ [ 22 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=23
+ [ 23 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=24
+ [ 24 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=25
+ [ 25 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=26
+ [ 26 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=27
+ [ 27 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=28
+ [ 28 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=29
+ [ 29 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=30
+ [ 30 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=31
+ [ 31 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=32
+ [ 32 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=33
+ [ 33 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=34
+ [ 34 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=35
+ [ 35 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=36
+ [ 36 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=37
+ [ 37 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=38
+ [ 38 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=39
+ [ 39 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=40
+ [ 40 -gt 40 ]
+ :
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ udevsettle
+ [ -z 151 ]
+ [ 151 -ge 143 ]
+ udevadm settle --exit-if-exists=/initqueue/work
+ check_finished
+ local f
+ [ -e /initqueue-finished/nfsroot.sh ]
+ . /initqueue-finished/nfsroot.sh
+ [ -e /sysroot/proc ]
+ return 1
+ [ -f /initqueue/work ]
+ [ -e /initqueue/*.sh ]
+ break
+ udevadm settle --timeout=0
+ modprobe scsi_wait_scan
+ rmmod scsi_wait_scan
+ udevadm settle --timeout=0
+ [ -e /initqueue-settled/*.sh ]
+ break
+ udevadm settle --timeout=0
+ sleep 0.5
+ [ -e /sys/block/sr0 ]
+ udevadm info --query=env --path=/block/sr0
+ strstr UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ID_CDROM_MEDIA
+ [ UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 != UDEV_LOG=3
DEVPATH=/block/sr0
MAJOR=11
MINOR=0
DEVNAME=/dev/sr0
DEVTYPE=disk
PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/host0/target0:0:0/0:0:0:0
PHYSDEVBUS=scsi
PHYSDEVDRIVER=sr
SUBSYSTEM=block
ID_SCSI=1
ID_VENDOR=Dell
ID_VENDOR_ENC=Dellx20x20x20x20
ID_MODEL=Virtual_CDROM
ID_MODEL_ENC=Virtualx20x20CDROMx20x20
ID_REVISION=123
ID_TYPE=cd
ID_BUS=scsi
DEVLINKS=/dev/block/11:0 /dev/scd0 ]
+ echo change
+ i=41
+ [ 41 -gt 40 ]
+ flock -s 9
+ emergency_shell No root device found
+ [ No root device found = -n ]
+ _rdshell_name=dracut
+ wait_for_loginit
+ getarg rdinitdebug
+ set +x
+ return 0
+ set +x

--=_1skqgr8setls--
