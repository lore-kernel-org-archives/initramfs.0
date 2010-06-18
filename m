From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.97 release
Date: Fri, 18 Jun 2010 16:07:58 +0200
Message-ID: <2010-06-18T16-04-16@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we just uploaded and released initramfs-tools 0.97 to Debian/unstable.

Most notably are bugfixes for mdstat parsing, hooks can abort build
of initramfs, bash-completion for update-initramfs, some code
cleanups and further bugfixes. Continous work for easier bug
reporting together with a lsinitramfs script.

We've a new document titled "Maintainer documentation for
initramfs-tools" in our docs, which documents our workflow, how to
contribute patches, test,.... - it's available online at:

  http://git.debian.org/?p=kernel/initramfs-tools.git;a=blob_plain;f=docs/maintainer-notes.html;hb=HEAD

Thanks to Colin Watson for merging in Ubuntu previous 0.96.1 and
providing patches.

regards,
-mika-

shortlog has the details:

Colin Watson (1):
      initramfs-tools: work around 'find -printf %Y' bug

Ferenc Wagner (1):
      scripts/nfs: cleanup retry logic

Martin Michlmayr (2):
      Produce an error when root cannot be determined with MODULES=dep
      hook-functions/init/scripts/local: add support for ubifs.

Michael Prokop (25):
      Fix bug number in changelog (#584520 -> #549680) for upload of 0.96.1.
      hook-functions/mkinitramfs/update-initramfs: consequently output error messages to stderr
      init: display warning message if devtmpfs could not be mounted.
      code cleanup: drop trailing whitespaces.
      code cleanup: consequently replace spaces in indentions with tabs to unify coding stile
      code cleanup: consequently use "W:" for warnings.
      add bash-completion for update-initramfs
      hook-functions: replace awk calls with sed in dep_add_modules()
      debian/script: append /proc/mdstat (iff present) to bugreports
      scripts/functions: allow hooks to abort build
      hook-functions: do not install ubi module by default via auto_add_modules()
      initial version of maintainer-notes.html
      maintainer-notes.html: fix git-dch commandline.
      move maintainer-notes.html to docs/ and install as /usr/share/doc/initramfs-tools/maintainer-notes.html
      maintainer-notes.html: extend contribution section, rewrap + fix git-dch/git-buildpackage commandline
      lsinitramfs: be more defensive against cmdline options
      scripts/functions: fix usage of test for script execution
      scripts/functions: fix another sh -n usage and fix typo
      hook-functions: install virtio_pci module if /sys/bus/virtio is present and using modules=dep
      docs/maintainer-notes: valid XHTML 1.0 Strict document, add section "Build snapshot version", add license note, minor formating cleanups + improvements
      slightly improve manpage lsinitramfs.8
      Releasing version 0.97.

maximilian attems (16):
      script: Add update-initramfs.conf to bug report
      update-initramfs: Fix another unbound variable
      get_fstype: reference blkid in comment
      pre_mountroot(): reduce timeout to 30 seconds
      scripts/functions: On panic change to tty1 if chvt around
      mkinitramfs: No point in hardcoding busybox path
      Add lsinitramfs to initramfs-tools
      lsinitramfs: set errexit and nounset
      lsinitramfs: allow to pass several filenames
      mkinitramfs: check syntax of boot and hook scripts
      scripts/functions: beautify a bit reduce_satisfied()
      maintainer doc: use git commands without the dash
      nfsmount: more small cleanups
      lsinitramfs: use getopt for -l option
      mkinitramfs, lsinitramfs: Better error message for non-GNU getopt

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFMG32+2N9T+zficugRAnp7AKCBVhC61a5JKDZM4pKtq3Xkbwa8WwCffOO0
+oOOp7VqDfiU+W1vfilBWzI=
=WO+8
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--
