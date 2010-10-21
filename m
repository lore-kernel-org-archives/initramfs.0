From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Thu, 21 Oct 2010 15:29:16 +0200
Message-ID: <20101021132916.GC22186@nb.net.home>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287586242-sup-9146@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Oct 20, 2010 at 05:17:22PM +0200, Amadeusz =C5=BBo=C5=82nowski =
wrote:
> When you're mounting device are you always specifying "-t fs_type"? :=
-)
> Disk is mounted readonly, so even if mount performs wrong guess, noth=
ing
> bad happens.  This is rare case.  Although maybe we can add it=E2=80=A6=
 :-) Then
> it would be:
>=20
>   rd.luks.key=3D<key_path>:<key_dev>:<key_dev_fs>:<luks_dev>

 The LABEL and UUID are always stored in filesystem specific
 superblock (or root directory) on the device. It means that your
 system has to be able to detect FS type before it's able to read
 LABEL/UUID from the device.  The <key_dev_fs> is unnecessary.

    Karel

--=20
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
