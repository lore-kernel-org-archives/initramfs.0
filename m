From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [RFC] Updating boot loaders in lenny and squeeze
Date: Sat, 19 Jun 2010 03:55:38 +0100
Message-ID: <1276916138.14011.869.camel@localhost>
Reply-To: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-N2YapkdYJs9rameyO4vf"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, Stephen Powell <zlinuxman-vw3iM7VyRdbQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-N2YapkdYJs9rameyO4vf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stephen Powell recently reminded the kernel team that LILO is not
automatically updated on installation of a new kernel version in lenny.
In fact there is a general problem that there are several different ways
a boot loader may be updated automatically and currently no guarantee
that this does happen whenever it should.

There are two major cases where a boot loader should be updated
automatically:

1. Where the boot loader relies on block lists rather than reading the
filesystem, these block lists need to be updated whenever a kernel image
or an initramfs is updated or removed.

2. Where the boot loader allows selection between arbitrarily many
installed versions, the configuration should be updated whenever a
kernel package is newly installed or removed.

There are several ways such updates may be triggered:

A. Packages built with older versions of kernel-package, including the
official kernel packages in etch, run a platform-specific default boot
loader if it is installed and if it falls into case 1 above.

B. The maintainer scripts of kernel packages invoke hook scripts
installed in appropriate subdirectories under /etc/kernel/.

C. The maintainer scripts of kernel packages invoke hook commands
specified in /etc/kernel-img.conf.

D. "update-initramfs -u" will run certain boot loader update programs if
installed.

In lenny, route A was effectively disabled in official kernel packages.
However, no boot loader uses route B and debian-installer enables route
C only for GRUB (as far as I know).  Disabling route A in lenny was
clearly premature and I intend to restore it in a stable update.

However, given that route B is present in both lenny and squeeze (and
even in etch, I think) there is no good reason for packages not to rely
on it now.  (Well, except lack of documentation.)  All boot loader
packages that fall into case 1 or 2 should be installing hook scripts,
but currently only extlinux does.  I intend to remove the vestigial code
for route A, and file bugs on all boot loaders in case 1 or 2 that do
not use route B.

In case 1, the boot loader should also be called by update-initramfs
when it is called outside of kernel package installation and removal.
This is normally covered by route D, but this seems a little fragile.  I
would prefer to replace this with a hook system (as already exists for
building the initramfs itself), but I'm not that involved in
initramfs-tools development.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-N2YapkdYJs9rameyO4vf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATBwxpee/yOyVhhEJAQI5sBAAu61s7zwq6wi7KSUBfWUMjf96PKVB5xWV
1TPMmbB6BFnLmGt07kUApZwdnJtSmRCmLKpj17a+5StKRAj9EoJ0XpWUIgQmK3b7
WlF4aQesUHYBIGB+S3wG24XJ2445DH1xMHD4chb3jjWxd83MDUKQcypX31MT05pJ
l4V1d8usp5HfhbPT0sGwmivl9WVihSKNK6rEnKihboC3xVUTqPvKBMa3QySjOYgR
+G7Xopc8akzDBCU/Ldo0XAQXJfwI6wWzF1CJNq2U0l+5vukdIxR+lT0hoJ4H86pJ
Ai+E1y6svwPjAjTfeIfv8YbnWsIMv7cS5EdGzefrCJqBF/cz/4U7toJe2fNj6aGu
414XZfid5lutNIqcOVRd1Adkqu8hBy3kJ6BQe5kFq8r34Od2HRZn5tOimMWhZi11
3r3fJ9ha0Kb//QQPqWm3VIHOjT/jJiOnCo+fnywVVKRkngzFKZJUwQcX3UwwcYk/
aXPRcN7spmQw1Fk6wCy929gAytFlBsyS+WWlBOaxPXVS+vWca+UiScGWYoOvDGiP
jKDTld5lirNr0CSyoLFJZl7OFAGzoQF6U5Ab2KcqQBatQpERW6pI2z0vjry6KPMy
un0wowOJkDUkbe8qbaeTpHPE2pBFVaGw65XEs/yDxyJ1nfuYgbVAD0SHZ0uiELkF
iKoBwm9hO6o=
=zwJk
-----END PGP SIGNATURE-----

--=-N2YapkdYJs9rameyO4vf--
