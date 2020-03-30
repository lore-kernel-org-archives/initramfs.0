From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 050
Date: Mon, 30 Mar 2020 15:24:19 +0200
Message-ID: <5675245a-d5e0-c37f-f2cd-a4ffb94a8f22@redhat.com>
References: <e838111c-697b-1073-4050-1ebe0c87a071@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585574680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AMurFpxjqU4enEVz3osUoa2ZXjSK/DLrydKunim1bsM=;
        b=KD2WWNW1Xm+J8Fm4zCvsQyWeyyCcumkH8Q52K3Int2h79iQMyp8DDikaGs8VWIf5iRf4Rd
        UqaU4hbeGJY6scE1rfQz1V6KUusK3FGBznQW0v9D4yTcoupXllWt3xKkA+lQkEti3PiR/k
        Ss2XbIljOnxLS3X3QUjqfGVRfd1BpKA=
In-Reply-To: <e838111c-697b-1073-4050-1ebe0c87a071-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Due to a PebKaC my master PGP key 0x034eb370014df270 has been revoked (bu=
t not compromised).

All tarballs <=3D 050 on http://www.kernel.org/pub/linux/utils/boot/dracu=
t are signed with this old key.

kernel.org helpdesk has been contacted.

The new PGP key of Harald Hoyer can be found on:

    https://harald.hoyer.xyz/files/gpg-key.txt
    https://people.redhat.com/harald/gpg-pub-7F3D64824AC0B6B8009E50504BC0=
896FB5693595.asc
    https://keybase.io/haraldhoyer/pgp_keys.asc?fingerprint=3D7f3d64824ac=
0b6b8009e50504bc0896fb5693595
    https://pgpkeys.co.uk/pks/lookup?op=3Dget&search=3D0x4BC0896FB5693595
    http://keyserver.ubuntu.com/pks/lookup?search=3D0x4BC0896FB5693595&fi=
ngerprint=3Don&op=3Dindex


Am 04.03.20 um 14:55 schrieb Harald Hoyer:
> Long time, no release...
>=20
> Here comes a new dracut version. Thanks to all who have contributed to =
this
> release.
>=20
> The tarball can be found here:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://www.kernel.org/pub/li=
nux/utils/boot/dracut/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ftp://ftp.kernel.org/pub/lin=
ux/utils/boot/dracut/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/dracutdev=
s/dracut/releases/
>=20
> Report Issues:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/dracutdev=
s/dracut/issues
>=20
> File Pull Requests:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/dracutdev=
s/dracut/pulls
>=20
> Git:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dr=
acut.git
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/dracutdev=
s/dracut.git
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git://git.kernel.org/pub/scm=
/boot/dracut/dracut.git
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://git.kernel.org/pub/sc=
m/boot/dracut/dracut.git
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/s=
cm/boot/dracut/dracut.git
>=20
> Git Web:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/dracutdev=
s/dracut
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://git.kernel.org/?p=3Db=
oot/dracut/dracut.git
>=20
> Git Web RSS Feed:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://git.kernel.org/?p=3Db=
oot/dracut/dracut.git;a=3Drss
>=20
> Project Page:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://www.kernel.org/pub/li=
nux/utils/boot/dracut/dracut.html
>=20
> Project Wiki:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://dracut.wiki.kernel.or=
g
>=20
> The ChangeLog can be found here:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://git.kernel.org/?p=3Db=
oot/dracut/dracut.git;a=3Dblob_plain;f=3DNEWS
>=20
>=20
> dracut-050
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> dracut:
> - support for running on a cross-compiled rootfs, see README.cross
> - add support for creating secureboot signed UEFI images
> - use microcode found in packed cpio images
> - `-k/--kmodir` must now contain "lib/modules/$KERNEL_VERSION"
> =C2=A0 use DRACUT_KMODDIR_OVERRIDE=3D1 to ignore this check
> - support the EFI Stub loader's splash image feature.
> =C2=A0 `--uefi-splash-image <FILE>`
>=20
> dracut modules:
> - remove bashism in various boot scripts
> - emergency mode: use sulogin
>=20
> fcoe:
> - add rd.nofcoe option to disable the FCoE module from the command line
>=20
> 10i18n:
> - fix keymaps not getting included sometimes
> - use eurlatgr as default console font
>=20
> iscsi:
> - add option `rd.iscsi.testroute`
>=20
> multipath:
> - fix udev rules detection of multipath devices
>=20
> network:
> - support NetworkManager
>=20
> network-legacy:
> - fix classless static route parsing
> - ifup: fix typo when calling dhclient --timeout
> - ifup: nuke pid and lease files if dhclient failed
> - fix ip=3Ddhcp,dhcp6
> - use $name instead of $env{INTERFACE} (systemd-udevd regression)
>=20
> shutdown:
> - fix for non-systemd reboot/halt/shutdown commands
> - set selinux labels
> - fix shutdown with console=3Dnull
>=20
> lsinitrd:
> - list squash content as well
> - handle UEFI created with dracut --uefi
> - make lsinitrd usable for images made with Debian mkinitramfs
>=20
> dracut-install:
> - fixed ldd parsing
> - install kernel module dependencies of dependencies
> - fixed segfault for hashing NULL pointers
> - add support for compressed firmware files
> - dracut_mkdir(): create parent directories as needed.
>=20
> test suite:
> - lots of cleanups
> - add github actions
>=20
> new modules:
> - rngd
> - network-manager
> - ppcmac - thermal/fan control modules on PowerPC based Macs
>=20

