From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 7 May 2014 15:47:33 +0400
Message-ID: <20140507154733.386369cd@work.puleglot>
References: <2263850.UM9clb02rz@skinner>
	<536A19D7.2010405@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=uBCox6TBp0IVxCy2LMaLhjEV1TEj8MDN65LLSnRvdrM=;
	b=F1dG4B6/my0YjY1uqAG+p6TPRsiuLPo3E0ug/fXWueE7U/yesIKtjy1iWOfw/kU5lwvoj/ts6OPepHdvlm6LoP79ZdE6izCnTS9Tbn71tfbgybLQtJuREcdU9iuiAsrM2kogFwB1fCwBObg7Sd6VlejXTpE5vSWSW4DWYS49p/8=;
In-Reply-To: <536A19D7.2010405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Wed, 07 May 2014 13:32:39 +0200
Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =D0=C9=DB=C5=D4:

> On 07.05.2014 13:12, Thomas Renninger wrote:
> > Hi,
> >=20
> > I wonder for what this one is exactly for?
> >=20
> > commit ab9457efd78ff74c654b4123956cdbd131935066
> > Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Date:   Tue Feb 25 12:35:32 2014 +0100
> >=20
> >     Add flag to toggle hostonly cmdline storing in the initramfs
> >    =20
> >     --hostonly-cmdline:
> >         Store kernel command line arguments needed in the initramfs
> >    =20
> >     --no-hostonly-cmdline:
> >         Do not store kernel command line arguments needed in the in=
itramfs
> >=20
> >=20
> >=20
> > Wouldn't it be enough to simply add hostonly command line parameter=
s
> > only in hostonly case like:
> > +    if [[ $hostonly =3D=3D "yes" ]]; then
> > +        cmdline  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
> > +        echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
> > +    fi
> >=20
> > why is a hostonly-cmdline extra parameter needed?
> >=20
> > Thanks,
> >=20
> >   Thomas
> >=20
>=20
> hostonly stores config files like mdadm.conf and only installs those =
kernel
> modules, which are specific to the machine.
>=20
> hostonly-cmdline also stores dracut specific kernel cmdline parameter=
s to boot
> the system in the initramfs, so that basically you could boot the sys=
tem by
> only specifying "root=3D" on the kernel cmdline.
>=20
> The advantage of hostonly-cmdline is that the kernel cmdline does not=
 need
> complex rd.md.uuid=3D... or rd.luks.uuid=3D... parameters.
>=20
> The disadvantage is that in case of uuid or disk changes, you cannot =
alter the
> parameters which are in the initramfs.
>=20
> I suggest to use the output of:
>=20
> # dracut --print-cmdline
>=20
> and add it to the kernel command line.
>=20
> hostonly-cmdline should only be used, when e.g. the maximum char limi=
t of the
> kernel command line would be reached or when the user has a generic r=
escue
> image, to be used when the disk layout changed and the user has not g=
enerated a
> new initramfs with it.
>=20
> Maybe we could let hostonly-cmdline be the default and add a paramete=
r
> "rd.cmdline.conf=3D0", which turns of parsing $initrd/etc/cmdline.d/*=
=2Econf.
>=20
> Thoughts?

Actually hostonly-cmdline is partially broken with systemd in
initramfs. For example systemd-cryptsetup-generator does not
read /etc/cmdline.d/*.conf files, so rd.luks* parameters must be
appended to kernel cmdline anyway.

--=20
Alexander Tsoy
