From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.128 release
Date: Sun, 09 Apr 2017 00:46:44 +0100
Message-ID: <1491695204.2409.42.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-qh/XvLH2oivcMxEWUDdA"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-qh/XvLH2oivcMxEWUDdA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update fixes various bugs:

- Upgrades could fail due to the conditional dependency on busybox
- The manual page for unmkinitramfs wasn't included in any package
- The hibernation resume script did not wait for the resume device to
  appear, but only polled for it once

Ben.

Ben Hutchings (9):
      debian/control: Add Breaks against older versions of busybox
      Include the unmkinitramfs(8) manual page in initramfs-tools-core
      scripts/local: local_device_setup should not assume devices hold file=
 systems
      scripts/local: Apply a single time limit to all device discovery
      scripts/local: Add option for local_device_setup to return failure
      scripts/local-premount/resume: Check for kernel resume interface earl=
ier
      scripts/local-premount/resume: Use local_device_setup for resume devi=
ce
      Merge branch 'benh/wait-for-resume'
      Releasing version 0.128.

--=20
Ben Hutchings
73.46% of all statistics are made up.


--=-qh/XvLH2oivcMxEWUDdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAljpdmQACgkQ57/I7JWG
EQl6bBAAhJ/fpc3IOExprPChUK2D+3wFO2pZYXYtmnvPBkTwsETyIbTPqBxYroT1
jZQ0fGqPxgInmWsxLmxzqfrH8DuVZOVNtV7ahBuIh4mEQA4H+FmbBGo3MkRJA2mq
2Z4FC/98OD6Bh5cjsZEJ1NzY8MqwIwej2TsuOEInFYLVcnGj1U055fxT8/rR8l6y
mMPFZ3/h6fAqUf6lAGb2Sz/pDI1R3dy9BZtCAim+3yWJkEavSRveqY2DNA/1OJJj
CPFcrmLR/5LHLlQmnaBGzN9hkstbOQ7/+/mEcNi23gakaGJ88+WLvJKxtenI/2sB
V8wZZyhvRQ1b7s8wfxwNlTyfNzEV5gdvPjpWDQ46i2lB+MEhZTR5x49kZZjptYoA
ljHSuZuHlX6Y1YDEUjXj4RA0Vk0M6oEzLYxtFrDX7mU+DGnWM3kHxKpxYZdNVWNC
OZfuQf4zC7FS3mZEvXflJl5dkhhsunzXTHz3bHUYdYfmpjcOi4sm0BD9SN97oxrr
m0Z3W3+dqQ08HNqfKv6JZ3t8BG6MZcuQA5lCMKxQrFX3rGNNSFoH8UMJAHE6dyiG
4vrEfOyPEVFLjG+Ya7RAZZwLsfaBi7q67wG8LvwLWX6ZXh9McawGjB9sXZXG9O87
Hv/AWMmAXQQGp43bit8sEsbFYtYzzq41iPZpG5n5M4ySkjqq5Ks=
=eQBu
-----END PGP SIGNATURE-----

--=-qh/XvLH2oivcMxEWUDdA--
