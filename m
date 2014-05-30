From: Julian Wolf <juwolf-l3A5Bk7waGM@public.gmane.org>
Subject: 90crypt and disk-by-id in crypttab
Date: Fri, 30 May 2014 13:59:07 +0200
Message-ID: <6741208.yq6nlQL6aV@e117>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

there seems to be a problem with 90crypt (especially parse-crypt.sh) wh=
en the=20
disk is specified by-id in /etc/crypttab.

I'm not quite sure how and where to tackle this issue reasonable so I'l=
l start=20
with what I found out until now:

I'm running dracut with systemd, $LUKS is not empty.
If devices are specified by-id (/dev/disk/by-id/...) in /etc/crypttab,=20
'crypttab_contains "$luksid"' always returns false, so udev rules=20
are created which try to start "systemd-cryptsetup@luks$$(dev_unit_name=
=20
-$env{ID_FS_UUID}).service" which doesn't exist and results in error me=
ssages=20
(No such file or directory).

In my case this doesn't break the system as the correct systemd-
cryptsetup@$(disk-by-id) services are created and linked to=20
cryptsetup.target.requires. The system comes up fine.

The error messages are just confusing and misleading, especially when=20
searching for other errors.

So where would be a good point to fix this problem? Extend the=20
"crypttab_contains" function not only to check uuid but all other possi=
ble=20
device identifiers, too?

Regards,
Julian

--=20
Julian Wolf, Working student
SUSE LINUX Products GmbH GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6r=
ffer, HRB=20
16746 (AG N=FCrnberg)
Maxfeldstr. 5 / D-90409 N=FCrnberg

