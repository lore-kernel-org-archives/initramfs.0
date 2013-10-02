From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] Use the same paths in dracut.sh as those set with configure script
Date: Wed,  2 Oct 2013 23:00:29 +0200
Message-ID: <1380747630-555-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Makefile alters destination main dracut script and sets dracutbasedir to
the value of pkglibdir set in configure.
---
 Makefile  | 3 +++
 dracut.sh | 9 ++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 124a41b..ea504f5 100644
--- a/Makefile
+++ b/Makefile
@@ -91,6 +91,9 @@ install: dracut-version.sh
 	mkdir -p $(DESTDIR)$(pkglibdir)/modules.d
 	mkdir -p $(DESTDIR)$(mandir)/man1 $(DESTDIR)$(mandir)/man5 $(DESTDIR)$(mandir)/man7 $(DESTDIR)$(mandir)/man8
 	install -m 0755 dracut.sh $(DESTDIR)$(bindir)/dracut
+	sed -r \
+		-e "s|^(pkglibdir)=.*|\1=$(pkglibdir)|" \
+		-i $(DESTDIR)$(bindir)/dracut
 	install -m 0755 dracut-catimages.sh $(DESTDIR)$(bindir)/dracut-catimages
 	install -m 0755 mkinitrd-dracut.sh $(DESTDIR)$(bindir)/mkinitrd
 	install -m 0755 lsinitrd.sh $(DESTDIR)$(bindir)/lsinitrd
diff --git a/dracut.sh b/dracut.sh
index e135dfc..c68e74e 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -26,10 +26,13 @@
 # store for logging
 dracut_args=( "$@" )
 
+# base dirs
+pkglibdir=/usr/lib/dracut
+dracutbasedir="$pkglibdir"
+
 set -o pipefail
 
 usage() {
-    [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
     if [[ -f $dracutbasedir/dracut-version.sh ]]; then
         . $dracutbasedir/dracut-version.sh
     fi
@@ -54,7 +57,6 @@ EOF
 }
 
 long_usage() {
-    [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
     if [[ -f $dracutbasedir/dracut-version.sh ]]; then
         . $dracutbasedir/dracut-version.sh
     fi
@@ -548,8 +550,6 @@ export DRACUT_LOG_LEVEL=warning
     debug=yes
 }
 
-[[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
-
 # if we were not passed a config file, try the default one
 if [[ ! -f $conffile ]]; then
     if [[ $allowlocal ]]; then
@@ -668,7 +668,6 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $use_fstab_l ]] && use_fstab=$use_fstab_l
 [[ $mdadmconf_l ]] && mdadmconf=$mdadmconf_l
 [[ $lvmconf_l ]] && lvmconf=$lvmconf_l
-[[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
 [[ $fw_dir ]] || fw_dir="/lib/firmware/updates /lib/firmware"
 [[ $tmpdir_l ]] && tmpdir="$tmpdir_l"
 [[ $tmpdir ]] || tmpdir=/var/tmp
-- 
1.8.3.2
