From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v3 2/4] dracut: added new module masterkey
Date: Fri,  8 Jul 2011 14:11:00 +0200
Message-ID: <1310127065-23292-3-git-send-email-roberto.sassu@polito.it>
References: <1310127065-23292-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----3B0D058E1DA7261331FAD246F76721C8"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=huGYc09R4tNUVmGl+0j/yzqCWlc=; b=HRKdB7DBHvlue18v8y+tg3TQR3vgZ5IQlI8d9DVNvsje38I1eIROlWupujkFv9Ma/SfgtP6uRMq8xe5u1GvkJu/A70yBQVFB8v6aJsa56GDZgm8ywy+iGvvTABDagPEp7uGV6JCn1wRAHBKohI/+OITx33zehnkpYEcQ2q/6rl0=
In-Reply-To: <1310127065-23292-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------3B0D058E1DA7261331FAD246F76721C8

This module initializes a trusted/user kernel master key that will be used
to decrypt other encrypted keys.

Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
---
 dracut.kernel.7.xml                   |   17 +++++++
 modules.d/97masterkey/README          |   68 +++++++++++++++++++++++++++++
 modules.d/97masterkey/masterkey.sh    |   75 +++++++++++++++++++++++++++++++++
 modules.d/97masterkey/module-setup.sh |   25 +++++++++++
 4 files changed, 185 insertions(+), 0 deletions(-)
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
index 0000000..524ccfc
--- /dev/null
+++ b/modules.d/97masterkey/README
@@ -0,0 +1,68 @@
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
+MULTIKERNELMODE="NO"
+MASTERKEYTYPE="trusted"
+MASTERKEY="/etc/keys/kmk-${MASTERKEYTYPE}.blob"
+--------------------------------------------------------------------------
+
+2) create the configuration file '/etc/sysconfig/masterkey' to override the
+value of one or all variables;
+
+3) specify these parameters in the kernel command line:
+- masterkey=</kernel/master/key/path>, to override the MASTERKEY variable;
+- masterkeytype=<kernel-master-key-type>, to override the MASTERKEYTYPE variable.
+
+# The variable MULTIKERNELMODE has been introduced to support multi boot
+# configurations, where a trusted/user key is tied to a specific kernel and
+# initial ramdisk. In this case, setting MULTIKERNELMODE to 'YES' will cause the
+# kernel version to be added to the default masterkey path name, so that the
+# MASTERKEY variable should not be overridden each time a different kernel is
+# chosen. The default value of MASTERKEY will be equal to:
+--------------------------------------------------------------------------
+MASTERKEY="/etc/keys/kmk-${MASTERKEYTYPE}-$(uname -r).blob"
+--------------------------------------------------------------------------
+
+# The masterkey path name also depends on the value of MASTERKEYTYPE, as reported
+# in the default values for defined variables. For example, if only MASTERKEYTYPE
+# is overridden by setting it to 'user' in the configuration file or from the
+# kernel command line, the value of MASTERKEY will be:
+--------------------------------------------------------------------------
+MASTERKEY="/etc/keys/kmk-user.blob"
+--------------------------------------------------------------------------
+
+
+[1] https://projects.sirrix.com/trac/trustedgrub/
diff --git a/modules.d/97masterkey/masterkey.sh b/modules.d/97masterkey/masterkey.sh
new file mode 100755
index 0000000..0cd009a
--- /dev/null
+++ b/modules.d/97masterkey/masterkey.sh
@@ -0,0 +1,75 @@
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
+MULTIKERNELMODE="NO"
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
+        MASTERKEY=${MASTERKEYARG}
+
+    # override the kernel master key type from the 'masterkeytype=' parameter
+    # in the kernel command line
+    MASTERKEYTYPEARG=$(getarg masterkeytype=)
+    [ $? -eq 0 ] && \
+        MASTERKEYTYPE=${MASTERKEYTYPEARG}
+
+    # set default values
+    [ -z "${MASTERKEYTYPE}" ] && \
+        MASTERKEYTYPE="trusted"
+
+    if [ -z "${MASTERKEY}" ]; then
+        # append the kernel version to the default masterkey path name
+        # if MULTIKERNELMODE is set to YES
+        if [ "${MULTIKERNELMODE}" = "YES" ]; then
+            MASTERKEY="/etc/keys/kmk-${MASTERKEYTYPE}-$(uname -r).blob"
+        else
+            MASTERKEY="/etc/keys/kmk-${MASTERKEYTYPE}.blob"
+        fi
+    fi
+
+    # set the kernel master key path name
+    MASTERKEYPATH="${NEWROOT}${MASTERKEY}"
+
+    # check for kernel master key's existence
+    if [ ! -f "${MASTERKEYPATH}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "masterkey: kernel master key file not found: ${MASTERKEYPATH}"
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


------3B0D058E1DA7261331FAD246F76721C8
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDgxMjExMjFaMCMGCSqG
SIb3DQEJBDEWBBQglspLt93m6KUZLxrcyOz8/mILmDB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQA4ZEBAvw6YAmKv8xe9M2n2TanN
VXPx2QlE0FhtFmTxqhRLHChL4bKUs6JGWrEfcpYFXxVBOpcA6JuRlxoL9EnLkiuE
xUvhftzmyBkFYya7Dy0nbCnY1fbFJcWXawD/dph3Mz0nVohbwoH3knD0Q6o90Uby
DlN44jCk4SyU3H7Ak0GmVRrwYXqN5kW+L206wxRgdFU349L8aIj3Hwh+52Ub1VRH
fo8cQiAP1BEWpMkJtLGbmKgNEMS9cjXJFKOyPjCyHJ85bJkN6HOlLOVNPh8Z05kM
zpBOpWgujmI32i8Balk5GHCsWzYZYYz5PfhOWIdpZQd8mohUKbCHBLgmdIwy

------3B0D058E1DA7261331FAD246F76721C8--

