From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: [PATCH] dracut: use TMPDIR defintion
Date: Mon, 16 May 2011 17:46:46 +0200
Message-ID: <1305560806-27836-1-git-send-email-max@stro.at>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maximilian attems <max-U9r9yeDMy7A@public.gmane.org>

mktemp has marked the "-t" as deprecated.
TMPDIR is anyway write guarded just a line above since dracut 003.

Signed-off-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index d19c162..e018061 100755
--- a/dracut
+++ b/dracut
@@ -452,7 +452,7 @@ elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
 fi
 
 [[ $TMPDIR && ! -w $TMPDIR ]] && unset TMPDIR
-readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
+readonly initdir=$(mktemp --tmpdir=${TMPDIR:-/var/tmp/} -d initramfs.XXXXXX)
 
 # clean up after ourselves no matter how we die.
 trap 'ret=$?;rm -rf "$initdir";exit $ret;' EXIT
-- 
1.7.4.4
