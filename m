From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: sysroot not mounted in case several rootflags=subvol=@ boot
 params are passed
Date: Mon, 20 Jan 2014 23:40:54 +0400
Message-ID: <20140120234054.1f45a631@home.puleglot>
References: <2256706.I9F4d4aePX@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=CzXBEiPIy6smkgWobE/GlJumkAGi7ybmFDpU4dG+OxM=;
	b=BR7lO4x2HyGYFLx1qih75ldx5SID1mjbThxu7Wn+qS+L0/HQTk1QNR+Oen5MabQtLQ7twps3lSel0BxA7N9R2PsuYMpugyMPXYoeMoTgN/EVeDo5AzSG9dj3y2sCeL4QtokfLAQW2L7CsxLDMESsW6KUQOZ9gK3gvzzO7wcTuxo=;
In-Reply-To: <2256706.I9F4d4aePX@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Mon, 20 Jan 2014 17:41:10 +0100
Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=C9=DB=C5=D4:

> Hi,
>=20
> due to a bug in another tool it came out that
> systemd/dracut cannot mount /sysroot if the same rootflags=3D
> parameter is passed twice:
> rootflags=3Dsubvol=3D@ rootflags=3Dsubvol=3D@
>=20
> Yep, this should be fixed somewhere else, but I still
> like to make the /sysroot mount more robust or at least find
> out what what is going on more detailed.
>=20
> journalctl -b -u  sysroot.mount
> Jan 20 15:02:30 localhost systemd[1]: Failed to mount /sysroot.
> Jan 20 15:02:30 localhost systemd[1]: Unit sysroot.mount entered
> failed state. Jan 20 15:16:46 localhost systemd[1]:
> Mounting /sysroot... Jan 20 15:16:46 localhost mount[970]: mount:
> wrong fs type, bad option, bad superblock on /dev/vda2, Jan 20
> 15:16:46 localhost systemd[1]: sysroot.mount mount process exited,
> code=3Dexited status=3D32
>=20
>=20
> It looks like in
> modules.d/99base/parse-root-opts.sh
> rflags is made to "subvol=3D@,subvol=3D@"
> and
> modules.d/95rootfs-block/mount-root.sh
> fails due to passing this as -o to mount?
>=20
> But what I am mostly missing is any dracut warning.
> I should see:
> modules.d/95rootfs-block/mount-root.sh:
>     while ! mount -t ${rootfs} -o "$_rflags_ro" "${root#block:}"
> "$NEWROOT"; do warn "Failed to mount -t ${rootfs} -o $_rflags_ro
> ${root#block:} $NEWROOT" fsck_ask_err
>     done
> ?

No. In your case rootflags are handled by systemd-fstab-generator.
Comment from systemd sources (src/fstab-generator/fstab-generator.c):

/* root=3D and roofstype=3D may occur more than once, the last instance
should take precedence.
 * In the case of multiple rootflags=3D the arguments should be
concatenated */

You can see the generated mount unit from emergency shell. It should be
located here:
/run/systemd/generator/sysroot.mount

>=20
> This would give an obvios hint what is going wrong.
>=20
> But I cannot find where "warn" is even defined.
>=20
> Could be that I came on the wrong track somewhere.
> I guess there cannot be made much against passing bad (or doubled)
> rootflags=3D options, things will simply fail then, right?
>=20
> Still it would be nice if someone can give me a hint how I can
> debug similar stuff easier next time.
>=20
> Thanks!
>=20
>     Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"
> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Alexander Tsoy
