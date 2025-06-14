Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF31A08BC
	for <initramfs@vger.kernel.org>; Sat, 14 Jun 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918990; cv=none; b=aPB2BsqCy2/KB38jFNbbpxFiIqHdWEaigD2EXh6w/IOgb70Fh34tP3YQbmYY4eSAzitYz7YakbLcyPlD1YIPPnmhfxrP8TWUB9SHbDNBNSm8Dx1UeNbDv6xYqs3WysRUpHiF/ae6BG8iZZvfB88MV57YonDgoe/Qub8KX3CNgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918990; c=relaxed/simple;
	bh=Kf2IBUOby9rjywJO+qE+WTMrdC7n++W0XDMzIztK/1U=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=OdovOuYPg57YOZft8VZi5yTipa8N5TPosGpPGXgdZiHhZTQCGKlxSi1zzLcC9IWGXBRexiBX1V/gYYXPVH8XIZc3LpjoVNX3Gsb/IDy4Z/YQR906stK53FCkYZE+lG88oZfsZl9rpELYwBuSfbXownHEkJTITL/z3OZ9W9vxLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQTHc-001hbf-39;
	Sat, 14 Jun 2025 15:59:04 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQTHa-00000000urM-12VD;
	Sat, 14 Jun 2025 17:59:02 +0200
Message-ID: <2dbdfc8453a9578c4ace0a984e4d868b650e5b27.camel@decadent.org.uk>
Subject: initramfs-tools 0.149 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Sat, 14 Jun 2025 17:58:50 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6KjmFbFngJXZGNs2ssVq"
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


--=-6KjmFbFngJXZGNs2ssVq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes 2 bugs:
- On s390(x), when MODULES=3Dmost, the zfcp driver is again included
- The initramfs-tools-bin package has the required versioned Breaks
  (as well Replaces) relation to initramfs-tools-core

It adds several features:
- framebuffer_coreboot, simpledrm, and simplefb modules may be
  automatically included (depending on the MODULES setting) and
  loaded
- When MODULES=3Dmosst, all bridge, panel, and backlight drivers are
  included
- When MODULES=3Ddep, more panel drivers are recognised and included
- unmkinitramfs supports lzma compression

Other changes:
- copy_file prints an error message on failure
- unmkinitramfs no longer creates subdirectories when the initramfs
  image includes an "early" part

The shortlog is below.

Ben.

Alper Nebi Yasak (2):
      Handle simple-framebuffer drivers built as modules
      Handle framebuffer_coreboot driver built as a module
=20
Bastian Blank (1):
      Re-add s390 specific scsi drivers
=20
Ben Hutchings (10):
      unmkinitramfs: Stop splitting into "early" and "main" subdirectories
      Merge branch 'simple-framebuffer-modules' into 'debian/latest'
      Merge branch 'log-copy_file-failures' into 'debian/latest'
      Merge branch 'unmkinitramfs-unsplit' into 'debian/latest'
      Merge branch 'panels' into 'debian/latest'
      unmkinitramfs: Add support for lzma compression
      Merge branch 'unmkinitramfs-lzma' into 'debian/latest'
      Merge branch 'fix-zfcp' into 'debian/latest'
      Merge branch 'missing-breaks' into 'debian/latest'
      Releasing version 0.149.
=20
Benjamin Drung (2):
      hook-functions: Print error message on copy_file failure
      Add missing Breaks to initramfs-tools-bin (for moved unmkinitramfs)
=20
Tobias Heider (2):
      Fix include of panel drivers if MODULES=3Ddep
      Include all bridge, panel and backlight drivers if MODULES=3Dmost

--=20
Ben Hutchings
Hoare's Law of Large Problems:
   Inside every large problem is a small problem struggling to get out.

--=-6KjmFbFngJXZGNs2ssVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhNnDoACgkQ57/I7JWG
EQmVShAAsJKYceZZ/pQ08MA9T6epoJFbpm3O87G86etcI9QVBOODPh02XGzsxyw2
1ilXY2v1wgMGMu8KMmloUIl7rSeOfYuJ3ItgZR/U+Aj67zLkmOecYhJkSPglDRjq
F0VqZ8HHwg8Xy7BveupRIz+scqLvVoowAu25eUmNNQMyqxYVecNCFUnQGt4JsmpF
IxVzi2nUTXqAu+Sv/fa0r4Nst34C9hTjpCPX6lB9Syd5GRyZW+wcg87e27LCMasJ
7p6UxwnoqplNDzv6r8uUwMIor4vJX3KU03tImyPmnp922zhd2XMSOVwrjParJhUA
+UBJnaAOwlZgIKo2NZsSXngD8lkhXtwWyG4qC3sDomOU0rcMKPwiEAkBo2PB6Yrl
eXUhhS1rhHkiSJo+rQFrnF+YQYEjWjHSHjsfrmG6pq/8af96p+txHzM5OFGJK7nn
rAf0ygWpykg90lyhMvSYsCajOk45Jt3JtggoVLVwwJpX7c4ZNcDD5vwmx1qoxfjH
MgNiY6ZS3qfSDcysgbYjXQK0/PcZtIAY93dew7YnhvAeRxPtpoE86CARYXIFlfw1
nT/9rpzlwIXpLEazqCKAqUBXCsoLPdFK0Narw3nKeHfFWqmiQS0iDMTrptoisfPM
fhfeZClOk/kK+nmfFsgMey/8gb1wif1DcEOn/zH9Fjx/+uwPMmI=
=QU1l
-----END PGP SIGNATURE-----

--=-6KjmFbFngJXZGNs2ssVq--
