From: "Carl D. Roth" <roth-xf5kL+kFV/5eoWH0uzbU5w@public.gmane.org>
Subject: Re: AOE (ATA over Ethernet) boot support?
Date: Sat, 5 Feb 2011 01:58:55 +0000 (UTC)
Message-ID: <iiiasu$69c$1@dough.gmane.org>
References: <ihpndo$kvk$1@dough.gmane.org> <4D415151.1020600@redhat.com>
	<iihvpc$hu6$1@dough.gmane.org>
	<1296861302.23654.22.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 04 Feb 2011 18:15:02 -0500, David Dillow wrote:

> On Fri, 2011-02-04 at 22:49 +0000, Carl D. Roth wrote:
>> Here's a first draft at AOE support in dracut.  Sorry for the kludgy
>> posting method, I'm not sure what the best way is to contribute files
>> here.
> 
> Inlined patches relative to HEAD are preferred.

OK here goes:

From 33bfa0a8741a9a7ff420a1a70121b135f3904a98 Mon Sep 17 00:00:00 2001
From: Carl D. Roth <roth-HnfRZWj23JKgXEEh9Od0haxOck334EZe@public.gmane.org>
Date: Fri, 4 Feb 2011 16:10:54 -0800
Subject: [PATCH] Initial checkin of AOE support.

---
 modules.d/95aoe/aoeroot          |   79 +++++++++++++++++++++++++++++++++
+++++
 modules.d/95aoe/check            |   54 ++++++++++++++++++++++++++
 modules.d/95aoe/install          |    5 ++
 modules.d/95aoe/installkernel    |    2 +
 modules.d/95aoe/parse-aoeroot.sh |   66 +++++++++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/95aoe/aoeroot
 create mode 100755 modules.d/95aoe/check
 create mode 100755 modules.d/95aoe/install
 create mode 100755 modules.d/95aoe/installkernel
 create mode 100755 modules.d/95aoe/parse-aoeroot.sh

