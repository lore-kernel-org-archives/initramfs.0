From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 34/50] Use inst to install hooks.
Date: Mon, 16 Feb 2009 14:06:53 -0500
Message-ID: <200902161906.n1GJ6rWf028445@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=4b3f76dbe2f57c847c4804150be367abf5ffd574
Commit:     4b3f76dbe2f57c847c4804150be367abf5ffd574
Parent:     ec1ad3347c423f27dd546858032a73edccbcc806
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:52 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 34/50] Use inst to install hooks.
    
    This will ensure that pathname mangling is handled correctly, and that
    whatever interpreter is handling /bin/sh is installed as /bin/sh
---
 dracut |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index ecf58dc..aec20c0 100755
--- a/dracut
+++ b/dracut
@@ -37,6 +37,7 @@ initfile=$dsrc/init
 switchroot=$dsrc/switch_root
 rulesdir=$dsrc/rules.d
 echoer=$dsrc/echoer
+hookdirs="pre-udev pre-mount pre-pivot"
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
