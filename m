Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35E1CD15
	for <initramfs@vger.kernel.org>; Mon,  8 Jul 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439184; cv=pass; b=rPiLxOWINxEMZQgg4J1ct7tlhAlhMpAZNXDXAyZwFIFJwMggm4rRuUTlmiRzxlXqet/X3fW9hRjjiKC0qRhP89AN5BJFJpRIhW8wgNxxy9+Z3meK7SS8+V8bYUXk9m4ye/0XYpUYzSkWV8JKL1ZowJZaunk03TZ7IDfxeBr/dlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439184; c=relaxed/simple;
	bh=hw2pXdFamsmUtJWbwgL+b4iAju/dieq5lpLY2PLIo/w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=oM/yrBPuQXimoepa9CvXnB8gZIFEFcUx5WCdh2oLp9Mkp8z1dminaa/zNVLqhL4cCaDx6ZbxtJRDPocSCvylg2cI9z3VTnBio8/0+tSlrhKRgTH2DH2CLlbzdPsjRQeqffK13uAUjptYkEQ2klPsIfunYoJLiVAGt2jiymTAQN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de; spf=none smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=UYB5dgdc; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=MskHZlef; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aepfle.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="UYB5dgdc";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="MskHZlef"
ARC-Seal: i=1; a=rsa-sha256; t=1720438816; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=by4V9Luvgzx+wRO2PY06ZQR733NB0qCwvlcklOcTWv+1NJ3A8bZztlg6GujQFInBFg
    HYoaRN+RQOvlLAUlHP67Hi6MsfnXa2jYLXXvnHV11Xm/MNJdaSJixHqVoBd9GDdOZ5X4
    djMDVNOZ1TwF/TWezKazeUhtB4OKS80E5IhRCbsd3pasB2ogKAKDxMP6ie7BgokRXxy7
    Nce+pJphQWI0S7rKQtEq4I+6GJJFhZvbM5sU2Egnw93vrBAgb8ktdi4o8glMY1OFaQTy
    AhdwN/eHlFmVRv3UL5VfH5oZc4OxcKoQ4b/7j+ui1kaaDwOQQaBOAWXXc0/QyDIqabjW
    d+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720438816;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hw2pXdFamsmUtJWbwgL+b4iAju/dieq5lpLY2PLIo/w=;
    b=a+TupbAiJDULQDiKjSDaIt/zNrgLCdi0efNrCtIYVRv041YcoKzHd+fO5kFCPoG4z1
    Skc7ljP9ABLspckpAZjEvqVmQi8MFLImCiqbeMWFK20Kt3e4gfnbP6N35/VFNti/pE4r
    zshhlQ86GpXb21f0a8m186tO4imoz1bdSa8/AKtVshCiJ39XUcFEwWxUr/EuHCgqd76z
    +nFdnZMD/o3BMvs1hKh1BgxtHsPJpPlWq99rZzRgKbK1Wn79S+mKoe4/b1XC6IP7APzS
    fQKarSs1rzNHuewa+kTZuxPb7eluZ61j6ZkNvvAnzux8CcwuMy6MCZ2Si53yzxGzo4WY
    wHZQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720438816;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hw2pXdFamsmUtJWbwgL+b4iAju/dieq5lpLY2PLIo/w=;
    b=UYB5dgdcTYWvTxt0feR99m/JEOWjzOI7Zei0hzYEiDwKdDM5MsbChGI5vF2XRwpJyI
    iujR7SwUG7z4HrVKToZHuv18Vr//7tzslrihyJYkqfV1t/qDpPUNg9vO+fZDkNKPc3Qy
    +X8XIRwIhgDGx8qGseFccLjYHjVUhPSiXVaJlzeqDaqOYXJzkljh5DtJAf9bzgjIVrMe
    6tDH1gi4uZk8SUBsTfDWy8J9EMLyPz/q+B5JnLQ8UZIR6durpLSANmVd0+Qp1pYv2nIj
    Y9uQE1wxkKklo0GaxKx6db8D5NY48NgyEI6/bn5/Tw2b1PBxd25Qx0b8Zinu46w6qgno
    LV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720438816;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hw2pXdFamsmUtJWbwgL+b4iAju/dieq5lpLY2PLIo/w=;
    b=MskHZlefmdqeqIr5Kvykt9CCRwnbkOtVV3DMMK8vt2hMD9L+hNhYHFqeC96bL2dtvY
    bgWN3jQpXxQR5zzz1GCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5BkKIOBzsrQFE/ZQyiRRrPkprT4fzoKOdWSb+rw=="
