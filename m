From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 02/50] Add a simple getarg function.
Date: Mon, 16 Feb 2009 14:05:51 -0500
Message-ID: <200902161905.n1GJ5pNl027166@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=047891955e9039ea4242c941d6c4bc617528226a
Commit:     047891955e9039ea4242c941d6c4bc617528226a
Parent:     09f9fec00c04858806d235688b6d728a20c3201e
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:32 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 02/50] Add a simple getarg function.
    
    If we ever need to get more than one kernel command line argument, this
    function will pay for itself.  It relies on a feature of the way bash
    handles string comparisons in [[ ]] statements -- the RHS is matched
    according to globbing rules, and is not a straight string match.
---
 init |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/init b/init
index eb8998d..b5b0b1b 100755
--- a/init
+++ b/init
@@ -14,6 +14,12 @@ emergency_shell()
     bash < /dev/console
 }
 
+getarg() {
+    for o in $(< /proc/cmdline); do
+	[[ $o == $1 ]] && { echo $o; break; }
+    done
+}
+
 echo "Starting initrd..."
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
