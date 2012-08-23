From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] make splitsep preserve backslashes (RHBZ#851295)
Date: Thu, 23 Aug 2012 16:56:01 -0400
Message-ID: <1345755361-1375-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

splitsep() would drop escapes from its inputs. For example:

  splitsep ':' 'first:middle:\e\s\c\a\p\e\d' a b c

gave a='first', b='middle', c='escaped'. Even worse:

  splitsep ':' '\e\s\c\a\p\e\d:middle:last' a b c

gave a='escaped', b='escaped', c='escaped:middle:last'.

This fixes the quoting so both calls return the values you'd expect
(e.g. 'first', 'middle', '\e\s\c\a\p\e\d').
---
 modules.d/99base/dracut-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 381b4dd..60b4cb1 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -271,12 +271,12 @@ splitsep() {
 
     while [ -n "$str" -a "$#" -gt 1 ]; do
         tmp="${str%%$sep*}"
-        eval "$1=${tmp}"
-        str="${str#$tmp}"
+        eval "$1='${tmp}'"
+        str="${str#"$tmp"}"
         str="${str#$sep}"
         shift
     done
-    [ -n "$str" -a -n "$1" ] && eval "$1=$str"
+    [ -n "$str" -a -n "$1" ] && eval "$1='$str'"
     debug_on
     return 0
 }
-- 
1.7.11.4
