From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/8] Netroot updates and multinic test-suite
Date: Wed, 07 Oct 2009 18:57:43 +0200
Message-ID: <4ACCC887.3030800@redhat.com>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch> <4ACCAAAA.7070003@redhat.com> <4ACCC79A.2000602@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000803090106000804010508"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ACCC79A.2000602-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a cryptographically signed message in MIME format.

--------------ms000803090106000804010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

look closer!

http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;a=3Dsu=
mmary

Am 07.10.2009 18:53, schrieb Warren Togami:
> Where?  I don't see these changes at origin/master.
>
> On 10/07/2009 10:50 AM, Harald Hoyer wrote:
>> pushed most of these
>>
>> On 09/17/2009 05:16 PM, Philippe Seewer wrote:
>>> A bit late, but this is the corrected updates to netroot I sent
>>> a while ago, plus some new things that are needed.
>>>
>>> Philippe Seewer (8):
>>> Give the kernel some time to up interfaces
>>> Be a bit more optimistic when setting mtus
>>> Get rid of hostname utility
>>> Add simple STP timeout handler
>>> Add DAD to dhclient-script
>>> Add multinic test suite
>>> Move write-ifcfg to its own module
>>> Move netroot to initqueue
>>>
>>> modules.d/40network/check | 2 +-
>>> modules.d/40network/dhclient-script | 24 +++-
>>> modules.d/40network/ifup | 5 +-
>>> modules.d/40network/install | 6 +-
>>> modules.d/40network/net-genrules.sh | 2 +-
>>> modules.d/40network/netroot | 23 ++++
>>> modules.d/40network/write-ifcfg.sh | 52 --------
>>> modules.d/45ifcfg/check | 6 +
>>> modules.d/45ifcfg/install | 2 +
>>> modules.d/45ifcfg/write-ifcfg.sh | 60 +++++++++
>>> modules.d/99base/init | 11 +--
>>> test/TEST-50-MULTINIC/Makefile | 10 ++
>>> test/TEST-50-MULTINIC/client-init | 9 ++
>>> test/TEST-50-MULTINIC/dhcpd.conf | 36 ++++++
>>> test/TEST-50-MULTINIC/exports | 1 +
>>> test/TEST-50-MULTINIC/hard-off.sh | 2 +
>>> test/TEST-50-MULTINIC/hosts | 5 +
>>> test/TEST-50-MULTINIC/server-init | 30 +++++
>>> test/TEST-50-MULTINIC/test.sh | 226 +++++++++++++++++++++++++++++++++=
++
>>> 19 files changed, 436 insertions(+), 76 deletions(-)
>>> delete mode 100755 modules.d/40network/write-ifcfg.sh
>>> create mode 100755 modules.d/45ifcfg/check
>>> create mode 100755 modules.d/45ifcfg/install
>>> create mode 100755 modules.d/45ifcfg/write-ifcfg.sh
>>> create mode 100644 test/TEST-50-MULTINIC/Makefile
>>> create mode 100755 test/TEST-50-MULTINIC/client-init
>>> create mode 100644 test/TEST-50-MULTINIC/dhcpd.conf
>>> create mode 100644 test/TEST-50-MULTINIC/exports
>>> create mode 100755 test/TEST-50-MULTINIC/hard-off.sh
>>> create mode 100644 test/TEST-50-MULTINIC/hosts
>>> create mode 100755 test/TEST-50-MULTINIC/server-init
>>> create mode 100755 test/TEST-50-MULTINIC/test.sh
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" i=
n
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>



--------------ms000803090106000804010508
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKYjCC
BS0wggMVoAMCAQICAwbD1jANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wOTA0
MjIxMzEzNDFaFw0xMTA0MjIxMzEzNDFaMDkxFTATBgNVBAMTDEhhcmFsZCBIb3llcjEgMB4G
CSqGSIb3DQEJARYRaGFyYWxkQHJlZGhhdC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDcYRNZNcpUzmHaTtZXCPoLNJW7g0iD9Oo8BgGQDmLQPEIw05SINqk5f+YvIvoo
a85lze7+bfhDg3MJmcTu5C8OKnej+GfZV8qVnLLg0F1d2pSc1oKTarasUN+BSNTn8mc+BlKM
jEF5I4faGGATEgM/1pkscRofiQoWDvMAHsD/UVErVTKzLT03vczQutUYfHJuGJohXdJubQdJ
C2AyXqLJBkvns+0pNGB7qMHTVPWm9+v1I18iz0sXe5hOsTMIJFFCkia41ZVpGkwU/9ITVLtY
E+UmW897Tpi4uUE5YsPVoA3u5YIFlQFkwW1Zp9bAlmFGNlUUe2UEvpTAWWVte+qBAgMBAAGj
gf0wgfowDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNl
cnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcw
QAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMD
BglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5j
YWNlcnQub3JnMBwGA1UdEQQVMBOBEWhhcmFsZEByZWRoYXQuY29tMA0GCSqGSIb3DQEBBQUA
A4ICAQCh+mhGXDvGVDStE8cUUqnDjLL6JOcsJIrfQV/aqEQMSwD3CijxO1Q1GAp0520W71Bk
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
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGw9YwCQYFKw4DAhoF
AKCCAegwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDkxMDA3
MTY1NzQzWjAjBgkqhkiG9w0BCQQxFgQU32mSENl5dXWFoZR5dSucHbBqIeQwXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAw
eTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIw
IAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwbD1jCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBD
ZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5v
cmcCAwbD1jANBgkqhkiG9w0BAQEFAASCAQAI0ahnL1laK3yfTrYMFCfy4+KNQTMW/4tpsM8p
Bg589fqQPgHvK9xY6HrCk51hA5wmNRo8NT7N0suDbmAHvl+MsYjOW20nD9zhCrT2Ks/8N/ld
F62SjmbJDq+1lRFfoLmQPWBOhAtBvOGn1Zs0YeG4+v4Vl+teduvhQMPNIda1SsGc8xIy9eSz
ZWlLw+zQ5d0T7MbM7JP1u1mQJkuexUAc99aikDLUe58wBrJBbeWhbok1OkbByniJjhPgFuOi
AL/VL0dFNCKoTKgRjelTzp1eB1UJtbW2RGMpuduvOtek70nMwkgUlS+5Wl/z4poFFBr1RrKT
CFxC5t6OD3xiIlh5AAAAAAAA
--------------ms000803090106000804010508--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
