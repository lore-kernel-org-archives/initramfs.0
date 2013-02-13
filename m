From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH 6/6] kernel-modules: Add ehci support for kernel 3.8+
Date: Wed, 13 Feb 2013 17:42:52 +0100
Message-ID: <511BC28C.9080902@harald-hoyer.de>
References: <1358972106-2395-1-git-send-email-colin@mageia.org> <1358972106-2395-7-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms040401080803090808030008"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-7-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms040401080803090808030008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 23.01.2013 21:15, schrieb Colin Guthrie:
> From: Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
>=20
> Kernel 3.8 split ehci-hcd into ehci-hcd, ehci-pci and ehci-platform,
> so adapt the list to cope with this change.
> ---
>  modules.d/90kernel-modules/module-setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90k=
ernel-modules/module-setup.sh
> index 633a59d..f75bb61 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -41,7 +41,8 @@ installkernel() {
>              sdhci_esdhc_imx mmci sdhci_tegra mvsdio \
>              omap omapdrm omap_hsmmc sdhci_dove ahci_platform pata_imx =
sata_mv \
>              atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-lo=
gitech \
> -            hid-logitech-dj hid-microsoft ehci-hcd ohci-hcd uhci-hcd x=
hci-hcd hid_generic \
> +            hid-logitech-dj hid-microsoft ehci-hcd ehci-pci ehci-platf=
orm \
> +            ohci-hcd uhci-hcd xhci-hcd hid_generic \
>              unix
> =20
>          # install virtual machine support
>=20

merged, thanks


--------------ms040401080803090808030008
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift

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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEzMDIxMzE2NDI1Mlow
IwYJKoZIhvcNAQkEMRYEFF+I91VEE5TqsTktZ+RQTcA3B0KoMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgZEGCSsGAQQBgjcQBDGB
gzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5v
cmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEW
EnN1cHBvcnRAY2FjZXJ0Lm9yZwIDDNBzMIGTBgsqhkiG9w0BCRACCzGBg6CBgDB5MRAwDgYD
VQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMT
GUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2Fj
ZXJ0Lm9yZwIDDNBzMA0GCSqGSIb3DQEBAQUABIIBAFx2iD6RNTBV7uEek1CxamNvfw15HZ+E
WKHE9XRo0VPegiq3L90O2qHiTe5jf+kIZQnbZStFHGs+FswWaFfF55iUsbCpOYsfSIebdsEK
XnHFuYT/sOlyQl4c5R1K7zk3uYdvI6eww2RdiaIh7+38x78Ch3hSz0kv4rCaWJ0G1oudIlBw
LUlPzXPJHXkaQZQvkVkw4dWzAD9X2Uefs5dXeAkvsUBraZbvxNsQGNa/81f45ZBK87EHj456
iL9r6Uz9kTlh12h1nJ0PPe4wnhODw81kzEN92ej+NP6mvtKECRZfjgn4zy0StLZcUekZzVu6
WLJG/20/RDtk4yQHVzTsWRQAAAAAAAA=
--------------ms040401080803090808030008--
