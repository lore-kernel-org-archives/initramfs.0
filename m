From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>
Subject: Re: dracut: fails to copy udev rules to initramfs
Date: Mon, 11 Jan 2016 11:11:41 +0100
Message-ID: <37246061.WcLcQ4omHC@linux-lm3i.site>
References: <alpine.LSU.2.20.1601090036500.20214@nerf40.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LSU.2.20.1601090036500.20214-Og55a6x16tXH9RFtKMg/Ng@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Jan Engelhardt <jengelh-9+2X+4sQBs8@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jan Engelhardt wrote:
> dracut 044 (and prior versions) only copy a handful of .rules files to 
> the initramfs, the exact list of which is in 
> /usr/lib/dracut/modules.d/95udev-rules/module-setup.sh. Copying only 
> half of the files leads to a problem with regard to object naming
> in certain systems.
> 
> 
> Suppose there is a deliberately-placed file 
> /etc/udev/rules.d/70-net.rules with:
> 
> SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", 
> ATTR{address}=="52:54:00:12:34:56", ATTR{type}=="1", KERNEL=="eth*", 
> NAME="ex7"
> 
> (52:.. substituted as appropriate per system)
> 
> In case of a Thinkpad system (happens to have dracut 037):
> * the e1000e.ko module is not copied to the initramfs
> * e1000e.ko gets loaded after switching to real root
> * in the real root, 70-net.rules is available and processed.
> => ex7 name
> 
> In case of a QEMU system (with dracut 044):
> * the virtio_net.ko module is copied to the initramfs
> * virtio_net.ko gets loaded by initramfs udev
> * no 70-net.rules inside initramfs, default net_id naming comes in.
> => ens3 name
> 
> Why is dracut copying virtio_net.ko? I have no idea, it does not tell by 
> default. 
Seems to be a bug, 90qemu-net should be treated
the same as 90kernel-network-modules or even merged into it.

> Keeping in mind that there are also scenarios with root-on-NFS 
> and such, the presence of NIC modules inside initramfs has to be taken 
> into account, and with that, this leads me to lean in the direction that 
> dracut ought to copy all .rules files, in particular those from /etc.
> 
> Counterarguments?
That would fix
    # Fixme: would be nice if we didn't have to guess, which rules to grab....
    # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
    # of the rules we want so that we just copy those in would be best
from 95udev-rules/module-setup.sh.
I see an issue though, what if a udev rule references an external file?
I'd say that adding a parameter to dracut.conf(.d) or the addition of a symlink
dir like the #Fixme mentions is the best option.
