From: Jan Engelhardt <jengelh-9+2X+4sQBs8@public.gmane.org>
Subject: dracut: fails to copy udev rules to initramfs
Date: Sat, 9 Jan 2016 01:08:38 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1601090036500.20214@nerf40.vanv.qr>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


dracut 044 (and prior versions) only copy a handful of .rules files to 
the initramfs, the exact list of which is in 
/usr/lib/dracut/modules.d/95udev-rules/module-setup.sh. Copying only 
half of the files leads to a problem with regard to object naming
in certain systems.


Suppose there is a deliberately-placed file 
/etc/udev/rules.d/70-net.rules with:

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", 
ATTR{address}=="52:54:00:12:34:56", ATTR{type}=="1", KERNEL=="eth*", 
NAME="ex7"

(52:.. substituted as appropriate per system)

In case of a Thinkpad system (happens to have dracut 037):
* the e1000e.ko module is not copied to the initramfs
* e1000e.ko gets loaded after switching to real root
* in the real root, 70-net.rules is available and processed.
=> ex7 name

In case of a QEMU system (with dracut 044):
* the virtio_net.ko module is copied to the initramfs
* virtio_net.ko gets loaded by initramfs udev
* no 70-net.rules inside initramfs, default net_id naming comes in.
=> ens3 name

Why is dracut copying virtio_net.ko? I have no idea, it does not tell by 
default. Keeping in mind that there are also scenarios with root-on-NFS 
and such, the presence of NIC modules inside initramfs has to be taken 
into account, and with that, this leads me to lean in the direction that 
dracut ought to copy all .rules files, in particular those from /etc.

Counterarguments?
