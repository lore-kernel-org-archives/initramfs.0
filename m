From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 12/50] Get rid of some redundancy when sourcing our functions.
Date: Mon, 16 Feb 2009 14:06:09 -0500
Message-ID: <200902161906.n1GJ69Hu027803@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=f9d7779e30d979bd157ae2831d5d3e9cd2c6db38
Commit:     f9d7779e30d979bd157ae2831d5d3e9cd2c6db38
Parent:     e4191d353f6afad96a144ddf13939d23e05c6e90
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:59 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 12/50] Get rid of some redundancy when sourcing our functions.
---
 dracut |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/dracut b/dracut
index 7ba4a09..c333173 100755
--- a/dracut
+++ b/dracut
@@ -32,17 +32,11 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-if [[ $allowlocal && -f ./init ]]; then
-    . ./dracut-functions
-    initfile=./init
-    switchroot=./switch_root
-    rulesdir=./rules.d
-else
-    . /usr/libexec/dracut/functions
-    initfile=/usr/libexec/dracut/init
-    switchroot=/usr/libexec/dracut/switch_root
-    rulesdir=/usr/libexec/dracut/rules.d
-fi
+[[ $allowlocal && -f ./init ]] && dsrc="." || dsrc=/usr/libexec/dracut
+. $dsrc/dracut-functions
+initfile=$dsrc/init
+switchroot=$dsrc/switch_root
+rulesdir=$dsrc/rules.d
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
