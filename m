Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292128DB7F
	for <initramfs@vger.kernel.org>; Wed, 28 May 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456722; cv=none; b=V2BpgAeSPp3BTkWPXMK6sPiMt/mAK4A0i2tGRu6gcujTE0iqf4QYCWLFgZ6efp7Mpjfh26pza1qHzXq5m4VbxagyQPZsEkKHt99q0eMzU3jGrenLR46XHggZWjjwepLGYXWznPBufsP9Fe2DQi2MnX0H45qcOUSqBKmTrjpqPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456722; c=relaxed/simple;
	bh=Y2vGBRbL0f3vqII5QvWBEK3WdT7eJG7eATv8G9i3GiM=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=q6gmX0mHKELLv60JBr7Hd7oZTXKl0aC7Oho47GupbNNu+sUEJu4oBAqCuSLi4hHlPsbOHLCM/sqwyQmbenvTcSx6sMOK2VV2LG6ua5BKADFnL0kbfRmROJMvrV+Prh37CCDPqkm8VGcyao4f6rqw0cUEUbKGBFqbdpaf1Yidx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uKL9u-007vkl-3C;
	Wed, 28 May 2025 18:05:46 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uKL9t-00000003m7L-3Ouy;
	Wed, 28 May 2025 20:05:45 +0200
Message-ID: <548de093958414c353fa98375d5b054028ccae97.camel@decadent.org.uk>
Subject: initramfs-tools 0.147 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Wed, 28 May 2025 20:05:39 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cAx2ADeqbwi/V6Vsk17b"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-cAx2ADeqbwi/V6Vsk17b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the late announcement of this release, which was made on
28th March.

This release fixed 1 bug:
- The change in v0.146 to subdirectory names created by unmkinitramfs
broke several tests, and has been effectively reverted.

It added several features:
- When MODULES=3Ddep, any loaded reset drivers are included.
- When MODULES=3Dmost, squashfs is included.
- mkinitramfs and update-initramfs support a --version option.
- The kernel postinst hook does nothing if the update-initramfs command
is not the initramfs-tools implementation.
- update-initramfs and the postinst script avoid updating an initramfs
via the triggger if it has already been updated since the trigger was
activated.

Other changes:
- /dev/pts is now mounted with mode=3D0600 instead of 0620, matching
systemd's default.
- When MODULES=3Dmost, the selection of block drivers to include now
matches dracut.
- The autopkgtests include an iSCSI test case.

The shortlog is below.

Ben.

Ben Hutchings (17):
      hook-functions: Add reset drivers when MODULES=3Ddep
      unmkinitramfs: Create temporary directory for initramfs parts
      unmkinitramfs: Fix detection of EOF marker
      unmkinitramfs: Restore split to "early" and "main" subdirectories
      Merge branch 'devpts' into 'debian/latest'
      Merge branch 'dep-add-reset' into 'debian/latest'
      unmkinitramfs.8: Update and expand description of multi-archive handl=
ing
      Merge branch 'squashfs' into 'debian/latest'
      Merge branch 'update-initramfs' into 'debian/latest'
      Merge branch 'iscsi' into 'debian/latest'
      Merge branch 'unmk-regression' into 'debian/latest'
      Merge branch 'avoid-double-generation' into 'debian/latest'
      Merge branch 'block-modules' into 'debian/latest'
      Merge branch 'spelling' into 'debian/latest'
      Merge branch 'test-order' into 'debian/latest'
      Merge branch 'debian-policy' into 'debian/latest'
      Releasing version 0.147.
=20
Benjamin Drung (15):
      Merge branch 'bug1099461' into 'debian/latest'
      test: let run_qemu* take extra kernel parameters as single parameter
      test: support setting a disk label in build_fs_ext2
      test-common: introduce intermediate _run_qemu_default_devices
      Add qemu-net-iscsi autopkgtest
      mkinitramfs: add --version parameter
      update-initramfs: add --version parameter
      kernel/postinst.d: check for correct update-initramfs provider
      Fix spelling mistakes in d/changelog
      hook-functions: Move UFS storage drivers to block class
      Filter block kernel modules by symbol regex from dracut
      update-initramfs: add -s parameter
      Avoid updating the initramfs twice for some cases
      test: run quick copy-file autopkgtest first
      Bump Standards-Version to 4.7.2
=20
Chris Hofstaedtler (2):
      hook-functions: avoid aborting in chroots
      Tighten /dev/pts permissions
=20
Scott Moser (1):
      hook-functions: add squashfs driver


--=20
Ben Hutchings
Always try to do things in chronological order;
it's less confusing that way.

--=-cAx2ADeqbwi/V6Vsk17b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmg3UHMACgkQ57/I7JWG
EQmAgRAA0SBjY5zkY1rdIgcWvSR0w9ZcYh9l03B64wss4ag7TGp6B+wh3fWqwIQ+
ktBVlkHjD+hVcqmpEX39zbB2MPQnSZxCeTOQCaImn1GQfWbuvJsGswCFhmoK+EV9
mUlnMRskBsKtDaHjbGg6s4A8xNcSq0wDZJi9zTsnn72dycnwqN/4tyXjYcyaMiOK
YnZ6OkqlW7Sy3dpgySi6EDO7DcP/eYuDPsxubz086+OGULgQOczrVVb/WeNbjyHU
k7R1lxYmJqjGFEM9MXKZyXHyabWDZVNtLYJ69Qyqw2Piaq0dgV5PiZT9GhcEoMSn
yy9Bk1dTa99UxTDL0E8xIhiVVcfdKNN/+jv+owTUH3MbxjxCZibkS8WWWDLFoG6h
Mk2NtDHW0Yc1a5kK4tgSijUt0nKgQkMEuMo5owjL7QtxG7D8dbh/cLipvtCopu5g
I4+qwICAiQ0K8c54eXTR5DkHygmru9E9pjYyqEzy9R/rqVFnFMg8RXWIQmEj3T4v
tKidLWpld0Zs1xgLfSpsx/TfA3Y44GQgXcbiQltjxUFidgclNgibsEccyY0Lrlsz
yQOt63e7jeL/3AOz/PWnnqixXAFZK/1GjyXR/SiWP9O+c9qTE0Jd4ak1QMuLkEpi
3G/D3Lb5cqDSra+7j0yf0peoel/pPCkDBiGMJCpx1vuNJOnZ06g=
=ioW5
-----END PGP SIGNATURE-----

--=-cAx2ADeqbwi/V6Vsk17b--
