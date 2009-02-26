From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] Add some predefined break points.
Date: Wed, 25 Feb 2009 18:32:46 -0800 (PST)
Message-ID: <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther@gmail.com>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=ZKCPVTY9Ms57EHtAYYsUCQo9G1w/9Kni4jKXA89ok3g=;
        b=qFX2MVUqenJJEF+9fbKlHyVUKDhXGlIwB5z9i6Wp7NwPdAFknDUP68tCAMoE0uhdGJ
         AbdoZypRiGO7zZkvrARUo+lCOG97f1LzH7fHykOT3bxMQXl/4jDasxCM8gmiW3jhFWe2
         tS7sd5YH93/s13Lk0+9D3r9IR4eL6H+0hdLlI=
In-Reply-To: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We now have a breakpoint just before each of the hook invocations, and one
just before we switch to the real root.
---
 init |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/init b/init
index f5b4177..74b3368 100755
--- a/init
+++ b/init
@@ -48,18 +48,20 @@ mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
 
 # pre-udev scripts run before udev starts, and are run only once.
+getarg 'break=pre-udev' && emergency_shell
 source_all pre-udev
 
 # start up udev and trigger cold plugs
 udevd --daemon
 udevadm trigger >/dev/null 2>&1
-udevadm settle --timeout=30
+udevadm settle --timeout=30 >/dev/null 2>&1
 
 NEWROOT="/sysroot"
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
+getarg 'break=pre-mount' && emergency_shell
 source_all pre-mount
-
+getarg 'break=mount' && emergency_shell
 # mount scripts actually try to mount the root filesystem, and may
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 while :; do
@@ -83,7 +85,9 @@ done
 }
 
 # pre pivot scripts are sourced just before we switch over to the new root.
+getarg 'break=pre-pivot' && emergency_shell
 source_all pre-pivot
+getarg break && emergency_shell
 echo "Switching to real root filesystem $root"
 exec switch_root "$NEWROOT" "$INIT"  $CMDLINE || {
     # davej doesn't like initrd bugs
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
