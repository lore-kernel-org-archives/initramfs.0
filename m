From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH] Harden check for used modules in hostonly mode
Date: Wed, 4 Aug 2010 10:55:15 +0400
Message-ID: <201008041055.18981.arvidjaar@mail.ru>
References: <20100509182358.3768.89142.stgit@cooker>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6017745.1d1ZmLQyHl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100509182358.3768.89142.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart6017745.1d1ZmLQyHl
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Sunday 09 of May 2010 22:23:58 Andrey Borzenkov wrote:
> Make sure
that we do not accept module name which is substring of
> some other
module name. This resulted in piix being mistakenly loaded
> together
with ata_piix. It completely broke DVD access here.
>=20
>
Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
>=20

Ping. In
2.6.35 it became much worse. In 2.6.33 I had DVD as IDE and HD as PATA
which was OK. In 2.6.35 using exactly the same setup I lost any access
to HD. I.e. with these modules:

{pts/1}% lsmod | grep piix
ata_piix =20
            22460  0=20
libata                193241  4
ata_generic,pata_acpi,ata_piix,ahci
piix                    5408  1

ide_core              116373  3
ide_cd_mod,ide_pci_generic,piix

2.6.33 detects DVD as hda and HDD as
sda; with 2.6.35 only hda is detected. If I unload IDE stack and
reload ata_piix it correctly detects both HDD as sda and DVD as
sr0.

So without this patch dracut generates initrd that cannot find
root device.

Thank you!

> ---
>=20
>  dracut-functions |    2 +-
>  1
files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git
a/dracut-functions b/dracut-functions
> index fdcfb7e..ebf09c0
100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -502,7
+502,7 @@ instmods() {
>  	        [[ -f $initdir/$1 ]] && { shift;
continue; }
>  		# If we are building a host-specific initramfs and
this
>  		# module is not already loaded, move on to the next one.
>
=2D		[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && \
>
+		[[ $hostonly ]] && ! grep -qe "\<${mod//-/_}\>" /proc/modules &&
\
>  	        ! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
>  		 =20
 shift; continue;
>  		}
>=20
> --
> To unsubscribe from this list: send
the line "unsubscribe initramfs"
> in the body of a message to
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at=20
http://vger.kernel.org/majordomo-info.html


--nextPart6017745.1d1ZmLQyHl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxZDtMACgkQR6LMutpd94ySTQCfYq9m8dSlLNLr+wdEF3w4F8DP
Bv0AoMLU6JVZrIgH4Y9c3fp6GE2Xlkp0
=Oi9+
-----END PGP SIGNATURE-----

--nextPart6017745.1d1ZmLQyHl--
