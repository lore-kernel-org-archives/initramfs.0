From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.123 release
Date: Thu, 11 Feb 2016 02:46:20 +0000
Message-ID: <1455158780.2801.13.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-AiENakszwighgfwwKnNY"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-AiENakszwighgfwwKnNY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update fixes regressions introduced in 0.121 and many more bugs
reported in the Debian bug tracker. =C2=A0The only major change is the
removal of the busybox and klibc hooks; now the busybox{,-initramfs}
and klibc-utils packages must install their own hooks.

Ben.

Andy Whitcroft (4):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Don't display "Loading, please wait..."=
 message when 'quiet' is in /proc/cmdline.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mount /dev with the default tmpfs size =
rather than sourcing udev.conf.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Sync the mount options for /run from /l=
ib/init/fstab
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Mount /dev with "nosuid"

Ben Hutchings (39):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/control: Remove redundant depend=
ency on klibc-utils|busybox
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/control: Recommend the right bus=
ybox packages for the target distribution
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Remove busybox hook in favour of busybo=
x's own
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Update TODO for removal of busybox hook
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include any modular RTC=
 drivers in the initramfs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Stop setting e2fsck broken_=
system_clock option
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Assume blkid is always installed, and r=
emove fallbacks
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Use get_fstype rather than =
blkid to probe filesystem type
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Always use get_fstype to pr=
obe type of root filesystem
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pass filesystem type from /etc/fstab to=
 fsck when checking /usr
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include drivers for all=
 keyboards when MODULES=3Ddep
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Explicitly load keyb=
oard drivers only at break=3Dtop
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Use more sensible mo=
dprobe options at break=3Dtop
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Load more USB host c=
ontrollers drivers on break=3Dtop
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Load HID drivers at =
break=3Dtop
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/busybox-hook'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/fsck-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/keyboard-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Connect panic shell =
to normal tty device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Clean up split between =
dep_add_modules and dep_add_modules_mount
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include modules for res=
ume partition when MODULES=3Ddep
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Stop force-loading driv=
ers found through sysfs when MODULES=3Ddep
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/dep-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel/postinst.d: Make test for update=
-initramfs consistent with invocation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0copy_file: Skip duplicating symlink if =
it points to the target file
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools: Include empty /etc/ini=
tramfs-tools/conf.d directory
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools.8: Update list of varia=
bles exported to hook scripts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools.8: Add a new section fo=
r the general description of scripts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools.8: Add brief descriptio=
n of configuration hooks and files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Remove klibc hook in favour of klibc's =
own
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bash-completion: Simplify by using _get=
_comp_words_by_ref
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Use "case" rather than loop to lo=
ok for "quiet" parameter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Remove fallback from devtmpfs to =
tmpfs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Take over handling of rootdelay p=
arameter from udev boot script
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bash-completion: Rename our completion =
script so that it works again
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkinitramfs: Delete or report temporary=
 files on failure
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Move initramfs.conf around in maintaine=
r scripts to avoid it being 'obsolete'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Dereference links when =
looking up block device number
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.123.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, reading IRC for the first time

--=-AiENakszwighgfwwKnNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVrv1/Oe/yOyVhhEJAQqx8Q//YJcyknSesAILdIbx012EDbFhY9T8Be69
CJfKAqT6HsXdrkS4yo8S5uaxnb08DTlrpn3n4hQI1a4jijVfsnrS/EpUsgjU5ugP
FdmNIAdvx1Ky9HJVRlx5huXi1LVYODcukfNjWltMEaH5DZloD+LSwQJssvuR1zVl
2kbh3wUi4Ah8tIDOuQ2T9Xy1XhF0u+eQpL3sBCuVMwIuvKl4rRCVowbgItM+ybXU
gSbKhDCXEgBpUm9jgfmEZl3yGObkda+xJ93yc+4OJx9qA0PuP0hdzgaQ7Xlz2qR0
KTu68zMvmV0Nc/wgnWRrq8bHTBLs7veWnYW5jb1Xm0wLxWKvH8sqlBPUZEbCcl32
eVrkPF4SMHLl+pIlhnXIsSDeO/O6po2bsXWqOoWRQcqfSzlJKbrGC/4hEOv9Cb5W
D9kCWVfLtpREBkYEjGNmlEgrIfywWIzg6JNeo/5kpejlrYlZHB5yka95OM6sz5xK
RchqmL9r6hxyQQyGg0fqiWnasG+iZeVRLdXQvHxgh6M/IKBFf31r93OEAkqgvdci
C0qdLd05Lak3EZflicTSLeIiHE1ebslLYbOlYbF2/M/9wj7sC5n9zm79yYri5Ru1
wHgUCkJEzR+SYLjDaPvJechqz0R68wm9wi5ekLD5BWwqEC3MIP9xHvrx/V4cazAM
ZhEsIbx5emA=
=dHMA
-----END PGP SIGNATURE-----

--=-AiENakszwighgfwwKnNY--
