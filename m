From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2 2/4] dracut: added new module masterkey
Date: Tue,  5 Jul 2011 18:23:05 +0200
Message-ID: <1309882990-2828-3-git-send-email-roberto.sassu@polito.it>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----E6FAC37FFBD6069AADED238708A74C92"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=9oVG+H9NV8XgRd3kVWvZ8HZ/2tY=; b=ts3NyIU3nRN+/CmJhNhc/gaCHeOXhmNBaJZS3LsuHqsMgWGb0WXobwK40GDlsaZsckKfNXp8MEk/uHHgbeI2fjLuJh+1bKJJHbQEK8Ht4MS46K32WbmAyjlga5rpea1n59bOCiY9vOtTB9TtyrIiqNJW/ZnRg8vAvOciuFJv5ac=
In-Reply-To: <1309882990-2828-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------E6FAC37FFBD6069AADED238708A74C92

This module initializes a trusted/user kernel master key that will be used
to decrypt other encrypted keys.

Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
---
 dracut.kernel.7.xml                   |   17 ++++++++
 modules.d/97masterkey/README          |   59 +++++++++++++++++++++++++++++
 modules.d/97masterkey/masterkey.sh    |   67 +++++++++++++++++++++++++++++++++
 modules.d/97masterkey/module-setup.sh |   25 ++++++++++++
 4 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/97masterkey/README
 create mode 100755 modules.d/97masterkey/masterkey.sh
 create mode 100755 modules.d/97masterkey/module-setup.sh

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index a277c74..3fac18b 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -703,6 +703,23 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
         </varlistentry>
       </variablelist>
     </refsect2>
+   <refsect2>
+      <title>Kernel keys</title>
+      <variablelist>
+        <varlistentry>
+          <term><envar>masterkey=</envar><replaceable>&lt;kernel master key path name&gt;</replaceable></term>
+          <listitem>
+            <para>Set the path name of the kernel master key. e.g.: <programlisting>masterkey=/etc/keys/kmk-trusted.blob</programlisting></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term><envar>masterkeytype=</envar><replaceable>&lt;kernel master key type&gt;</replaceable></term>
+          <listitem>
+            <para>Set the type of the kernel master key. e.g.: <programlisting>masterkeytype=trusted</programlisting></para>
+          </listitem>
+        </varlistentry>
+      </variablelist>
+    </refsect2>
     <refsect2>
       <title>Deprecated, renamed Options</title>
       <para>Here is a list of options, which were used in dracut prior to version 008, and their new replacement.</para>
