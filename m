From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Fri, 30 Sep 2011 10:17:10 +0800
Message-ID: <4E8526A6.30003@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E848C48.6050506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 09/29/2011 11:18 PM, Cong Wang wrote:

> =E4=BA=8E 2011=E5=B9=B409=E6=9C=8829=E6=97=A5 10:55, Dave Young =E5=86=
=99=E9=81=93:
>> Hi,
>>
>> In current dracut modules there's still fstab-sys for mount somethin=
g
>> other than root, So how about add a similar module ie. fstab-kdump w=
hich
>> contains the kdump target device/fstype, add mount-kdump.sh to mount=
 all
>> the stuff. For rootfs we can use dracut mount point.
>=20
> I doubt fstab-sys module could mount all kinds of block devices, e.g.
> LVM or RAID, because I see no code to detect/handle LVM/RAID in fstab=
-sys
> or fs-lib module.


I just tried a simple lvm mount, it was skipped due to there's no dev
nodes. making the fstab-sys module depends on lvm also does not work,
but mannually call lvm_scan in rdshell, then mannually mounting the lvm
volume can success

So If we properly deal with the dependency issue it should be possible
to resolve. There's dracut module dependency currently, but question is
that is there dependency of hooks? such as make the mount-sys hook
depends on the lvm setup code, is it possible with current interface?

>=20
>>
>> As discussion in mail archive I see nfs is a main problem for this
>> issue. I did not understand why nfs is special, could someone explai=
n
>> a bit?
>>
>=20
> Yeah, one reason that I can remember is that it depends on network mo=
dule
> which handles root device per nic.
>=20
> But, we certainly want to find a way to handle non-root devices no ma=
tter
> which kind it is, and a generic interface to express that we want to =
mount
> some specific devices and let dracut to handle the module dependencie=
s.
>=20
> Thanks.



--=20
Thanks
Dave
