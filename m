From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] new module - 98evm
Date: Tue, 24 May 2011 09:18:22 -0400
Message-ID: <1306243102.3231.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

EVM verifies file metadata integrity based on a keyed HMAC.  The key
should be loaded in the initramfs before pivoting root.  This patch
loads the trusted and encrypted EVM keys onto root's keyring before
enabling EVM.

--- /dev/null	2011-05-24 06:19:53.737797039 -0400
+++ modules.d/98evm/install	2011-05-23 08:47:39.859250064 -0400
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+dracut_install keyctl
+inst_hook pre-pivot 60 "$moddir/evm-enable.sh"
--- /dev/null	2011-05-24 06:19:53.737797039 -0400
+++ modules.d/98evm/check	2011-05-23 07:49:31.839983246 -0400
@@ -0,0 +1,9 @@
+#!/bin/bash
+
+[[ $1 = '-h' ]] && {
+    [ -x "/bin/keyctl" ] || exit 1
+    exit 0
+}
+
+exit 0
+
--- /dev/null	2011-05-24 06:19:53.737797039 -0400
+++ modules.d/98evm/evm-enable.sh	2011-05-23 06:59:27.786421196 -0400
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+security_evm_exists()
+{
+    RC=0
+
+    if [ ! -d "/security" ]; then
+       mkdir /security
+    fi
+    mount -t securityfs /security /security >/dev/null 2>&1
+    if [ ! -e "/security/evm" ]; then
+       RC=1
+    fi
+    umount /security
+    return $RC
+}
+
+enable_evm()
+{
+    if [ ! -d "/security" ]; then
+       mkdir /security
+    fi
+    mount -t securityfs /security /security >/dev/null 2>&1
+    if [ -e "/security/evm" ]; then
+       echo 1 > /security/evm
+    fi
+    umount /security
+}
+
+load_keys()
+{
+    RC=0
+
+    MASTERKEY=$(getarg masterkey=)
+    if [ $? -ne 0 ]; then
+        MASTERKEY='kmk-trusted.blob'
+    fi
+
+    EVMKEY=$(getarg evmkey=)
+    if [ $? -ne 0 ]; then
+        EVMKEY='evm-trusted.blob'
+    fi
+
+    if [ ! -f "$NEWROOT/etc/keys/$MASTERKEY" ]; then
+	info "EVM: missing master key"
+        RC=1
+    elif [ ! -f "$NEWROOT/etc/keys/$EVMKEY" ]; then
+	info "EVM: missing EVM key"
+        RC=1
+    else
+        keyctl add trusted kmk-trusted "load `cat $NEWROOT/etc/keys/$MASTERKEY`" @u
+        keyctl add encrypted evm-key "load `cat $NEWROOT/etc/keys/$EVMKEY`" @u
+    fi
+    return $RC
+}
+
+security_evm_exists
+RC=$?
+if [ $RC -eq 0 ]; then
+   load_keys
+   RC=$?
+fi
+if [ $RC -eq 0 ]; then
+   enable_evm
+fi
--- /dev/null	2011-05-24 06:19:53.737797039 -0400
+++ modules.d/98evm/README	2011-05-24 07:37:43.467948636 -0400
@@ -0,0 +1,47 @@
+# Directions for creating an EVM key, encrypted/decrypted using a trusted key.
+
+# Create the kernel master key (trusted key type) for encrypting/decrypting
+# other keys, including the EVM key.
+ 
+# A trusted key is a TPM random number, which is only ever exposed to
+# userspace as an encrypted datablob. A trusted key can be sealed to a 
+# set of PCR values. For more details on trusted keys, refer to the 
+# kernel keys-trusted-encrypted.txt documentation.
+$ keyctl add trusted kmk-trusted "new 32" @u
+801713097
+
+# Save the kernel master key
+$ su -c 'keyctl pipe 801713097 > /etc/keys/kmk-trusted.blob'
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
+$ su -c 'keyctl pipe 782117972 > /etc/keys/evm-trusted.blob'
+
+------------------------------------------------------------------
+# Directions for creating an EVM key, encrypted/decrypted using a user key.
+# (Dracut support for encrypting/decrypting the EVM key using a user key is
+# not provided.)
+
+# For those systems which don't have a TPM, create a user key of 32 
+# random bytes. Unlike trusted/encrypted keys, user type key data is
+# visible to userspace.
+$ keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u
+144468621
+
+# Save the user key
+$ su -c 'keyctl pipe 144468621 > /etc/keys/kmk-user.blob'
+
+# Create the EVM key (encrypted key type), using the user key to
+# encrypt/decrypt it.
+$ keyctl add encrypted evm-key "new user:kmk-user 32" @u
+432095285
+
+# Save the encrypted key
+$ su -c 'keyctl pipe 432095285 > /etc/keys/evm-user.blob'