diff --git a/modules.d/97masterkey/README b/modules.d/97masterkey/README
new file mode 100644
index 0000000..c4e0fbd
--- /dev/null
+++ b/modules.d/97masterkey/README
@@ -0,0 +1,59 @@
+# Directions for creating the kernel master key that will be used for
+# encrypting/decrypting other keys.
+
+# A trusted key is a TPM random number, which is only ever exposed to
+# userspace as an encrypted datablob. A trusted key can be sealed to a
+# set of PCR values. For more details on trusted keys, refer to the
+# kernel keys-trusted-encrypted.txt documentation.
+$ keyctl add trusted kmk-trusted "new 32" @u
+801713097
+
+# For those systems which don't have a TPM, but want to experiment with
+# encrypted keys, create a user key of 32 random bytes. Unlike
+# trusted/encrypted keys, user type key data is visible to userspace.
+$ keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u
+144468621
+
+# Save the kernel master key (trusted type):
+$ su -c 'keyctl pipe `keyctl search @u trusted kmk-trusted` > /etc/keys/kmk-trusted.blob'
+
+# or (user type):
+$ su -c 'keyctl pipe `keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob'
+
+# A useful feature of trusted keys is that it is possible to prevent their
+# unsealing at later time by providing the parameter 'pcrlock=<pcrnum>' when
+# loading it, which causes the PCR #<pcrnum> to be extended with a random value.
+# Actually, the <pcrnum> variable is set to '11' to let users experiment with
+# this feature by using a register that is never extended during the boot,
+# making the re-sealing not necessary. In the future, the kernel master key will
+# be sealed to the PCR #14 which is extended, according to the TrustedGRUB
+# documentation[1], to the measure of the kernel and the initial ramdisk.
+
+# The kernel master key path name and type can be set in one of the following
+# ways (specified in the order in which variables are overwritten):
+
+1) use default values:
+--------------------------------------------------------------------------
+MASTERKEYTYPE=trusted
+MASTERKEY=/etc/keys/kmk-trusted-$(uname -r).blob
+--------------------------------------------------------------------------
+
+2) create the configuration file '/etc/sysconfig/masterkey' to override the
+value of one or both variables;
+
+3) specify these parameters in the kernel command line:
+- masterkey=</kernel/master/key/path>, to override the MASTERKEY variable;
+- masterkeytype=<kernel-master-key-type>, to override the MASTERKEYTYPE variable.
+
+# If only the MASTERKEYTYPE variable is overridden with the value 'user',
+# the default value of MASTERKEY will be:
+--------------------------------------------------------------------------
+MASTERKEY=/etc/keys/kmk-user-$(uname -r).blob
+--------------------------------------------------------------------------
+
+# If the system is configured to boot multiple kernels and a trusted/user key is
+# tied to each one, the MASTERKEY variable should be not modified to avoid
+# setting the path name each time a different kernel is chosen.
+
+
+[1] https://projects.sirrix.com/trac/trustedgrub/
diff --git a/modules.d/97masterkey/masterkey.sh b/modules.d/97masterkey/masterkey.sh
new file mode 100755
index 0000000..af042a9
--- /dev/null
+++ b/modules.d/97masterkey/masterkey.sh
@@ -0,0 +1,67 @@
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
+MASTERKEYSCONFIG="${NEWROOT}/etc/sysconfig/masterkey"
+PCRLOCKNUM=11
+
+load_masterkey()
+{
+    # read the configuration from the config file
+    [ -f "${MASTERKEYSCONFIG}" ] && \
+        . ${MASTERKEYSCONFIG}
+
+    # override the kernel master key path name from the 'masterkey=' parameter
+    # in the kernel command line
+    MASTERKEYARG=$(getarg masterkey=)
+    [ $? -eq 0 ] && \
+        MASTERKEY=$MASTERKEYARG
+
+    # override the kernel master key type from the 'masterkeytype=' parameter
+    # in the kernel command line
+    MASTERKEYTYPEARG=$(getarg masterkeytype=)
+    [ $? -eq 0 ] && \
+        MASTERKEYTYPE=$MASTERKEYTYPEARG
+
+    # set default values
+    [ -z "$MASTERKEYTYPE" ] && \
+        MASTERKEYTYPE="trusted"
+
+    [ -z "$MASTERKEY" ] && \
+        MASTERKEY="/etc/keys/kmk-${MASTERKEYTYPE}-$(uname -r).blob"
+
+    # set the kernel master key path name
+    MASTERKEYPATH="${NEWROOT}${MASTERKEY}"
+
+    # check for kernel master key's existence
+    if [ ! -f "${MASTERKEYPATH}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "masterkey: missing the kernel master key: kmk-${MASTERKEYTYPE}"
+        fi
+        return 1
+    fi
+
+    # read the kernel master key blob
+    KEYBLOB=$(cat ${MASTERKEYPATH})
+
+    # add the 'load' prefix if the key type is 'trusted'
+    [ "${MASTERKEYTYPE}" = "trusted" ] && \
+        KEYBLOB="load ${KEYBLOB} pcrlock=${PCRLOCKNUM}"
+
+    # load the kernel master key
+    info "Loading the kernel master key"
+    keyctl add "${MASTERKEYTYPE}" "kmk-${MASTERKEYTYPE}" "${KEYBLOB}" @u >/dev/null || {
+        info "masterkey: failed to load the kernel master key: kmk-${MASTERKEYTYPE}";
+        return 1;
+    }
+
+    return 0
+}
+
+load_masterkey
diff --git a/modules.d/97masterkey/module-setup.sh b/modules.d/97masterkey/module-setup.sh
new file mode 100755
index 0000000..64f164b
--- /dev/null
+++ b/modules.d/97masterkey/module-setup.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+check() {
+    [ "$1" = "-h" ] && {
+        [ -x "/bin/keyctl" ] || return 1
+    }
+
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+installkernel() {
+    instmods trusted encrypted
+}
+
+install() {
+    inst keyctl
+    inst uname
+    inst_hook pre-pivot 60 "$moddir/masterkey.sh"
+}
-- 
1.7.4.4


------E6FAC37FFBD6069AADED238708A74C92
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDUxNjIzNDFaMCMGCSqG
SIb3DQEJBDEWBBSEOI8O6spJPwsVN1hqDw1h5MGq9jB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQAulabwFhxSQzG6cCNyPysH1/w+
JtpQDIj+6Wv/oJLWRNGhnZHGgyI4b9j+JuMHyQlT2/o3LFjdADcQ7HWGF/w3lkwA
QPwDZk+D7uCThTzVplz1jlR65KMW2zsidDmxlc192hfoKIV0UsjYCWOLUKSqlWpa
GsmdCtdQ2QUXmD9uOotHy8+TPzydDh7DMstTS7659OCjrIY7kazH3TT8XIHjVQIA
q5frzIeOksO8angw0k4pzOVCOKtJjnS1Tj4h4WuSvJ/apYYvuyu6KfTDhljlwffI
Vot+7wPYb9pxS4n5UNFzzqpIhh7RTBtWmMSFbJEmvVLRMn9HDpReJ+rOfoDA

------E6FAC37FFBD6069AADED238708A74C92--

