From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Fri, 30 Sep 2011 11:40:12 +0800
Message-ID: <4E853A1C.5070905@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com>	<4E8526A6.30003@redhat.com> <4E85370A.7020509@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E85370A.7020509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 09/30/2011 11:27 AM, Cong Wang wrote:

> =E4=BA=8E 2011=E5=B9=B409=E6=9C=8830=E6=97=A5 10:17, Dave Young =E5=86=
=99=E9=81=93:
>> On 09/29/2011 11:18 PM, Cong Wang wrote:
>>
>>> =E4=BA=8E 2011=E5=B9=B409=E6=9C=8829=E6=97=A5 10:55, Dave Young =E5=
=86=99=E9=81=93:
>>>> Hi,
>>>>
>>>> In current dracut modules there's still fstab-sys for mount someth=
ing
>>>> other than root, So how about add a similar module ie. fstab-kdump
>>>> which
>>>> contains the kdump target device/fstype, add mount-kdump.sh to mou=
nt
>>>> all
>>>> the stuff. For rootfs we can use dracut mount point.
>>>
>>> I doubt fstab-sys module could mount all kinds of block devices, e.=
g.
>>> LVM or RAID, because I see no code to detect/handle LVM/RAID in
>>> fstab-sys
>>> or fs-lib module.
>>
>>
>> I just tried a simple lvm mount, it was skipped due to there's no de=
v
>> nodes. making the fstab-sys module depends on lvm also does not work=
,
>> but mannually call lvm_scan in rdshell, then mannually mounting the =
lvm
>> volume can success
>>
>=20
> Yeah, this is not strange, I bet you can also pass "rd_LVM_LV=3D" to
> mount the target device.


Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
being called automaticlly via dependencies it will be good. OTOH fstab
is better than cmdlines as an interface for multi-target dumping

>=20
>> So If we properly deal with the dependency issue it should be possib=
le
>> to resolve. There's dracut module dependency currently, but question=
 is
>> that is there dependency of hooks? such as make the mount-sys hook
>> depends on the lvm setup code, is it possible with current interface=
?
>>
>=20
> I don't think so, you called 'lvm_scan' and did mount manually, lvm
> module itself will not mount it unless you add "rd_LVM_LV=3D". So, th=
is
> a not only a problem of module dependency, but also a problem
> of lvm module code.


Yes, agree

>For kdump, even using "rd_LVM_LV=3D" is not a good
> choice, because we still need to convert the device name (or UUID) in=
to
> the correct kernel cmdline.


not understand yet, could you help to explain or give an example?

>=20
> If some hook need some other module, then the whole module itself sho=
uld
> depend on that module, which can be expressed in depend().
>=20



--=20
Thanks
Dave
