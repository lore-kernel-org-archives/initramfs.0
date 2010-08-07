From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.98 release
Date: Sat, 7 Aug 2010 21:38:37 +0200
Message-ID: <2010-08-07T21-34-32@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rdbbj4JunmnVtKq/"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--rdbbj4JunmnVtKq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

DebConf10 in New York goes towards its end those minutes and as a
result we just uploaded initramfs-tools 0.98 to Debian/unstable.

Most notably are improvements with regards to failures during
build/hook time, some reverted nounsets and added support for
(absolute) symlinks for the init binary.

shortlog has the details:

Michael Prokop (14):
      fix typos in manpage, scripts/functions and conf/initramfs.conf - thanks lintian
      debian/NEWS: drop asterisk chars to make lintian happy
      install doc-base file for doc-base-registration
      add debian/source/format with "3.0 (native)" to make lintian happy
      maintainer-notes: document "git remote prune origin"
      maintainer-notes: use git config instead of environment variables
      some minor rewording of sentences about development mailinglists
      mkinitramfs: do not execute compress command under quotes
      update-initramfs: stop buildprocess if any script is failing
      init: provide validate_init() wrapper to support absolute symlinks.
      init: provide fastforward path for the common case when validating init binary.
      Merge branch 'maks/bootloader'
      Bump Standards-Version to 3.9.1.
      release 0.98

Stephen Powell (2):
      postinst hook: respect INITRD variable
      Redirect STDOUT to STDERR for post{inst,rm} hooks

maximilian attems (21):
      mkinitramfs: set nounset and errexit
      reportbug: list the mkinitramfs hook scripts of reporting box
      initramfs-tools.8: Enhance documentation of boot option
      update-initramfs: run_bootloader() return after zipl and flash-kernel
      mkinitramfs: Fix missing compress quotings
      mkinitramfs: Fix missing compress quotings
      release 0.97.1
      initramfs-tools: output name of script that errexits.
      initramfs-tools: output name of script that errexits.
      release 0.97.2
      mkinitramfs: set COMPRESS=gzip to be more consistent.
      control: conform to latest policy without changes
      mkinitramfs: Provide error code of failed mkinitramfs creation
      revert mkinitramfs errexit and nounset
      Maintainer notes document dev mailinglists
      maintainer notes: underline that mail to one of the 2 lists is good
      Merge branch 'maks/hooks'
      Merge branch 'sid'
      update-initramfs: revert nounset
      initramfs-tools: only allow hook scripts to errexit on mkinitramfs
      update-initramfs: run_bootloader() invoke Initramfs hooks

regards,
-mika-

--rdbbj4JunmnVtKq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkxdtj0ACgkQ2N9T+zficugkowCfdX1zhQX4NUkwR1y8CdbYGy3N
QYYAn0IpivbqTY/Poya4DmIV30FfFe6H
=h0It
-----END PGP SIGNATURE-----

--rdbbj4JunmnVtKq/--
