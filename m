From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.100 release
Date: Tue, 14 Feb 2012 14:57:12 +0100
Message-ID: <2012-02-14T14-51-29@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we just released initramfs-tools v0.100, with a bunch of bugfixes.

The shortlog at the end of this mail has the details, find the git
stuff at the usual place:

* Git repository: git://git.debian.org/kernel/initramfs-tools.git
* Git web: http://git.debian.org/?p=kernel/initramfs-tools.git;a=summary

regards,
-mika-

Git shortlog:

Alkis Georgopoulos (1):
      configure_networking() wait for udev to populate available nics

Colin Watson (1):
      mark Multi-Arch: foreign

Harald Hoyer (1):
      MODULES=dep: awk free version for root dev search

Martin Pitt (1):
      hooks/busybox: Fix 2.99 busybox breakage

Michael Prokop (5):
      lsinitramfs: support xz/lzma, bzip2 and lzop as compress methods.
      set_initlist: redirect warning messages to stderr.
      Alternate Recommends on busybox-static
      warn user if directory is present in confdir
      Releasing version 0.100

Sven Joachim (1):
      copy_exec: Handle optimized libraries under multiarch paths

Timo Juhani Lindfors (2):
      panic(): print the name of each module before loading it
      panic: Load modules for highly probable USB keyboard

maximilian attems (13):
      manual_add_modules: No longer add firmware.agent too.
      mkinitramfs: Use version comparison for xz or other compression tools
      initramfs-tools: rephrase description
      mkinitramfs: Check if TMPDIR is writable
      mkinitramfs: Use /var/tmp rather then /tmp for space reasons
      Revert "Revert "mkinitramfs: Nuke MIN_VERSION handling.""
      MODULES=dep: Use /sys again to decide for libata or ide
      debian/control: Drop versioned depend on pre-Etch udev version
      debian/control: Tighten dep on klibc-utils 1.5.23-2
      init: Prepare for switch_root(8) usage
      update-initramfs: Cleanup nowadays unused run_lilo()
      update-initramfs: run_bootloader() hooks on create too
      preinst: get rid of awk usage

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk86aDgACgkQ2N9T+zficuh45QCfQsU50Zf6xd+soIi4U5NFYRHk
F84An2oIMvQPqc8HDs1arm+lYt56m19y
=DQil
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--
