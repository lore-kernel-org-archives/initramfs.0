From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.130 release
Date: Wed, 26 Apr 2017 02:16:46 +0100
Message-ID: <1493169406.2474.8.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-8CSA+unu2lIJoY5QyF3F"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-8CSA+unu2lIJoY5QyF3F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update, together with the unannounced 0.129, fixes more bugs than
you might imagine possible in a <40-line script:

- Setting the RESUME variable anywhere other than
  /etc/initramfs-tools/conf.d/resume was ignored
- Setting the RESUME variable to UUID=3Dsomething or LABEL=3Dsomething
  was ignored
- The fallback to automatic selection of the biggest swap partition
  actually sorted by dictionary order, not numeric order, of size
- There was no way to disable this automatic selection

All of which went largely unnoticed, since most systems have no more
than one swap partition, and if the resume device wasn't available at
boot we would (until version 0.128) ignore that.

I would like to automatically filter out swap device types that we know
won't be available at boot (e.g. zram).=C2=A0 But I think this will have to
do for now.  The resume hook will report when it fixes up a blank or
invalid RESUME value, and the NEWS file also explains the changes and
the new option of RESUME=3Dnone.

Ben.

Ben Hutchings (12):
      hooks/resume: Use correct sort options to select the biggest swap par=
tition
      initramfs.conf(5): Clean up split between general and NFS variables
      Support setting of RESUME in initramfs.conf or anywhere in conf.d/
      initramfs.conf(5): Document the RESUME variable
      hooks/resume: Check for chroot earlier
      Allow disabling resume from disk at build time by setting RESUME=3Dno=
ne
      Support requesting automatic selection of resume device with RESUME=
=3Dauto
      hooks/resume: Report when we might be doing something surprising
      NEWS: Add entry explaining the need for RESUME=3Dnone on some systems
      Releasing version 0.129.
      hooks/resume: Fix validation of resume devices specified by UUID etc.
      Releasing version 0.130.

--=20
Ben Hutchings
All extremists should be taken out and shot.


--=-8CSA+unu2lIJoY5QyF3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlj/9P4ACgkQ57/I7JWG
EQkYCg/9HpiddAMMNVZTMJYkRWY6S9ReSJd5susDBUhsG95yx2SDA2o1qUI+JiuM
rwv+HPgdXv+8nspxXrm5AvEWb4HynSrO1OOMsnaz8caBK0raHNOjd8gHEQSUANdx
AHQoWZwjLM5VKoQu/ry8buWjY75sKK6kWvdmL9g3k5xs+ywgGwab0HlzgFPFYJDc
jg/g0YFPxpejg7iyrdzsHwYQ0AsIp+4nbKUp1RPOS9Q44rUjNNPj7uz7lVxR6W1U
3I57zCc8x2biHABycfYEdQUd4sHqWnT0Qs7nilIHuoO63PWnH4HTI9Ylaxut4ViY
rLmxugYfhJO181aCOXKdkgm56oakJxIN+wM5E9kz9P9gzjs8M6UhjQURG53vkdLw
9dl8A2EJ8CeeC1MR05EM2MWFe6cNqvIIT17vEMz3yjupFhkYXrN3uuRwLCDzDMjH
je9SGThRcOYdiwx7Wb9rI78Vm3KLX3s8f6FyWHc5e8r8vZQCG+NmgBEWIuz+dXxd
aHD1hzuBaX8lQ/7cvq5MCcn4dhWXSlBbX+A0gYkXMSfV/Q0CX3TuUqn50Ysd8CuD
7Z5aUYvGB7LN+V1NSEeSa3O9J+Ds4rhmxAHaWAEBHilEqiqPA7rRcboS+8RQYb9Z
3wpLtZYvXVJcGP0476TU40t7vxXZjC5RlIJ6hO6a9Ih8+x7KxDI=
=isaT
-----END PGP SIGNATURE-----

--=-8CSA+unu2lIJoY5QyF3F--
