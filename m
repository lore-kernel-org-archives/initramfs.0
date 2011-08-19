From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: build initramfs: prelink --undo /sbin/*
Date: Fri, 19 Aug 2011 08:11:30 +0200
Message-ID: <4E4DFE92.2030301@harald-hoyer.de>
References: <4E4DDEB7.3050602@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms050705050703050500030105"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4DDEB7.3050602-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms050705050703050500030105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19.08.2011 05:55, John Reiser wrote:
> Fix a typo (omitting the 's' in "sbin") which caused
> "prelink --undo" twice on      /bin/*,  and
> "prelink --undo" omitted for  /sbin/*.
>=20
> diff --git a/dracut b/dracut
> index cf27b23..601fb6c 100755
> --- a/dracut
> +++ b/dracut
> @@ -642,7 +642,7 @@ type hardlink &>/dev/null && {
>   if strstr "$modules_loaded" " fips " && command -v prelink >/dev/null=
; then
>      for i in $initdir/bin/* \
> -       $initdir/bin/* \
> +       $initdir/sbin/* \
>         $initdir/usr/bin/* \
>         $initdir/usr/sbin/*; do
>         [ -x $i ] && prelink -u $i &>/dev/null
>=20

Thank you! Pushed!


--------------ms050705050703050500030105
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
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA4MTkwNjExMzBaMCMGCSqGSIb3DQEJBDEW
BBRHV8BLvekGu6uVn5MdQIY2IkRPOjBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYI
KoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGBgzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMIGT
BgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRw
Oi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkx
ITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMA0GCSqGSIb3DQEBAQUA
BIIBAHPtlXiBCGTQGz/g6HhnjcVrMPw7bEnv9xgakjWnZXV3+SfkuyDgxbMoURloJDRHpp64
gMj4o/6OLz/ZZgKD4vs4udtP4n7kqrePMsYSJRNSMEHYpM585fSDyMy5YiUlttqi3MLfIp85
87uN3+txuwoxK/pxkUyzvB77sKH9uZzRFjJ72F3MXrcQYTXmOY6jHJFmpSYdepJrct2Mm8SQ
NhMZfKWKoG3kEbM6a3mhomi/b/qXYMDio8Yxd4MMHOB30T9pnUSJE2+O2/LmD3thDOjAoQ2n
oUDQA8qfFxPWtiOclS8Oi2Hyb7E5hg4BOTpY3yN5je7V/hH2t5YlG2YtRXEAAAAAAAA=
--------------ms050705050703050500030105--
