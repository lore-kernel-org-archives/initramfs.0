From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] fstab: do not mount and fsck from fstab if using
	systemd
Date: Tue, 01 Apr 2014 11:06:01 +0400
Message-ID: <1396335961.11970.4.camel@Nokia-N900>
References: <20140401051913.GA644@dhcp-17-89.nay.redhat.com>
Reply-To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Message-Id:Date:Content-ID:Content-Type:In-Reply-To:References:Subject:Cc:To:Reply-To:From; bh=LDMoVM4n+duYnBfJBddM5dOAamYAvKZ/+3Ty8FzGavQ=;
	b=EuffqxUxpj8bpFaA6NPbbjTizQnu/ssM5yZDqctdQ6f9EvKh0gsSzWy0KoIoBdVdDpb2sYeXCZ1ZV61G1T+HFjqApnZhzvJtRzQzEZObLJhwq36B58TcqMq4O8BPzWSIh1TgbnLGRftyi32yIhUxLEhSeguPxqMUs5esIoNkS2U=;
In-Reply-To: <20140401051913.GA644-2coKmSd1Zb6BYdNaKHuJJRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Content-ID: <1396335960.11970.3.camel@Nokia-N900>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue Apr=C2=A0  1 09:19:13 2014 WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> If using systemd in initramfs, we could run into a race condition whe=
n
> dracut and systemd both are trying to mount and run fsck for the same
> filesystem, and mount or fsck could be a failure.
>=20
> To fix such failure, we should use systemd to mount/fsck from /etc/fs=
tab
> only.
>=20
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>=C2=A0  modules.d/95fstab-sys/mount-sys.sh | 6 +++++-
>=C2=A0  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/modules.d/95fstab-sys/mount-sys.sh
> b/modules.d/95fstab-sys/mount-sys.sh index 12711a0..d65cafd 100755
> --- a/modules.d/95fstab-sys/mount-sys.sh
> +++ b/modules.d/95fstab-sys/mount-sys.sh
> @@ -27,7 +27,11 @@ fstab_mount() {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  return 0
>=C2=A0  }
>=C2=A0 =20
> -[ -f /etc/fstab ] && fstab_mount /etc/fstab
> +# systemd will mount and run fsck from /etc/fstab and we don't want =
to
> +# run into a race condition.
> +if [ `readlink -f /init` !=3D '/usr/lib/systemd/systemd' ]; then

It's better to test DRACUT_SYSTEMD variable here:

if [ -z "$DRACUT_SYSTEMD" ]; then

> +=C2=A0 =C2=A0 =C2=A0  [ -f /etc/fstab ] && fstab_mount /etc/fstab
> +fi
>=C2=A0 =20
>=C2=A0  # prefer $NEWROOT/etc/fstab.sys over local /etc/fstab.sys
>=C2=A0  if [ -f $NEWROOT/etc/fstab.sys ]; then
> --=20
> 1.8.5.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info.h=
tml

--=20
Alexander Tsoy
