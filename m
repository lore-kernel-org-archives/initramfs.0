From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i18n: do not use systemd-vconsole-setup
Date: Sun,  7 Nov 2010 00:14:49 +0300
Message-ID: <1289078089-3599-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=XIhVNBITzfKTrKRLdjyQt7kCiWdi1cTu38Dukb+hPek=;
        b=Elb9LHEXd3WoAvI3x2tbVKVjQdVf62vrJFeOSZ6Ojt3IsmP9C97FCT3QX/k9HRV6DQ
         Z4lGBw4YD+cglhsOpMNu7/R2FlrmundBTS8QXVm5HJATWMssYFDU1ZwNnXVPsmHA3qlN
         WhsfLqEmv5ZTBOwLGmfsqk7t57zHP37SkOgpU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

systemd-vconsole-setup was not designed to be run from udevd.
It checks locale environment to decide, whether UNICODE should
be enabled or disabled. Normally environment is setup by
systemd; but the only environment available in udev rules is
those from device properties. It means systemd-vconsole-setup
always assumes default C locale and disables UNICODE.

Revert to using built-in console_init which explicitly
imports locale settings from /etc/vconsole.conf. Alternative
is to revert 6545b9d7 and call console_init directly :)

Additionally patch fixes console_init to use new namespace as
well as ensures that default font is always installed.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/10i18n/console_init |   10 +++++-----
 modules.d/10i18n/install      |   18 ++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index e6f2da4..bdd39b0 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -4,7 +4,7 @@
 
 [ -e /etc/vconsole.conf ] && . /etc/vconsole.conf
 
-DEFAULT_SYSFONT=LatArCyrHeb-16
+DEFAULT_FONT=LatArCyrHeb-16
 DEFAULT_KEYMAP=/etc/sysconfig/console/default.kmap
 
 set_keyboard() {
@@ -42,11 +42,11 @@ set_keymap() {
 set_font() {
     local dev=$1; local trans=''; local uni=''
 
-    [ -z "${SYSFONT}" ] && SYSFONT=${DEFAULT_SYSFONT}
-    [ -n "${CONTRANS}" ] && trans="-m ${CONTRANS}"
-    [ -n "${UNIMAP}" ] && uni="-u ${UNIMAP}"
+    [ -z "${FONT}" ] && FONT=${DEFAULT_FONT}
+    [ -n "${FONT_MAP}" ] && trans="-m ${FONT_MAP}"
+    [ -n "${FONT_UNIMAP}" ] && uni="-u ${FONT_UNIMAP}"
 
-    setfont ${SYSFONT} -C ${dev} ${trans} ${uni}
+    setfont ${FONT} -C ${dev} ${trans} ${uni}
 }
 
 dev_close() {
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
index d8647c0..96d563d 100755
--- a/modules.d/10i18n/install
+++ b/modules.d/10i18n/install
@@ -73,13 +73,7 @@ gather_vars() {
 install_base() {
     dracut_install setfont loadkeys kbd_mode stty
 
-    if [ -x /lib/systemd/systemd-vconsole-setup ]; then
-        dracut_install /lib/systemd/systemd-vconsole-setup
-        inst_dir /lib/udev
-        ln -s /lib/systemd/systemd-vconsole-setup "${initdir}/lib/udev/console_init"
-    else
-        inst ${moddir}/console_init /lib/udev/console_init
-    fi
+    inst ${moddir}/console_init /lib/udev/console_init
     inst_rules ${moddir}/10-console.rules
     inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
 }
@@ -123,9 +117,13 @@ install_local_i18n() {
 
     inst_opt_decompress ${KEYMAPS}
 
-    [[ ${FONT} ]] || FONT=${DEFAULT_FONT}
-    FONT=${FONT%.psf*}
-    inst_opt_decompress ${kbddir}/consolefonts/${FONT}.*
+    inst_opt_decompress ${kbddir}/consolefonts/${DEFAULT_FONT}.*
+
+    if [[ ${FONT} ]]
+    then
+        FONT=${FONT%.psf*}
+        inst_opt_decompress ${kbddir}/consolefonts/${FONT}.*
+    fi
 
     if [[ ${FONT_MAP} ]]
     then
-- 
tg: (1c29003..) upstream/i18n-no-vconsole (depends on: master)