Received: from sender
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id D05b2e068BeGPfR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <initramfs@vger.kernel.org>;
    Mon, 8 Jul 2024 13:40:16 +0200 (CEST)
Date: Mon, 8 Jul 2024 13:40:06 +0200
From: Olaf Hering <olaf@aepfle.de>
To: initramfs@vger.kernel.org
Subject: built-in configuration file prevents booting with command line
 options
Message-ID: <20240708134006.05da2f2d.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DUyw4c=n27GyJWzzrzeaPBq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/DUyw4c=n27GyJWzzrzeaPBq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

dracut in Leap 15.5 puts /etc/cmdline.d/90crypt.conf into initrd.
This file contains "rd.luks.uuid=3Dluks-${old_uuid}".

If the disk dies, and the backup is populated on the replacement disk,
the UUID of the LUKS container does obviously change.

I was able to boot the existing old initrd with "rd.luks.crypttab=3D0
rd.luks.key=3D/some_path rd.luks.uuid=3D${new_uuid}", but this was not enou=
gh.

Booting with "rd.debug" revealed that "${old_uuid}" was still expected
to be present. A search in the extracted initrd revealed that
"rd.hostonly=3D0" removes "/etc/cmdline.d/*.conf". But using that option
disables also all knobs specified on the kernel command line.

Is booting an "arbitrary" existing initrd with "rd.hostonly=3D0",
and specifying every required detail of the root filesystem on
the kernel command line, supposed to work?
Did I maybe miss yet another required knob?

This is the full list of used kernel cmdline options:

log_buf_len=3D16M
mitigations=3Doff
net.ifnames=3D0
nosgx
panic=3D9
plymouth.enable=3D0
rd.fstab=3D0
rd.luks.allow-discards
rd.luks.crypttab=3D0
rd.luks.key=3D/.root.key
rd.luks.uuid=3D${new_uuid}
rd.lvm.conf=3D0
rd.lvm.lv=3D${vg}/${lv}
rd.lvm.vg=3D${vg}
rd.timeout=3D11
resume=3D/dev/disk/by-label/${label_swap}
root=3D/dev/disk/by-label/${label_btrfs}
rootflags=3Dsubvol=3D/${subvolume},noatime


Thanks,
Olaf

--Sig_/DUyw4c=n27GyJWzzrzeaPBq
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmaL0BYACgkQ86SN7mm1
DoDdwg//VVbru9F8a0qqBtlaS6xLzf4nOZPPBElj2j8Srg9OqGlOkdmXFNsfu8Qp
iy4J4I6c/oqXn8GIGVqn+nRSW/P9M6NLEiDzUrHvznfb0chcKdGwR1jIlbBjMkjA
2OapzKTZuPm6PBBwKofSTLQrw0OGodpaqmRjpORpkMoFQ0nUruV0ZAfIbeep/WWd
NapCS03wQ3DYLdmoIi7azBdgSKT931WUdgm2Ihd4Gr2EE5SE9KK22out2st4h3xt
uM17kJ0rfNGknP4dNzHCC/oFE+O+oOrIkgWBPtTC7PYAQR0910d4U3E8fzSbBGX7
iJLKwxw237LkfGVH9zQGA381iQUduai2gRalWZtn3yaMM1zkU5nNe7UfzjSuqeUr
z/ixfYFvY3ysIaCGM6Il1qM8E/jiK/mP4Mpu81kuMHPcqGp768T1C1w3oAd6Y6hO
kKXXVtyKnapdCoaq6+ZdxHgiUvIoY1mk/bFuLFkJQgz3z1x+bNRaP+GL7rbIwBCZ
bTgYzMCKlDbD71dLdJ9+Ufaebi9+uOmIRH5yY3GIKTOPg4MpWs/pOEoAKhlLD3t1
2p+mxK9gu/0R9OSbxjwo6B5osQZJgThn0HdCprb8OAMIH237SMH/I5M5qvrD7vEn
QeKJ22B1gOysZsb2ycyKOggpsSYBPWJElnqCNudN5/Be+Drjsx4=
=ccLJ
-----END PGP SIGNATURE-----

--Sig_/DUyw4c=n27GyJWzzrzeaPBq--
