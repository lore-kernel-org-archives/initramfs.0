From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 09:32:20 +0200
Message-ID: <1313739140.2981.19.camel@eagle.danny.cz>
References: <4E4D5779.6090209@bitwagon.com>
	 <CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com>
	 <4E4D9B9F.9030001@bitwagon.com> <j2kq7p$guf$1@dough.gmane.org>
	 <4E4E0707.4060504@redhat.com>
	 <CAM_iQpUr2mVRM+PFeYkefzx9xEAOJKhZh+wpaXgKg6bj+1dozQ@mail.gmail.com>
	 <4E4E0B95.6040909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4E0B95.6040909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer p=C3=AD=C5=A1e v P=C3=A1 19. 08. 2011 v 09:07 +0200:=20
> On 19.08.2011 09:04, Am=C3=A9rico Wang wrote:
> > On Fri, Aug 19, 2011 at 2:47 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> w=
rote:
> >> On 19.08.2011 06:53, WANG Cong wrote:
> >>> As a kdump developer, I worry more about the size of initramfs ge=
nerated
> >>> by dracut, because we have very limited memory (usually 128M or 2=
56M)
> >>> in the second kernel. So, the output of `lsinitrd test2.img` woul=
d
> >>> be helpful too.
> >>>
> >>> Thanks.
> >>
> >> Maybe you should build your kdump kernel with the "hostonly" optio=
n, which will
> >> significantly reduce your initramfs.
> >>
> >=20
> > Yeah, that does help, but the size is still large, see below
> >=20
> > [root@nec-em18 ~]# dracut -H -M -f test.img --force-add nfs
> > dash
> > i18n
> > rpmversion
> > network
> > ifcfg
> > plymouth
> > dm
> > kernel-modules
> > lvm
> > nfs
> > resume
> > rootfs-block
> > terminfo
> > udev-rules
> > biosdevname
> > base
> > fs-lib
> > shutdown
> > [root@nec-em18 ~]# ls -lh test.img
> > -rw-r--r--. 1 root root 11M Aug 19 03:00 test.img
> >=20
> > Also note, there are still some unneeded modules get included, e.g.=
 i18n
> > and plymouth.
> >=20
> > Therefore, I choose to use -m and -a to specify the modules we real=
ly need.
>=20
> Absolutely! You don't want plymouth and shutdown for example in your =
kdump
> initramfs :-)

and maybe you can use --filesystems too,
http://fedora.danny.cz/arm/dracut.conf is an example of dracut config I
use for preparing size-limited initramfs images for my Fedora/ARM
devices


Dan

