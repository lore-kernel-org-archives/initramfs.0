From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 09:07:01 +0200
Message-ID: <4E4E0B95.6040909@redhat.com>
References: <4E4D5779.6090209@bitwagon.com> <CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com> <4E4D9B9F.9030001@bitwagon.com> <j2kq7p$guf$1@dough.gmane.org> <4E4E0707.4060504@redhat.com> <CAM_iQpUr2mVRM+PFeYkefzx9xEAOJKhZh+wpaXgKg6bj+1dozQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM_iQpUr2mVRM+PFeYkefzx9xEAOJKhZh+wpaXgKg6bj+1dozQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 19.08.2011 09:04, Am=C3=A9rico Wang wrote:
> On Fri, Aug 19, 2011 at 2:47 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wro=
te:
>> On 19.08.2011 06:53, WANG Cong wrote:
>>> As a kdump developer, I worry more about the size of initramfs gene=
rated
>>> by dracut, because we have very limited memory (usually 128M or 256=
M)
>>> in the second kernel. So, the output of `lsinitrd test2.img` would
>>> be helpful too.
>>>
>>> Thanks.
>>
>> Maybe you should build your kdump kernel with the "hostonly" option,=
 which will
>> significantly reduce your initramfs.
>>
>=20
> Yeah, that does help, but the size is still large, see below
>=20
> [root@nec-em18 ~]# dracut -H -M -f test.img --force-add nfs
> dash
> i18n
> rpmversion
> network
> ifcfg
> plymouth
> dm
> kernel-modules
> lvm
> nfs
> resume
> rootfs-block
> terminfo
> udev-rules
> biosdevname
> base
> fs-lib
> shutdown
> [root@nec-em18 ~]# ls -lh test.img
> -rw-r--r--. 1 root root 11M Aug 19 03:00 test.img
>=20
> Also note, there are still some unneeded modules get included, e.g. i=
18n
> and plymouth.
>=20
> Therefore, I choose to use -m and -a to specify the modules we really=
 need.

Absolutely! You don't want plymouth and shutdown for example in your kd=
ump
initramfs :-)
