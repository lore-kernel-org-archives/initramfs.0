From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Fix "can't shift that many" crash with empty /proc/cmdline
Date: Mon, 16 May 2011 19:17:57 -0400
Message-ID: <1305587877-14485-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If /proc/cmdline is empty (like if root=... is set in /etc/cmdline),
modules.d/99base/init will crash with a message saying "can't shift that
many" right before switch_root. The problem is in the block of code that
tries to look for init args. It does something like:

read CMDLINE </proc/cpuinfo
    [...]
    set $CMDLINE
    shift

If CMDLINE="" then "set $CMDLINE" will dump all the variables to stdout.
(That should be "set -- $CMDLINE" instead.) Since there's no $1, the
"shift" causes an error, and dracut crashes.

The 'shift' was copy-and-pasted from the previous block. It doesn't
belong here; remove it.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/init |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index e2c34c7..87778ac 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -361,8 +361,8 @@ if getarg init= >/dev/null ; then
     ignoreargs="console BOOT_IMAGE"
     # only pass arguments after init= to the init
     CLINE=${CLINE#*init=}
-        set $CLINE
-        shift
+        set -- $CLINE
+        shift # clear out the rest of the "init=" arg
         for x in "$@"; do
             for s in $ignoreargs; do
                 [ "${x%%=*}" = $s ] && continue 2
@@ -372,8 +372,7 @@ if getarg init= >/dev/null ; then
         unset CLINE
 else
     set +x # Turn off debugging for this section
-    set $CLINE
-    shift
+    set -- $CLINE
     for x in "$@"; do
         case "$x" in
             [0-9]|s|S|single|emergency|auto ) \
-- 
1.7.5.1
