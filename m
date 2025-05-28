Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533528DEE1
	for <initramfs@vger.kernel.org>; Wed, 28 May 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455784; cv=none; b=SpfvXBsKWicsMJbFtZ5NIEVioIXQfsuDfccIJSxUWrPRrVQncJX0FC7mOBPN/Gj5qTYMKoTtkyH21anszET3IvwoPrSCqveWRLn54y5NYcnLFuhr819Q6o3PAqNBVBWxaYS7/s0vLi+bMztPpz6DCK14wYMKZpq2AlL7mSS0IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455784; c=relaxed/simple;
	bh=mItXIha85NGfYoktFqkh9e6tdEgMMQ1SJYE3OS5HIm0=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=b5RKjZKjz7El16Cd3AmWCjpVe8ivYLThurVfs8oTnUBPXUy/8/M0vaSnjwRsDvZkd/jDD5FnnGds7FcH0pM9P1DyUST6fmRRmEftfRPZd/AT3QoLcofcQbjptdy9o+JkYl9Pp+qWkq63Fz82WSfVKD/kj+Z032Sm1W1g4hs9HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uKLDf-007vlH-1O;
	Wed, 28 May 2025 18:09:39 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uKLDe-00000003mC5-24tM;
	Wed, 28 May 2025 20:09:38 +0200
Message-ID: <17f415e33d179cc7abbac22e174dbe8abdb5fc13.camel@decadent.org.uk>
Subject: initramfs-tools 0.148 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Wed, 28 May 2025 20:09:38 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-o9qOMMJgfI4Gj9IaiWtY"
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


--=-o9qOMMJgfI4Gj9IaiWtY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release replaces the unmkinitramfs shell script with an
implementation in C.  This was done because the previous changes to
handle multiple uncompressed cpio archives securely made it unacceptably
slow.

The unmkinitramfs command is moved to a new initramfs-tools-bin package.

The shortlog is below.

Ben.

Ben Hutchings (5):
      unmkinitramfs: Rewrite in C to make it acceptably fast
      Move unmkinitramfs to new initramfs-tools-bin package
      test: Add autopkgtest case for unmkinitramfs
      Merge branch 'unmkinitramfs-c' into 'debian/latest'
      Releasing version 0.148.

--=20
Ben Hutchings
Always try to do things in chronological order;
it's less confusing that way.

--=-o9qOMMJgfI4Gj9IaiWtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmg3UWIACgkQ57/I7JWG
EQkF1BAAzOs7kOR5vq9KL/BlYLNkUeTT8SpF8JEBtodOI2BGTFKRW+PSnPDQX8Z2
6EGzp2xRBaQWjQQAQaR0J46dE6/Ktw84hyg3mma/lln7VjYRC3nE9zXAaaH5o6jV
Gi6kQ8GkpqB8hd6UvbFhfiGsT0tKDdIX6Yh76u3NvJXhHYhgrxqqelKiPCt5im8N
RIKrpj9nLjX+21gD65LMIcdngYcWRR/on2m1k6vCNUlRW6REK+0IZLvdNxJQQJm4
E8Fa4yofTS3d4+zHfYsiWlgeZAv40izOUuQ+M9QsfugwhwEPWtRNu5Jg9RHRc38q
y8vfcLtqnwgsLkCfRPGCBo7IGE1IHavq63QteQa9yaCHRlQCImaxyNzCrejriHcb
8++jFHM82wuUSJ7G5iKM3IiZ+hvswBesgpu1ap5K+oCAfhat59GCC+3qRgRxVypf
tJMadvILCShZbjgM09qRP8+1zrJSOVz9NpEpZzILL4ESze1daenyKlmLLeQm4yrd
FIV3mrfBZB4aqI59p8dcRBnqBwjkhFpBHO8UhGmo7rsAtnT5gUzWY5IfU3Bifw0z
QPVmtxeTret0ydECsCos9a1yex16RyY9ayp1XT5iWDdbr9rH91vLDP06BEpESPxG
OTBCulBG5Uke87xjELq/02zcILIc3PMyj8qzfogR9+SGB7W+XhU=
=QszS
-----END PGP SIGNATURE-----

--=-o9qOMMJgfI4Gj9IaiWtY--
