From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] url-lib: extend to enable TFTP support
Date: Tue, 28 Jan 2014 15:44:23 +0100
Message-ID: <52E7C247.2070600@harald-hoyer.de>
References: <E86DFAF410366A40AD1683994061D9D605DE54@CFWEX01.americas.cray.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms060103080908040907060804"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E86DFAF410366A40AD1683994061D9D605DE54-aOe8g7e11MUSZAcGdq5asVgOPcOSbvolAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Stig Telfer <stelfer-WVYJKLFxKCc@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a cryptographically signed message in MIME format.

--------------ms060103080908040907060804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/16/2013 04:17 PM, Stig Telfer wrote:
> Libcurl has wider capabilities than those assigned to it by Dracut.  In=
 this patch to url-lib I've added registration for TFTP URLs, which I've =
found to be useful.
>=20
> Enjoy,
> Stig Telfer
>=20
>=20
> diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-l=
ib.sh
> index 12df9b4..c9d143a 100755
> --- a/modules.d/45url-lib/url-lib.sh
> +++ b/modules.d/45url-lib/url-lib.sh
> @@ -76,7 +76,7 @@ curl_fetch_url() {
>      fi
>      if [ -z "$2" ]; then echo "$outloc" ; fi
>  }
> -add_url_handler curl_fetch_url http https ftp
> +add_url_handler curl_fetch_url http https ftp tftp
>=20
>  set_http_header() {
>      echo "header =3D \"$1: $2\"" >> $CURL_HOME/.curlrc

Thanks! Pushed.



--------------ms060103080908040907060804
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDEyODE0NDQyM1ow
IwYJKoZIhvcNAQkEMRYEFCauOOSrSGwTlmV7CNtrVMtHxrNQMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGB
gzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5v
cmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEW
EnN1cHBvcnRAY2FjZXJ0Lm9yZwIDDNBzMIGTBgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYD
VQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMT
GUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2Fj
ZXJ0Lm9yZwIDDNBzMA0GCSqGSIb3DQEBAQUABIIBADIb1K6ZVaNZRJcu6Dr5FXYhLL2WEFfc
QVb5ssGIoLhL7razc+Irk6kdO6yrtk/b4I+JOATES8vVwx3dkzrLNAxPqLQMblW04hjhzDBv
J1moNPYZbwkWFKva6TmQtFI22WmpIKXtfFoiC8xj55FnXdb+5qog7Q5Ue80PfUugifTkAoNp
2k8qsfg1LXG3/JGLylXT9MQZEWSfiGlutWmy6digOsuET4PtBCsTpqFTKtbT1WzByxYa/u5R
IlDOm9PMgCBH7VX0slTcMZTOi9AL6HBaFXVHKV1y1Gmw7TWdSYHuAeVCpbaSFCpCAQ6Yj8S6
jkYl+2J+JNKrL0c/FP2R3JAAAAAAAAA=
--------------ms060103080908040907060804--
