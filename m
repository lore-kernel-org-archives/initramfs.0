From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] inst_symlink: create parent dir if doesn't exist
Date: Mon, 26 Mar 2012 09:39:03 +0200
Message-ID: <1332747454-sup-6881@raeviah>
References: <1332713513-17889-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1332747543-552962-14066-2723-1-="
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1332713513-17889-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1332747543-552962-14066-2723-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Amadeusz =C5=BBo=C5=82nowski's message of 2012-03-26 00:11:=
53 +0200:
> +    set -x
> +    [[ ! -e $initdir/${_target%/*} ]] && inst_dir "${_target%/*}"
>      [[ -d ${_target%/*} ]] && _target=3D$(readlink -f ${_target%/*})/$=
{_target##*/}
>      ln -sfn $(convert_abs_rel "${_target}" "${_realsrc}") "$initdir/$_=
target"
> +    set +x

Sorry, I have forgot to remove debug. Corrected patch in next post.

-- =

Amadeusz =C5=BBo=C5=82nowski

--=-1332747543-552962-14066-2723-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPcB0XAAoJEPATRTHh2/q1g7kIAJqIq+MdTxoE4TW0N+xdqpiC
8AJ66DixA01+F1n+tCJbhTp8V1PEit6jlsNAUF3lt6kMVAnnhKYmhrPUVlA+Tk4G
FflwVujUL7ifild/O6i0IjzIztL//ALNcrwPlpLNs9PmmgwBmMZFOhgPXlXAdtEd
KRPCWZiCn+tfk3Or6dC/u4j2tRKxcDbP0VVnr10inyQeyfXi9JMsRqzlciZbLnHR
ybDnCCpPcylGCxt9QWbowH+ig4Wd7RDIFeCSBojHdWR7xY2MLsZWTUehu0851Nd9
pE0fRfWGUptwkhiOi07ZbJwa4UHn0AGNuhraHfuUGglg48VWRKvEDIlzEYwPiUw=
=wW/n
-----END PGP SIGNATURE-----

--=-1332747543-552962-14066-2723-1-=--
