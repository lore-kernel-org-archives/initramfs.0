From: Joachim Wiedorn <ad_debian@joonet.de>
Subject: Re: [RFC] Updating boot loaders in lenny and squeeze
Date: Sat, 19 Jun 2010 11:37:34 +0200
Message-ID: <20100619113734.21336621@venus.home>
References: <1276916138.14011.869.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AQ6PEiBlRwMjFdH3nCSJNc3";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org>
In-Reply-To: <1276916138.14011.869.camel@localhost>
Resent-Message-ID: <mQ2pYvjO9EN.A.NRH.bAJHMB@liszt>
List-Id: <initramfs.vger.kernel.org>
List-Post: <mailto:debian-devel@lists.debian.org>
List-Help: <mailto:debian-devel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-devel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request@lists.debian.org?subject=unsubscribe>
To: debian-devel@lists.debian.org, Ben Hutchings <ben@decadent.org.uk>
Cc: debian-kernel@lists.debian.org, Stephen Powell <zlinuxman@wowway.com>, initramfs@vger.kernel.org, William Pitcock <nenolod@dereferenced.org>

--Sig_/AQ6PEiBlRwMjFdH3nCSJNc3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

Ben Hutchings <ben@decadent.org.uk> wrote on 2010-06-19 03:55:

> However, given that route B is present in both lenny and squeeze (and
> even in etch, I think) there is no good reason for packages not to rely
> on it now.  (Well, except lack of documentation.)  All boot loader
> packages that fall into case 1 or 2 should be installing hook scripts,
> but currently only extlinux does.  I intend to remove the vestigial code
> for route A, and file bugs on all boot loaders in case 1 or 2 that do
> not use route B.

It seems this is the first step for optimizing lilo. I have checked the
sources for extlinux (package syslinux) and the scripts appears to be
simple.

> In case 1, the boot loader should also be called by update-initramfs
> when it is called outside of kernel package installation and removal.
> This is normally covered by route D, but this seems a little fragile.  I

I have tested this behaviour with a hook script for update-initramfs.=20
There is still a problem: Until now in the script is a check about which
bootloader is active. Only if no grub is installed then the script starts
lilo after install/update/remove of initrd's. But this feature shall go
away and then a hook script for update-initramfs is a good solution
(in /etc/initramfs-tools/hooks/).

Over all - thanks for you very detailed information. Now I think the lilo
package can better maintained again.

Have a nice day,

Joachim (Germany)


--Sig_/AQ6PEiBlRwMjFdH3nCSJNc3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwcj94ACgkQSiJUZB/hsIvd5wCfaJJjyMQR7j7rIX6H6Q5d3zST
lzwAn0Z5eTVERTk9oyV7um9JuuPPpxRE
=0mG6
-----END PGP SIGNATURE-----

--Sig_/AQ6PEiBlRwMjFdH3nCSJNc3--

