From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:49 -0800 (PST)
Message-ID: <ec9d84aa2b3667b6252e1f9c9f4fe7b4396188a4.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=AXCkBnPhECHVHnHHbFx3sUFOyo53DyDUNz06htqgTXg=;
        b=NoAVJMLwDCZRGb27rHs3VswuQfu+YRQI146ki6bApvzCB6uDgyKu1QyQKdXQIB9iFF
         1MpWB7w+fducIuXJ68J0GoQVnB+EFm8W320ZdK2aMEkSDJyRzq8X0n7eRqG3gibI+gt6
         nA/qhmBRI4t7eNG7igRp9gGxKgzoeWlUwKwvg=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Try to install file as scripts before installing them as binaries

This ensures that scripts will have their interpreter installed before
they get installed.

Also included a minor fixup that skips library checking if the binary
we are testing is already installed.
---
 dracut-functions |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 1ded3d8..97ac626 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -59,6 +59,7 @@ inst_library() {
 inst_binary() {
     local bin="$1" target="${2:-$1}"
     local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
+    [[ -f $initdir$target ]] && return 0
 
     LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
 	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
@@ -122,7 +123,7 @@ inst() {
         return 1
     fi
     local src=$1 dest=${2:-$1}
-    for x in inst_symlink inst_binary inst_script inst_simple; do
+    for x in inst_symlink inst_script inst_binary inst_simple; do
 	$x "$src" "$dest" && return 0
     done
     return 1
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
