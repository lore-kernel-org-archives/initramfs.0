From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 5/5] new module - 91crypt-gpg
Date: Thu,  5 May 2011 13:34:21 +0200
Message-ID: <1304595261-11077-5-git-send-email-aidecoe@aidecoe.name>
References: <1304595261-11077-1-git-send-email-aidecoe@aidecoe.name>
 <1304595261-11077-2-git-send-email-aidecoe@aidecoe.name>
 <1304595261-11077-3-git-send-email-aidecoe@aidecoe.name>
 <1304595261-11077-4-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1304595261-11077-4-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

It's an extension to 90crypt module.  Adds support for GPG-encrypted
keys (symmetrically, of course).  Module is optional.
---
 modules.d/91crypt-gpg/crypt-gpg-lib.sh |   33 ++++++++++++++++++++++++++++++++
 modules.d/91crypt-gpg/module-setup.sh  |   19 ++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/91crypt-gpg/crypt-gpg-lib.sh
 create mode 100755 modules.d/91crypt-gpg/module-setup.sh

diff --git a/modules.d/91crypt-gpg/crypt-gpg-lib.sh b/modules.d/91crypt-gpg/crypt-gpg-lib.sh
new file mode 100644
index 0000000..f934cae
--- /dev/null
+++ b/modules.d/91crypt-gpg/crypt-gpg-lib.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=4 sw=4 sts=0 et filetype=sh
+
+command -v ask_for_password >/dev/null || . /lib/dracut-crypt-lib.sh
+
+# gpg_decrypt mnt_point keypath keydev device
+#
+# Decrypts encrypted symmetrically key to standard output.
+#
+# mnt_point - mount point where <keydev> is already mounted
+# keypath - GPG encrypted key path relative to <mnt_point>
+# keydev - device on which key resides; only to display in prompt
+# device - device to be opened by cryptsetup; only to display in prompt
+gpg_decrypt() {
+    local mntp="$1"
+    local keypath="$2"
+    local keydev="$3"
+    local device="$4"
+
+    local gpghome=/tmp/gnupg
+    local opts="--homedir $gpghome --no-mdc-warning --skip-verify --quiet"
+    opts="$opts --logger-file /dev/null --batch --no-tty --passphrase-fd 0"
+
+    mkdir -m 0700 -p "$gpghome"
+
+    ask_for_password \
+        --cmd "gpg $opts --decrypt $mntp/$keypath" \
+        --prompt "Password ($keypath on $keydev for $device)" \
+        --tries 3 --tty-echo-off
+
+    rm -rf -- "$gpghome"
+}
diff --git a/modules.d/91crypt-gpg/module-setup.sh b/modules.d/91crypt-gpg/module-setup.sh
new file mode 100755
index 0000000..3adb3a6
--- /dev/null
+++ b/modules.d/91crypt-gpg/module-setup.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# GPG support is optional
+check() {
+    type -P gpg >/dev/null || return 1
+
+    return 255
+}
+
+depends() {
+    echo crypt
+}
+
+install() {
+    dracut_install gpg
+    inst "$moddir/crypt-gpg-lib.sh" "/lib/dracut-crypt-gpg-lib.sh"
+}
-- 
1.7.5.rc3
