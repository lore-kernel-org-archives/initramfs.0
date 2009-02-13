From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] Modify hook loading to make it slightly easier to script.
Date: Fri, 13 Feb 2009 04:37:33 -0800 (PST)
Message-ID: <f4aa277200a601cca9cb46817ddef303b32f7330.1234528086.git.victor.lowther@gmail.com>
References: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=zn+YbAfY1zsksi8HwVPR5LlwGsaHtMZ6acjlmxrqKGo=;
        b=WGRM73X/Oi47CT2eYtW9DWhiOsMJmu7Hg/JcWfbGSUzhaUbZki2g/IQDQMD+R/iQDI
         Ta65jV2u2SA/UHZHJ6j3f1bEmk6j9S23KZFAX7bOyVImxz9lJKhVbBNje/ThryrWclT1
         CMnKLWUu2GD3qLIPPGIzVxLRLJZipzWyJF76w=
In-Reply-To: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Modules are now responsible for loading their hooks into the initrd.

This should be all the structure we need to make it easy for things
to integrate with dracut -- now to document and test it all.
---
 Makefile                                           |    8 ++++----
 dracut-functions                                   |   16 ++++++++++++++++
 pre-mount/50cryptroot => hooks/cryptroot           |    0
 pre-mount/99resume => hooks/resume                 |    0
 .../selinux-loadpolicy                             |    0
 modules/90crypt                                    |    3 ++-
 modules/99base                                     |    7 ++-----
 7 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 365cdf1..5d48a5f 100644
--- a/Makefile
+++ b/Makefile
@@ -4,16 +4,16 @@ all:
 install:
 	mkdir -p $(DESTDIR)/usr/libexec/dracut
 	mkdir -p $(DESTDIR)/sbin
-	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-mount
-	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-udev
-	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-pivot
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/hooks
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/modules
 	install -m 0755 dracut $(DESTDIR)/sbin/dracut
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
-	for hooks in pre-*/* ; do install -m 0755 $$hook $(DESTDIR/usr/libexec/dracut ; done
+	for hooks in hooks/* ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
+	for module in modules/*; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 clean:
 	rm -f *~
 
diff --git a/dracut-functions b/dracut-functions
index 1923b26..852ce36 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -145,6 +145,22 @@ inst() {
     return 1
 }
 
+# install function specialized for hooks
+# $1 = type of hook, $2 = hook priority (lower runs first), $3 = hook
+# All hooks should be POSIX/SuS compliant, they will be sourced by init.
+inst_hook() {
+    [[ -f $3 ]] || {
+	echo "Cannot install a hook ($3) that does not exist." >&2
+	echo "Aborting initrd creation." >&2
+	exit 1
+    }
+    strstr "$hookdirs" "$1" || {
+	echo "No such hook type $1. Aborting initrd creation." >&2
+	exit 1
+    }
+    inst_simple "$3" "/${1}/${2}${3##*/}"
+}
+
 dracut_install() {
     while (($# > 0)); do
 	inst "$1" && shift
diff --git a/pre-mount/50cryptroot b/hooks/cryptroot
similarity index 100%
rename from pre-mount/50cryptroot
rename to hooks/cryptroot
diff --git a/pre-mount/99resume b/hooks/resume
similarity index 100%
rename from pre-mount/99resume
rename to hooks/resume
diff --git a/pre-pivot/50selinux-loadpolicy b/hooks/selinux-loadpolicy
similarity index 100%
rename from pre-pivot/50selinux-loadpolicy
rename to hooks/selinux-loadpolicy
diff --git a/modules/90crypt b/modules/90crypt
index e8f9269..66d7e70 100755
--- a/modules/90crypt
+++ b/modules/90crypt
@@ -1,3 +1,4 @@
 #!/bin/bash
 inst cryptsetup
-inst_rules "$dsrc/rules.d/63-luks.rules"
\ No newline at end of file
+inst_rules "$dsrc/rules.d/63-luks.rules"
+inst_hook pre-mount 50 "$dsrc/hooks/cryptroot"
\ No newline at end of file
diff --git a/modules/99base b/modules/99base
index e1c699b..c746abc 100755
--- a/modules/99base
+++ b/modules/99base
@@ -4,9 +4,6 @@ dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
 # install our scripts and hooks
 inst "$initfile" "/init"
 inst "$switchroot" "/sbin/switch_root"
-for hookdir in $hookdirs; do
-    for hook in "$dsrc/$hookdir"/*; do
-	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
-    done
-done
+inst_hook pre-pivot 50 "$dsrc/hooks/selinux-loadpolicy"
+inst_hook pre-mount 99 "$dsrc/hooks/resume"
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
