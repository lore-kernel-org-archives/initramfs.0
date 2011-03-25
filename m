From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 5/9] modules.d: logging functions adjusted to dracut-logger
Date: Fri, 25 Mar 2011 15:56:48 +0100
Message-ID: <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-4-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/10i18n/module-setup.sh      |   13 +++++++++----
 modules.d/40network/module-setup.sh   |    5 +++--
 modules.d/50gensplash/module-setup.sh |    2 +-
 modules.d/98syslog/module-setup.sh    |    3 ++-
 modules.d/99base/module-setup.sh      |    4 ++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module-setup.sh
index 57a0f9a..f764c8e 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -115,12 +115,15 @@ install() {
         # original redhat-i18n module.  Anyway it won't hurt.
         EXT_KEYMAPS+=\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
 
-        [[ ${KEYMAP} ]] || dwarning 'No KEYMAP.' || return 1
+        [[ ${KEYMAP} ]] || {
+            derror 'No KEYMAP.'
+            return 1
+        }
         findkeymap ${KEYMAP}
 
         for map in ${EXT_KEYMAPS}
         do
-            dinfo "Adding extra map: ${map}"
+            ddebug "Adding extra map: ${map}"
             findkeymap ${map}
         done
 
@@ -183,13 +186,15 @@ install() {
         done
 
         [[ ${kbddir} ]] || {
-            derror "Directories ${KBDSUBDIRS//,/, } not found.  Please inform us about the issue including your OS name and version."
+            derror "Directories ${KBDSUBDIRS//,/, } not found.  Please" \
+                "inform us about the issue including your OS name and version."
             return 1
         }
 
         [[ -f $I18N_CONF && -f $VCONFIG_CONF ]] || \
             [[ ! ${hostonly} || ${i18n_vars} ]] || {
-            dwarning 'Please set up i18n_vars in configuration file.'
+            derror 'i18n_vars not set!  Please set up i18n_vars in ' \
+                'configuration file.'
         }
         return 0
     }
diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 6dd5fab..59f358f 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -7,13 +7,14 @@ check() {
 
     for program in ip arping; do 
         if ! type -P $program >/dev/null; then
-            dwarning "Could not find program \"$program\" required by network." 
+            derror "Could not find program \"$program\" required by network."
             return 1
         fi
     done
     for program in dhclient brctl ifenslave tr; do
         if ! type -P $program >/dev/null; then
-            dwarning "Could not find program \"$program\" it might be required by network." 
+            dwarn "Could not find program \"$program\" it might be required " \
+                "by network."
         fi
     done
 
diff --git a/modules.d/50gensplash/module-setup.sh b/modules.d/50gensplash/module-setup.sh
index cdcdabd..c34413e 100755
--- a/modules.d/50gensplash/module-setup.sh
+++ b/modules.d/50gensplash/module-setup.sh
@@ -24,7 +24,7 @@ install() {
 '
             for line in ${out}; do
                 if [[ ${line} =~ ^Warning ]]; then
-                    dwarning "${line}"
+                    dwarn "${line}"
                 else
                     derror "${line}"
                     (( ret == 0 )) && ret=1
diff --git a/modules.d/98syslog/module-setup.sh b/modules.d/98syslog/module-setup.sh
index 4db3e84..056e9d9 100755
--- a/modules.d/98syslog/module-setup.sh
+++ b/modules.d/98syslog/module-setup.sh
@@ -24,7 +24,8 @@ install() {
     elif type -P syslog-ng >/dev/null; then
         installs="syslog-ng"
     else
-        dwarning "Could not find any syslog binary although the syslogmodule is selected to be installed. Please check."
+        derror "Could not find any syslog binary although the syslogmodule" \
+            "is selected to be installed. Please check."
     fi
     if [ -n "$installs" ]; then
         dracut_install cat
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index c219d8f..a94d4bc 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -31,10 +31,10 @@ install() {
     # Bail out if switch_root does not exist
     if type -P switch_root >/dev/null; then
         inst $(type -P switch_root) /sbin/switch_root \
-            || derror "Failed to install switch_root"
+            || dfatal "Failed to install switch_root"
     else
         inst "$moddir/switch_root" "/sbin/switch_root" \
-            || derror "Failed to install switch_root"
+            || dfatal "Failed to install switch_root"
     fi
     inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
     inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
-- 
1.7.4.1
