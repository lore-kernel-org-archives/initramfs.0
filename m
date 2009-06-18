From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Files copied from generating system
Date: Thu, 18 Jun 2009 16:25:46 -0400
Message-ID: <4A3AA2CA.7000507@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

We can't really predict the behavior of or support initrd's that end up 
with whatever customized config files are copied from the system, but 
options for dealing with this problem are not clear.  Any ideas?

modules.d/95nfs/install:
> /etc/nsswitch.conf
> /etc/idmapd.conf

These could possibly be edited and cause NFS to behave unexpectedly in 
the initrd.

(Harald and I agree we should write the needed user to /etc/passwd 
during dracut generation instead of copying the /etc/passwd.  I'm 
working on this.)

modules.d/90kernel-modules/install:
> [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
> dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')

Some of these are shipped by the distribution and important, but others 
can be edited and cause the initrd to behave differently.

modules.d/90mdraid/install:
> #!/bin/bash
> dracut_install mdadm
> inst /etc/passwd
> inst /etc/group

With agreement from Harald we're writing these during dracut generation 
instead of copying.

> instmods =drivers/md
> inst_rules "$moddir/61-mdadm.rules"
> [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
> [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
> if [ -x  /sbin/mdmon ] ; then
>     dracut_install mdmon
>     inst_hook pre-pivot 30 "$moddir/mdmon-pre-pivot.sh"
> fi

mdadm.conf is another file that can influence the behavior of a system. 
  Shouldn't this be --hostonly?

Is dracut mdraid module usable at all without mdadm.conf?  I've used 
many RAID systems without mdadm.conf, although I don't understand why 
some systems seemingly need it while others don't.

modules.d/95udev-rules/install:
> #!/bin/bash
> # FIXME: would be nice if we didn't have to know which rules to grab....
> # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
> # of the rules we want so that we just copy those in would be best
> dracut_install udevd udevadm /lib*/udev/*_id /etc/udev/udev.conf /etc/group
> dracut_install basename
> inst_rules 50-udev-default.rules 60-persistent-storage.rules \
>     61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rules
> #Some debian udev rules are named differently
> inst_rules 50-udev.rules 95-late.rules
>
> if ldd $(find_binary udevd) |grep -q /lib64/libc; then
>     dracut_install /lib64/libnss_files*
> else
>     dracut_install /lib/libnss_files*
> fi

udev.conf could be another source of unexpected behavior?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
