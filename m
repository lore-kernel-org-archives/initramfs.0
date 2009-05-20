From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: 90kernel-modules/install should not detect from current system
Date: Wed, 20 May 2009 15:38:23 -0400
Message-ID: <4A145C2F.4040202@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

bash-4.0# ./dracut -l -f /boot/initrd-2.6.29.3-140.fc11.i586.img 
2.6.29.3-140.fc11.i586
ldd: /proc/8072/exe: No such file or directory
./modules.d/90kernel-modules/install: line 8: /proc/mounts: No such file 
or directory
58848 blocks

#!/bin/bash
# FIXME: hard-coded module list of doom.
instmods ${modules:-=ata =block sd_mod =fs}

# Grab modules for all filesystem types we currently have mounted
while read d mp t rest; do
     instmods "$t"
done </proc/mounts

We shouldn't be relying on the running system to decide what payload 
goes into the initrd.  In this case we see an error message during 
dracut because this is a chroot without /proc mounted.  Shouldn't we be 
including all filesystem drivers if we want the standard dracut output 
to boot anything?

We should rely on system detection only for --hostonly mode.

Thoughts?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
