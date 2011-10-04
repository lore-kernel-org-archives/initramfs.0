From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Tue, 04 Oct 2011 11:13:16 +0800
Message-ID: <4E8A79CC.3080109@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com> <4E8526A6.30003@redhat.com> <4E85370A.7020509@redhat.com> <4E853A1C.5070905@redhat.com> <20110930183839.GF25891@redhat.com> <20110930190311.GH25891@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110930190311.GH25891-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

=E4=BA=8E 2011=E5=B9=B410=E6=9C=8801=E6=97=A5 03:03, Vivek Goyal =E5=86=
=99=E9=81=93:
> On Fri, Sep 30, 2011 at 02:38:39PM -0400, Vivek Goyal wrote:
>> On Fri, Sep 30, 2011 at 11:40:12AM +0800, Dave Young wrote:
>>
>> [..]
>>>
>>> Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
>>> being called automaticlly via dependencies it will be good. OTOH fs=
tab
>>> is better than cmdlines as an interface for multi-target dumping
>>
>> Agreed that fstab.sys looks like a good interface to mouting non-roo=
t devices.
>
> Having said that, looks like dracut builds all the state using comman=
d
> line options. All the lvms, iscsi root, fcoe targets etc. So they mig=
ht
> expect everything to be passed on command line. In that case it will
> become hard from kdump perspective.

Yeah, the problem is that we still need to detect which module is neede=
d
to mount some specified device, which is duplicated, as the code is alr=
eady
in these modules (e.g. is_lvm()).

Thanks.
