From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.133 release
Date: Wed, 06 Feb 2019 21:06:08 +0000
Message-ID: <dccccef98b69b72e617b14ad30fdfc2c559127f5.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-wqpLfhUGhQwL9NZs7Rti"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <26z69vaV0kP.A.GpF.Vx0WcB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/dccccef98b69b72e617b14ad30fdfc2c559127f5.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-wqpLfhUGhQwL9NZs7Rti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs reported to Debian, none of them
particularly severe.  It addresses many errors and warnings emitted by
the static checker shellcheck, thanks to Benjamin Drung.

mkinitramfs now uses pigz as a substitute for gzip if it's installed,
and initramfs-tools-core recommends it.  The man page synopses and
usage messages have been made more consistent, and all commands now
support the --help option.  The README has been updated for the first
time in 13 years.

Possible breaking changes:
- The build process now includes running shellcheck over all shell
  scripts.  Downstream packagers that change or add to the scripts may
  need to update their changes or disable this check.
- The update-initramfs -y option has been removed
- lsinitramfs -l (with no filename) is now an error
- The get_fstype function is now silent on failure
- The render function has been removed
- Checks for very old kernel (< 2.6.38) and dpkg (< 1.14.17) versions
  have been removed

Ben.

Ben Hutchings (49):
      unmkinitramfs, lsinitramfs: Avoid zcat compatibility issue by running=
 gzip
      mkinitramfs: Remove check for kernel version < 2.6.38
      mkinitramfs; Stop setting both compress and COMPRESS variables
      initramfs-tools: Change trigger declaration to "interest-await"
      update-initramfs: Remove test for working dpkg-trigger
      kernel hooks: Remove use of update-initramfs -t option
      update-initramfs: Remove undocumented -y option
      mkinitramfs: Warn if the compression command is not recognised
      Merge branch 'benh/compression'
      init: Always export the resume and noresume variables, as documented
      Merge branch 'bdrung/initramfs-tools-master'
      debian/rules: Use a more conservative "find" for shellcheck arguments
      Change get_fstype to be silent on failure
      scripts/functions: Abort _checkfs_once early if fs type is unknown
      scripts/local: Explicitly check for missing root parameter and mount =
failure
      scripts/{local,nfs}: Remove redundant modprobe of filesystem modules
      hook-functions: Remove an obsolete FIXME
      hook-functions: Avoid symlinks that conflict with usr-merge in copy_f=
ile
      {hooks,scripts}/keymap: Use setupcon --setup-dir
      scripts/local: Handle rootfstype=3Dauto the same as if type is unspec=
ified
      mkinitramfs: Use default compression level for lzop
      README: Summarise what initramfs-tools does and point to manual pages
      initramfs-tools(7): Document how to update the initramfs from another=
 package
      scripts/functions: Revert change to _log_msg and make callers format-=
safe
      scripts/local-premount/resume: Report when we are resuming
      scripts/nfs: Use "sleep" instead of /bin/sleep
      Print warnings and errors in initramfs generation consistently
      hooks/fsck: If get_fstype fails, report which file system it failed f=
or
      mkinitramfs: Delete comment about an impossible deprecation
      mkinitramfs: Change EXTRA_CONF to include directory names
      mkinitramfs: Don't add directories to EXTRA_CONF
      mkinitramfs: Use pigz if available instead of gzip
      initramfs-tools-core: Recommend pigz
      Remove descriptions of removed/deprecated options from man page synop=
sises
      mkinitramfs(8), update-initramfs(8): Fix over-indentation of options
      update-initramfs(8): Fix formatting of mode options in the synopsis
      Move usage function for mkinitramfs out of hook-functions
      update-initramfs: Use getopt instead of getopts
      update-initramfs: Make -h option return 0 and write usage to stdout
      update-initramfs: Support --help option
      Make all commands return 2 in case of a usage error
      mkinitramfs: Support -h and --help options
      unmkinitramfs(8): Abbreviate synopsis to avoid wrapping
      Make manual pages and usage messages more consistent
      squash! Make all commands return 2 in case of a usage error
      lsinitramfs, mkinitramfs, unmkinitramfs: Show usage if getopt fails
      lsinitramfs: Check for empty list of arguments after parsing options
      hooks/resume: Report in excruciating detail if the -v option is used
      Releasing version 0.133.

Benjamin Drung (9):
      scripts/functions: Fix syntax error: unexpected "(" on panic
      mkinitramfs: Fix termination of gzip compression case
      scripts/functions: Drop render function
      Remove trailing newline from debian/changelog
      Fix (nearly) all issues found by shellcheck
      Disable shellcheck for desired behaviour
      Replace 'echo -n' by printf
      Run shellcheck on package build time
      Add autopkgtest for shellcheck

--=20
Ben Hutchings
Man invented language to satisfy his deep need to complain.
                                                          - Lily Tomlin



--=-wqpLfhUGhQwL9NZs7Rti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxbTEAACgkQ57/I7JWG
EQnvsA//YTUK2zAr7aRXQPrXNeq8wa3Sdi2euKjGlMLNBsbqPqUoFtnLBndknGsN
N5WZW0/bSGVXMr6LtT749pYUVdOlaPgCpIWP2XRdVmqSXKGDtexYO3FFrHGx+rhA
L2/XrEHuoZ4Etz7UlMKPCuy3JUVM3E8Y/WneK9q7oNqoFfL0JHtpf98kyCXTIgdx
iGgtPXmkNaGDMUSRxqRWsuylwE4Si83a2adn96Au0z5T+gxKjgh8oTK2msxcfy8P
oJGD9AfXrU+KuuKuaCWOBTTqiJy7ni5xkVmi8mjjZiOOWxUDpDkRKRwO4sbnEakx
Cx7nxpfXGO9s5bmF0A8zeFlfSygN8XSqCdQCQQjYkQXSZWorGfm+jAS2GsCQkk0r
VK8CsK1xrC8nJhqkodTDE9Jv+8kAsRDQjIUCJyLOgjICDPIgVLjW8uUY8FFFPuRY
1vooGlP4IFYbkqyVKYgsMMtgXAW5esC/pa6MfB2WtACjNpx+SRpVSM8OsqOSjFXN
QeK4LMPfo3U1RU3QUV0y13DBTuSLIKQdwBn3XbT4AEq3H5+ygG9sVCC+K2EkQ5aT
gjyUH+TWjr4LkLJXIScQuITlvrtmnLwF7mPrxFv1hUSrny8axuO83YU2ZqKqdhE0
jlFuMfhPSeDEnFbDKkw1ACGKPdWFpluxdUufVhSSyHhxlnIK9o4=
=dS8p
-----END PGP SIGNATURE-----

--=-wqpLfhUGhQwL9NZs7Rti--

