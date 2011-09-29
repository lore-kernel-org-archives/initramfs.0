From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Thu, 29 Sep 2011 23:18:32 +0800
Message-ID: <4E848C48.6050506@redhat.com>
References: <4E83DE33.4020204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E83DE33.4020204-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

=E4=BA=8E 2011=E5=B9=B409=E6=9C=8829=E6=97=A5 10:55, Dave Young =E5=86=99=
=E9=81=93:
> Hi,
>
> In current dracut modules there's still fstab-sys for mount something
> other than root, So how about add a similar module ie. fstab-kdump wh=
ich
> contains the kdump target device/fstype, add mount-kdump.sh to mount =
all
> the stuff. For rootfs we can use dracut mount point.

I doubt fstab-sys module could mount all kinds of block devices, e.g.
LVM or RAID, because I see no code to detect/handle LVM/RAID in fstab-s=
ys
or fs-lib module.

>
> As discussion in mail archive I see nfs is a main problem for this
> issue. I did not understand why nfs is special, could someone explain=
 a bit?
>

Yeah, one reason that I can remember is that it depends on network modu=
le
which handles root device per nic.

But, we certainly want to find a way to handle non-root devices no matt=
er
which kind it is, and a generic interface to express that we want to mo=
unt
some specific devices and let dracut to handle the module dependencies.

Thanks.
