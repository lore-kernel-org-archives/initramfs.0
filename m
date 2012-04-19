From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Thu, 19 Apr 2012 12:57:13 +0800
Message-ID: <1334811433.31095.5.camel@cr0>
References: <20120418222829.GG2224@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418222829.GG2224-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, 2012-04-18 at 18:28 -0400, Vivek Goyal wrote:
> Hi,
> 
> I am trying to dump kernel vmcore to an software iscsi target (kdump).
> kdump specifies the dump destination using "--mount" option. But dracut
> does not even include the "iscsi" module and associated device is not
> mounted in second kernel.
> 
> Following is the dracut command line as called by /sbin/mkdumprd.
> 
> dracut -m kdumpbase --add dash --add fstab-sys --add kernel-modules -c /dev/null -I /sbin/makedumpfile --mount '/dev/mapper/vg-lv_root / ext4 rw,seclabel,relatime,user_xattr,barrier=1,data=ordered' --mount '/dev/mapper/mpatha /mnt/common ext4 rw,seclabel,relatime,user_xattr,barrier=1,stripe=16,data=ordered' -M -f /boot/initramfs-3.3.2-1.fc17.x86_64kdump.img 3.3.2-1.fc17.x86_64
> 
> Note there is a multipath target over iscsi devices and that target is
> mounted on /mnt/common. Hence specified using "--mount /dev/mapper/mpatha
> /mnt/common"
> 
> Following is list of modules being included by dracut (printed on standard
> output due to -M option).
> 
> rpmversion
> dm
> kernel-modules
> lvm
> multipath
> fstab-sys
> rootfs-block
> udev-rules
> base
> fs-lib
> kdumpbase
> shutdown
> 
> I thought that once you specify a mount using "--mount" option, dracut
> will traverse through the full device stack, figure out all the
> dependencies, include all the modules and bring up the full stack in 
> the kernel and mount the top level device. Is that not the case?
> 
> BTW,  I have done testing with multipath targets (without iscsi) and
> it works. So multipath is not the issue. But iscsi is.

I think this is a bug, dracut fails to detect iscsi thus doesn't include
the iscsi module.

Vivek, can you try to add 'set -x' in the check() function in
module-setup.sh of iscsi module to get some debugging info? Especially
is_iscsi().

Thanks for testing!
