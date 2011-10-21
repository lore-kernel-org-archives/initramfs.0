From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] remove the xen dracut module
Date: Fri, 21 Oct 2011 13:19:05 +0200
Message-ID: <4EA15529.3060105@harald-hoyer.de>
References: <1319130906-14267-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms080109080808010809090200"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319130906-14267-1-git-send-email-pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms080109080808010809090200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

thanks! pushed


On 20.10.2011 19:15, Paolo Bonzini wrote:
> The Xen module is unnecessary and it has been for a while. =20
> Most Xen systems will not be using the module, even now, because
> xen-detect is not installed by default on most Xen systems, and
> dracut uses xen-detect to decide whether to include the module.
>=20
> It also has some problems:
>=20
> 1) it does not try loading xen_platform_pci;
>=20
> 2) it loads modules unnecessarily; modules.alias is where all Xen suppo=
rt
> should reside.  Assuming xenbus_probe_frontend and xen_platform_pci
> are loaded so that Xen devices are probed, other modules are picked up
> automatically thanks to aliases such as
>=20
>     alias xen:vbd xen_blkfront
>=20
> 3) Even not-so-recent kernels (say 2.6.32) require the xen_platform_pci=

> and xenbus_probe_frontend modules even for non-paravirtualized guests.
> 60xen/module-setup.sh picks the module only for PV guests.
>=20
> So, just require xenbus_probe_frontend to be builtin, and also
> xen_platform_pci for fully-virtualized guests, and remove the module.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> ---
>  modules.d/60xen/module-setup.sh |   42 -------------------------------=
--------
>  modules.d/60xen/xen-pre-udev.sh |   13 ------------
>  2 files changed, 0 insertions(+), 55 deletions(-)
>  delete mode 100755 modules.d/60xen/module-setup.sh
>  delete mode 100755 modules.d/60xen/xen-pre-udev.sh
>=20
> diff --git a/modules.d/60xen/module-setup.sh b/modules.d/60xen/module-s=
etup.sh
> deleted file mode 100755
> index 75309be..0000000
> --- a/modules.d/60xen/module-setup.sh
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -#!/bin/bash
> -# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
> -# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
> -
> -check() {
> -    # No Xen-detect? Boo!!
> -    if ! hash xen-detect 2>/dev/null; then
> -        [[ -d /usr/lib/xen-default ]] && \
> -            hash -p /usr/lib/xen-default/bin/xen-detect xen-detect || =
return 1
> -    fi
> -
> -    . $dracutfunctions
> -    [[ $debug ]] && set -x
> -
> -    # Yes, we are under Xen PV env.
> -    xen-detect | grep -q -v PV || return 0
> -
> -    return 1
> -}
> -
> -depends() {
> -    return 0
> -}
> -
> -installkernel() {
> -    local _i
> -    for _i in \
> -        xenbus_probe_frontend xen-pcifront \
> -        xen-fbfront xen-kbdfront xen-blkfront xen-netfront \
> -        ; do
> -        modinfo -k $kernel $_i >/dev/null 2>&1 && instmods $_i
> -    done
> -
> -}
> -
> -install() {
> -    hash xen-detect 2>/dev/null || \
> -        hash -p /usr/lib/xen-default/bin/xen-detect xen-detect
> -    inst "$(hash -t xen-detect)" /sbin/xen-detect
> -    inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
> -}
> -
> diff --git a/modules.d/60xen/xen-pre-udev.sh b/modules.d/60xen/xen-pre-=
udev.sh
> deleted file mode 100755
> index f039aaa..0000000
> --- a/modules.d/60xen/xen-pre-udev.sh
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#!/bin/sh
> -# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
> -# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
> -xen-detect
> -RC=3D$?
> -if [ "$RC" =3D "1" ] ; then
> -    modprobe xenbus_probe_frontend
> -    modprobe xen-kbdfront
> -    modprobe xen-fbfront
> -    modprobe xen-blkfront
> -    modprobe xen-netfront
> -    modprobe xen-pcifront
> -fi



