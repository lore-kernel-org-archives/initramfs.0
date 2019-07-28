From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.134 release
Date: Sun, 28 Jul 2019 01:56:12 +0100
Message-ID: <5c91947e2372cd93f0e7481c3e42ee352223dc1a.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DGAZV65RMkCSrFPUQ6rw"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <nfeg-C2w7ML.A.MRC.FLPPdB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/5c91947e2372cd93f0e7481c3e42ee352223dc1a.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-DGAZV65RMkCSrFPUQ6rw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs reported to Debian.  It includes
more drivers in the initramfs that are needed by some ChromeOS devices.
It extends the autopkgtest static checks to cover all hooks and boot
scripts.

Ben.

Alper Nebi Yasak (2):
      hook-functions: Include extcon-usbc-cros-ec when MODULES=3Dmost
      hook-functions: Include extcon drivers when MODULES=3Ddep

Ben Hutchings (14):
      hooks/resume: Disable resume when there are no suitable swap devices
      Merge branch 'master' into 'master'
      Merge branch 'master' into 'master'
      hook-functions: Include all keyboard driver modules when MODULES=3Dmo=
st
      hook-functions: Include cros_ec_spi and SPI drivers when MODULES=3Dmo=
st
      Merge branch 'ukl/bugfix-930754' into 'master'
      resume: Set plymouth status only if there is a suspend image
      hook-functions: Fix copy_file with target of "/bin"
      scripts/functions: Use "reboot -f" to reboot on panic
      unmkinitramfs: Work around lz4cat filename check
      initramfs-tools-core: Depend on logsave or older e2fsprogs
      update-initramfs(8): Document -d option as "delete" instead of "remov=
e"
      update-initramfs(8): Update description of "-k all" option
      Releasing version 0.134.

Benjamin Drung (1):
      autopkgtest: Check also /usr/share/initramfs-tools/{hooks,scripts}

Uwe Kleine-K=C3=B6nig (1):
      mkinitramfs: suppress warning when using bzip2 or lzma

--=20
Ben Hutchings
If at first you don't succeed, you're doing about average.



--=-DGAZV65RMkCSrFPUQ6rw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl088qwACgkQ57/I7JWG
EQmyghAAkFXExAmERq3MHLG/wT0mj0f68tsVzOW9BH3xDJDw1dxO/5PDiQYOjthx
oz3ODTqYdImK8FYBo28tlp4cwFbUBKLWkqdEYEcdxTdFaTYy6JlOxLufxRtKnQpK
Pct5jFUQI8/3GdBTC0jqrW0bwaoLdSd6kqZ6AoNUR8Kho5LOdNHv2dL6eCphW4Lt
S9iATQr8dbqUKrZdgez4MzKG8fLR15O9ss84uYw9qK1zkRy+Yw9wdj+5Chkuf9fQ
MGZYrjbjHicEnoir1xEL9lbfzh6xd+FyoPp00od2iTF7g/DxfTSmH1cotmXxftfi
DY8Mop9Yv6H3eV+6Vngls1jyKLt2ZStcQX/iPAjk2anfaDBOILf5NYC6jW8KsCvg
YZgc1fg+zNUsnBZeVhpcHDfhvSFRxKUehaoU/Sac8CxqL04f16Bom9n15hMwK3QI
b78+EnjLXtm4+YjzlBQayd9jFyu8Hmaau3CJnJaQaE8QZpcQk9ZJ+pD2aQHBrPLl
m9lxs7yJlyBiqZFrmlQT74UdVYbRgstoKZBlfTaa6F6NgtvLJOQ8Lw6nXY1EBOwc
+UkH6JmJTaI8Yn9KfLPJ5gVw0kAIzFB24vWldNeQXm9/506Xy1jg1scX5DeR/JdR
pxiqzq8YhiqoOoMQBffOJS+hTd4xYLPpM4Lt5tAYCAp/Mlu9wBQ=
=BPjK
-----END PGP SIGNATURE-----

--=-DGAZV65RMkCSrFPUQ6rw--

