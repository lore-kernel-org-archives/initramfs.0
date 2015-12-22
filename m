From: Andrey Utkin <andrey.od.utkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: LUKS rootfs & resume from suspend-to-disk - hangs on boot
Date: Tue, 22 Dec 2015 23:58:01 +0200
Message-ID: <5679C769.3050903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GjmRWicGnwNPRk8GpTHMXLPNxvCFK0fCm"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type;
        bh=fTC34KPhmO4/384hfmHfczhxkK9rkp6dQrKeDLAU+y4=;
        b=NulfByZLyus25+739uh6rqvxDJR7udk2BdtelYxYotLFGHaYbLXGftMs66FK1ganks
         CNbldCP6j1JMKR2nB+xLG1A5U59g16NXx2cYfBuxktRHEV+GntVkgvp54D5UylrDqXmy
         e3ig+Fl6czH+v9vGNx+anqRExNRa6nr2M1rCGMKQgSY29DIdo5njx4pkKo5AXksURPnQ
         dEoP+cA17xx/cUzFNaAo/5scR3MhWAMH1A2voR93tSfgH6SmGxG0u/RPunP7XX/aUPAJ
         H6LZMTrBpD/hhSFmdBpYhV9LHyA0grpBmwTQmXBtNMbSuyh8OGY0zrqOTMJz6f3U48kN
         6lIg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GjmRWicGnwNPRk8GpTHMXLPNxvCFK0fCm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I have my rootfs and swap partition LUKS-encrypted. Now I cannot
make resume from swap to work. I can only get working my LUKS rootfs
alone, without resume.
The working way, I give options

rd.luks.uuid=3D(rootfs-uuid)
rd.luks.key=3D/key:UUID=3D(boot uuid)
root=3D/dev/mapper/luks-(rootfs-uuid)

But if I remove rd.luks.uuid (specifying to open all LUKS devices), or
if I put another rd.luks.uuid parameter for my swap partition, no matter
if I specify rd.luks.key with luksdev part twice, or anyhow, it hangs on
boot. What's supposed way to accomplish this?

Note that on the same USB stick where I have /boot, I have another
partition encrypted with another key. Maybe this is what makes it hang?

I can provide any logs required, but I've tried many configurations and
nothing works, so I am asking how it is supposed to work at all, so that
I report the bug and logs against correct configuration.

Thanks in advance.

--=20
OpenPGP usage is appreciated (it also helps your letter to bypass spam
filters). To email me with encryption easily, go
https://encrypt.to/0xC6FCDB11
I also use Jabber and appreciate you to use it, too.


--GjmRWicGnwNPRk8GpTHMXLPNxvCFK0fCm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWecdpAAoJENVqfNDG/NsRlv4QAJtkrFs41MAHAIm6LgJ5bBvP
2tnD4o6LMRgxldxkSURGE2evJGQkIIO4fTvlFgnu0StkkJnB3y70oYcjVFzBOS3g
htK5d7zSoJ+3weNw2/kWt6vz9ELY1PP6ikoMB1zGUhWKEsCxZS82E/lcGsrY0Y62
UbDPEZgnBvIqqJWfv57TGQEUgLb15niZuYqp6YxLAMAHPD5z+xJAryJLyEKXiFME
cfk2/DZdEkh4WNXgGS9rLI8DEG0fOa8fCya1iAfa+aWF+0YD8W2h6+bATnbZ8HRx
tP7hp3g6c6MAu5nsKikkMScgFWu56nz6uqyPkkCUSmS2Ec9VnbEXTPmgWi32UNa/
D2ZGlEPAHeMtt+WgsCTo8ewKeT3EWvAIQMbNb9YKryBS5h0N+dLTj5+xeX1QAb2O
xNSTzHiIzPUrnae72DOSjihnNC0M0/q237H3Cm+yaTjtE2rIisDAXMbTVu7Ti3E7
6ZPKy2Ocdh9CbAkW5suK9F9+3ZUgxlI1zzmieEbymxoqxWNburA5pUZdjybl64pK
OLa2Eq1l5KOjIrIOdyu7N9cmo05+GgQvfn/OXD/ywpLyrRWfmoNKHWN6SMiYngLG
1r7mNSpfAJtcbZvCNDNWNUXlf9eB/mSjYJv9ho2jdaZPW7a201Cg77geHU/KTbMF
jGaYdgMvoQmSurL7BQi+
=HIK+
-----END PGP SIGNATURE-----

--GjmRWicGnwNPRk8GpTHMXLPNxvCFK0fCm--
