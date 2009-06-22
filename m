From: Michael Prokop <mika@debian.org>
Subject: Bug#533903: initramfs-tools: support different compression tools in mkinitramfs
Date: Tue, 23 Jun 2009 01:45:19 +0200
Message-ID: <2009-06-23T00-46-40@devnull.michael-prokop.at>
References: <20090621133116.32436.69638.reportbug@grmlvrs> <20090622214041.GE6173@stro.at>
Reply-To: Michael Prokop <mika@debian.org>, 533903@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.533903.B533903.12457143251415@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20090622214041.GE6173@stro.at>
List-Id: <initramfs.vger.kernel.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: maximilian attems <max@stro.at>
Cc: 533903@bugs.debian.org, initramfs@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* maximilian attems <max@stro.at> [20090623 00:25]:
> On Sun, 21 Jun 2009, Michael Prokop wrote:

> > Current kernel versions support different decompression options for
> > kernel and initrd:

> >   CONFIG_DECOMPRESS_GZIP
> >   CONFIG_DECOMPRESS_BZIP2
> >   CONFIG_DECOMPRESS_LZMA

> i haven't played with those, but yes why not.
> do you know what happens if initramfs is in lzma but kernel not?

Looking at the kernel source AFAICS (providing the example for lzma):

* CONFIG_KERNEL_LZMA (depends on CONFIG_HAVE_KERNEL_LZMA) is for the
  kernel related part at kernel build time (requires lzma userspace
  tools then) and relevant as well for decompressing a lzma compressed
  kernel during bootup.

* CONFIG_INITRAMFS_COMPRESSION_LZMA (depends on
  CONFIG_DECOMPRESS_LZMA) is for generating the initramfs file at
  kernel build time with lzma compression.

* CONFIG_DECOMPRESS_LZMA is for loading a lzma compressed
  (initramfs) file at bootup.


So the kernel and initramfs parts should be independent from each
other and IMHO it should be enough to check for accordingly set
CONFIG_DECOMPRESS_LZMA support in /boot/config-... when generating a
lzma compressed initramfs file via initramfs-tools.

> > initramfs-tools currently supports gzip only. I'd like to see
> > support for bzip2 and lzma as well, as both of them provide better
> > compression (which is especially interesting for live systems).

> > IMHO the user should get gzip by default (if unset) but be able to
> > choose between gzip, bzip2 and lzma. Something like
> > COMPRESSION=[gzip|bzip2|lzma] in /etc/initramfs-tools/initramfs.conf
> > should provide that.

> > I plan to provide the according code for integration (though I'm
> > running out of time right now, so it might need a few days/weeks).
> > Please ACK my idea if that's in your interest. If have any special
> > configuration variable / implementation wishes please let me know.

> adding the dracut guys on cc, afais they haven't implement it
> yet too, so maybe we can easily agree:
> ~/src/dracut$ egrep gzip dracut
> ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )

Thanks, good idea. Any input/feedback welcome.

regards,
-mika-

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKQBeO2N9T+zficugRAuv+AJ9BhKSgQWTd+VynyBKAi73NAvcxAwCfTvXu
kAxKgeccE/RXiyA2WZAb4vc=
=Xd1k
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--


