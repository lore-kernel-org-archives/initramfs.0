From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: Fix variable name typo.
Date: Fri, 07 Feb 2014 18:45:18 +0100
Message-ID: <52F51BAE.8050701@harald-hoyer.de>
References: <1391594811-14489-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010908010602090108020408"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391594811-14489-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms010908010602090108020408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/05/2014 11:06 AM, Colin Guthrie wrote:
> This caused the root_dev variable not to be set which in turn meant tha=
t
> the root device was not whitelisted in 99base/module-setup.sh when inje=
cting
> compile-time devexists hooks in hostonly initrds. This ties the generat=
ed
> initrd to the root fs device (typically the UUID) rather than relying s=
olely
> only the root=3D kernel command line.
>=20
> While it is hostonly, not hardcoding e.g. UUIDs is still desirable. Any=

> swap partition on the host device is still added however.
> ---
>  dracut.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dracut.sh b/dracut.sh
> index ccff358..5267af5 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1005,7 +1005,7 @@ if [[ $hostonly ]]; then
>          _bdev=3D$(readlink -f "/dev/block/$_dev")
>          [[ -b $_bdev ]] && _dev=3D$_bdev
>          push host_devs $_dev
> -        [[ "$_mp" =3D=3D "/" ]] && root_dev=3D"$_dev"
> +        [[ "$mp" =3D=3D "/" ]] && root_dev=3D"$_dev"
>          push host_devs "$_dev"
>      done
> =20
>=20

Thanks! Pushed.


--------------ms010908010602090108020408
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFgDCC
BXwwggNkoAMCAQICAwzQczANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0xMzAy
MDUxMTUyMDlaFw0xNTAyMDUxMTUyMDlaMD4xFTATBgNVBAMTDEhhcmFsZCBIb3llcjElMCMG
CSqGSIb3DQEJARYWaGFyYWxkQGhhcmFsZC1ob3llci5kZTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMWJ6ewlyqPdfi2JF6XsM9hxa/l6edcmLEALUs5fblqJxA9ixAoWI+WY
0agbuZgs/iudr69sU9lJIfpXUdLdZoVUn6iWxwRuJmvgihnFpLfojx+l4wDZu5JeJUXbcml4
2wHvykdBfkfTEmUGn09CbPWeG5fAfOq37s9TIyAq4AnVWPaR4ZtIgg/s9ns9DoCAKP1pzgLn
qTu94pfLtl5dB/dpCV9seqe+YtUZqedXhFOtWkq/w2hbFA+mXSbSDts6rZMlQO8+Rzkx1fSc
aMZYBZ3OqRRxk6+oC4Tlv24Yj2lPMV+inTyXllxxqUa9NuXYK9hI+juy4fa3BIbKBCKidCEC
AwEAAaOCAUYwggFCMAwGA1UdEwEB/wQCMAAwVgYJYIZIAYb4QgENBEkWR1RvIGdldCB5b3Vy
IG93biBjZXJ0aWZpY2F0ZSBmb3IgRlJFRSBoZWFkIG92ZXIgdG8gaHR0cDovL3d3dy5DQWNl
cnQub3JnMA4GA1UdDwEB/wQEAwIDqDBABgNVHSUEOTA3BggrBgEFBQcDBAYIKwYBBQUHAwIG
CisGAQQBgjcKAwQGCisGAQQBgjcKAwMGCWCGSAGG+EIEATAyBggrBgEFBQcBAQQmMCQwIgYI
KwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2VydC5vcmcwMQYDVR0fBCowKDAmoCSgIoYgaHR0
cDovL2NybC5jYWNlcnQub3JnL3Jldm9rZS5jcmwwIQYDVR0RBBowGIEWaGFyYWxkQGhhcmFs
ZC1ob3llci5kZTANBgkqhkiG9w0BAQUFAAOCAgEAcoAhP2eXXOYJe21kF7GNzD8xVCsbjXRZ
1VjjXWCTb/LTJphp62h1K6wMz4xnBDJ2iCvPLP3jdqeVyQeBW1c5sbW69yd9Tzhz2qESFGlV
vf1YcZVw//dr86jptUizhoxIQeLyWYV9/a/Ms+UNi/PARYHiINahctx9z2mqcOXZvWnzkD+v
ZV9kNTZqY4jb60YCnfc5SjB5t5l/6cnxPL3WUBpxx7tMnYKo5XlDTbxK7EcssFnxpPSgbJvR
S0X7JqvtKscnMA8buR+IWwO1xbq7sloOhfwKbCw9XjAqND/xf8c6hNr5+AeXy/okyuz1VTIT
ytYDorJ9kf2XOcpIKt6gILvA6Vy/8Awuaup6Cv2+B5FfEH2+cgIdEw/GyEmuVXvdPUil4DJM
4ftprMZLMpUHv6YgavLaXKCIK5dzXmRDG0NjGgRzsl52ROLqutTwZG+U6DQZDJpNdCHEQN6Q
PMA1Cf2JNVhbpwwQ5QMXDW3msR9CS3n3KoiC8C6ctPSZY81zGipiBgFeJnQ1+LwtICLeFo0y
IRi1gT/ECY/59Uj+L8pehxFe1TCF/PIdxSRTKnJti5i6Bnq9asX6o1G9IQW2LA6nJexEZgYa
cGw0JH1FMyZvo9pQ0iPTVQGmnqeIeoPouQXpAB1tzlP0oQg1QMymA6BtntZ3LOXRhYVYCYs8
jdQxggOhMIIDnQIBATCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8v
d3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAf
BgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDDNBzMAkGBSsOAwIaBQCgggH1MBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDIwNzE3NDUxOFow
IwYJKoZIhvcNAQkEMRYEFCPgudB/6UZCrHNfI3E7nH/oxk8yMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGB
gzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5v
cmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEW
EnN1cHBvcnRAY2FjZXJ0Lm9yZwIDDNBzMIGTBgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYD
VQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMT
GUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2Fj
ZXJ0Lm9yZwIDDNBzMA0GCSqGSIb3DQEBAQUABIIBAAhneUPOAKylTxGh+JExPGcyEhtVJgU+
MOcacb9ltiSf8nmihVRF/umEdibofFiDuoOdWnKgLGM4pNh0MzbrbtBS4qWL3w9UUUaDBQht
zX31+xwOirEZRwioDYERxxry5PeXEhogpNDRLlNoKsjFXh1XcdwcvSiwBS/tzFALoipe3ZDm
SR94b1w+i2Yt5cdNABFVbVC5hkY0YwF9aUvV0ZLZxqJr/9y5F+wPFfih2CIOq1n60BFGgXD+
DxWaxlZArAhfgLikqvKnqtWBrjGwRWAlP0Qwcybuhl3RNX+8DpMxKoNwe17epSIGoLBUs3+B
LsuOwIFa6r2GnsycSdFXj1MAAAAAAAA=
--------------ms010908010602090108020408--
