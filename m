Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A81C9ECE
	for <initramfs@vger.kernel.org>; Thu, 22 Aug 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341376; cv=none; b=s4RcDP5w1vCwGJxTpv5lQQdNukCn4+0vQto6kygvOmmhh9Cv0JJTJyDBaMGY4qann9GGy4ZoTHqtt7LQ3OhayDPITt9YmVfnWvUeAQ40vkmOvLhuW8CffvGgigB056KceP0xfTV8jJ6G/8UgASQRc2UluU+JGLNaqGCdf09KjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341376; c=relaxed/simple;
	bh=Dgss760lyGM5/k1jksA0yqq8TifCauNg492GQ8T2IDw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=RtyNvcKbCxKp6d7AankV9nR4PMdoQtipM69v4+drzm8NIvphxU5DumpoytMApYdX3IfS+gPr5HCzMdDYcxvChZSFaUi58n297MXVigPkqKdlhF8jmPeKmWfqx01su4WmBBNrvc80CRV51HuXRVpjTXcgmns/rxGrYqBKSG/+Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1sh9xd-005Njw-0M;
	Thu, 22 Aug 2024 15:42:52 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1sh9xb-000000045p1-1Bdh;
	Thu, 22 Aug 2024 17:42:51 +0200
Message-ID: <44916261184378c890f972788a2c567a4aefbfb5.camel@decadent.org.uk>
Subject: initramfs-tools 0.145 release
From: Ben Hutchings <ben@decadent.org.uk>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, 
	kernel-team@lists.ubuntu.com
Date: Thu, 22 Aug 2024 17:42:46 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-CJyVe5V6EeLeFwshyvyB"
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


--=-CJyVe5V6EeLeFwshyvyB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes 2 bugs:
- The autopkgtest test cases are run as root.  This matches how
  initramfs-tools is normally used and should allow a workaround for
  missing firmware warnings to work.
- copy_file canonicalises the target filename to be absolute, so that
  it can be reliably compared with the usr-merged directory patterns
  and with a symlink target.

The shortlog is below.

Ben.

Ben Hutchings (5):
      autopkgtest: Run tests as root
      hook-functions: copy_file: Canonicalise target filename
      Merge branch 'test-as-root' into 'master'
      Merge branch 'bug1079276' into 'master'
      Releasing version 0.145.

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken


--=-CJyVe5V6EeLeFwshyvyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbHXHYACgkQ57/I7JWG
EQllQhAAoJ+57cRkGkHDTyq2KWdh3ZdCM89h7qQ+Yyoqo5pIK9Ka8wH9pKucAyS3
eX2wxdYRKimtzQP69h6nuM7wBsE9s3rHDFKe6kX2IIO2T8tzkl6ByNEwr+MP5ZEf
7LvW6IS5GWVP5celHbgZxSrqcSBx06SmuEeuzJkHN5QTDwMq73v6oGcZmU6oWl+B
jsFY0rKBAQxGv9aqruNuMy5CUONaySk1QAp5zCYCzuHqwPmm2Pqn0jGhNYlOng0v
sHkJudW7vyKicQDlojmcHBtKHgMchrDaJBLp8wMaF/uxc2mafDCdv99WMezdcCoe
NS6zvk0msk5GX6A+1UNeRvZ6JaIccdAUO588ZnGTQwJeNAcMl/fs50cE+9iC09jE
FaiuI2mMpftPNziB8WDO40juRvyrFihQWxzaLIsvEW7zME5/Gi/ZPEjTOA6m+mzH
mHzzJSQ6IMP0bHIB9Snq4A9ZwT7WCHp1zHpNE/LUBv1i6f3MyVbcPtw9ySznFZbP
21bLwn8cmXM0ALtOKKe9WlPq6AaF3H+sqOr7QKWNmW8ZUQML96zFopFoVf3RB9/A
bMvoAs0QDrf9LqvTTTM41nuQcP89yNxTi9tjo13bNNxNdbugnEV9h/iR1n1MTooj
qyAu1FZo9OyfLsZtZgceiiPEyjDSu9fLY41RHKvsHLRNdKi0rek=
=ryN+
-----END PGP SIGNATURE-----

--=-CJyVe5V6EeLeFwshyvyB--
