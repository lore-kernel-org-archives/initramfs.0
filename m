Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063152D8363
	for <initramfs@vger.kernel.org>; Tue, 12 Aug 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035722; cv=none; b=bapLezJwcXAceUkPOB97ZMVCmD6c75g+rfv21hnKfOTIaPbg/C8paPEdRTkJpTIUyPMt0KqFcQcudhmuEQMwascNtWWa7in2HRBDttdPMDvw/Q9Lbo543v14y4nuln5y4CpAIVbhukZgISj0Yt3s03BMDH3CXfgrTkxR91iPWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035722; c=relaxed/simple;
	bh=sqxL6Q5wi1CxXlr5fQfoK/dMQkz+lx3wBFRX28ot6Rw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=UDAR6UaCyHFqZPyyEE9BwZmtfPsepbv4QFJdWHXuWlHhg3AXt3XQvzra1aw36zKv4Nn/aMktnysIlwkbFUlzsq5RkaINMpiJLRAJJYoiXlFT9ZoumzHnaLXtPZiw3sjNndVIBBci8vHg6+qqvPG9jMAIi34Xuklhz+zfrRcJpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1ulwSp-009IXY-1w;
	Tue, 12 Aug 2025 21:23:23 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1ulwSp-00000001QeH-0Sex;
	Tue, 12 Aug 2025 23:23:23 +0200
Message-ID: <6650f38227432d8bc9a8103b0bd28bcd6e9e3ef3.camel@decadent.org.uk>
Subject: initramfs-tools 0.150 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Tue, 12 Aug 2025 23:23:12 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0kxXzfPgoQRGTIMg0i9a"
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


--=-0kxXzfPgoQRGTIMg0i9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes 2 bugs:
- The optimisation of update-initramfs triggers did not (and cannot)
  handle all cases correctly, and has been reverted
- unmknitramfs now accepts lower-case hex digits in cpio headers

It adds some minor features:
- When MODULES=3Dmost, Cadence USB drivers are included
- When the btrfs module is included, modules for all possible btrfs
  checksum modes are also included

Other changes:
- Depend on qemu-system-native to run tests, rather than qemu-kvm
- update-initramfs uses "set -u"
- update-initramfs has an inline copyright notice

The shortlog is below.

Ben.

Askar Safin (1):
      hook-functions: add modules for non-default checksums on btrfs
=20
Ben Hutchings (9):
      Merge branch 'revert-avoid-double-generation' into 'debian/latest'
      Merge branch 'set-eu' into 'debian/latest'
      Merge branch 'qemu-system-native' into 'debian/latest'
      Merge branch 'include-cdns' into 'debian/latest'
      Merge branch 'copyright' into 'debian/latest'
      Merge branch 'patch-1' into 'debian/latest'
      unmkinitramfs: Accept lower-case hex digits in cpio headers
      Merge branch 'cpio-case-fold' into 'debian/latest'
      Releasing version 0.150.
=20
Benjamin Drung (5):
      autopkgtest: replace qemu-kvm by qemu-system-native
      Revert "Avoid updating the initramfs twice for some cases"
      update-initramfs: move "set -e" to the beginning
      update-initramfs: use "set -u"
      update-initramfs: add copyright information
=20
E Shattow (1):
      hook-functions: Add Cadence USB driver to base

--=20
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.

--=-0kxXzfPgoQRGTIMg0i9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmibsMAACgkQ57/I7JWG
EQlmjw/+M+UJObmX7oedoNkEo2fnoHYzeimBbYbVvalgmWjQwJ/as/Fu/l11/OqQ
2i7GI9CIqXAiJHR2g+WqzpOQ0W/bjzlhmEO3XKiuZCzG2BWK7gxodxwonOwewTpR
C0bSgVATFg8E/Avu64NboqIIkBwsrT0cJeUfHfNDFMyK5v7maX87pPQKqhxL+44N
KlXDWibjQD6bqm4UZw4V4YC8MEreUKSoXTPhThcKaZdPBb/+v9DjB/Vufaak3aNr
yLDqQW0GiUN/eivYyjlGdEMHdSGwLfxzC6va5Oe/enysXcsAJqzC4qBagazl6gA0
Yyg4OPcAqDwIKQ913hmccjcQ0Si4GbhJW3VqROrwue4TfO+N3WWDlHy/ZPni8fHk
Om6v75UFDqxoXoKwSSGnKnmdNtU4MyiJuItOddsHk06EbYJZkUlgV5grSJhZV3zY
732HxZriQQxzPG/C2KxbGetsDXMRFqAi2coNnC6X9LZe/QRTWop0X3tjEn/9hY71
cuzdHQgQ1m7IbwFjtFIN72sTq3l7abZExEhgS/CwoMAbiFJOxLaUqxAvrQzo/8gd
e9Vcj3aQmvEqoCxxQ8E7QA3Yc8mgtIA/dNjF262nRngnD4mQOHhXWa92tfjyT3hE
L0O80BsAXAPLHJwHDSUDEHnSIoplJG0t4qsh+qUf37VBfdMnYAw=
=389G
-----END PGP SIGNATURE-----

--=-0kxXzfPgoQRGTIMg0i9a--
