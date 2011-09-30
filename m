From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Fri, 30 Sep 2011 11:48:10 +0800
Message-ID: <4E853BFA.5090407@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com>	<4E8526A6.30003@redhat.com> <4E85370A.7020509@redhat.com> <4E853A1C.5070905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E853A1C.5070905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

=E4=BA=8E 2011=E5=B9=B409=E6=9C=8830=E6=97=A5 11:40, Dave Young =E5=86=99=
=E9=81=93:
> On 09/30/2011 11:27 AM, Cong Wang wrote:
>
>> =E4=BA=8E 2011=E5=B9=B409=E6=9C=8830=E6=97=A5 10:17, Dave Young =E5=86=
=99=E9=81=93:
>>> On 09/29/2011 11:18 PM, Cong Wang wrote:
>>>
>>>> =E4=BA=8E 2011=E5=B9=B409=E6=9C=8829=E6=97=A5 10:55, Dave Young =E5=
=86=99=E9=81=93:
>>>>> Hi,
>>>>>
>>>>> In current dracut modules there's still fstab-sys for mount somet=
hing
>>>>> other than root, So how about add a similar module ie. fstab-kdum=
p
>>>>> which
>>>>> contains the kdump target device/fstype, add mount-kdump.sh to mo=
unt
>>>>> all
>>>>> the stuff. For rootfs we can use dracut mount point.
>>>>
>>>> I doubt fstab-sys module could mount all kinds of block devices, e=
=2Eg.
>>>> LVM or RAID, because I see no code to detect/handle LVM/RAID in
>>>> fstab-sys
>>>> or fs-lib module.
>>>
>>>
>>> I just tried a simple lvm mount, it was skipped due to there's no d=
ev
>>> nodes. making the fstab-sys module depends on lvm also does not wor=
k,
>>> but mannually call lvm_scan in rdshell, then mannually mounting the=
 lvm
>>> volume can success
>>>
>>
>> Yeah, this is not strange, I bet you can also pass "rd_LVM_LV=3D" to
>> mount the target device.
>
>
> Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
> being called automaticlly via dependencies it will be good. OTOH fsta=
b
> is better than cmdlines as an interface for multi-target dumping

Yes, but the problem is that lvm is supposed to handle this, what
we need to do is invent some interface to tell lvm module to mount
some specified device parsed in kdump module.

>
>>
>>> So If we properly deal with the dependency issue it should be possi=
ble
>>> to resolve. There's dracut module dependency currently, but questio=
n is
>>> that is there dependency of hooks? such as make the mount-sys hook
>>> depends on the lvm setup code, is it possible with current interfac=
e?
>>>
>>
>> I don't think so, you called 'lvm_scan' and did mount manually, lvm
>> module itself will not mount it unless you add "rd_LVM_LV=3D". So, t=
his
>> a not only a problem of module dependency, but also a problem
>> of lvm module code.
>
>
> Yes, agree
>
>> For kdump, even using "rd_LVM_LV=3D" is not a good
>> choice, because we still need to convert the device name (or UUID) i=
nto
>> the correct kernel cmdline.
>
>
> not understand yet, could you help to explain or give an example?
>

Sure, for example, on my machine I need to convert /dev/mapper/vg_cr0-l=
v_home
to rd_LVM_LV=3Dvg_cr0/lv_home.
