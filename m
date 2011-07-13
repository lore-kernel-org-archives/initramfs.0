From: Asher <asher-QzpIIgBpbaGuGCoOt2QH1kEOCMrvLtNR@public.gmane.org>
Subject: Dracut iSCSI Root
Date: Tue, 12 Jul 2011 21:52:50 -0400
Message-ID: <EBEA83B2-D6E5-43AB-879A-DC725178D0AB@ridiculouspower.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm attempting to setup a system without a hard drive, booting from an iSCSI root. The iSCSI root is a logical volume on a Scientific Linux 6.0 host. I am able to verify that iSCSI works as expected, and have been able to use iSCSI from the machine in question to do a base install using an iSCSI root, but the resulting configuration does not boot.

I am using PXELinux to do the actual netbooting. The system currently gets to the point where iSCSI is connected but then can't find the root device.

I have set up a label using e2label for the iSCSI volume (I did so by mounting it), but the label does not seem to make it to the dracut generated initrd.

When I am dropped into the debug shell, no volumes appear present - either by fdisk -l, blkid, dmesg, or attempting to mount /dev/sda1. 

Any help would be much appreciated!

-Asher

-----------------------------------------------------------------------------------------------------------------------------------
Output on bootup with root=LABEL=rig1 netroot=iscsi:@10.0.0.1::3260::iqn.2011-01.local:rig1
-----------------------------------------------------------------------------------------------------------------------------------

... [ misc boot information up to networking ] ...
eth0: link up.
iscsi:10.0.0.1::3260:01:iqn.2011-01.local:rig1
icscistart: transport class version 2.0-872
iscsistart: Logging into iqn.2011-01.local:rig1 10.0.0.1:3268,1
iscsistart: version 2.0-872
scsi0 : iSCSI initiator over TCP/IP
iscsistart: Connection1:0 to [target: iqn.2011-01.local:rig1, portal: 10.0.0.1,3268] through [iface: default] is operational now
scsi 0:0:0:0: RAID            IET      Controller   0001 PQ: 0 ANSI: 5
scsi 0:0:0:1: Direct-Access   OURHOUSE VIRTUAL-DISK 0001 PQ: 0 ANSI: 5


<28>dracut Warning: No root device "block:/dev/disk/by-label/rig1" found

Dropping to debug shell.

sh: cannot set terminal process group (-1): Inappropriate ioctl for device
sh: no job control in this shell
dracut:/#

-----------------------------------------------------------------------------------------------------------------------------------
Output on bootup with root=iscsi:@10.0.0.1::3260::iqn.2011-01.local:rig1
-----------------------------------------------------------------------------------------------------------------------------------

... [ misc boot information up to networking ] ...
eth0: link up.
icscistart: transport class version 2.0-872
iscsistart: Logging into iqn.2011-01.local:rig1 10.0.0.1:3268,1
iscsistart: can not connect to iSCSI daemon (111)!
iscsistart: version 2.0-872
scsi0 : iSCSI initiator over TCP/IP
iscsistart: Connection1:0 to [target: iqn.2011-01.local:rig1, portal: 10.0.0.1,3268] through [iface: default] is operational now
scsi 0:0:0:0: RAID            IET      Controller   0001 PQ: 0 ANSI: 5
scsi 0:0:0:1: Direct-Access   OURHOUSE VIRTUAL-DISK 0001 PQ: 0 ANSI: 5


<28>dracut Warning: No root device "iscsi:@10.0.0.1::3260::iqn.2011-01.local:rig1" found

Dropping to debug shell.

sh: cannot set terminal process group (-1): Inappropriate ioctl for device
sh: no job control in this shell
dracut:/#

-----------------------------------------------------------------------------------------------------------------------------------
Output of /proc/scsi/scsi after boot drops to debug shell:
-----------------------------------------------------------------------------------------------------------------------------------

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IET      Model: Controler     Rev: 0001
  Type:   RAID                          ANSI SCSI revision: 05
Host: scsi0 Channel: 00 Id: 00 Lun: 01
  Vendor: OURHOUSE Model: VIRTUAL-DISK  Rev: 0001
  Type:   Direct-Access                 ANSI SCSI revision: 05

-----------------------------------------------------------------------------------------------------------------------------------
/etc/tgt/targets.conf:
-----------------------------------------------------------------------------------------------------------------------------------

default-driver iscsi

<target iqn.2011-01.local:rig1>
    vendor_id OURHOUSE
    <backing-store /dev/ourhouse15s/rig1>
        lun 1
        scsi_sn snrig1
    </backing-store>
    allow-in-use yes
    #initiator-address 10.0.0.1
</target>

-----------------------------------------------------------------------------------------------------------------------------------
I used the kernel from the server running DHCPd and created an initrd using dracut:
-----------------------------------------------------------------------------------------------------------------------------------

dracut -m "iscsi network base" --install 'ssh sshd df fdisk' --add-drivers 'iscsi rootfs-block' initramfs-net.img

-----------------------------------------------------------------------------------------------------------------------------------
/tftpboot/pxelinux.cfg:
-----------------------------------------------------------------------------------------------------------------------------------

default menu.c32
prompt 0
timeout 100
ONTIMEOUT local

MENU TITLE PXE Menu

LABEL Scientific Linux 6.0 - iSCSI Parameter
        MENU LABEL Scientific Linux 6.0
        KERNEL images/scientific_linux/x86_64/6.0/vmlinuz
        APPEND noapic initrd=images/scientific_linux/x86_64/6.0/initrd.img root=LABEL=rig1 netroot=iscsi:10.0.0.1::3260:01:iqn.2011-01.local:rig1

-----------------------------------------------------------------------------------------------------------------------------------
/etc/dhcpd.conf:
-----------------------------------------------------------------------------------------------------------------------------------

authoritative;

default-lease-time 86400;

option domain-name "local";
option routers 10.0.0.1;
option subnet-mask 255.255.255.0;

use-host-decl-names on;

option domain-name-servers 10.0.0.1;

option time-offset -5;
option time-servers clock.redhat.com;

deny client-updates;
deny unknown-clients;

ddns-update-style ad-hoc;

option option-128 code 128 = string;
option option-129 code 129 = text;

shared-network OurHouse {
        subnet 10.0.0.0 netmask 255.255.255.0 {
                allow unknown-clients;
                range 10.0.0.101 10.0.0.240;
        }
}

group   {
        allow booting;
        allow bootp;
        next-server 10.0.0.1;
        filename "/pxelinux.0";
        host rig1 {
                hardware ethernet f4:6d:04:0f:46:62;
                fixed-address 10.0.0.90;
        }
}
