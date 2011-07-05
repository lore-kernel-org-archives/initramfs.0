From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2 3/4] dracut: added new module integrity
Date: Tue,  5 Jul 2011 18:23:06 +0200
Message-ID: <1309882990-2828-4-git-send-email-roberto.sassu@polito.it>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----78A91B2D54E666C405FCE6636300F837"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=l8/tmMKayffVdzUpQueS5Y7pQHs=; b=QzPhEjYzxQXwft8aFogwVuA1z/zpdf1DHwE8Tg8bQPqPLPU5kRLVp/FKC49xwg9VWfIONHY/4jOX9kgBW8e+kZBszHXbaPL5hacLa53KquHK8WmeVE2OhvcN/GN60p/4TQBPGvswxezAz1tMtbEIxUHzxl44HK8Py9KJkf0sveU=
In-Reply-To: <1309882990-2828-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------78A91B2D54E666C405FCE6636300F837

This module initializes the EVM software and permits to load a custom IMA
policy.

Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
---
 dracut.kernel.7.xml                      |    6 ++
 modules.d/98integrity/README             |   40 +++++++++++++
 modules.d/98integrity/evm-enable.sh      |   91 ++++++++++++++++++++++++++++++
 modules.d/98integrity/ima-policy-load.sh |   41 +++++++++++++
 modules.d/98integrity/module-setup.sh    |   17 ++++++
 5 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/98integrity/README
 create mode 100755 modules.d/98integrity/evm-enable.sh
 create mode 100755 modules.d/98integrity/ima-policy-load.sh
 create mode 100755 modules.d/98integrity/module-setup.sh

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 3fac18b..759871b 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -718,6 +718,12 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
             <para>Set the type of the kernel master key. e.g.: <programlisting>masterkeytype=trusted</programlisting></para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term><envar>evmkey=</envar><replaceable>&lt;EVM key path name&gt;</replaceable></term>
