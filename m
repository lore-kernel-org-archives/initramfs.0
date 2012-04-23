From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Mon, 23 Apr 2012 18:11:54 +0200
Message-ID: <4F957F4A.6090808@redhat.com>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com> <20120420135156.GE22419@redhat.com> <1335154319.18028.14.camel@cr0> <4F95076A.9060504@redhat.com> <20120423151711.GD15561@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120423151711.GD15561-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 23.04.2012 17:17, schrieb Vivek Goyal:
> On Mon, Apr 23, 2012 at 09:40:26AM +0200, Harald Hoyer wrote:
> 
> [..]
>> Just activate the host-only mode "--hostonly" or "-H"
> 
> I tried -H but then it looks like it does not include modules required
> to mount disks passed using "--mount" option. For example, I want to 
> mount a multipath target in initramfs but I don't see multipath module
> being included.
> 
> Following is dracut command line.
> 
> dracut --add kdumpbase --add dash --add fstab-sys --add kernel-modules -c /dev/null -I /sbin/makedumpfile --hostonly --mount '/dev/mapper/vg-lv_root / ext4 rw,seclabel,relatime,user_xattr,barrier=1,data=ordered' --mount '/dev/mapper/mpathb /mnt/common ext4 rw,seclabel,relatime,user_xattr,barrier=1,data=ordered' -M -f /boot/initramfs-3.3.2-1.fc17.x86_64kdump.img 3.3.2-1.fc17.x86_64
> 
> Notice, /dev/mapper/mpathb is the multipath device.
> 
> Following is the list of modules included by dracut.
> 
> -----------------
> i18n
> rpmversion
> plymouth
> dm
> kernel-modules
> lvm
> fstab-sys
> resume
> rootfs-block
> terminfo
> udev-rules
> biosdevname
> usrmount
> base
> fs-lib
> kdumpbase
> shutdown
> -------------------
> 
> Notice it did not inclde "multipath" module.
> 
> I passed the --debug option to dracut and attaching the resulting output.
> I personally think that a new dracut option "--mount-only" might make
> sense where only those modules are included which somehow contribute to
> mounting of targets specified by "--mount".
> 
> BTW, using --hostonly gave a nice redcution in initramfs size and my
> uncomressed initramfs is around 18MB which sounds just right.
> 
> Thanks
> Vivek

oh.. multipath detection is not yet implemented for host-only... everything else
should work, though
