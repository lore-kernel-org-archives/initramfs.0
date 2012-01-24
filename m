From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] netroot: actually run netroot hooks
Date: Tue, 24 Jan 2012 13:09:34 -0500
Message-ID: <1327428574-3986-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The line "source_all netroot" was trying to source netroot hooks from
/netroot, which doesn't exist, so netroot hooks were never executed.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/netroot |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 9d996cc..bda34df 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -123,7 +123,7 @@ if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
 fi
 
 # Source netroot hooks before we start the handler
-source_all netroot
+source_all $hookdir/netroot
 
 # Run the handler; don't store the root, it may change from device to device
 # XXX other variables to export?
-- 
1.7.7.5
