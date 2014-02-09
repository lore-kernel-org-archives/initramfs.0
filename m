From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] Cryptroot-ask.sh: Use variables consistently
Date: Sun, 09 Feb 2014 23:37:56 +0400
Message-ID: <1391974676.27942.2.camel@Nokia-N900>
References: <1391933322-17308-1-git-send-email-opensource@till.name>
Reply-To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Message-Id:Date:Content-ID:Content-Type:In-Reply-To:References:Subject:To:Reply-To:From; bh=K7KVjNmvYnSWCk1L23fn+gM8/nyc4H/QKTsavJ8k2tg=;
	b=e6C9gMX95yxWl8NKuJ4nI7ZyKJbVg8Svayei0HJ24Xp43Rdt3QFGBpzsPpZrTxcnK+LQeByXIEQUdWpMxfuWdkfFQv+mX2sp3FqoE2akGRX8ZkhjXHYy5kzfUx9IxFhRw1uhc+sDc8wTtSq1YjF52hKEGp/Lbi6afp869AIP3qc=;
In-Reply-To: <1391933322-17308-1-git-send-email-opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>
Content-ID: <1391974675.27942.1.camel@Nokia-N900>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun Feb=C2=A0  9 12:08:42 2014 Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org> wrot=
e:
> - Always use $luksname instead of sometimes $2
> - define $asked_file instead of using the same path twice
> ---
>=C2=A0  modules.d/90crypt/cryptroot-ask.sh | 14 ++++++++------
>=C2=A0  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/modules.d/90crypt/cryptroot-ask.sh
> b/modules.d/90crypt/cryptroot-ask.sh index 9665e48..1ab03bc 100755
> --- a/modules.d/90crypt/cryptroot-ask.sh
> +++ b/modules.d/90crypt/cryptroot-ask.sh
> @@ -8,19 +8,21 @@ NEWROOT=3D${NEWROOT:-"/sysroot"}
>=C2=A0  # do not ask, if we already have root
>=C2=A0  [ -f $NEWROOT/proc ] && exit 0
>=C2=A0 =20
> +# default luksname - luks-UUID
> +luksname=3D$2
> +
>=C2=A0  # check if destination already exists
> -[ -b /dev/mapper/$2 ] && exit 0
> +[ -b /dev/mapper/luksname ] && exit 0

Here is a typo.

[ -b /dev/mapper/$luksname ] && exit 0

>=C2=A0 =20
>=C2=A0  # we already asked for this device
> -[ -f /tmp/cryptroot-asked-$2 ] && exit 0
> +asked_file=3D/tmp/cryptroot-asked-$luksname
> +[ -f $asked_file ] && exit 0
>=C2=A0 =20
>=C2=A0  # load dm_crypt if it is not already loaded
>=C2=A0  [ -d /sys/module/dm_crypt ] || modprobe dm_crypt
>=C2=A0 =20
>=C2=A0  . /lib/dracut-crypt-lib.sh
>=C2=A0 =20
> -# default luksname - luks-UUID
> -luksname=3D$2
>=C2=A0 =20
>=C2=A0  # fallback to passphrase
>=C2=A0  ask_passphrase=3D1
> @@ -45,7 +47,7 @@ if [ -f /etc/crypttab ] && getargbool 1
> rd.luks.crypttab -d -n rd_NO_CRYPTTAB; t=20
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  # UUID=
 used in crypttab
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  if [ "=
${dev%%=3D*}" =3D "UUID" ]; then
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0  if [ "luks-${dev##UUID=3D}" =3D "$2" ]; then
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0  if [ "luks-${dev##UUID=3D}" =3D "$luksname" ]; then
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  luksname=3D"$name"
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  break
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0  fi
> @@ -157,7 +159,7 @@ fi
>=C2=A0  unset device luksname luksfile
>=C2=A0 =20
>=C2=A0  # mark device as asked
> ->> /tmp/cryptroot-asked-$2
> +>> $asked_file
>=C2=A0 =20
>=C2=A0  need_shutdown
>=C2=A0  udevsettle
> --=20
> 1.8.3.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info.h=
tml

--=20
Alexander Tsoy
