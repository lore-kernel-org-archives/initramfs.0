From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v3 4/4] dracut: added new module ecryptfs
Date: Fri,  8 Jul 2011 14:11:02 +0200
Message-ID: <1310127065-23292-5-git-send-email-roberto.sassu@polito.it>
References: <1310127065-23292-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----8F695C42DFEFE222542F76EB1CA6BF51"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=Lfwl4lx9b5Sy+8dZji3nAAiKHv0=; b=HVonc7siQ+i77wmWj9BraEJzJ0cmK8i4WpIicdpRL1wN7Iq/hfD1m48UV3m/+k5cVa3UXxVxPKymHCzSySruuEIQlOlFokOcVib4KPFhRkeAE4fgCi88VgnMaUUYAhWeVAapWKAnIddmm80F9Y36dXDKsMLlur9YC8l1r/etq4A=
In-Reply-To: <1310127065-23292-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

This is an S/MIME signed message

------8F695C42DFEFE222542F76EB1CA6BF51

This module mounts an eCryptfs filesystem from the initial ramdisk using an
encrypted key.

Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
---
 dracut.kernel.7.xml                    |    6 ++
 modules.d/98ecryptfs/README            |   50 ++++++++++++++++
 modules.d/98ecryptfs/ecryptfs-mount.sh |  100 ++++++++++++++++++++++++++++++++
 modules.d/98ecryptfs/module-setup.sh   |   20 ++++++
 4 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/98ecryptfs/README
 create mode 100755 modules.d/98ecryptfs/ecryptfs-mount.sh
 create mode 100755 modules.d/98ecryptfs/module-setup.sh

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 759871b..c5d74d0 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -724,6 +724,12 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
             <para>Set the path name of the EVM key. e.g.: <programlisting>evmkey=/etc/keys/evm-trusted.blob</programlisting></para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term><envar>ecryptfskey=</envar><replaceable>&lt;eCryptfs key path name&gt;</replaceable></term>
