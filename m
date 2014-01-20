From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: sysroot not mounted in case several rootflags=subvol=@ boot
	params are passed
Date: Tue, 21 Jan 2014 00:40:47 +0400
Message-ID: <1390250447.25863.2.camel@Nokia-N900>
References: <2256706.I9F4d4aePX@skinner>
	  <20140120234054.1f45a631@home.puleglot>
Reply-To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Message-Id:Date:Content-ID:Content-Type:In-Reply-To:References:Subject:Cc:To:Reply-To:From; bh=0d/0DVV6n/V5nTgqppioIOxntYRJXCFErIGIUIV9EYU=;
	b=dTpA5pNSQHVwc5a2/RWhh2VewlU4DhZsUZhw37XiqBtmPvQicHKEoHq0/U/FgZV4ULD2ne+C5X3zcjDl4+siabOStVq65OIf+blTbkefwMu7FPYwIXqt7W0W5m2ty9mNB92VnZBeI2nB3pDtvSD2rXtjEczInaBOErRX9p3P0Pg=;
In-Reply-To: <20140120234054.1f45a631-gl4+DzqHFJLpx9ONITL1FA@public.gmane.org>
Content-ID: <1390250447.25863.1.camel@Nokia-N900>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon Jan 20 23:40:54 2014 Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> wrote:
> =D0=92 Mon, 20 Jan 2014 17:41:10 +0100
> Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> > Hi,
> >=20
> > due to a bug in another tool it came out that
> > systemd/dracut cannot mount /sysroot if the same rootflags=3D
> > parameter is passed twice:
> > rootflags=3Dsubvol=3D@ rootflags=3Dsubvol=3D@
> >=20
> > Yep, this should be fixed somewhere else, but I still
> > like to make the /sysroot mount more robust or at least find
> > out what what is going on more detailed.
> >=20
> > journalctl -b -u=C2=A0  sysroot.mount
> > Jan 20 15:02:30 localhost systemd[1]: Failed to mount /sysroot.
> > Jan 20 15:02:30 localhost systemd[1]: Unit sysroot.mount entered
> > failed state. Jan 20 15:16:46 localhost systemd[1]:
> > Mounting /sysroot... Jan 20 15:16:46 localhost mount[970]: mount:
> > wrong fs type, bad option, bad superblock on /dev/vda2, Jan 20
> > 15:16:46 localhost systemd[1]: sysroot.mount mount process exited,
> > code=3Dexited status=3D32
> >=20
> >=20
> > It looks like in
> > modules.d/99base/parse-root-opts.sh
> > rflags is made to "subvol=3D@,subvol=3D@"
> > and
> > modules.d/95rootfs-block/mount-root.sh
> > fails due to passing this as -o to mount?
> >=20
> > But what I am mostly missing is any dracut warning.
> > I should see:
> > modules.d/95rootfs-block/mount-root.sh:
> > while ! mount -t ${rootfs} -o "$_rflags_ro" "${root#block:}"
> > "$NEWROOT"; do warn "Failed to mount -t ${rootfs} -o $_rflags_ro
> > ${root#block:} $NEWROOT" fsck_ask_err
> > done
> > ?
>=20
> No. In your case rootflags are handled by systemd-fstab-generator.

And, of course, systemd is actually mounting root fs, not the mount-roo=
t.sh script.

> Comment from systemd sources (src/fstab-generator/fstab-generator.c):
>=20
> /* root=3D and roofstype=3D may occur more than once, the last instan=
ce
> should take precedence.
>=C2=A0  * In the case of multiple rootflags=3D the arguments should be
> concatenated */
>=20
> You can see the generated mount unit from emergency shell. It should =
be
> located here:
> /run/systemd/generator/sysroot.mount
>=20
> >=20
> > This would give an obvios hint what is going wrong.
> >=20
> > But I cannot find where "warn" is even defined.
> >=20
> > Could be that I came on the wrong track somewhere.
> > I guess there cannot be made much against passing bad (or doubled)
> > rootflags=3D options, things will simply fail then, right?
> >=20
> > Still it would be nice if someone can give me a hint how I can
> > debug similar stuff easier next time.
> >=20
> > Thanks!

--=20
Alexander Tsoy
