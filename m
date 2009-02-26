From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] Trim out device nodes we do not have to actually create.
Date: Wed, 25 Feb 2009 18:32:43 -0800 (PST)
Message-ID: <1877ae16b1a8d6de63847a708db5e93168f489a8.1235615253.git.victor.lowther@gmail.com>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Im2y5HsvUNLAiwxGOctFlGIEa0nduC3Pobw/XJuOFjE=;
        b=rjx+qebA0kRVeVnIkPDsdGlN1MWevc/8JfTNxnh9QUjuYErwnSavsfSZKLq3Ulsqj+
         JEBmqjulMmEtdx67cQvYxOe97eFnABQ3b4zntSIIrJZgJ8aroHg8dnoyKtgDPUZ0NVda
         UM2kDbqAj2m03Qjc/xC8lDTLAfAdLRhUBpfes=
In-Reply-To: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If plymouth needs more, it can add them back in the hooks.
---
 init |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/init b/init
index c3f5150..f5b4177 100755
--- a/init
+++ b/init
@@ -40,16 +40,12 @@ mount -t sysfs /sys /sys
 mount -t tmpfs -omode=0755 udev /dev
 read CMDLINE </proc/cmdline;
 
-
-# FIXME: what device nodes does plymouth really _need_ ?
+# Make some basic devices first, let udev handle the rest
 mknod /dev/ptmx c 5 2
-mknod /dev/console c 5 0
-mknod /dev/fb c 29 0
+mknod /dev/null c 1 3
+mknod /dev/console c 5 1
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
-mknod /dev/tty0 c 4 0
-mknod /dev/tty1 c 4 1
-mknod /dev/null c 1 3
 
 # pre-udev scripts run before udev starts, and are run only once.
 source_all pre-udev
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
