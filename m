From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.121 release
Date: Mon, 18 Jan 2016 17:57:15 +0000
Message-ID: <1453139835.2519.141.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-clAEvRZfjTgLExkRoqQJ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-clAEvRZfjTgLExkRoqQJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a major update, fixing most of the important bugs in the Debian
bug tracker.

The major changes are:

- Split initramfs-tools binary packages into core and automation hooks,
=C2=A0 to allow for coinstallation of the core with other initramfs builder=
s
- Fail at build-time if busybox is needed but not found
=C2=A0 - The old default BUSYBOX=3Dy in initramfs.conf is changed to
=C2=A0 =C2=A0 BUSYBOX=3Dauto which preserves the old behaviour
- Rewrite build-time block device sysfs lookup to be generic
- Include modules for all components of a multi-disk device
- Use blkid to resolve LABEL=3D, UUID=3D, PARTLABEL=3D and PARTUUID=3D bloc=
k
=C2=A0 device IDs at boot time, and do this much later
- Change file copying to distinguish executables from other file types
=C2=A0 and to preserve symlinks
- Run panic scripts just before dropping to a shell
- Always mounts /usr rather than checking whether init is systemd
=C2=A0 - This requires an update to initscripts which I uploaded earlier
=C2=A0 =C2=A0 today

Ben.

And the git shortlog:

Andy Whitcroft (2):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Add 2>&1 to the run-init line.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0When adding i8042 also add psmouse as s=
ome keyboards are behind the mouse. LP: #1314764

Ben Hutchings (61):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Add .gitignore files to exclude generat=
ed and backup files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bash-completion: Install using dh_bash-=
completion
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Rename lintian override file so dh_lint=
ian installs it automatically
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/control: Update and shorten desc=
ription
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Split initramfs-tools binary packages i=
nto core and automation hooks
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/control,debian/copyright: Use ca=
nonical HTTP-S URLs for Alioth git repos
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include soft-dependenci=
es of all kernel modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/split-binary-package=
'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/busybox: Fail if busybox is wante=
d but not found
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Use shell to create =
stamp file instead of 'touch'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sripts/local: Remove obsolete hint abou=
t ATA device renaming
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Always use /proc/mounts=
, avoiding mangling of /dev/root
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Fold sys_walk_modalias =
into sys_walk_mod_add
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Split block device sysf=
s lookup into a separate function
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Remove loop-aes support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Rewrite block device sy=
sfs lookup to be generic
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include modules for all=
 components of a multi-disk device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parse_numeric: Tighten check for whethe=
r 'root' parameter is a number
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parse_numeric: Add support for 20-bit m=
inor numbers in 'root' parameter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parse_numeric: Replace numeric root wit=
h canonical device name
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update-initramfs: Use linux-version com=
mand to sort versions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lsinitramfs.8: Update the BUGS section =
to note fix for #717805
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/klibc-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/bug766920'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Stop copying sulogin, which=
 is no longer used
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Only run fsck if enabled in /etc/fstab =
(pass !=3D 0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Use 'command' to find fsck.=
<type>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/fsck-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Use blkid to resolve=
 LABEL=3D and UUID=3D block device IDs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Handle PARTLABEL=3D =
and PARTUUID=3D block device IDs using blkid
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Include drivers/nvme in=
 block driver modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update-initramfs: Run 'sync' after writ=
ing the initramfs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/block-sysfs-generic'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/version-sort'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/parse-numeric-fixes'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Introduce copy_file fun=
ction
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Use copy_file to copy config files and =
firmware, instead of copy_exec
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Use copy_file to instal=
l modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools: Support multiple break=
 points using a comma delimiter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/block-device-ids'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Set emacs local variables to implement =
our shell coding style
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Preserve symlinks when =
copying files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hooks/fsck: Simplify by letting copy_ex=
ec handle symlinks
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/copy-files'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0maintainer-notes.html: Update changelog=
 command lines to use 'gbp dch'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/control: Ensure lockstep upgrade=
 of initramfs-tools and -core
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/TODO: Update for released and pe=
nding changes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/local: Remove residual support =
for separate /etc filesystem
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/local: Name parameters to local=
_device_setup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Defer resolving block device IDs to loc=
al_device_setup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Stop resolving symli=
nks in resolve_device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/fix-resolve-device'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.121~rc1.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.121~rc2.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Restore automatic selection between bus=
ybox and klibc by default
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Always mount /usr before looking =
for the real init
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Remove use of switch_root
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Use run-init -n option to validat=
e real init
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Merge branch 'benh/bug810965'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/functions: Fix fsck display opt=
ions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.121.

Boris Egorov (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkinitramfs: fix bashism in script

Laurent Bigonville (2):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Support fsck.mode=3D and fsck.repair=3D=
 parameters as known by systemd-fsck
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bug#602331: [PATCH] Run new panic scrip=
ts just before dropping to a shell

Roger Leigh (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init: Always migrate /run to the rootfs

Roger Shimizu (2):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0advance the timing of insmod netconsole
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0redirect debug info to netconsole

Salvatore Bonaccorso (2):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/nfs: Check return value from nf=
s_mount_root_impl
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debian/NEWS: Fix typo in reference to i=
nitramfs.conf configuration file

Ben.

--=20
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson

--=-clAEvRZfjTgLExkRoqQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVp0ne+e/yOyVhhEJAQpFNBAAhjDeCTKIqUcULXTQJ0Bztk3b2nsCDP0+
SMqMluztOLLE7fJAsDQlrSk2kHnLiyHNFf1aFZcgUg/eV10Wq3NP38BwCET06SWV
QrDeNPcXTRSR7nzQ0PeLjoBvWlTT6EnwLO0M5M+5LQ/F/ANEW9u/gWuPiVRK381W
Ac723AMqF/RA9NFOWSMbXwloyuawL7N3klSI0pC0QzApZ0x/Oejt7mTx9il4nHQS
b7/oqOAk3WwR9ILK3lV6adzGtFce+BXHRDFt3ACovZhf10b7AeRFyjf5ReKGOANW
ExzfsHLQzLV7OKQV9eNxz5p2ZM4IK9QbjLK5NOObt6yb8Ny/tZG0VYi6wk1+ed6b
ohgtJgwI3sTm8fIyqHQ8vdHU/0Tlf/gkei7DpQbERXKUsJzQZqdYC15Vo8ui3tvN
kMd8sh2sH93nnAO4vPk9DbAPvu8kUdobRNMsTRd4UgLAzj3Z/wa9wjR9Ji09pap/
MTeJk1VSva7romwguYX/yuGc1xinaoxv4BYeD+Wajg8JnDKvX4V0p7LCM3H4ZD0t
AI3iHvWiWICPpaoHbppL0eMPA/hMEjAkqjCKte+RDt+Ng1wMTSJ2vGwEkma+fDeh
WkCOU5ZHMV1/N6kgRrnF2LDKgLdzG6A6Y5z6hwrpVs173ofKPhvULiK3n+KT6Fhr
zSsrOuEgGLk=
=w2NF
-----END PGP SIGNATURE-----

--=-clAEvRZfjTgLExkRoqQJ--
