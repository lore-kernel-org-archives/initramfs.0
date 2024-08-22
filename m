Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B91CB316
	for <initramfs@vger.kernel.org>; Thu, 22 Aug 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339244; cv=none; b=FzqRcFoAaJeOMrHXGIUxcvYVV59uHwqnpogh3f7yLUoddWsOo6ITdXLAOifI3fvRDs6YSBkKnlLnzxgJG3f9Q7VpGCsEhsyFDWwchonSeTTibjCXcS5hGXLIYo+1KBTvv/EOsuWLCtHQbdg6k2Nq/vuiTJnQTVKWga1c8y04KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339244; c=relaxed/simple;
	bh=ZP3/WGwqlJzEkcwPYa2psmnjjThjA5ySwg0/heS/L20=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=KwF50gS5OMOiLW6SG0+DygAOauAQtQTpV6+Qy9kYoLdFnIFMJVFHD57vuvwbC5pCIbn8aMuVGNfj8rQJKCpMgJudIi4DszGWIT5lgrKF10tT0blokozN+Vt4twYkurnJmof/BNxAbTfLPmH7isN/CLm3YXgtBdpC8Y+vpMwC0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1sh9PC-005NNI-2w;
	Thu, 22 Aug 2024 15:07:18 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1sh9PB-000000045Ds-29c2;
	Thu, 22 Aug 2024 17:07:17 +0200
Message-ID: <ba3a2dfc3a1bfd3eeda42d0411cdabdd29405ea5.camel@decadent.org.uk>
Subject: initramfs-tools 0.144 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Thu, 22 Aug 2024 17:07:12 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rBlpy5pKhgwG4jH7vAiB"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-rBlpy5pKhgwG4jH7vAiB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs:
- copy_file handles avoids duplicating files whose source filename
  includes a directory symlink.
- The autopkgtest test cases now work on ppc64el.
- mkinitramfs exits with an error if dracut-install fails.

It adds several features:
- Support for MS Surface Pro 4 keyboard when MODULES=3Dmost.
- The onboard_usb_hub or onboard_usb_dev driver is included when
  MODULES=3Dmost.
- Drivers for supplier devices are also included when MODULES=3Ddep.
- mkinitramfs gained a -m option to override the MODULES setting.
and optimisations:
- Iteration over module directories is mostly deferred to
  dracut-install.
- The main cpio archive is piped to the compressor rather
  than written to a temporary file first,

Known breaking change:
- The bug fix in copy_file exposed other longstanding bugs in this
  function, that affect in particular the reiserfsprogs hook.
  This will be fixed by another release shortly.

The shortlog is below.

Ben.

Alper Nebi Yasak (4):
      hook-functions: auto_add_modules: Add onboard_usb_hub, onboard_usb_de=
v
      hook-functions: add_loaded_modules: Walk bound devices for suppliers
      d/gbp.conf: Set gbp-dch options matching existing changelog entries
      mkinitramfs: Add -m argument to override MODULES setting
=20
Ben Hutchings (18):
      Releasing version 0.143.1.
      Merge branch 'enable-kvm' into 'master'
      Merge branch 'replace-copy_modules_dir-calls-by-dracut' into 'master'
      Merge branch 'avoid-tmp-main-cpio' into 'master'
      Merge branch 'multitouch' into 'master'
      Merge branch 'fsck-mention-device' into 'master'
      Merge branch 'onboard-usb-hub' into 'master'
      Merge branch 'dep-walk-loaded-modules' into 'master'
      Merge branch 'gbp-dch-config' into 'master'
      Merge branch 'mkinitramfs-modules-arg' into 'master'
      hook_functions: Fix copy_file with source including a directory symli=
nk
      Merge branch 'shellcheck' into 'master'
      Merge branch 'copy-file-symlink-dir' into 'master'
      autopkgtest: Fix name of ppc64el kernel flavour
      autopkgtest: Fix test failure when built-in drivers request firmware
      Merge branch 'autopkgtest-fixes' into 'master'
      mkinitramfs, hook-functions: Exit with error if dracut-install fails
      Releasing version 0.144.
=20
Benjamin Drung (8):
      Replace copy_modules_dir by manual_add_modules calls
      autopkgtest: Enable KVM if available
      mkinitramfs: Use pipefail for creating final initrd.img file
      mkinitramfs: Do not store intermediate main cpio archive
      install hid-multitouch module for Surface Pro 4 Keyboard
      fsck: Mention file system name in failed identification warning
      Move shellcheck configuration to .shellcheckrc
      Check shell scripts for POSIX sh compliance

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken


--=-rBlpy5pKhgwG4jH7vAiB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbHVCAACgkQ57/I7JWG
EQlN2Q//QrIyPP4CuSTMhyHjIWmQIiPNROpPsFE+U/k+4rKy1sRhFVBXrnkxk8ZP
eMZxKwVqHHOmNSJyydkohQWtg9cA8gnOeIXTFE8h0z0lpIB2Kt+NyQgSaMc/+XWk
oX4wj1zeijCuh3s/bApk4piNd8j44CBjN0jBJ9o/Yq/CIl9b6nzU/Q0dxYiZAzlw
XMEdSG5F257FygvnyLkNgV2nFKCFnAjlp5yKfN+r/6gwjQMc/l9tjyj/mmXcnej6
ZNgPQU0j574cw2pnHQ3PCHtoyQuXil1BRPWdahifU5bJk173nZxbU8cAQ9tUySlo
cCG8uNeZIM+5wRvfqsjHaLfShE20XnAJ/PVKSlrQBh4tXsTjREeYmPonk2dFcA6/
zoWEDhAMOG8+uef09WZ58lnIE0iS7IC5xLE6vKr5DgaiYEOk3juYWh0gA17j0fuf
FVru6WDYSEjicsWVErD/Pth0CUqhKm6jGANJZmEuh6lzcNLFNB7XDh3jtv1BwM4Z
CZg/xjt8NXPWi2n9m9SkNClBu3DzLsB8Bb9bhGrIn02D1FE7kUHvp6DfGb04L2n8
t8RJnQd90cM6NGH2pfai0/x0/yh2fJ4gAXIEfsBW3MaYElmt7qXFEAZTGYOdk2Dz
ws1pJLsDJYU44swDcTI2nXUcPUUr/8fKJblKrNH/Wgv6UsMlyAc=
=+djG
-----END PGP SIGNATURE-----

--=-rBlpy5pKhgwG4jH7vAiB--
