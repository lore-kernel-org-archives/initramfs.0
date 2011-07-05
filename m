From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2 0/4] new dracut modules
Date: Tue,  5 Jul 2011 18:23:03 +0200
Message-ID: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----224B9310C1EAFA87999937D16AE77643"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:mime-version:content-type; s=smtpout; bh=UvhEmDKZE/MAVVlnPBkMu0oY3k0=; b=UsLu7QAoSschRXg4aVv8TKMRogMpRkOrTiw16+BTRrT8ruGDSjEb0tFJeAASkLmVHsBbhTKB0NXCm/1NA63cmC6+zn1oX1412fDshuxhs6kZIe56N48VAtno8TbIoURx2HceNbynzwgjboj9EL+agticELk36nmDjRrXNIxggF4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------224B9310C1EAFA87999937D16AE77643

Hi all

this patch set introduces three new modules (masterkey, integrity and
ecryptfs) and allows to mount the securityfs filesystem from the initial
ramdisk.

These patches are based upon the first version sent by Mimi Zohar, which
can be retrieved at the address:

http://article.gmane.org/gmane.linux.kernel.initramfs/1910

Roberto Sassu 


Roberto Sassu (4):
  base/init: mount the securityfs filesystem
  dracut: added new module masterkey
  dracut: added new module integrity
  dracut: added new module ecryptfs

 dracut.kernel.7.xml                      |   29 +++++++++
 modules.d/97masterkey/README             |   59 ++++++++++++++++++
 modules.d/97masterkey/masterkey.sh       |   67 +++++++++++++++++++++
 modules.d/97masterkey/module-setup.sh    |   25 ++++++++
 modules.d/98ecryptfs/README              |   45 ++++++++++++++
 modules.d/98ecryptfs/ecryptfs-mount.sh   |   95 ++++++++++++++++++++++++++++++
 modules.d/98ecryptfs/module-setup.sh     |   20 ++++++
 modules.d/98integrity/README             |   40 +++++++++++++
 modules.d/98integrity/evm-enable.sh      |   91 ++++++++++++++++++++++++++++
 modules.d/98integrity/ima-policy-load.sh |   41 +++++++++++++
 modules.d/98integrity/module-setup.sh    |   17 +++++
 modules.d/99base/init                    |    6 ++
 12 files changed, 535 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/97masterkey/README
 create mode 100755 modules.d/97masterkey/masterkey.sh
 create mode 100755 modules.d/97masterkey/module-setup.sh
 create mode 100644 modules.d/98ecryptfs/README
 create mode 100755 modules.d/98ecryptfs/ecryptfs-mount.sh
 create mode 100755 modules.d/98ecryptfs/module-setup.sh
 create mode 100644 modules.d/98integrity/README
 create mode 100755 modules.d/98integrity/evm-enable.sh
 create mode 100755 modules.d/98integrity/ima-policy-load.sh
 create mode 100755 modules.d/98integrity/module-setup.sh

-- 
1.7.4.4


