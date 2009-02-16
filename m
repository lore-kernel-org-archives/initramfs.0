From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 44/50] Get rid of echoer script
Date: Mon, 16 Feb 2009 14:07:12 -0500
Message-ID: <200902161907.n1GJ7CNv028862@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=955f8b09ad8766dbe593361205268f43ca938029
Commit:     955f8b09ad8766dbe593361205268f43ca938029
Parent:     7d18dca5c1b99cda942c7e0c95a3df2959dea2c2
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:16 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 44/50] Get rid of echoer script
    
    We can use sh -c to accomplish the same goal
    
    Also move cat back on to the list of debugging tools -- all the files we were
    using it on in the initrd can use read to accomplish the same goal.
---
 Makefile              |    3 +--
 dracut                |    6 ++----
 echoer                |    4 ----
 init                  |    7 ++++---
 pre-mount/50cryptroot |    2 +-
 rules.d/63-luks.rules |    2 +-
 6 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 6d7cb68..365cdf1 100644
--- a/Makefile
+++ b/Makefile
@@ -11,9 +11,8 @@ install:
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
-	install -m 0755 echoer $(DESTDIR)/usr/libexec/dracut/echoer
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
-	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
+	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
 	for hooks in pre-*/* ; do install -m 0755 $$hook $(DESTDIR/usr/libexec/dracut ; done
 clean:
 	rm -f *~
diff --git a/dracut b/dracut
index 3e3d6f7..c8550c7 100755
--- a/dracut
+++ b/dracut
@@ -36,7 +36,6 @@ fi
 initfile=$dsrc/init
 switchroot=$dsrc/switch_root
 rulesdir=$dsrc/rules.d
-echoer=$dsrc/echoer
 hookdirs="pre-udev pre-mount pre-pivot"
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
@@ -48,11 +47,11 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
 done
 
 # executables that we have to have
-exe="bash mount mknod mkdir modprobe udevd udevadm nash pidof sleep chroot echo cat sed"
+exe="bash mount mknod mkdir modprobe udevd udevadm nash pidof sleep chroot echo sed"
 lvmexe="lvm"
 cryptexe="cryptsetup"
 # and some things that are nice for debugging
-debugexe="ls ln ps grep more dmesg"
+debugexe="ls ln ps grep more dmesg cat"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
@@ -70,7 +69,6 @@ fi
 # install our scripts and hooks
 inst "$initfile" "/init"
 inst "$switchroot" "/sbin/switch_root"
-inst "$echoer" "/echoer"
 for hookdir in $hookdirs; do
     for hook in "$dsrc/$hookdir"/*; do
 	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
diff --git a/echoer b/echoer
deleted file mode 100755
index 9fc7abf..0000000
--- a/echoer
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-target=$1
-shift
-echo "$@" >"$target"
\ No newline at end of file
diff --git a/init b/init
index 4b36e69..c8ac4e5 100755
--- a/init
+++ b/init
@@ -10,12 +10,13 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
-    exec sh -i
+    sh -i 2>/dev/console
 }
 
 getarg() {
-    local o;
-    for o in $(cat /proc/cmdline); do
+    local o line
+    read -r line </proc/cmdline
+    for o in $line; do
 	[ "${o%%=*}" = "$1" ] && { echo $o; break; }
     done
     return 1
diff --git a/pre-mount/50cryptroot b/pre-mount/50cryptroot
index de7eca4..0664f24 100755
--- a/pre-mount/50cryptroot
+++ b/pre-mount/50cryptroot
@@ -1,7 +1,7 @@
 #!/bin/sh
 [ -f /cryptroot ] && { 
     echo "Encrypted root detected."
-    cryptopts=$(cat /cryptroot)
+    read cryptopts </cryptroot
     /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
     udevadm settle --timeout=30
 }
diff --git a/rules.d/63-luks.rules b/rules.d/63-luks.rules
index ab907e9..4d6a379 100644
--- a/rules.d/63-luks.rules
+++ b/rules.d/63-luks.rules
@@ -8,6 +8,6 @@ SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
 KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/echoer /cryptroot $env{DEVNAME} luks-$env{ID_FS_UUID}"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/sh -c 'echo $env{DEVNAME} luks-$env{ID_FS_UUID} >/cryptroot'"
 
 LABEL="luks_end"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
