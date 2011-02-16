From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: [PATCH] dracut: Don't suppress the modprobe error output.
Date: Wed, 16 Feb 2011 14:56:07 +0100
Message-ID: <1297864567-15328-1-git-send-email-max@stro.at>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, maximilian attems <max-U9r9yeDMy7A@public.gmane.org>

It happens that either due to newer modprobe or missing depmod
module-init-tools cries.
Suppressing the error ensures for a funny debug search for the user.
Resulting initramfs is generally unbootable due to missing module deps.

Better use the quiet option of modprobe itself.
It makes it less chatty, but doesn't suppress "fatal" errors.

Signed-off-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
---
[ untested, as no dracut install at hand -maks ]
 dracut-functions  |    2 +-
 dracut-gencmdline |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 9ac0bba..eef8f1e 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -670,7 +670,7 @@ install_kmod_with_fw() {
 for_each_kmod_dep() {
     local func=$1 kmod=$2 cmd modpapth options
     shift 2
-    modprobe "$@" --ignore-install --show-depends $kmod 2>/dev/null | \
+    modprobe "$@" --ignore-install --quiet --show-depends $kmod | \
         while read cmd modpath options; do
         [[ $cmd = insmod ]] || continue
         $func $modpath
diff --git a/dracut-gencmdline b/dracut-gencmdline
index 76c91ac..90e4906 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -72,7 +72,7 @@ moduledep() {
     fi
     vecho -n "Looking for deps of module $1"
     deps=""
-    deps=$(modprobe $MPARGS --set-version $kernel --show-depends $1 2>/dev/null| awk '/^insmod / { print gensub(".*/","","g",$2) }' | while read foo ; do [ "${foo%%.ko}" != "$1" ] && echo -n "${foo%%.ko} " ; done)
+    deps=$(modprobe $MPARGS --set-version $kernel --quiet --show-depends $1 | awk '/^insmod / { print gensub(".*/","","g",$2) }' | while read foo ; do [ "${foo%%.ko}" != "$1" ] && echo -n "${foo%%.ko} " ; done)
     [ -n "$deps" ] && vecho ": $deps" || vecho
 }
 
-- 
1.7.2.3
