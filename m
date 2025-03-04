Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9F8836
	for <initramfs@vger.kernel.org>; Tue,  4 Mar 2025 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059236; cv=none; b=hM0GnS8gCvBHH9d5oK3SjhfWJTJjEtUobPnWVb/vFDHanI0nl+J4+4GWlAkTUxU5do6hbs5Z/wf6qCkRPRosITYSIFzxPQj/I/51tHn5wD+LKeALmV0+WFytHghbXoOHMUZPWHsThLfjc7yN0rL6dzgMEGHt/yr+l1Meqo5OvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059236; c=relaxed/simple;
	bh=aShKJIn/vDDZLXWlmFVxmufdHoC+eGe5BHS7VALeI/c=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ghQEvl/hELj4wOsfBateZS+kYkjGC8j4fjwCzZQsSoIFijNNeWzP125wCoP8LC7q79UM2q+VzJqHfPKY4UssyS83nJJwDYZDTAWbbhTPyxQk0xjQgCcKKu14bU9MGeTLEh3aXk4qa0aNKBaQgyZuJGShPCWkBNok9d7l99AfDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tpJ2S-007fYU-2t;
	Tue, 04 Mar 2025 03:33:47 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tpJ2P-000000058hs-3YOc;
	Tue, 04 Mar 2025 04:33:45 +0100
Message-ID: <deb28abc8530f26bbf62c2d476124b8e3d68d6e9.camel@decadent.org.uk>
Subject: [ANNOUNCE] klibc 2.0.14
From: Ben Hutchings <ben@decadent.org.uk>
To: klibc mailing list <klibc@zytor.com>
Cc: initramfs@vger.kernel.org
Date: Tue, 04 Mar 2025 04:33:40 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ugW4+LuHXe6n5vp2jazO"
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


--=-ugW4+LuHXe6n5vp2jazO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.14.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

New features:
- Added a system call wrapper for inotify_init1(), and a inotify_init()
  function for architectures that only have the newer system call

Bug fixes:
- inet_pton() actually works now
- inet_aton() detects and returns 0 for more (hopefully all) invalid
  inputs
- mlock(), munlock(), mlockall(), and munlockall() system call
  wrappers are again defined on all architectures
- parisc port is compatible with kernel headers from Linux 6.10+
- ipconfig no longer triggers alignment faults when processing DHCP
  option 51 on a CPU that requires natural alignment
- mips64 port explicitly sets the executable base address, fixing linker
  errors where the toolchain's default is not what we expect

Other changes:
- ia64 port has been removed
- The untested no-MMU support has been removed
- All ports that were still using socketcall() now use the separate
  system=C2=A0calls instead

A git shortlog of changes since version 2.0.13 follows.

Ben.

Ben Hutchings (15):
      [klibc] 2.0.13 released, next version is 2.0.14
      [klibc] tests: Add test programs for inet_aton() and inet_pton()
      [klibc] inet: Fix character type test in inet_pton()
      [klibc] inet: Stricter byte parsing in inet_aton()
      [klibc] inet: Stricter IPv6 field parsing in inet_pton()
      [klibc] Delete the ia64 port
      [klibc] parisc: Fix build with Linux 6.10+
      [klibc] Remove unused no-MMU support
      [klibc] syscalls: Define mlock() etc. on all architectures
      [klibc] syscalls: Clean up the fork() and clone() definitions
      [klibc] syscalls: Make more system calls non-optional
      [klibc] syscalls: Remove _KLIBC_SYS_SOCKETCALL config macro
      [klibc] syscalls: Remove support for socketcall()
      [klibc] syscalls: Support for inotify_init1()
      [klibc] mips64: Set executable base address to fix link failure on R6
=20
Donny Xia (1):
      [klibc] Fix the inet_pton implementation
=20
Jesse Taube (1):
      [klibc] ipconfig: align reads of ext for RISC architectures

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed
                                                    - Carolyn Scheppner

--=-ugW4+LuHXe6n5vp2jazO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfGdJQACgkQ57/I7JWG
EQmSFRAAq2Sk0YgvhcrhjH6MfsPYpQzN/h/WCMftCyTax3VdOuupcvfqFShu/FuP
mCmo3YNxLoeNsntQIBjkZqmRBmweux8JTC0vv5Wv2haL7bF0ygPlsi1fOoWfktKT
zHvRz4046ZbFPWEMlyPcSW+KkF2jt273U+l+MWOsyX6xw2hv/lX4ZWtKvIiWJBHe
fVJO68vE+OBLDaYnx288acsLC7Noeh1YF86xz5M7lSFL1HQsrPf+LhfYJTHrvfL5
X/mSNoy3xdtTaQgwFe3EL2HVGmhn4065KGZ/NywdDWBG9GEgAPgycZKwEMnzd4VX
5uMoHiAJ929ZzuF9QR+ktvfjOQSMw+yhnhuodMJP4Bv53cLSmn6KIYjxAvXYUyVj
VMJEPpw9ViSlCXkvAfuFe+A1/H0DXRGWWJrs1zHZicTwsAnQPB7cKOVqmIjtQIHz
FM98qC3jk+AgqegEb1PWic0jLSN6+WmlXWXZMGOoywSqN37QiaXTXAs7xB8Ofud1
/oOj+Fjr8tT52yHmP/kmJ783NWLdRerY1QRN9lfSKOjPHfgiPGkS0f8ws/SUCO6C
4WVENLcugNn1jDN7rMHHU6ZpjFueXWPHblZgW5EdrlzGggNj3CS5Pc2h9bNeerFC
asn9LeYh90avVOC/gjXCqekliU/z7WX1VzIjnY/xy5+uTzWLy94=
=SGoW
-----END PGP SIGNATURE-----

--=-ugW4+LuHXe6n5vp2jazO--
