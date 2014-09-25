From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.117 release
Date: Thu, 25 Sep 2014 11:07:45 +0200
Message-ID: <2014-09-25T11-05-24@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

trying to address "Please support mounting of /usr in the initramfs" -
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=652459 - I've just
uploaded initramfs-tools version 0.117 to Debian unstable.

regards,
-mika-

Git shortlog:

Michael Prokop (3):
      Bump Standards-Version to 3.9.6
      hooks/fsck: fall back to blkid, make sure fsck binary exists + install /sbin/sulogin
      Releasing version 0.117

Roger Leigh (12):
      nfs: Move retry_nr to site of use and rename to nfs_retry_count
      nfs: Rename do_nfsmount to nfs_mount_root_impl
      resolve_device: Canonicalise symbolic links to real device nodes
      Add support for running fsck
      local: Add local_top, local_premount and local_bottom
      nfs: Add nfs_top, nfs_premount and nfs_bottom
      functions: Add read_fstab_entry
      functions: Add resolve_device function
      Add functions to mount filesystems from /etc/fstab
      scripts: Add overridable indirect functions
      init: Use generic mount functions, and mount /usr
      local: Generalise local device setup

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlQj22EACgkQ2N9T+zficuhcDgCcDId9eUeOH4pZcBYmCvZgjUC0
WEIAnRw5yxhEqioJW3m/d8J38EUrAFOV
=0vb8
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