------224B9310C1EAFA87999937D16AE77643
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIICQYJKoZIhvcNAQcCoIIH+jCCB/YCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBWQwggVgMIIESKADAgECAgICuzANBgkqhkiG9w0BAQUFADBlMQswCQYD
VQQGEwJJVDEeMBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMTYwNAYDVQQD
Ey1Qb2xpdGVjbmljbyBkaSBUb3Jpbm8gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
HhcNMTAxMjIwMTExOTU0WhcNMTUxMjMxMjM1OTU5WjBfMQswCQYDVQQGEwJJVDEe
MBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMRcwFQYDVQQDEw5Sb2JlcnRv
ICBTYXNzdTEXMBUGCgmSJomT8ixkAQETB2QwMjEzMDUwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDS6p4SaJdmmJHJu9On9ZohhBFE2GgYiY7YtRnhhQJA
NfOtHEhSbpUMaSOfq/Pna6ipR5nAFrlM8cOGcSHZdxrPcgzeJU7F2v1fl2ThvFOc
TIkcC1aAJGQUuCaCXDlQt+KFecJWTrRZnalMHZueO+J6cgHcvR1CQz5e88dSzo3Q
XZy0w/hxGL9Ht9velqsl48ohBk2rs/svAOCp6GfqT1Yxwx1p87d3ViTrmuZB4/X+
da39nJqmo6AZ/y3Zg+r91BgNcfsHVqFT0JTcG6qRIaeqTtqVYpYl+rH1rZzYCakD
yQyys66sBvaXyaiMr0M+SpyH+LaGz5bDn5Odq16FYEq7AgMBAAGjggIeMIICGjAO
BgNVHQ8BAf8EBAMCA/gwJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMDBggr
BgEFBQcDBDAiBgNVHREEGzAZgRdyb2JlcnRvLnNhc3N1QHBvbGl0by5pdDAMBgNV
HRMBAf8EAjAAMB0GA1UdDgQWBBQgKbXSXn+j769x0tsZQ9pSOzIIdDAfBgNVHSME
GDAWgBTNm1tbnup2IcQQaOjSLTfbHy/I5DCBywYDVR0gBIHDMIHAMD4GCisGAQQB
qQcBAQIwMDAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9j
cHMvMS4yLzBEBgorBgEEAakHAgECMDYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
aXRhbHkuZXVyb3BraS5vcmcvY2EvY3BzLzEuMi8wOAYKKwYBBAGVYgECAjAqMCgG
CCsGAQUFBwIBFhxodHRwOi8vY2EucG9saXRvLml0L2Nwcy8yLjIvMGYGCCsGAQUF
BwEBBFowWDAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AucG9saXRvLml0MDMGCCsG
AQUFBzAChidodHRwOi8vY2EucG9saXRvLml0L2NlcnRzL3BvbGl0b19jYS5jZXIw
NwYDVR0fBDAwLjAsoCqgKIYmaHR0cDovL2NhLnBvbGl0by5pdC9jcmwvcG9saXRv
X2NybC5jcmwwDQYJKoZIhvcNAQEFBQADggEBADMe0aHcBJXV6pMJPVVSt1Vazd8Y
LuTLO45Igs9Sb2LuaO6pvcDGvq9dEJnBhP1B+zBAK6WEA1PWb66xC4QXaJnlGZTX
S3XeBivHWm6BNOH2kNeU0HBeGZCV/n5r70TPxkEAcc7u8YY2i6CiMM428YhZK8Zj
oN9D3QNIRf4HZgh0FTbf8eL/XvBbK/oPC+Rew+Qql6M3DHnaS1q2SKUwwO/4VXA4
JsOdatFI68AMXH0Xx9UIcjRi+kvsyvwHlc0Z8AoAtfRMoIl4zFF4Qaowec2UunBK
YlqPpFTtU9czuoEP12A86nqSVsoNok2mZOeYa9IdIjeE2rfdKx6k3YNRg08xggJt
MIICaQIBATBrMGUxCzAJBgNVBAYTAklUMR4wHAYDVQQKExVQb2xpdGVjbmljbyBk
aSBUb3Jpbm8xNjA0BgNVBAMTLVBvbGl0ZWNuaWNvIGRpIFRvcmlubyBDZXJ0aWZp
Y2F0aW9uIEF1dGhvcml0eQICArswCQYFKw4DAhoFAKCB2DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDUxNjIzMTBaMCMGCSqG
SIb3DQEJBDEWBBS3mVS1zkJVBsMvLD6YzgjnOIWhUDB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQCQOFvpmE9bQSS+9D138nXph5tO
6XQ6q/risJVAN/n0946HmdV+EHGMnmzhXvp1wXzTC4sChYFUtFdSJ99Az+hnMUv7
H/o6uaTfJHM551zYiG8fowrtpJ6QResBlpEPA2ms5/nc0uAWDFQtT5RnG7WubEZK
09Q2Z79Uwwpyh3oV3LxY21g5dMYH7TLrURSqX/qri0FOnKmsk/eESTbVh1/TnAyF
tU5XYqWd/KBZfM6UMh48glxntGtm9xm45lWuWqJ9l9YZpCbGl8IJrD+/2XBaZ4d+
kYUoQMchVT2SRTNzYN70LrhsHnvHLpLwPVuRZZxJ+LgJgr8VkIiDZucwXVix

------224B9310C1EAFA87999937D16AE77643--

