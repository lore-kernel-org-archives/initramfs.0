Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79C1C6BD
	for <initramfs@vger.kernel.org>; Sat,  1 Jun 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.213.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280719; cv=none; b=Msy99DhTxJRwehe8Orm2NQeSDbssPQP+azEi9VItQ9OfNweHlELJReiqdAsoIuk5IG0yzDUmtRiq7rPgyWtgmPBcCG1bPCvwWKsHoVrk7sldzz/DcyfQ5cLxUwet3+sbHyUxGIOtAxn7y71EuwceZivEB1fKmflU6Ptv444ziaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280719; c=relaxed/simple;
	bh=tybGkKEBXcFveSSa2HE9Z/i0myxSPIdVUG23xt3VWU8=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=bxf/Y4etukwn1Dx5WMokBdjcR2mtPK+MyqGWorODiYocOHPfvUQVO2viTYgx+/3BWksNk+lY0yYGzhtAV2AFq8eEuvyVSMZKJaG6KXp02yCXvoIHD7R9flt24zdVappnEUIrFW3KUEiU0+/0RKgh1zws4SH5OZD5YcoM6VEs1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=95.217.213.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a05:e201:2024:490:ad3b:6c1d:ad82:ad3a] (helo=deadeye)
	by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ben@decadent.org.uk>)
	id 1sDWuw-00017u-BX; Sun, 02 Jun 2024 00:09:38 +0200
Received: from ben by deadeye with local (Exim 4.97)
	(envelope-from <ben@decadent.org.uk>)
	id 1sDWuu-0000000027t-1A85;
	Sat, 01 Jun 2024 23:09:36 +0100
Message-ID: <ad4d40d632a95c73a8a1b5c5605b53d856bbd0c0.camel@decadent.org.uk>
Subject: initramfs-tools 0.143 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Sat, 01 Jun 2024 23:09:19 +0100
Autocrypt: addr=ben@decadent.org.uk; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-KzIoUYuBmBnblIZNJ4vA"
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a05:e201:2024:490:ad3b:6c1d:ad82:ad3a
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-KzIoUYuBmBnblIZNJ4vA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs:
- Some regressions in autopkgtest cases due to external changes have
  been fixed.
- copy_exec no longer fails if ldd prints a warning message.
- The check for compression support in the kernel config treated a
  missing config file as a fatal error.  It now assumes the required
  option is enabled if the config file is not found, and also looks for
  it under /lib/modules.
- When MODULES=3Ddep and root is on zfs, mkinitramfs does not fail (but it
  does not add the required device drivers itself).
- unmkinitramfs now tells dd to read the correct number of bytes from a
  multi-part initramfs.
- If ipconfig never succeeds, configure_networking no longer exits the
  current shell.

It adds several features:
- Support for compressed firmware.
- When configuring networking, populate /etc/hosts, /etc/resolv.conf,
  and the kernel hostname.
- The autopkgtest cases cover more architectures, and
  configure_networking.
- Always bring up networking when the 'ip' kernel parameter is set.
- Use dracut-install to install modules and their firmware, which will
  usually be faster than the previous implementation.
- Support for panel devices with any name and on any bus when
  MODULES=3Ddep, so long as the driver name includes "panel".
- Support for MT8173/8183 Chromebooks with MODULES=3Dmost.
- Support for Hyper-V keyboard driver.

Possible breaking changes:
- The detection of generic framebuffer support has been changed to work
  with newer kernel versions.  This might result in leaving out a
  needed hardware-specific framebuffer driver when MODULES=3Ddep.
- The networking bring-up changes might break hooks that also try to do
  this.
- Installation of kernel modules into the initramfs is now done with
  dracut-install, and is batched to amortise the cost of dracut-install
  startup.  This could break hooks that look for modules installed by
  other hooks.

Special thanks goes to Benjamin Drung, who will be joining as a co-
maintainer.

The shortlog is below.

Ben.

Adam Vodopjan (1):
      unmkinitramfs: add count_bytes iflag in a dd call

Alper Nebi Yasak (8):
      hook-functions: Don't walk graphics modules if corebootfb is availabl=
e
      hook-functions: dep_add_modules: Properly include panel drivers
      hook-functions: sys_walk_mod_add: Add devlink suppliers as dependenci=
es
      hook-functions: auto_add_modules: Add modules for MT8173/8183 Chromeb=
ooks
      hook-functions: dep_add_modules: Include mipi-dsi panel drivers
      hook-functions: dep_add_modules: Generalise wildcard for panel driver=
s
      test: Increase QEMU timeout to 120s
      hook_functions: dep_add_modules: Use heuristics for a generic framebu=
ffer

Arnaud Rebillout (1):
      Add hyper-keyboard module, needed to enter LUKS password in Hyper-V

Aron Xu (1):
      hook-functions: return from dep_add_modules_mount() for zfs

