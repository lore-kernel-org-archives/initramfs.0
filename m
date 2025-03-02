Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9808821
	for <initramfs@vger.kernel.org>; Sun,  2 Mar 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740946152; cv=none; b=a+3xqk2qfh/eQl4Yrb9+XDP31ng3Ye27BLssj5OguuUN9qOmyd+no8o4InY/4vJhNLg52diGx/TIIHNXDr80Bm9receYn6jZpIgG21PEwYL1SmWPtWjsBdnKkmnfNd/4mKKV53A0gNCRMALuU8qoAUttPkp5z+Qw6+ni8P7mBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740946152; c=relaxed/simple;
	bh=1/jMKUTH+8VlikMYUj7myQwFkB2pi09WA7SpN5tfmcI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=p++lc1UjD88YOtlHXfTmuh5YKENQywtL3RqNael9pMy3/R9PRQ5npPsxk6OvZewOYTpmgdpXVs9d/gB7doaEABnXaKzqz25FWtPTXZAqjnXFJf/nLfuBQyQWmr3jvyPKc1yorUVHfasd7I1jxurNTTvqVePBiq8zjOLNJjha+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1topcb-007TNa-1b;
	Sun, 02 Mar 2025 20:09:08 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1topcY-000000002y6-2exo;
	Sun, 02 Mar 2025 21:09:06 +0100
Message-ID: <f6bbacb6a446e4b8c12ed03753585e7721ab4028.camel@decadent.org.uk>
Subject: initramfs-tools 0.146 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Sun, 02 Mar 2025 21:09:01 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Apgug8iFcLJPVkU431u/"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-Apgug8iFcLJPVkU431u/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs:
- copy_file again treats a destination ending with a slash as being a
directory to copy into (regression in 0.145).
- copy_file excludes usr-merge symlinks from its detection of a source
being symlinked (regression in 0.144).
- Various drivers needed to boot systems with Qualcomm SoCs, and
probably other embedded systems, are now included by default.
- The resume device check properly checks that the device has a swap
label.
- When multiple network devices were configured, in some cases DNS
configuration was duplicated in resolv.conf; but now it is not.

It adds several features:
- "tmpfs" in the ROOTFSTYPE is recognised and skipped.
- Any kernel modules or firmware that are already compressed are placed
in an uncompressed cpio archive before the main compressed cpio archive,
rather than being recompressed.
- Network drivers are recognised and added based on the kernel symbols
they use, rather than only being included from specific directories.
- copy_libgcc no longer requires a directory argument.

Known breaking changes:
- unmkinitramfs now creates directories with names "cpio1", "cpio2",
etc. rather than "early" and "main".

The shortlog is below.

Ben.

Alper Nebi Yasak (18):
      hook-functions: Add soc and extcon drivers
      hook-functions: Add rpmsg and hwspinlock drivers
      hook-functions: Add interconnect drivers
      hook-functions: Add mailbox drivers
      hook-functions: Add memory drivers
      hook-functions: Add nvmem drivers
      hook-functions: Add power modules
      hook-functions: Add spmi modules
      hook-functions: Add qrtr driver
      hook-functions: Add devfreq drivers
      hook-functions: Add dma drivers
      hook-functions: Add watchdog drivers
      hook-functions: Add usb/typec drivers
      hook-functions: Add tty/serial drivers
      hook-functions: Add input/serio drivers
      hook-functions: Add platform/chrome drivers
      hook-functions: Handle msm hidden depency on qrtr
      hook-functions: Add msm to fb modules list
=20
Ben Hutchings (25):
      Merge branch 'modules-from-dracut' into 'master'
      hook-functions: Expand documentation of copy_exec and copy_file
      hook-functions: Restore copy_file's handling of target ending in slas=
h
      hook-functions: Exclude usr-merge symlinks in copy_file
      autopkgtest: Add tests for copy_file function
      Merge branch 'qcom' into 'master'
      Merge branch 'copy-file-to-dir-fix' into 'master'
      Merge branch 'keep-kernel-modules-compressed' into 'master'
      functions: Define list_filter_out function for filtering comma-sep li=
