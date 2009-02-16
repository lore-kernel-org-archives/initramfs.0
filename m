From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 46/50] fixed library-matching regex
Date: Mon, 16 Feb 2009 14:07:16 -0500
Message-ID: <200902161907.n1GJ7Gsi028916@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=bff8c33c2bb17a7641ce664c5435f35956dbd02f
Commit:     bff8c33c2bb17a7641ce664c5435f35956dbd02f
Parent:     aeaaa812d256e9d4b431d301b9a81dc6e103c349
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:21 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 46/50] fixed library-matching regex
    
    Forgot about /lib64
---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index e80d786..a0a1906 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -68,7 +68,7 @@ inst_binary() {
     [[ -f $initdir$target ]] && return 0
     # I love bash!
     while read line; do
-	[[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*|not found)' ]] || continue
+	[[ $line =~ '([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*|not found)' ]] || continue
 	FILE=${BASH_REMATCH[1]}
         [[ $FILE = 'not found' ]] && {
 	    echo "Missing a shared library required by $bin." >&2
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
