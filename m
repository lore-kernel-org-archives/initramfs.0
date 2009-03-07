From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH] Simply module writing and allow module skipping
Date: Sat, 7 Mar 2009 11:06:07 +0100
Message-ID: <49B2470F.3070902@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Some dracut modules are rather simple. They just install files from 
user-space, hooks and udev rules. Instead of writing a shell-script for 
that, a module could contain $moddir/files, $moddir/rules, $moddir/hooks
which would be run through and the corresponding inst-functions applied.

With $moddir/files there's another advantage in that before copying 
stuff, these files can be checked for existence and if --skip-missing is
provided the whole module can be skipped cleanly.

Patch is built on top of Harald Hoyers merge tree
(git://git.surfsite.org/pub/git/dracut.git) and implements the suggested
stuff for module 90crypt as an example

Regards,
Philippe Seewer


---
 dracut                    |   27 ++++++++++++++++++++++++++-
 dracut-functions          |   13 ++++++++-----
 modules.d/90crypt/files   |    1 +
 modules.d/90crypt/hooks   |    1 +
 modules.d/90crypt/install |    4 ----
 modules.d/90crypt/rules   |    1 +
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/dracut b/dracut
index a691a66..eeacf1c 100755
--- a/dracut
+++ b/dracut
@@ -28,7 +28,7 @@ while (($# > 0)); do
 	    exit 1 ;;
 	-v|--verbose) set -x;;
 	-l|--local) allowlocal="yes" ;;
-	--allow-missing) : ;;
+	--skip-missing) skipmissing="yes" ;;
 	*) break ;;
     esac
     shift
@@ -63,7 +63,32 @@ for moddir in "$dsrc/modules.d"/*; do
     [[ -d $moddir || -L $moddir ]] || continue
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]};
     if [[ $dracutmodules = all ]] || strstr "$dracutmodules " "$mod "; then 
+
+	skipme=""
+	[[ -f $moddir/files ]] && while read line; do 
+	    find_file $line || {
+		[[ $skipmissing ]] && skipme="yes" && break;
+		echo "Preqrequisite $line for $mod not found";
+		exit 1
+	    }
+	done < $moddir/files
+
+	[[ $skipme ]] && {
+	    echo "== Prerequisites for $mod not found, ignoring == "
+	    continue;
+	}
+
 	echo "== Module $moddir == "
+	[[ -f $moddir/files ]] && while read line; do 
+	    inst $line
+	done < $moddir/files
+	[[ -f $moddir/rules ]] && while read line; do 
+	    inst_rules $line
+	done < $moddir/rules
+	[[ -f $moddir/hooks ]] && while read line; do
+	    inst_hook $line
+	done < $moddir/hooks
+
 	[[ -x $moddir/install ]] && . "$moddir/install"
     fi
 done
diff --git a/dracut-functions b/dracut-functions
index 504332b..0161214 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -135,7 +135,7 @@ inst_symlink() {
 }
 
 find_rule() {
-    for r in . /lib/udev/rules.d /etc/udev/rules.d $dsrc/rules.d; do
+    for r in . /lib/udev/rules.d /etc/udev/rules.d $dsrc/rules.d $moddir; do
 	[[ -f $r/$1 ]] && { echo "$r/$1"; return 0; }
     done
     return 1
@@ -172,16 +172,19 @@ inst() {
 # $1 = type of hook, $2 = hook priority (lower runs first), $3 = hook
 # All hooks should be POSIX/SuS compliant, they will be sourced by init.
 inst_hook() {
-    [[ -f $3 ]] || {
+    local type number hook
+    type=$1 number=$2 hook=$3
+    [[ "$hook" =~ $moddir ]] || hook="$moddir/$hook"
+    [[ -f $hook ]] || {
 	echo "Cannot install a hook ($3) that does not exist." >&2
 	echo "Aborting initrd creation." >&2
 	exit 1
     }
-    strstr "$hookdirs" "$1" || {
-	echo "No such hook type $1. Aborting initrd creation." >&2
+    strstr "$hookdirs" "$type" || {
+	echo "No such hook type $type. Aborting initrd creation." >&2
 	exit 1
     }
-    inst_simple "$3" "/${1}/${2}${3##*/}"
+    inst_simple "$hook" "/$type/$number${hook##*/}"
 }
 
 dracut_install() {
diff --git a/modules.d/90crypt/files b/modules.d/90crypt/files
new file mode 100644
index 0000000..836b5e7
--- /dev/null
+++ b/modules.d/90crypt/files
@@ -0,0 +1 @@
+/bin/true
diff --git a/modules.d/90crypt/hooks b/modules.d/90crypt/hooks
new file mode 100644
index 0000000..6c70749
--- /dev/null
+++ b/modules.d/90crypt/hooks
@@ -0,0 +1 @@
+mount 10 cryptroot.sh
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
deleted file mode 100755
index 92b5169..0000000
--- a/modules.d/90crypt/install
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-inst cryptsetup
-inst_rules "$moddir/63-luks.rules"
-inst_hook mount 10 "$moddir/cryptroot.sh"
\ No newline at end of file
diff --git a/modules.d/90crypt/rules b/modules.d/90crypt/rules
new file mode 100644
index 0000000..5c21a81
--- /dev/null
+++ b/modules.d/90crypt/rules
@@ -0,0 +1 @@
+63-luks.rules

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
