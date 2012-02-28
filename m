From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: build initramfs faster
Date: Tue, 28 Feb 2012 21:20:42 +0100
Message-ID: <1805855.DzVeY6ZoDO@ernie>
References: <4F4D30C7.2030305@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2398417.sEUU8MATgi"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4D30C7.2030305-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2398417.sEUU8MATgi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi John and list!

Am Dienstag, 28. Februar 2012, 11:53:43 schrieb John Reiser:
> I suggest that modprobe could be extended with a command-line flag
> to read driver names from stdin, and to label the output lines with
> the input driver name (suggested syntax: a prefix line  :<driver>\n
> before any output corresponding to an input <driver>.)  Then a single
> invocation of modprobe could process all drivers.
Since libkmod exists (I don't know how much of modprobe it implements), can't 
you just write a small dedicated tool using it, that does the dependency 
discovery? That should be as fast and small as you can get.

In case modinfo could be used, I think it could also ease things a little, 
since it already does formatted output:
# modinfo unix doesnotexist btrfs
filename:       /lib/modules/3.2.6-gentoo/kernel/net/unix/unix.ko
alias:          net-pf-1
license:        GPL
depends:        
intree:         Y
vermagic:       3.2.6-gentoo SMP mod_unload modversions 
ERROR: Module doesnotexist not found.
filename:       /lib/modules/3.2.6-gentoo/kernel/fs/btrfs/btrfs.ko
license:        GPL
alias:          devname:btrfs-control
alias:          char-major-10-234
depends:        libcrc32c,zlib_deflate
intree:         Y
vermagic:       3.2.6-gentoo SMP mod_unload modversions 

Dunno if that is enough error reporting for your case, but certainly you can 
destinguish the different drivers by either a "filename:" line, or an ERROR 
line. And since modinfo does not consider the /etc/modprobe.d files, as was 
recently pointed out, you can maybe extend modinfo to do so based on a 
commandline flag - code copied from modprobe (or maybe already existing in 
libkmod)? That would still require you to write the read-from-stdin code, 
though...

--Dennis
--nextPart2398417.sEUU8MATgi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk9NNx4ACgkQjqfyF1DtJW74YQCfWIuOyXclmm0n8GRKJnHIzIJJ
0DoAoLTH9+As6B2ukocL0Lq3ac3A0FZb
=+mqj
-----END PGP SIGNATURE-----

--nextPart2398417.sEUU8MATgi--