Ben Hutchings (42):
      Merge branch 'szubersk-shellcheck' into 'master'
      Merge branch 'maintscripts-no-oldoldstable' into 'master'
      Merge branch 'szubersk-silence' into 'master'
      debian/tests/test-common: Update klibc.so installation for /usr-move
      Merge branch 'master' into 'master'
      Merge branch 'zfs' into 'master'
      Merge branch 'master' into 'master'
      Merge branch 'resolv.conf' into 'master'
      Merge branch 'set-eu' into 'master'
      Merge branch 'install_in_lib' into 'master'
      Merge branch 'dont-die-on-no-networking' into 'master'
      Merge branch 'dep-add-panels-properly' into 'master'
      Merge branch 'fix-amd64-separate-usr' into 'master'
      Merge branch 'lintian' into 'master'
      Merge branch 'improve-test-common' into 'master'
      Merge branch 'all-archs' into 'master'
      Merge branch 'dep-syswalk-devlink-suppliers' into 'master'
      Merge branch 'qemu-nodefaults' into 'master'
      Merge branch 'log-mkinitramfs-call' into 'master'
      Merge branch 'fix-missing-hostname' into 'master'
      Merge branch 'simplify-pipefail' into 'master'
      Merge branch 'ignore-ldd-warning' into 'master'
      Merge branch 'drop-obsolete-maint-script' into 'master'
      Merge branch 'wrap-and-sort' into 'master'
      Merge branch 'bring-up-networking' into 'master'
      Merge branch 'cros-modules-mt8173-mt8183' into 'master'
      Merge branch 'merge-manual_add_modules-calls' into 'master'
      Merge branch 'hyperv' into 'master'
      Merge branch 'dep-add-panels-wildcard' into 'master'
      Merge branch 'support-missing-kernel-config' into 'master'
      Merge branch 'dracut-install' into 'master'
      Merge branch 'indentation' into 'master'
      Merge branch 'add-bdrung-to-copyright' into 'master'
      Merge branch 'shorten-add_firmware' into 'master'
      Merge branch 'corebootfb-no-walk-graphics' into 'master'
      Merge branch 'dep-graphics-check-heuristics' into 'master'
      Merge branch 'test-qemu-timeout' into 'master'
      Merge branch 'reduce-dracut-calls' into 'master'
      Merge branch 'fix-indentation' into 'master'
      Add myself to debian/copyright
      Merge branch 'introduce-run-qemu' into 'master'
      Releasing version 0.143.

Benjamin Drung (37):
      Configure /etc/resolv.conf and persist hostname
      Add unit tests for netinfo_to_resolv_conf
      Support "set -u"
      test: Fix too small ext2 block count
      test-common: Use one common temporary directory
      Update lintian override to format for lintian 2.116.3
      Convert debian/copyright to machine-readable format
      Switch to debhelper 13
      Bump Standards-Version to 4.7.0
      Drop Breaks/Conflicts that predate Debian 10 "buster" and Ubuntu 20.0=
4 "focal"
      test-common: Support "set -u"
      test-common: Wrap long qemu-system-x86_64 line
      autopkgtest: Explicitly specify supported architectures
      autopkgtest: Rely on linux-image-generic alias on Debian
      autopkgtest: Group tests with identical dependencies
      test: Add random number generator to qemu
      Run autopkgtest on more architectures
      test: Call qemu with -nodefaults
      test: log build_initramfs call
      persist_hostname: fix missing hostname command
      mkinitramfs: Simplify pipefail implementation
      copy_exec: ignore ldd output lines not starting with a tab
      Run wrap-and-sort
      initramfs-tools-core: drop support for upgrading from < 0.138
      test: Check that the network is not configured
      test: create /lib64 to /usr/lib64 symlink as well
      Bring up networking if ip is specified on cmdline
      Merge consecutive manual_add_modules calls into one
      Skip compression support check if /boot/config-${version} is missing
      Use dracut-install in manual_add_modules
      mkinitramfs: indent code that writes the outfile
      hook-functions: Shorten add_firmware
      Add myself to debian/copyright
      refactor: Introduce debian/tests/run-qemu
      hook-utils: fix tab/spaces indentation
      mkinitramfs: Resolve hidden dependencies after all modules were copie=
d
      reduce number of dracut-install calls

Gioele Barabucci (1):
      d/initramfs-tools.maintscripts: Remove code for ancient versions

Luca Boccassi (1):
      Check for the kconfig in /lib/modules/ too

Paul Aurich (1):
      scripts/functions: Don't die if configure_networking times out

szubersk (2):
      Fix/ignore ShellCheck findings
      Silence unnecessary `ln -f` warning

=D0=BD=D0=B0=D0=B1 (3):
      Respect fw_path_para in add_firmware()
      Handle compressed firmware in add_firmware()
      Support ZSTD-compressed firmware in add_firmware()

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-KzIoUYuBmBnblIZNJ4vA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmZbnA8ACgkQ57/I7JWG
EQki1hAAu+sesQ/SW2TqHCfUHmO07pzDnzRXUfgwoansh+dmg8l92tkZPL2YatyS
PJZs3U4xaLqWWtLgO4Fac23fhAFFMnXSUoKJ5a/VVaDAu6VgFxi7FzBUiODA9T5r
M/SkaNr+EVyuZecGTMOiwDoFJyrfe5MgaZvjRCZm659S44KXG7mcGAnniWyPlAiS
aiJuNKYsgqW9FGYYkstkUizqhVvOOCqK13VQFy6NZ8fgYpC1GOIcu7cR2lhf6sXI
ePBQ0YV29VZS/PFqRKa1nMJbsDIGTv7thN3/tzPqNduUtr14VVwL9n+GhBryKvYg
YdZf72VnDyEYrlzIENYgUidFPWfAE3qqQx3xwdbRCwotdPZxB2QCKgvEr1cycsEi
eppL5cX8BgUDVGJGMn4Dckm9biOXzoFTMzf7KPn6Wg/TpfFNp42rwlxYJScL7G5h
absD/a9l8MEguzbsVlXQWCFc5vo8TY7q4xtaIFpnU2XPSeeHO/5OGfLzuxN81gBs
rC6rrPqxxjJRapclWBqgfooDld9eTW/tbW3QniPA7Y4owfJ6oemOrj08hpJZT81b
Lqv6oUmKDOzMrJJdJnBw39J9NufWXEGVCIJ+mOZf+jH42KUgVL7X2aK2wmHkqTC0
Z0M5E2+aZMubZefc+CNO/aYldKGWsED4kXaFCG3tbrFROtw+Iok=
=axak
-----END PGP SIGNATURE-----

--=-KzIoUYuBmBnblIZNJ4vA--
