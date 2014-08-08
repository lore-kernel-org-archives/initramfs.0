From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: cryptsetup + lvm order and crypt name
Date: Fri, 08 Aug 2014 09:16:02 +0200
Message-ID: <8738d7pi31.fsf@freja.aidecoe.name>
References: <53E15A01.9040604@gmx.net> <871tsuks7j.fsf@freja.aidecoe.name> <53E3E5F9.4040507@gmx.net> <8761i3pi87.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8761i3pi87.fsf-txNSArhcdoZACdk+e2mhCEEMvNT87kid@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Claudio Clemens <asturio-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(I've forgot to CC list, resending.)

> In which file should I write this Options, and how should the line
> look like? I tried also in /etc/conf.d/ and /etc/cmdline.d/, but I
> can't get away with the feeling, that they are not read.

If you are eventually dropped to shell, you can list cmdline parameters
with:

  cat /proc/cmdline


> And after setting the file correctly, what should I run? dracut, to
> build the initrd again, or grub-update, to put the options in the boot
> parameter?

First of all I advise to call dracut like that:

  dracut -H '' <kernel-version>

it will generate host-specific initramfs for specified kernel version in
default location.  Later edit variable GRUB_CMDLINE_LINUX_DEFAULT in
/etc/default/grub and put there parameters you want. After that
regenerate grub2 config with grub2-mkconfig.

I hope that helps. :-)


Cheers,

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJT5HkyAAoJEPATRTHh2/q1ejUIAIeM/aobSWb2q/SP41kDHjCd
pf1I8MItmTqRuah++oa+kGWLU+JoizzwiU945yhuAidlUftxRgJulJS6JoT/gUgR
QWiJ4lIxOYtbxPJJaC1L/1hu3OrrJSictKwqGfbeihBk7Kyl+eb2/qMJhWphxGgC
ZuZtM/BCOxpLsN2PZlkGjkL3EwoawKeoQh65MjJZqSV0dDUHaczYO9CozvW2a6dh
kDB+rYwXU/LA8fW9G9Pa0WokrqSo4+JDwO23IfqaoPDZ40ZaNCqbF6Mlu9yJ/Jrx
jPrXyECry8YRyp/Wq7PIpZPpD/3TJALG/7ZfE+YryYxcdEyglgIobvgY6g/FrAo=
=DeW2
-----END PGP SIGNATURE-----
--=-=-=--
