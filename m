From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] 99fs-lib: export FSTAB_FILE before fsck call
Date: Thu, 22 Sep 2011 15:54:44 +0200
Message-ID: <4E7B3E24.10704@harald-hoyer.de>
References: <1315264935-20369-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms030907000809030205040608"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315264935-20369-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms030907000809030205040608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06.09.2011 01:22, Michal Soltys wrote:
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> ---
>  modules.d/99fs-lib/fs-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.s=
h
> index f7b20dd..fdd3304 100755
> --- a/modules.d/99fs-lib/fs-lib.sh
> +++ b/modules.d/99fs-lib/fs-lib.sh
> @@ -179,10 +179,10 @@ fsck_batch() {
>          info "    $_dev"
>      done
> =20
> +    export FSTAB_FILE
>      _out=3D"$(fsck -M -T "$@" -- -a)"
>      _ret=3D$?
> =20
> -    export FSTAB_FILE
>      fsck_tail
> =20
>      return $_ret

pushed to temporary http://git.surfsite.org/dracut.git

Thanks!


--------------ms030907000809030205040608
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
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA5MjIxMzU0NDRaMCMGCSqGSIb3DQEJBDEW
BBQMhBIbjz30oUn7iTI6HYEYKAHffTBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYI
KoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGBgzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMIGT
BgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRw
Oi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkx
ITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDCfqaMA0GCSqGSIb3DQEBAQUA
BIIBAE/KiTdH1ic4IblIU525M8IZ8oMqN1JUD0Wako/KZh5tbwnQJeJfrWtW8wXVCB22tLXM
73S3fWUSJGa0aJHDKupYw8QqX3w/cpaGvKtGF1mP4uohl0QTie7m2U1zMRYxCqG+fwk6/PO3
Wj+2gHbzQuEDA3H8Cfz5jIknFPdoboCrH0CAiD2s3bOoVWeiYMVXyjztu33KunMVvIW/Z+sY
cvLkszXohwcFuEFHMHm8RXVoyOdy8TvrcpoO7awj3KP98wyiAc8Po4dtindM+Gkl9gc1V/xs
Wz5X6FE8P1ymvGzSffRSOmIQVJlG5ZiSw3/0hpfplB6TuIfaAa1O/6647lUAAAAAAAA=
--------------ms030907000809030205040608--