--------------ms080109080808010809090200
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFPDCC
BTgwggMgoAMCAQICAwn6mjANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0xMTAz
MjMxMTU4MTVaFw0xMzAzMjIxMTU4MTVaMD4xFTATBgNVBAMTDEhhcmFsZCBIb3llcjElMCMG
CSqGSIb3DQEJARYWaGFyYWxkQGhhcmFsZC1ob3llci5kZTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMWJ6ewlyqPdfi2JF6XsM9hxa/l6edcmLEALUs5fblqJxA9ixAoWI+WY
0agbuZgs/iudr69sU9lJIfpXUdLdZoVUn6iWxwRuJmvgihnFpLfojx+l4wDZu5JeJUXbcml4
2wHvykdBfkfTEmUGn09CbPWeG5fAfOq37s9TIyAq4AnVWPaR4ZtIgg/s9ns9DoCAKP1pzgLn
qTu94pfLtl5dB/dpCV9seqe+YtUZqedXhFOtWkq/w2hbFA+mXSbSDts6rZMlQO8+Rzkx1fSc
aMZYBZ3OqRRxk6+oC4Tlv24Yj2lPMV+inTyXllxxqUa9NuXYK9hI+juy4fa3BIbKBCKidCEC
AwEAAaOCAQIwgf8wDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIg
b3duIGNlcnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2Vy
dC5vcmcwQAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEE
AYI3CgMDBglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8v
b2NzcC5jYWNlcnQub3JnMCEGA1UdEQQaMBiBFmhhcmFsZEBoYXJhbGQtaG95ZXIuZGUwDQYJ
KoZIhvcNAQEFBQADggIBAFZcfmCgsk7743CPH2jmToVyC2hotfjnKsrCyky/b0GH0Ov9Y4TL
+0uGcrq0vZeC/xEKKCmaUF5bAPtYLIJGByV8xVzUUzCypkmh5eyR93OuWnbNpD0VW+u3If5v
m93CXp11bUh1eDk2OOP0irJNmze0GqohW/hjibY6exN183zOc75xD1Horf1j1/JcJocJR0aq
hU4mQRnYqxc2Rhkeyd2vueWDV69pc+orqLinT6O09EpPVo/Yxh6Xq/fM5gTong1Hf2hFVwGu
9KIotNPMauU/IY4Hedxc6uXIZ2UEW2lpmfNh242Z6Bv0/nir4iOtOr8EcowxNYs7yXLBSVh7
X8eYIcUY9qu6SJ0L2tHPIwhK9JjZXD9mg/ko/zI3+wHvJbU/kGsQGCvKTdF44QnRv1YMiQBP
X5M1R1lun+4lJ8XT02Xo0tiDQqbtCsO3nFmZ5DfRBuFK+uZj3JsuwiUPuxFhLE2jZIBxi0yX
JA71+hbbrTJ72dBRJD6Q2SlBzPLMAvvGQTEH23n5QYlCp2WuGujPpR2lD7CdGMjxhwbTPbXy
Ontf2+OqNS5EEu+gJoD3k4wLQNsWjaPD/Oi06I4VkO4VQgo9ddpDgTmEuoa5sOstzrRA+eBZ
8/g/K/LqlLVXvux5KLrmrvNmQO4UHBTOFe3XMRvL2wNrz8Ay8xaO//TIMYIDlDCCA5ACAQEw
gYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3Jn
MSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJz
dXBwb3J0QGNhY2VydC5vcmcCAwn6mjAJBgUrDgMCGgUAoIIB6DAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTEwMjExMTE5MDVaMCMGCSqGSIb3DQEJBDEW
BBTcRZa+ULiO3Xm12NEcEbwV5FTK7TBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYI
KoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGBgzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMIGT
BgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRw
Oi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkx
ITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMA0GCSqGSIb3DQEBAQUA
BIIBAFdjb8yq8Ry+thPRw8aZ3Kf80cquBcFeX6WbTX0ekbtsXs/LpnAEoFrZymA1WsKXj3wh
pZulC7lX5r0FUXziOlw7i8/qr9jZbCMdMFN7iIhhy5/o2q4+dpVwc0Vzood/zVgFeoPKPjfv
5+j5rXB3WisfZ7TXngNgaud9M9bW8oPphyi7dYSIiRtDhbVUyiqxvmZQD1iLhXyVhZ3/xSgm
LRjw/BRObA7N8f1JJaXXT1KFPmgv7bDrc3XSUZcxm/rF70KpXuXfVyolQusfHSc8Q28QPDEa
3akPjM6Ih4UsiMbwNpZns0zQe+lqdw7n5eBGL8NU95/FWMGtLeBByC2XIHAAAAAAAAA=
--------------ms080109080808010809090200--
