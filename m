From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2 1/4] base/init: mount the securityfs filesystem
Date: Tue,  5 Jul 2011 18:23:04 +0200
Message-ID: <1309882990-2828-2-git-send-email-roberto.sassu@polito.it>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----ADE71C52CED8A97429E57A5200B1377F"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=J//Mqw+jS1KE2qetpcW52pe3noI=; b=RnfXZBizIBiULjJTUBV69A7XPmT3gQJFQ2nNafYPiy5Nhfu1U2NasaHBUq9q0GXJG7GEiyiv7otM9XB6NFIXoQqrlny2+FYvNowRUvMtB+spy5hJQspdXi/XgL54fAz+PVHFeYhWHasK6TQkqnfgOF8v/EhSAEkmdOx/VG8xsb4=
In-Reply-To: <1309882990-2828-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------ADE71C52CED8A97429E57A5200B1377F

Mount the securityfs filesystem and make available its location through the
exported variable SECURITYFSDIR.

Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
---
 modules.d/99base/init |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 5975b25..e2bbf3d 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -84,6 +84,12 @@ RD_DEBUG=""
 [ ! -d /sys/kernel ] && \
     mount -t sysfs -o nosuid,noexec,nodev sysfs /sys >/dev/null 2>&1
 
+SECURITYFSDIR="/sys/kernel/security"
+export SECURITYFSDIR
+if ! ismounted "${SECURITYFSDIR}"; then
+    mount -t securityfs -o nosuid,noexec,nodev ${SECURITYFSDIR} ${SECURITYFSDIR} >/dev/null 2>&1
+fi
+
 if [ -x /lib/systemd/systemd-timestamp ]; then
     RD_TIMESTAMP=$(/lib/systemd/systemd-timestamp)
 else
-- 
1.7.4.4


------ADE71C52CED8A97429E57A5200B1377F
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDUxNjIzMzZaMCMGCSqG
SIb3DQEJBDEWBBTFmGj8bZFpCNfALbgskbpIOMfiXDB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQBYHCE5WxQ6OcOAhTEG4V1c6uPS
Pe21OaX0y+QjdyQkzvDMNb+S7dHnpFV8BJGm77fbTIifNgM59lqM3Jz/tg+gCxNn
4aiUexnRcOHZ9P97k0jTZa5QUnE7JGOiV/YRR+C7N5jsaotpnWIdi7v4O83hjpSr
JwREZP/RgH3mMmA3fHPAMFWiDIEYdXNn2maa4rk9SG1ouRY+6J5I1BjM13YxxrjE
HK7Q3VF2EaZURx1zWpvHT6P4L3hCBo2+JfFtEIOA9Finhw607n5trbcqky7VPsp3
qa+NwybE/jm9vr7uVa4mn+sTd2vNpbv4Eti009w87NKCSrgwVj50IkZOzuV7

------ADE71C52CED8A97429E57A5200B1377F--

