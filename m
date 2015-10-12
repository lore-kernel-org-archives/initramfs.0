From: Neil Brown <neilb-IBi9RG/b67k@public.gmane.org>
Subject: dracut is too "clever" at identifying modules to exclude.
Date: Mon, 12 Oct 2015 14:02:57 +1100
Message-ID: <87r3l023ha.fsf@notabene.neil.brown.name>
References: <20150409140840.0bb6d59d@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, trenn-IBi9RG/b67k@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--=-=-=
Content-Type: text/plain


If I have booted a kernel with md/raid built in (no modules) and
I use dracut to build the initramfs for a different kernel which
has the md code compiled as separate modules, then it does not include
the required md modules in the initramfs.

As a particular instance this happen when the root filesystem is on
RAID0.  The 'raid0.ko' module is not included and boot fails.

https://bugzilla.opensuse.org/show_bug.cgi?id=935993

This only happens when 'host-only' is selected (which is the default for
openSUSE).

the modules.d/90mdraid/module-setup.sh code calls

    instmods =drivers/md

instmods calls
   module_is_host_only "raid0"
and this incorrectly fails.

If raid0.ko didn't have any alias this would succeed, but it does.

$ modinfo -F alias raid0
md-level-0
md-raid0
md-personality-2

However these aliases don't appear in any modalias file in /sys/devices,
in /proc/crypto, or in /proc/modules.

Maybe you could parse /proc/mdstat..

if [ -f /proc/mdstat ]; then
  while read _d _c _a _m _x; do
   if [ "$_c" = ':' -a "$_a" = 'active' ]; then
      host_modalias["md-$_m"]=1
   fi
  done < /proc/mdstat
fi

but it all seems rather fragile.  There are probably other modules that
might miss out accidentally. dm?

Do we really need the host_modalias stuff?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWGyLhAAoJEDnsnt1WYoG5YIAP/jV1dL7Oojz2FOCn41eur4fC
t0JqavNITQYNBfEKmiRpR4ew8ns7v4G+Ja495SDvCDDVrR5llrOWb/29+rjdPPHW
d9J5cbgMo3YPJpWNkKzMNyzTLrk9l8CDPbJTar9fhWWm7x895P9Q3bBAaz9JDohj
ZXvWzeFwLMn6C/K+t4I0YLPSQFyUmSDnvwFsvMqdDkI45WsG+R6QtiYqifr/ECf/
JvVZyuQylSASwQNWqjBeujumBxjd5wWJGqLNZ0GzuXgnK5xau0maEargrkH3rzdU
CKHAKXcM0YRgDFVQF8brPhas+nc1lC9Xt9tr7i+be3SfiLA9FKSKPjbgftGIC7Tb
YyPvqJMDS6rfIFDtcYK9h9Odl9Y3Qbj+wXpLQJV4cRsj4oUNdcgeFCVWiA60gRr1
zKeLsPUBvK2Pghj2vOZhONp1O1/vgs2WZkKK6U0UUFZaCLwcLpXdFTOZq1UcRbwl
HtKNMdUvpIx7PuO6LUQi5FaprxnITfTEefKa6POLckzvhQ0YRNeGaweKJaUHh23z
dC/1l7UwFYC/1CBKSV+3cL35D3GvG+XDjw6pLox+LKtRygJbZmvzbDIE/Acahcey
+8cYlxAyd7DZqDk/ArzOOt34RFVB7L0I7AArRs910rqzB3L9eduQVGId/xUGZy7F
5pSbH9ElcdWON3O7UAxD
=8Ew5
-----END PGP SIGNATURE-----
--=-=-=--
