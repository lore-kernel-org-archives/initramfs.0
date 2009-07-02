From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] Remove modules dependency
Date: Thu, 02 Jul 2009 18:47:32 +0200
Message-ID: <4A4CE4A4.6030701@harald-hoyer.de>
References: <20090702090615.44C0E9D405C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms070001040401000606020702"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090702090615.44C0E9D405C-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms070001040401000606020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/02/2009 11:06 AM, Daniel Drake wrote:
> This makes it possible to build a dracut initramfs without modules,
> where all needed kernel drivers are built into the kernel image.
> ---
>   dracut                 |    8 +++++---
>   modules.d/99base/check |    4 ++--
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/dracut b/dracut
> index f10af83..6bd2374 100755
> --- a/dracut
> +++ b/dracut
> @@ -135,9 +135,11 @@ echo $mods_to_load
>   ## final stuff that has to happen
>
>   # generate module dependencies for the initrd
> -if ! /sbin/depmod -a -b "$initdir" $kernel; then
> -    echo "\"/sbin/depmod -a $kernel\" failed."
> -    exit 1
> +if [ -d "$initdir/lib/modules/$kernel" ]; then
> +    if ! /sbin/depmod -a -b "$initdir" $kernel; then
> +        echo "\"/sbin/depmod -a $kernel\" failed."
> +        exit 1
> +    fi
>   fi
>
>   # make sure that library links are correct and up to date
> diff --git a/modules.d/99base/check b/modules.d/99base/check
> index 5c3bc51..1128497 100755
> --- a/modules.d/99base/check
> +++ b/modules.d/99base/check
> @@ -1,3 +1,3 @@
>   #!/bin/bash
> -[[ $1 =3D -d ]]&&  echo udev-rules kernel-modules
> -exit 0
> \ No newline at end of file
> +[[ $1 =3D -d ]]&&  echo udev-rules
> +exit 0

pushed


--------------ms070001040401000606020702
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKeDCC
BTgwggMgoAMCAQICAwbD1zANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wOTA0
MjIxMzEzNTNaFw0xMTA0MjIxMzEzNTNaMD4xFTATBgNVBAMTDEhhcmFsZCBIb3llcjElMCMG
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
KoZIhvcNAQEFBQADggIBALxiL/vzgv95mAJoJvuoZML7haGKzFe7L3DTqDEZNNW/AhYiqZKW
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
VQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMT
GUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2Fj
ZXJ0Lm9yZwIDBsPXMAkGBSsOAwIaBQCgggHoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTA5MDcwMjE2NDczMlowIwYJKoZIhvcNAQkEMRYEFOxZMCsEuNnB
NZKL1aSnLuUjuVLfMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDCBkQYJKwYBBAGCNxAEMYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0
dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0
eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGw9cwgZMGCyqGSIb3DQEJ
EAILMYGDoIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2Fj
ZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3
DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGw9cwDQYJKoZIhvcNAQEBBQAEggEANhC0bIWK
CGLmSwngnosOcVD1zXrcUkkt3u8Pk8E3N0uZFmBVSklBbPjt7Medn8PKF44Ov2h+NCvaptIW
+5mcmusPIHLnhMvQhkMI47aX+JeTF4OpHWb1s6/FswR9e7TVqIdEOZdIbKkiFaXKoqiCQosB
1tZWA/HwoP3qoEKx10ggg739OPJ0R4RW3vNyfpCV5PcgDwKaGwm16O+C5/RCHADgL0zhLUnX
B8yNSBVcUtBqqtPoJ8yXNOspTACZcfNmkzvL9Sr71jGrMW9gXnOP+bX71m9IT+H+ggzSLmlU
MEj2/E+jqQEOSjvxo+dPfIyNNU8j1zusiI65OWEDEFnkvwAAAAAAAA==
--------------ms070001040401000606020702--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