+          <listitem>
+            <para>Set the path name of the EVM key. e.g.: <programlisting>evmkey=/etc/keys/evm-trusted.blob</programlisting></para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2>
diff --git a/modules.d/98integrity/README b/modules.d/98integrity/README
new file mode 100644
index 0000000..f78f2cd
--- /dev/null
+++ b/modules.d/98integrity/README
@@ -0,0 +1,40 @@
+# Directions for creating the encrypted key that will be used to initialize
+# the EVM software.
+
+# Create the EVM key (encrypted key type)
+#
+# The encrypted key is a random number encrypted/decrypted using the
+# kernel master key.  The encrypted key is only exposed to userspace
+# as an encrypted datablob.
+$ keyctl add encrypted evm-key "new trusted:kmk-trusted 32" @u
+782117972
+
+# Save the encrypted key
+$ su -c 'keyctl pipe `keyctl search @u encrypted evm_key` > /etc/keys/evm-trusted.blob'
+
+# The EVM key path name can be set in one of the following ways (specified in
+# the order in which the variable is overwritten):
+
+1) use the default value:
+--------------------------------------------------------------------------
+EVMKEY=/etc/keys/evm-trusted.blob
+--------------------------------------------------------------------------
+
+2) create the configuration file '/etc/sysconfig/evm' and set the EVMKEY variable;
+
+3) specify the EVM key path name in the 'evmkey=' parameter of the kernel command
+line.
+
+
+# Directions for loading a custom IMA policy.
+
+# Write the policy following the instructions provided in the file
+# 'Documentation/ABI/testing/ima_policy' of the kernel documentation.
+
+# Save the policy in a file.
+
+# Create the configuration file '/etc/sysconfig/ima' to override the path name of
+# the IMA custom policy.
+------------- '/etc/sysconfig/ima' (with the default value) -------------
+IMAPOLICY=/etc/sysconfig/ima-policy
+-------------------------------------------------------------------------
diff --git a/modules.d/98integrity/evm-enable.sh b/modules.d/98integrity/evm-enable.sh
new file mode 100755
index 0000000..5dc734f
--- /dev/null
+++ b/modules.d/98integrity/evm-enable.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# Licensed under the GPLv2
+#
+# Copyright (C) 2011 Politecnico di Torino, Italy
+#                    TORSEC group -- http://security.polito.it
+# Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
+
+EVMSECFILE="${SECURITYFSDIR}/evm"
+EVMCONFIG="${NEWROOT}/etc/sysconfig/evm"
+EVMKEYDESC="evm-key"
+EVMKEYTYPE="encrypted"
+EVMKEYID=""
+
+load_evm_key()
+{
+    # read the configuration from the config file
+    [ -f "${EVMCONFIG}" ] && \
+        . ${EVMCONFIG}
+
+    # override the EVM key path name from the 'evmkey=' parameter in the kernel
+    # command line
+    EVMKEYARG=$(getarg evmkey=)
+    [ $? -eq 0 ] && \
+        EVMKEY=$EVMKEYARG
+
+    # set the default value
+    [ -z "$EVMKEY" ] && \
+        EVMKEY="/etc/keys/evm-trusted.blob";
+
+    # set the EVM key path name
+    EVMKEYPATH="${NEWROOT}${EVMKEY}"
+
+    # check for EVM encrypted key's existence
+    if [ ! -f "${EVMKEYPATH}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "integrity: missing the EVM encrypted key"
+        fi
+        return 1
+    fi
+
+    # read the EVM encrypted key blob
+    KEYBLOB=$(cat ${EVMKEYPATH})
+
+    # load the EVM encrypted key
+    EVMKEYID=`keyctl add ${EVMKEYTYPE} ${EVMKEYDESC} "load ${KEYBLOB}" @u`
+    [ $? -eq 0 ] || {
+        info "integrity: failed to load the EVM encrypted key: ${EVMKEYDESC}";
+        return 1;
+    }
+
+    return 0
+}
+
+unload_evm_key()
+{
+    # unlink the EVM encrypted key
+    keyctl unlink ${EVMKEYID} @u || {
+        info "integrity: failed to unlink the EVM encrypted key: ${EVMKEYDESC}";
+        return 1;
+    }
+
+    return 0
+}
+
+enable_evm()
+{
+    # check kernel support for EVM
+    if [ ! -e "${EVMSECFILE}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "integrity: EVM kernel support is disabled"
+        fi
+        return 0
+    fi
+
+    # load the EVM encrypted key
+    load_evm_key || return 1
+
+    # initialize EVM
+    info "Enabling EVM"
+    echo 1 > ${EVMSECFILE}
+
+    # unload the EVM encrypted key
+    unload_evm_key || return 1
+
+    return 0
+}
+
+enable_evm
diff --git a/modules.d/98integrity/ima-policy-load.sh b/modules.d/98integrity/ima-policy-load.sh
new file mode 100755
index 0000000..55c98bb
--- /dev/null
+++ b/modules.d/98integrity/ima-policy-load.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# Licensed under the GPLv2
+#
+# Copyright (C) 2011 Politecnico di Torino, Italy
+#                    TORSEC group -- http://security.polito.it
+# Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
+
+IMASECDIR="${SECURITYFSDIR}/ima"
+IMACONFIG="${NEWROOT}/etc/sysconfig/ima"
+IMAPOLICY="/etc/sysconfig/ima-policy"
+
+load_ima_policy()
+{
+    # check kernel support for IMA
+    if [ ! -e "${IMASECDIR}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "integrity: IMA kernel support is disabled"
+        fi
+        return 0
+    fi
+
+    # override the default configuration
+    [ -f "${IMACONFIG}" ] && \
+        . ${IMACONFIG}
+
+    # set the IMA policy path name
+    IMAPOLICYPATH="${NEWROOT}${IMAPOLICY}"
+
+    # check the existence of the IMA policy file
+    [ -f "${IMAPOLICYPATH}" ] && {
+        info "Loading the provided IMA custom policy";
+        cat ${IMAPOLICYPATH} > ${IMASECDIR}/policy;
+    }
+
+    return 0
+}
+
+load_ima_policy
diff --git a/modules.d/98integrity/module-setup.sh b/modules.d/98integrity/module-setup.sh
new file mode 100755
index 0000000..f1b97fd
--- /dev/null
+++ b/modules.d/98integrity/module-setup.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+check() {
+    return 0
+}
+
+depends() {
+    echo masterkey
+    return 0
+}
+
+install() {
+    inst_hook pre-pivot 61 "$moddir/evm-enable.sh"
+    inst_hook pre-pivot 62 "$moddir/ima-policy-load.sh"
+}
-- 
1.7.4.4


------78A91B2D54E666C405FCE6636300F837
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDUxNjIzNDZaMCMGCSqG
SIb3DQEJBDEWBBQ+7SdHUOMZSMGmAOf0u6kMwyRIgjB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQBjveLnVTWT4+iWju1ts74XOxuZ
FhloLocn12mWsxLqMV0u5Srac/VF/ybQ7xviQHy1uTWlJzMv0ZYK7d71tm1gIE3u
SO6P+7gcnh03e6u1ZazVJ+eCfUVVm3ymdwgIL9jOj4dOUGxolk+IzL1zbEQKUpC/
yrubSaRVYT0DYU+wrv5SA5iTzkC78dXhecxeRiHufTv2n5meXTHfimXqn7lirUMg
UQnsuaLAwsr3hBPGjEsUUqqDNjBg27gK2mwm4g5msQpkxdm3K+scnJ9zq2ysqAcP
NP59KbplyKl0NZVxIO0Vm1O+MqTZ2pyWS+mXmKy74/iK9kCblSEzaTYkstIJ

------78A91B2D54E666C405FCE6636300F837--

