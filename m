Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECB38423D
	for <initramfs@vger.kernel.org>; Wed,  1 Apr 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053483; cv=none; b=V70L61ppvwj1ITa/Glm09rrhgY8K+Vq7WwNDnxUpPwaDCQDFeO+aUhfQZHK4ftEQkisGsJnqwpC+ZF5Wb+4OnM3T/JUS5tfTC2C8wfWQxESXmglpfWcaVSYI06b3DOI/Y+3vrBMtCIH6D75PPpw/TfPxcZgP4uIog95i8TUT19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053483; c=relaxed/simple;
	bh=1Z1caq/f0s+shWPo8eFfwX9MXxgXyzM/EeILgL1YEcc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=sqbbbzgKzrXFib8m7mpwRY9uT+rF67VTys51u6QBbJfMV7ZsouPiTQr6CGCxtP6MlQgLjF3LrykuMf5E/08/LXZc/RX6YTcxBHH1V2edScang/+7efQQ9xzC/+ee2sk/fB5WKEb5e6sI6R+YQAtZCaZPHRfnXGB7RBhR10bjSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w7wUj-002q5h-1X;
	Wed, 01 Apr 2026 14:24:32 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w7wUh-000000008wy-2Hw0;
	Wed, 01 Apr 2026 16:24:31 +0200
Message-ID: <f3c3319e35eb0bad54b4b6789cfde94d38c9c38d.camel@decadent.org.uk>
Subject: initramfs-tools 0.151 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Wed, 01 Apr 2026 16:24:26 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TtbX1rul6JeAhz3OspPb"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-TtbX1rul6JeAhz3OspPb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release adds some minor features:
- 3cpio is used instead of cpio, if available
- post-update hooks can be installed in
  /usr/share/initramfs/post-update.d

Other changes:
- Fixed new shellcheck warnings
- Fixed various problems with the autopkgtests

The shortlog is below.

Ben.

Ben Hutchings (8):
      Merge branch 'shellcheck' into 'debian/latest'
      Merge branch 'wrap-and-sort' into 'debian/latest'
      Merge branch 'fix-test-arm64' into 'debian/latest'
      Merge branch '3cpio' into 'debian/latest'
      Merge branch 'runparts_usr' into 'debian/latest'
      Merge branch 's390x-timeout' into 'debian/latest'
      Merge branch 'deterministic-boot' into 'debian/latest'
      Releasing version 0.151.
=20
Benjamin Drung (8):
      Run wrap-and-sort
      silence incorrect shellcheck SC2329
      Fix shellcheck SC2268
      mkinitramfs: move unknown compression warning earlier
      mkinitramfs: introduce build_initrd_with_cpio
      Use 3cpio for unmkinitramfs/lsinitramfs if available
      Support 3cpio and prefer 3cpio over cpio
      autopkgtest: increase timeout to 240s on s390x
=20
Hector Cao (1):
      tests fail on arm64 because they call qemu-system-arm64 with cpu=3Dma=
x the qemu fails to boot the VM with recent EDK2.
=20
John Chittum (2):
      d/tests refactor for explicit paths
      d/t/qemu-net-iscsi: determinate boot by LABEL
=20
Luca Boccassi (1):
      update-initramfs: support loading post-update hooks from /usr/share/ =
too

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                         - Albert Camus

--=-TtbX1rul6JeAhz3OspPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnNKpoACgkQ57/I7JWG
EQkJbw/+L/D5PiyYqzoLsN4kM16KFuIEnetyUTHYvvQksbBowdGgDW6S3jhsj5zO
Qc7Dc77qwUAvA/2ukSBJyFjq8BTHFwL8tY/s3TbIKCff2R3bEsgEXmUWFL7iSL9M
6lEED7kRIxhCVfdphauLqvhXaUzOieXvmd+u1cTtMnOWL0ZzRO2jUv8cAOLTPqEk
trobldXM94FniGjQRNLDU2V2BZ1SmiYM4kdbSLbNp+eCmnHTwLEQAV76jPrX4z3+
OymrZ3nJQTWoKTFA3CVyzwHBgSw50NU593+sKY9PG3XQR01ImDHxBg6GBJI1KZGM
oDL/DfDIY3HkftjI7aMayJKKAWXKqQT0E5YTHPVVpxzdMWxXtlxWe/iv/FyB73SC
SmwqlLlMPxNmCrxJNxF5P70oTZ5bvG4ikC7QEugkz3Y3xPOVwhLrYROH9tXSW4dv
n6wUvWlqNBXJjvGwQGXxh5Ak4N5BfzjntjKPGG0unJoBfkD0DGinsrP4uqG6TFWF
FwYdvRSQsVBFNhb0TmXaM+wd6+sWxfHtq9EWdoenOvAMuVFJHw4hXKdk5bYJ4U2k
f2JVcSKClB9Tb4i5+nCYWWEs6rCKs56ULKv50XhsYmnnjAQ1QY+1+s6sBcJ16xas
jQXdqid9mexPB02ZhBOc8Zm5rpfpgmNvHGTZp2TMfjkOlAe75Zs=
=mAv0
-----END PGP SIGNATURE-----

--=-TtbX1rul6JeAhz3OspPb--