diff --git a/modules.d/95aoe/aoeroot b/modules.d/95aoe/aoeroot
new file mode 100755
index 0000000..9b12d7b
--- /dev/null
+++ b/modules.d/95aoe/aoeroot
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+##############################
+#
+# aoeroot
+#
+# Adapted from 'nbdroot' and 'iscsiroot'
+#
+# Here we assume that 'root' is specified;
+# we do not make any special attempts to mount it here.
+#
+##############################
+
+. /lib/dracut-lib.sh
+
+PATH=$PATH:/sbin:/usr/sbin
+
+# Huh? Empty $1?
+test -z "$1" && exit 1
+
+# Huh? Empty $2?
+test -z "$2" && exit 1
+
+# Huh? Empty $3?
+test -z "$3" && exit 1
+
+# root is in the form root=aoe:eM.N
+netif="$1"
+aoeroot="$2"
+NEWROOT="$3"
+
+# If it's not aoe we don't continue
+test "${aoeroot%%:*}" = "aoe" || return
+
+aoeroot=${aoeroot#aoe:}
+aoedev=/dev/etherd/$aoeroot
+
+# FIXME: the init script does not export UDEVVERSION
+if test "$UDEVVERSION"; then
+  :
+else
+  UDEVVERSION=$(udevadm --version)
+fi
+
+getarg 'rdbreak=aoeroot' && emergency_shell -n aoeroot "Break (pre) AOE"
+
+# XXX better way to wait for the device to be made?
+i=0
+while true; do
+  test -b $aoedev && break
+  test $i -ge 20 && exit 1
+  aoe-discover
+  if test $UDEVVERSION -ge 143; then
+    udevadm settle --exit-if-exists=$aoedev
+  else
+    sleep 0.1
+  fi
+  i=$(( $i + 1 ))
+done
+
+##############################
+#
+# These next two statements are borrowed from 'iscsiroot';
+# I do not really understand them.
+#
+##############################
+
+# inject new exit_if_exists
+echo 'settle_exit_if_exists="--exit-if-exists=/dev/root"; rm "$job"' > /
initqueue/aoe-settle.sh
+
+# force udevsettle to break
+> /initqueue/work
+
+# now we have a root filesystem somewhere in /dev/etherd/*
+# let the normal block handler handle root=
+
+getarg 'rdbreak=aoeroot' && emergency_shell -n aoeroot "Break (post) AOE"
+
+exit 0
diff --git a/modules.d/95aoe/check b/modules.d/95aoe/check
new file mode 100755
index 0000000..e24f56b
--- /dev/null
+++ b/modules.d/95aoe/check
@@ -0,0 +1,54 @@
+#!/bin/bash
+
+##############################
+#
+# dracut check script for AOE
+#
+# Adapted from iscsi.
+#
+##############################
+
+# We depend on network modules being loaded
+test "$1" = "-d" && echo network
+
+# FIXME: check prerequisites here (any tools that need to be loaded)
+
+# If hostonly was requested, fail the check if we are not actually
+# booting from root.
+
+. $dracutfunctions
+
+test "$debug" && set -x
+
+is_aoe()
+{
+  local dev tgt
+  dev=$1; shift
+
+  test -L /sys/dev/block/$dev || return 1
+  tgt=`readlink -f /sys/dev/block/$dev` || return 1
+  cd "$tgt" || return 1
+  while true; do
+    test "$PWD" = "/" && break
+    test -e mac -a -e netif && break
+    cd .. || return 1
+  done
+
+  test -e netif
+  return $?
+}
+
+case $1 in
+  -h)
+    rootdev=$(find_root_block_device)
+    if test "$rootdev"; then
+      # root lives on a block device, so we can be more precise about 
+      # hostonly checking
+      check_block_and_slaves is_aoe "$rootdev" || exit 1
+    else
+      exit 1
+    fi
+  ;;
+esac
+
+exit 0
diff --git a/modules.d/95aoe/install b/modules.d/95aoe/install
new file mode 100755
index 0000000..70ca7a8
--- /dev/null
+++ b/modules.d/95aoe/install
@@ -0,0 +1,5 @@
+#!/bin/bash
+inst aoe-discover
+inst aoe-stat
+inst_hook cmdline 90 "$moddir/parse-aoeroot.sh"
+inst "$moddir/aoeroot" "/sbin/aoeroot"
diff --git a/modules.d/95aoe/installkernel b/modules.d/95aoe/installkernel
new file mode 100755
index 0000000..b3db783
--- /dev/null
+++ b/modules.d/95aoe/installkernel
@@ -0,0 +1,2 @@
+#!/bin/bash
+instmods aoe
diff --git a/modules.d/95aoe/parse-aoeroot.sh b/modules.d/95aoe/parse-
aoeroot.sh
new file mode 100755
index 0000000..2afcdcb
--- /dev/null
+++ b/modules.d/95aoe/parse-aoeroot.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# Format:
+#
+#   root=aoe:eM.N
+#   root=/dev/etherd/eM.N
+#   [root=*] netroot=aoe:eM.N
+#   [root=*] netroot=/dev/etherd/eM.N
+#
+# root= takes precedence over netroot= if root=iscsi[...]
+#
+
+# Don't continue if root is ok
+test -n "$rootok" && return
+
+# This script is sourced, so root should be set. But let's be paranoid
+test -z "$root" && root=$(getarg root=)
+test -z "$netroot" && netroot=$(getarg netroot=)
+
+case "$root" in
+  /dev/etherd/*)
+    root=aoe:${root#/dev/etherd/}
+  ;;
+esac
+
+case "$netroot" in
+  /dev/etherd/*)
+    netroot=aoe:${netroot#/dev/etherd/}
+  ;;
+esac
+
+# Root takes precedence over netroot
+case "$root" in
+  aoe:*)
+    if test -n "$netroot"; then
+      echo "Warning: root takes precedence over netroot. Ignoring 
netroot"
+    fi
+    netroot=$root
+  ;;
+esac
+
+# If it's not empty or aoe we don't continue
+case "$netroot" in
+  "") ;;
+  aoe:*) ;;
+  *)
+    return
+  ;;  
+esac
+
+# If it's not aoe we don't continue
+case "$netroot" in
+  aoe:*) ;;
+  *) return ;;
+esac
+
+# AOE actually supported?
+test -e /sys/devices/virtual/aoe || modprobe aoe || die "aoe requested 
but kernel/initrd does not support aoe"
+
+# Done, all good!
+rootok=1
+
+# Shut up init error check
+test -z "$root" && root="aoe"
+
+echo '[ -e /dev/root ]' > /initqueue-finished/aoe.sh
-- 
1.7.3.5

