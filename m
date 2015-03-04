From: Jan Synacek <jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] crypt: don't use systemd for crypto handling
Date: Wed,  4 Mar 2015 08:49:45 +0100
Message-ID: <1425455385-28495-1-git-send-email-jsynacek@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

There already is the code necessary to handle an encrypted root
device. The "rd.luks.key" option is not handled the same way in systemd
as it is in dracut, so some setups (like having the keyfile on a
separate device) don't work.
---
 modules.d/90crypt/crypt-run-generator.sh | 31 ----------------------
 modules.d/90crypt/module-setup.sh        |  9 -------
 modules.d/90crypt/parse-crypt.sh         | 44 +++++++++-----------------------
 3 files changed, 12 insertions(+), 72 deletions(-)
 delete mode 100755 modules.d/90crypt/crypt-run-generator.sh

diff --git a/modules.d/90crypt/crypt-run-generator.sh b/modules.d/90crypt/crypt-run-generator.sh
deleted file mode 100755
index 3c5d7b1..0000000
--- a/modules.d/90crypt/crypt-run-generator.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-
-. /lib/dracut-lib.sh
-type crypttab_contains >/dev/null 2>&1 || . /lib/dracut-crypt-lib.sh
-
-dev=$1
-luks=$2
-
-crypttab_contains "$luks" && exit 0
-
-allowdiscards="-"
-
-# parse for allow-discards
-if strstr "$(cryptsetup --help)" "allow-discards"; then
-    if discarduuids=$(getargs "rd.luks.allow-discards"); then
-        discarduuids=$(str_replace "$discarduuids" 'luks-' '')
-        if strstr " $discarduuids " " ${luks##luks-}"; then
-            allowdiscards="allow-discards"
-        fi
-    elif getargbool 0 rd.luks.allow-discards; then
-        allowdiscards="allow-discards"
-    fi
-fi
-
-echo "$luks $dev - timeout=0,$allowdiscards" >> /etc/crypttab
-
-if command -v systemctl >/dev/null; then
-    systemctl daemon-reload
-    systemctl start cryptsetup.target
-fi
-exit 0
diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index ea1e340..5b3001f 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -85,14 +85,5 @@ install() {
 
     inst_simple "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
 
-    inst_multiple -o \
-        $systemdutildir/system-generators/systemd-cryptsetup-generator \
-        $systemdutildir/systemd-cryptsetup \
-        $systemdsystemunitdir/systemd-ask-password-console.path \
-        $systemdsystemunitdir/systemd-ask-password-console.service \
-        $systemdsystemunitdir/cryptsetup.target \
-        $systemdsystemunitdir/sysinit.target.wants/cryptsetup.target \
-        systemd-ask-password systemd-tty-ask-password-agent
-    inst_script "$moddir"/crypt-run-generator.sh /sbin/crypt-run-generator
     dracut_need_initqueue
 }
diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index 94ad1f6..f2bc181 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -19,25 +19,13 @@ else
 
             luksid=${luksid##luks-}
 
-            if [ -z "$DRACUT_SYSTEMD" ]; then
-                {
-                    printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
-                    printf -- 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
-                    printf -- 'RUN+="%s --settled --unique --onetime ' $(command -v initqueue)
-                    printf -- '--name cryptroot-ask-%%k %s ' $(command -v cryptroot-ask)
-                    printf -- '$env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $tout
-                } >> /etc/udev/rules.d/70-luks.rules.new
-            else
-                if ! crypttab_contains "$luksid"; then
-                    {
-                        printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
-                        printf -- 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
-                        printf -- 'RUN+="%s --settled --unique --onetime ' $(command -v initqueue)
-                        printf -- '--name systemd-cryptsetup-%%k %s start ' $(command -v systemctl)
-                        printf -- 'systemd-cryptsetup@luks$$(dev_unit_name -$env{ID_FS_UUID}).service"\n'
-                    } >> /etc/udev/rules.d/70-luks.rules.new
-                fi
-            fi
+            {
+                printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
+                printf -- 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
+                printf -- 'RUN+="%s --settled --unique --onetime ' $(command -v initqueue)
+                printf -- '--name cryptroot-ask-%%k %s ' $(command -v cryptroot-ask)
+                printf -- '$env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $tout
+            } >> /etc/udev/rules.d/70-luks.rules.new
 
             uuid=$luksid
             while [ "$uuid" != "${uuid#*-}" ]; do uuid=${uuid%%-*}${uuid#*-}; done
@@ -50,19 +38,11 @@ else
             } >> $hookdir/emergency/90-crypt.sh
         done
     elif getargbool 0 rd.auto; then
-        if [ -z "$DRACUT_SYSTEMD" ]; then
-            {
-                printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="%s ' $(command -v initqueue)
-                printf -- '--unique --settled --onetime --name cryptroot-ask-%%k '
-                printf -- '%s $env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $(command -v cryptroot-ask) $tout
-            } >> /etc/udev/rules.d/70-luks.rules.new
-        else
-            {
-                printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="%s ' $(command -v initqueue)
-                printf -- '--unique --settled --onetime --name crypt-run-generator-%%k '
-                printf -- '%s $env{DEVNAME} luks-$env{ID_FS_UUID}"\n' $(command -v crypt-run-generator)
-            } >> /etc/udev/rules.d/70-luks.rules.new
-        fi
+        {
+            printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="%s ' $(command -v initqueue)
+            printf -- '--unique --settled --onetime --name cryptroot-ask-%%k '
+            printf -- '%s $env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $(command -v cryptroot-ask) $tout
+        } >> /etc/udev/rules.d/70-luks.rules.new
     fi
 
     echo 'LABEL="luks_end"' >> /etc/udev/rules.d/70-luks.rules.new
-- 
2.1.0