sts
      init: Filter 'tmpfs' out of $ROOTFSTYPE
      Merge branch 'net-modules' into 'debian/latest'
      Merge branch 'small-fixes' into 'debian/latest'
      Merge branch 'msm-qrtr-hidden-dep' into 'debian/latest'
      Merge branch 'most-fb-msm' into 'debian/latest'
      Merge branch 'miniramfs' into 'debian/latest'
      Merge branch 'shellcheck' into 'debian/latest'
      Merge branch 'set-e' into 'debian/latest'
      Merge branch 'reset-vars-before-sourcing' into 'debian/latest'
      Merge branch 'local-net_file' into 'debian/latest'
      Merge branch 'log-commands-with-output' into 'debian/latest'
      Merge branch 'libgcc' into 'debian/latest'
      tests: Add e2fsprogs to dependencies
      Merge branch 'tests-install-e2fsprogs' into 'debian/latest'
      Merge branch 'shellcheck-tests' into 'debian/latest'
      Releasing version 0.146.
=20
Benjamin Drung (19):
      Put compressed kernel modules and firmware in an uncompressed cpio
      unmkinitramfs: use directory names 'cpio1', 'cpio2', etc.
      Declare breaking miniramfs 1.0.2 and older
      Drop obsolete shellcheck overrides
      Filter net kernel modules by symbol regexp from dracut
      Explicitly call "set -e" instead of specifying on shebang
      netinfo_to_resolv_conf: clear variables between sourcing
      netinfo_to_resolv_conf: add net_file to local variables
      hook-functions: make copy_libgcc to not take any parameters
      test: log commands that produce output on stdout
      Mark debian/tests/test-common as sh script
      tests: fix shellcheck warning "Declare and assign separately to ..."
      tests: Replace 'echo -n' by printf
      tests: fix shellcheck warning "variable appears unused"
      tests: fix shellcheck info "read without -r will mangle backslashes"
      test: make prepare_network_dumping_rootfs take no parameters
      test: silence incorrect shellcheck SC2119
      test: fix checking output / initrd content
      d/salsa-ci.yml: include tests in shellcheck
=20
Dmitry Baryshkov (1):
      hook-functions: add missing module dependencies for Qualcomm plaforms
=20
Jeffery To (1):
      Fix resume device type check

--=20
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.

--=-Apgug8iFcLJPVkU431u/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfEut0ACgkQ57/I7JWG
EQnBKA/+Or4vQqDi9U/ah3TIZS6c3ZpkceQJNVrC+NnWDbKy8JcgTK0yZaJwcr9y
wskJMoZQ6Cfl20LAmHNl+soEQKAJSiSXzVg8h9epTw0jUjXvyPgF7W8Ng7Fjv5zo
p+/NDU6Scz4KHsaC6QzJZlm0z4Z1u0c4tMi+1d1Ca+sv3bcUVCEIPyvVyetgQT4z
Ihb/DVlLhk0gGEdNSF/U9ZZl53OVtqGGixdNE4vvwvXZ2/Tv+/z7Eu4/E8B0MT2A
TnLqp4hL225olUP4PhaEPjiEU2yl7Lre/h1fEL1r8tNTYgqN7bmpuHOPu0Yc3Hyv
L8+jMqC9yz8nB/nUF455Ryd+rQYdLS5ffmU8OQk613EVnHl/Ox52xzOxLLuNWB/I
8JAzgHLsiDrOC4B38hlMUYanvjdUo9mdLpjhmTv8qEPO/qlJhvkBDjxD4dQRjIlk
2MzsQ61ftRLe5tM5LD2YEj9RKDBXjUgfIQc/uCPNTOxUBsqAMlHVqNncvK1xAvSr
8VFME5c4XKBqq8nYjop3Z8h78Aq+Qr69NXBi2rm+qYBCPRLu6vnWv0bHDA9ZDTFW
R14IxxAnKyLwXFT8fPXqbRRgKr33Tk6otx81Nh+SKXr3lZCfH/FLyk9W5YhVNFlS
oIdi69d7dN73vbDmfYaLVb0AUSdODT97H8bGiemNwCtSG71ujnE=
=LayL
-----END PGP SIGNATURE-----

--=-Apgug8iFcLJPVkU431u/--
