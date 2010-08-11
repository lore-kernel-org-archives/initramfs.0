From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Fix autodetection of UNICODE keymap
Date: Wed, 11 Aug 2010 21:47:57 +0400
Message-ID: <20100811174757.15606.72777.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org

Original console_init from RH initscripts supports KEYTABLE variable
which dynamically determines whether to load UNICODE keymap depending
on current LANG value.

Scripts from 10i18n are more simplistic and assume the right keymap is
statically defined in configuration files.

Mandriva depends on console_init behavior and is using KEYTABLE
exclusively, so under new 10i18n non-UNICDE keymap is always loaded.

Add support for KEYTABLE to dynamically determine whether to install
UNICODE or non-UNICODE keymap version. This should probably go into
run-time 10i18n/console_init instead to be fully compatible.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/10i18n/README  |    2 ++
 modules.d/10i18n/install |   54 +++++++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index c1878a7..11a7315 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -47,6 +47,8 @@ The following variables are used by i18n install script and at initramfs
 runtime:
 
     KEYMAP - keyboard translation table loaded by loadkeys
+    KEYTABLE - base name for keyboard translation table; if UNICODE is
+	true, Unicode version will be loaded. Overrides KEYMAP.
     EXT_KEYMAPS - list of extra keymaps to bo loaded (sep. by space)
     UNICODE - boolean, indicating UTF-8 mode
     SYSFONT - console font
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
index 83999e5..de719b6 100755
--- a/modules.d/10i18n/install
+++ b/modules.d/10i18n/install
@@ -91,13 +91,42 @@ install_all_kbd() {
     dracut_install gzip bzip2
 }
 
+check_unicode() {
+    if [[ ${UNICODE} ]]
+    then
+        if [[ ${UNICODE^^} = YES || ${UNICODE} = 1 ]]
+        then
+            UNICODE=1
+        elif [[ ${UNICODE^^} = NO || ${UNICODE} = 0 ]]
+        then
+            UNICODE=0
+        else
+            UNICODE=''
+        fi
+    fi
+    if [[ ! ${UNICODE} && ${LANG^^} =~ .*\.UTF-?8 ]]
+    then
+        UNICODE=1
+    fi
+}
+
 install_local_keyboard() {
     local map
 
-    eval $(gather_vars ${keyboard_vars})
-
     # Gentoo user may have KEYMAP set to something like "-u pl2",
     KEYMAP=${KEYMAP#-* }
+
+    # KEYTABLE is a bit special - it defines base keymap name and UNICODE
+    # determines whether non-UNICODE or UNICODE version is used
+
+    if [[ ${KEYTABLE} ]]; then
+	if [[ ${UNICODE} == 1 ]]; then
+	    [[ ${KEYTABLE} =~ .*\.uni.* ]] || KEYTABLE=${KEYTABLE%.map*}.uni
+	fi
+
+	KEYMAP=${KEYTABLE}
+    fi
+
     # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They were in
     # original redhat-i18n module.  Anyway it won't hurt.
     EXT_KEYMAPS+=\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
@@ -118,7 +147,6 @@ install_local_keyboard() {
 }
 
 install_local_i18n() {
-    eval $(gather_vars ${i18n_vars})
 
     [[ ${SYSFONT} ]] || SYSFONT=${DEFAULT_SYSFONT}
     SYSFONT=${SYSFONT%.psf*}
@@ -136,23 +164,6 @@ install_local_i18n() {
         inst ${kbddir}/unimaps/${UNIMAP}.uni
     fi
 
-    if [[ ${UNICODE} ]]
-    then
-        if [[ ${UNICODE^^} = YES || ${UNICODE} = 1 ]]
-        then
-            UNICODE=1
-        elif [[ ${UNICODE^^} = NO || ${UNICODE} = 0 ]]
-        then
-            UNICODE=0
-        else
-            UNICODE=''
-        fi
-    fi
-    if [[ ! ${UNICODE} && ${LANG^^} =~ .*\.UTF-?8 ]]
-    then
-        UNICODE=1
-    fi
-
     mksubdirs ${I18N_CONF}
     print_vars LC_ALL LANG UNICODE SYSFONT CONTRANS UNIMAP >> ${I18N_CONF}
 }
@@ -187,6 +198,9 @@ then
 
     if [[ ${hostonly} ]]
     then
+	eval $(gather_vars ${keyboard_vars})
+	eval $(gather_vars ${i18n_vars})
+	check_unicode
         install_local_keyboard
         install_local_i18n
     else
