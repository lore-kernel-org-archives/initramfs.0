From: Michael Prokop <mika@debian.org>
Subject: initramfs-tools 0.116 release
Date: Sun, 31 Aug 2014 09:53:11 +0200
Message-ID: <2014-08-31T09-47-27@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
Resent-Message-ID: <HSnUFzhvSj.A.nBE.IStAUB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I just released and uploaded version 0.116 of initramfs-tools
towards Debian/unstable, addressing several bug reports we had
pending in Debian's BTS and trying to get i-t into better shape for
the upcoming Debian/jessie release.

The shortlog has the details:

Aurelien Jarno (1):
      hook-functions: add support for virtio-mmio

Helge Deller (1):
      get_fstype: initialize FSTYPE variable

Michael Prokop (9):
      Fix hidden dependency issue with btrfs and crc32c
      Do not spawn shell when panic=... is used
      Preserve file permissions if root builds the initramfs images
      Support drop_capabilities=... boot option
      Support MODULES=dep usage on i2o hardware RAID controller
      Support usage of partitioned nbd devices with MODULES=dep
      Inform user that lsinitramfs doesn't support cpio archives yet
      Bump Standards-Version to 3.9.5
      Releasing version 0.116

maximilian attems (1):
      scripts/nfs: fix nfs mount check for possible init symlink

regards,
-mika-

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlQC1GcACgkQ2N9T+zficugmaACfZuOmln+bo6OLWdueClGCNtD5
BO0AnAytO2IPoSxJXpaRqe4SVasxwif5
=nWPO
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

