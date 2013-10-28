From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Mon, 28 Oct 2013 16:45:37 +0400
Message-ID: <20131028164537.5e464c82@work.puleglot>
References: <5253DD0C.7050506@redhat.com>
	<l4dk8e$fv8$1@ger.gmane.org>
	<526A7412.8030804@redhat.com>
	<20131028134216.049c6a01@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date; bh=kzv/Z7Utg2al6nbvvbc1IjmdqxlAwJhQ4kU7KQ9IVfo=;
	b=Y9lXYoq01g6LYgqGGWSLZQ+OGt4xjfbxXuF94PkIk6WdrwPRky+OQ83miV8TvC0KbJEWNRmu/O9+RA6nvSDKG8OXXcZ5AO7dizFNrCkYQ8Qy6cH5ryY4mHv8H6mDUns0IYftb5WSZrgZC42KzGIbLky8dcnthwOew3Hey/rOcIQ=;
In-Reply-To: <20131028134216.049c6a01-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Mon, 28 Oct 2013 13:42:16 +0400
Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> =D0=C9=DB=C5=D4:

> =F7 Fri, 25 Oct 2013 15:37:22 +0200
> Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =D0=C9=DB=C5=D4:
>=20
> > On 10/25/2013 01:22 PM, EatDirt wrote:
> > > On 08/10/13 12:23, Harald Hoyer wrote:
> > >> Here comes a new dracut version. Thanks to all who have contribu=
ted to this
> > >> release.
> > >=20
> > > Hi guys,
> > > sorry if this is not the right place to post, but we have some pr=
oblems with mga
> > > distributed dracut-034
> > >=20
> > > For users having two partitions / and /usr; specified in their /e=
tc/fstab,
> > > without including systemd module, dracut does not automatically i=
ncludes the
> > > necessary usrmount module.
> > >=20
> > > Without usrmount, the initrd yields a kernel panics at boot time.=
 I naively
> > > though that dracut would automatically take care of the partition=
s specified in
> > > /etc/fstab and therefore "sees" that without systemd added, usrmo=
unt must be
> > > present.
> > >=20
> > > Do you think it is a dracut bug, or we should take care of this a=
t the "distro"
> > > packaging level?
> > >=20
> > > Thanks for your help!
> > >=20
> > > cheers,
> > > chris.
> > >=20
> > >=20
> > > PS: the mga full bug report is there (check the last posts):
> > >=20
> > > https://bugs.mageia.org/show_bug.cgi?id=3D11292
> > >=20
> >=20
> > Hmmm, the usrmount module is automatically included, if /sbin/init =
is on /usr.
> > If it is not on /usr, normally /sbin/init can mount /usr via fstab.
> >=20
>=20
> But this logic breaks systems with separate (not merged) /usr. Accord=
ing
> to [1], /usr should be always mounted inside initramfs. For example,
> openrc in Gentoo launches udev before mounting filesystems via fstab.

Same applies to systemd installed in "/". I think there are only 2
cases when usrmount module can be omitted:
1. systemd module is included
2. hostonly + non-separate /usr

>=20
> Sorry for offtop. :)
>=20
> [1] http://freedesktop.org/wiki/Software/systemd/separate-usr-is-brok=
en/
>=20

--=20
Alexander Tsoy
