From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 31/50] We no longer require plymouth.  Remove it from the spec.
Date: Mon, 16 Feb 2009 14:06:47 -0500
Message-ID: <200902161906.n1GJ6lOT028356@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=b32f55156d345ddc52c16482ade1766acdda666b
Commit:     b32f55156d345ddc52c16482ade1766acdda666b
Parent:     7924b2127923b35c8c6ef25c19164751fa4d7096
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:45 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 31/50] We no longer require plymouth.  Remove it from the spec.
---
 dracut.spec |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index c1a1cf9..24f6513 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -21,7 +21,6 @@ Requires: mktemp
 Requires: mount
 Requires: nash
 Requires: bash
-Requires: plymouth >= 0.6.0-2
 Requires: /usr/bin/eu-readelf
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