+          <listitem>
+            <para>Set the path name of the eCryptfs key. e.g.: <programlisting>ecryptfskey=/etc/keys/ecryptfs-trusted.blob</programlisting></para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2>
diff --git a/modules.d/98ecryptfs/README b/modules.d/98ecryptfs/README
new file mode 100644
index 0000000..f741c54
--- /dev/null
+++ b/modules.d/98ecryptfs/README
@@ -0,0 +1,50 @@
+# Directions for creating the encrypted key that will be used to mount an
+# eCryptfs filesystem
+
+# Create the eCryptfs key (encrypted key type)
+#
+# The encrypted key type supports two formats: the 'default' format allows
+# to generate a random symmetric key of the length specified, the 'ecryptfs'
+# format generates an authentication token for the eCryptfs filesystem,
+# which contains a randomly generated key. Two requirements for the latter
+# format is that the key description must contain exactly 16 hexadecimal
+# characters and that the encrypted key length must be equal to 64.
+$ keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk-trusted 64" @u
+782117972
+
+# Save the encrypted key
+$ su -c 'keyctl pipe `keyctl search @u encrypted 1000100010001000` > /etc/keys/ecryptfs-trusted.blob'
+
+# The eCryptfs key path name can be set in one of the following ways (specified in
+# the order in which the variable is overwritten):
+
+1) use the default value:
+--------------------------------------------------------------------------
+ECRYPTFSKEY="/etc/keys/ecryptfs-trusted.blob"
+--------------------------------------------------------------------------
+
+2) create the configuration file '/etc/sysconfig/ecryptfs' and set the ECRYPTFSKEY
+variable;
+
+3) specify the eCryptfs key path name in the 'ecryptfskey=' parameter of the kernel command
+line.
+
+# The configuration file '/etc/sysconfig/ecryptfs' is also used to specify
+# more options for mounting the eCryptfs filesystem:
+
+ECRYPTFSSRCDIR: existent directory in the lower root filesystem;
+ECRYPTFSDSTDIR: mount point directory for the eCryptfs filesystem (the directory must be
+                created in the root filesystem before rebooting the platform);
+ECRYPTFS_EXTRA_MOUNT_OPTS: extra mount options for the eCryptfs filesystem (the 'ecryptfs_sig'
+                           option is automatically added by the dracut script).
+
+# Example of the configuration file:
+----------- '/etc/sysconfig/ecryptfs' (with default values) -----------
+ECRYPTFS_KEY="/etc/keys/ecryptfs-trusted.blob"
+ECRYPTFSSRCDIR="/secret"
+ECRYPTFSDSTDIR="${ECRYPTFSSRCDIR}"
+ECRYPTFS_EXTRA_MOUNT_OPTS=""
+-----------------------------------------------------------------------
+
+# If the variable ECRYPTFSDSTDIR is not specified in the configuration file,
+# its value will be equal to that of ECRYPTFSSRCDIR.
diff --git a/modules.d/98ecryptfs/ecryptfs-mount.sh b/modules.d/98ecryptfs/ecryptfs-mount.sh
new file mode 100755
index 0000000..2f67716
--- /dev/null
+++ b/modules.d/98ecryptfs/ecryptfs-mount.sh
@@ -0,0 +1,100 @@
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
+ECRYPTFSCONFIG="${NEWROOT}/etc/sysconfig/ecryptfs"
+ECRYPTFSKEYTYPE="encrypted"
+ECRYPTFSKEYDESC="1000100010001000"
+ECRYPTFSKEYID=""
+ECRYPTFSSRCDIR="/secret"
+ECRYPTFS_EXTRA_MOUNT_OPTS=""
+
+load_ecryptfs_key()
+{
+    # override the eCryptfs key path name from the 'ecryptfskey=' parameter in the kernel
+    # command line
+    ECRYPTFSKEYARG=$(getarg ecryptfskey=)
+    [ $? -eq 0 ] && \
+        ECRYPTFSKEY=${ECRYPTFSKEYARG}
+
+    # set the default value
+    [ -z "${ECRYPTFSKEY}" ] && \
+        ECRYPTFSKEY="/etc/keys/ecryptfs-trusted.blob";
+
+    # set the eCryptfs key path name
+    ECRYPTFSKEYPATH="${NEWROOT}${ECRYPTFSKEY}"
+
+    # check for eCryptfs encrypted key's existence
+    if [ ! -f "${ECRYPTFSKEYPATH}" ]; then
+        if [ "${RD_DEBUG}" = "yes" ]; then
+            info "eCryptfs: key file not found: ${ECRYPTFSKEYPATH}"
+        fi
+        return 1
+    fi
+
+    # read the eCryptfs encrypted key blob
+    KEYBLOB=$(cat ${ECRYPTFSKEYPATH})
+
+    # load the eCryptfs encrypted key blob
+    ECRYPTFSKEYID=$(keyctl add ${ECRYPTFSKEYTYPE} ${ECRYPTFSKEYDESC} "load ${KEYBLOB}" @u)
+    [ $? -eq 0 ] || {
+        info "eCryptfs: failed to load the eCryptfs key: ${ECRYPTFSKEYDESC}";
+        return 1;
+    }
+
+    return 0
+}
+
+unload_ecryptfs_key()
+{
+    # unlink the eCryptfs encrypted key
+    keyctl unlink ${ECRYPTFSKEYID} @u || {
+        info "eCryptfs: failed to unlink the eCryptfs key: ${ECRYPTFSKEYDESC}";
+        return 1;
+    }
+
+    return 0
+}
+
+mount_ecryptfs()
+{
+    # read the configuration from the config file
+    [ -f "${ECRYPTFSCONFIG}" ] && \
+        . ${ECRYPTFSCONFIG}
+
+    # load the eCryptfs encrypted key
+    load_ecryptfs_key || return 1
+
+    # set the default value for ECRYPTFSDSTDIR
+    [ -z "${ECRYPTFSDSTDIR}" ] && \
+        ECRYPTFSDSTDIR=${ECRYPTFSSRCDIR}
+
+    # set the eCryptfs filesystem mount point
+    ECRYPTFSSRCMNT="${NEWROOT}${ECRYPTFSSRCDIR}"
+    ECRYPTFSDSTMNT="${NEWROOT}${ECRYPTFSDSTDIR}"
+
+    # build the mount options variable
+    ECRYPTFS_MOUNT_OPTS="ecryptfs_sig=${ECRYPTFSKEYDESC}"
+    [ ! -z "${ECRYPTFS_EXTRA_MOUNT_OPTS}" ] && \
+        ECRYPTFS_MOUNT_OPTS="${ECRYPTFS_MOUNT_OPTS},${ECRYPTFS_EXTRA_MOUNT_OPTS}"
+
+    # mount the eCryptfs filesystem
+    info "Mounting the configured eCryptfs filesystem"
+    mount -i -t ecryptfs -o${ECRYPTFS_MOUNT_OPTS} ${ECRYPTFSSRCMNT} ${ECRYPTFSDSTMNT} >/dev/null || {
+        info "eCryptfs: mount of the eCryptfs filesystem failed";
+        return 1;
+    }
+
+    # unload the eCryptfs encrypted key
+    unload_ecryptfs_key || return 1
+
+    return 0
+}
+
+mount_ecryptfs
diff --git a/modules.d/98ecryptfs/module-setup.sh b/modules.d/98ecryptfs/module-setup.sh
new file mode 100755
index 0000000..56c2d41
--- /dev/null
+++ b/modules.d/98ecryptfs/module-setup.sh
@@ -0,0 +1,20 @@
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
+installkernel() {
+    instmods ecryptfs
+}
+
+install() {
+    inst_hook pre-pivot 63 "$moddir/ecryptfs-mount.sh"
+}
-- 
1.7.4.4


------8F695C42DFEFE222542F76EB1CA6BF51
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTA3MDgxMjExMzFaMCMGCSqG
SIb3DQEJBDEWBBSQS/qjXdZKnvwpkf0WlzxodI/s6DB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQB4D4grrEcKE7IM+s0PQg8MGx1v
lQdVH7/EtgDPy4BLI6dRKJKDaOCLUOyUczg7Z3HUgZu4nhIvHcRIevx0AME/MSUf
PLhAjA+ZdFQ+v9T2SH2MwJ9LgGv6sK8mCs36qxmTteEfv7Njy4z2yurdrR8OsqGb
QO2xxOf5Hsb75XdS9nX3Z5FQrfA7eArqv1sxMdKKf4e4TrjFdvYxr7kYCKfctsfD
oy8O8bA2suZLbakhphykrQ0HIGOwQcXPi0OBdm82YcYj3gVZVMXMxXj9zRMtGBu9
rFG69Cp9gvLmNPFuAJ1jEZwdhfzJQfsmDeGoCUKOXElf+Q/RDENksqFqd74+

------8F695C42DFEFE222542F76EB1CA6BF51--

