From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] Make splitsep work as documented with less vars than fields
Date: Thu,  5 Apr 2012 13:01:38 -0400
Message-ID: <1333645299-16837-5-git-send-email-wwoods@redhat.com>
References: <1333645299-16837-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333645299-16837-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

According to its comment in dracut-lib.sh:

    splitsep ":" "one:all:the:rest" one two

should set two="all:the:rest". But there's no check to see if the
current field is the last field, so it just gets "all".
---
 modules.d/99base/dracut-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 1ecd286..e10a34d 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -224,13 +224,14 @@ splitsep() {
     local sep="$1"; local str="$2"; shift 2
     local tmp
 
-    while [ -n "$str" -a -n "$*" ]; do
+    while [ -n "$str" -a "$#" -gt 1 ]; do
         tmp="${str%%$sep*}"
         eval "$1=${tmp}"
         str="${str#$tmp}"
         str="${str#$sep}"
         shift
     done
+    [ -n "$str" -a -n "$1" ] && eval "$1=$str"
 
     return 0
 }
-- 
1.7.7.6
