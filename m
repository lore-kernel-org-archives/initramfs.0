From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] Support rootflags and rootfstype kernel parameters.
Date: Sat, 21 Feb 2009 08:24:35 -0800 (PST)
Message-ID: <549916f6823fb95dc12fbee9cd5a23f91b422e80.1235233199.git.victor.lowther@gmail.com>
References: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=1RXGw8airQQeKrtWPPy/UBOhW8GkKBZ14BcDXaM70p0=;
        b=M0qYrnoJfs215vMMiZm6XIiCgGDxIv3FD/HSuoc5/mFiAxiPxiykwag7X11Ff/cXpN
         hXpwVYbpuiUluUuK5CfGcdU8uoysIbnIhohonHwjAd/kGEdm/uxYKpFUXibpPfslNyCJ
         07SjkXXCuz8OR2A0dvkXxjgdBTlJE6iZ0S0o8=
In-Reply-To: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This also folds in support for ro and rw flags.
---
 init |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/init b/init
index 7b0c61b..581c2b9 100755
--- a/init
+++ b/init
@@ -79,10 +79,16 @@ udevadm settle --timeout=30
 source_all pre-mount
 
 echo "Trying to mount rootfs $root"
-rwopt="$(getarg rw)" || rwopt="ro"
+if rflags="$(getarg rootflags)"; then
+    rflags="${rflags#rootflags=}"
+    getarg rw >/dev/null && rflags="${rflags},rw" || rflags="${rflags},ro"
+else
+     getarg rw >/dev/null && rflags=rw || rflags=ro
+fi
 [ -e "$root" ] || emergency_shell
-ln -s "$root" /dev/root    
-mount -o $rwopt /dev/root $NEWROOT || emergency_shell
+ln -s "$root" /dev/root 
+fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
+mount $fstype -o $rflags /dev/root $NEWROOT || emergency_shell
 
 INIT=$(getarg init)
 [ "$INIT" ] || {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
