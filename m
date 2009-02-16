From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 13/50] Missed an instance of $initdir not being quoted.
Date: Mon, 16 Feb 2009 14:06:11 -0500
Message-ID: <200902161906.n1GJ6BaE027830@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=535df366535e64c716a635548346e20aa17d753a
Commit:     535df366535e64c716a635548346e20aa17d753a
Parent:     f9d7779e30d979bd157ae2831d5d3e9cd2c6db38
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:02 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 13/50] Missed an instance of $initdir not being quoted.
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index c333173..9de5bea 100755
--- a/dracut
+++ b/dracut
@@ -57,7 +57,7 @@ done
 # FIXME: would be nice if we didn't have to know which rules to grab....
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
-mkdir -p $initdir/lib/udev/rules.d
+mkdir -p "$initdir/lib/udev/rules.d"
 for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
   cp "$rule" "$initdir/lib/udev/rules.d"
 done
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
