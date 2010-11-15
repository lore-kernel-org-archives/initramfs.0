From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i18n: support KEYMAP_TOGGLE from vconsole.conf
Date: Mon, 15 Nov 2010 10:25:34 +0300
Message-ID: <1289805934-17653-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=YOvUnn+WIJiWdd2waL055RWP4SBYs1CcVVgs+ykt9U8=;
        b=VYakHVBa6fDZ1P7hWde1RQC8OSr73ErNRXsXG53Y0BUFnL+U0ukuzUxB4BtQ6mGykn
         EiBXBUEvQFtm7pELRSZ6gLN3ktaoXqdqcw7DOCEBxpGF9ipthSEVId1likL+BYnoNl4n
         jIwCxdPVq4SCGjeuEVEEsJZyPpo6tSDGQuIss=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Support KEYMAP_TOGGLE for switching keyboard layout.
This is what GRP_TOGGLE most likey maps to.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/10i18n/README       |    2 +-
 modules.d/10i18n/console_init |    2 +-
 modules.d/10i18n/install      |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index b2204cd..1007763 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -47,6 +47,7 @@ The following variables are used by i18n install script and at initramfs
 runtime:
 
     KEYMAP - keyboard translation table loaded by loadkeys
+    KEYMAP_TOGGLE - map that defines characters to switch keyboard layouts
     EXT_KEYMAPS - list of extra keymaps to bo loaded (sep. by space)
     UNICODE - boolean, indicating UTF-8 mode
     FONT - console font
@@ -56,7 +57,6 @@ runtime:
 The following are appended to EXT_KEYMAPS only during build time:
 
     UNIKEYMAP
-    GRP_TOGGLE
 
 They were used in 10redhat-i18n module, but not sure of its purpose.
 I'm leaving it in case...  The following are taken from the environment:
diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index bdd39b0..dde550a 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -36,7 +36,7 @@ set_keymap() {
 
     [ "${UNICODE}" = 1 ] && utf_switch=-u
 
-    loadkeys -q ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
+    loadkeys -q ${utf_switch} ${KEYMAP} ${KEYMAP_TOGGLE} ${EXT_KEYMAPS}
 }
 
 set_font() {
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
index 96d563d..0daf920 100755
--- a/modules.d/10i18n/install
+++ b/modules.d/10i18n/install
@@ -102,9 +102,9 @@ install_local_i18n() {
 
     # Gentoo user may have KEYMAP set to something like "-u pl2",
     KEYMAP=${KEYMAP#-* }
-    # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They were in
+    # I'm not sure of the purpose of UNIKEYMAP.  It was in
     # original redhat-i18n module.  Anyway it won't hurt.
-    EXT_KEYMAPS+=\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
+    EXT_KEYMAPS+=\ ${UNIKEYMAP}
 
     [[ ${KEYMAP} ]] || dwarning 'No KEYMAP.' || return 1
     findkeymap ${KEYMAP}
@@ -157,7 +157,7 @@ install_local_i18n() {
     mksubdirs ${initdir}${I18N_CONF}
     mksubdirs ${initdir}${VCONFIG_CONF}
     print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
-    print_vars KEYMAP EXT_KEYMAPS UNICODE FONT FONT_MAP FONT_UNIMAP >> ${initdir}${VCONFIG_CONF}
+    print_vars KEYMAP KEYMAP_TOGGLE EXT_KEYMAPS UNICODE FONT FONT_MAP FONT_UNIMAP >> ${initdir}${VCONFIG_CONF}
     return 0
 }
 
-- 
tg: (325d491..) upstream/01-keymap_toggle (depends on: master)
