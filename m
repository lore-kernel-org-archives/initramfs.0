From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] Do not worry at all about selinux stuff if we cannot find load_policy
Date: Wed,  2 Jun 2010 07:07:56 -0500 (CDT)
Message-ID: <d0ba9e0f511ab3e4b0cca6d3d0551ae7a881385f.1275480426.git.victor.lowther@gmail.com>
References: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Forcing users to pass selinux=0 when operating on a system that does not and
never has used selinux is really annoying.
---
 modules.d/99base/selinux-loadpolicy.sh |  124 +++++++++++++++----------------
 1 files changed, 60 insertions(+), 64 deletions(-)

diff --git a/modules.d/99base/selinux-loadpolicy.sh b/modules.d/99base/selinux-loadpolicy.sh
dissimilarity index 68%
index 7db9f8c..5792410 100755
--- a/modules.d/99base/selinux-loadpolicy.sh
+++ b/modules.d/99base/selinux-loadpolicy.sh
@@ -1,64 +1,60 @@
-#!/bin/sh
-# FIXME: load selinux policy.  this should really be done after we switchroot 
-
-rd_load_policy()
-{
-    # If SELinux is disabled exit now 
-    getarg "selinux=0" > /dev/null && return 0
-
-    SELINUX="enforcing"
-    [ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"
-
-    # Check whether SELinux is in permissive mode
-    permissive=0
-    getarg "enforcing=0" > /dev/null 
-    if [ $? -eq 0 -o "$SELINUX" = "permissive" ]; then
-	permissive=1
-    fi
-
-    # Attempt to load SELinux Policy
-    if [ -x "$NEWROOT/usr/sbin/load_policy" -o -x "$NEWROOT/sbin/load_policy" ]; then
-	ret=0
-	info "Loading SELinux policy"
-	{
-            # load_policy does mount /proc and /selinux in 
-            # libselinux,selinux_init_load_policy()
-            if [ -x "$NEWROOT/sbin/load_policy" ]; then
-		chroot "$NEWROOT" /sbin/load_policy -i
-		ret=$?
-            else
-		chroot "$NEWROOT" /usr/sbin/load_policy -i
-		ret=$?
-            fi
-	} 2>&1 | vinfo
-
-	if [ "$SELINUX" = "disabled" ]; then
-	    return 0;
-	fi
-
-	if [ $ret -eq 0 -o $ret -eq 2 ]; then
-	    # If machine requires a relabel, force to permissive mode
-	    [ -e "$NEWROOT"/.autorelabel ] && ( echo 0 > "$NEWROOT"/selinux/enforce )
-            mount --bind /dev "$NEWROOT/dev"
-            chroot "$NEWROOT" /sbin/restorecon -R /dev
-	    return 0
-	fi
-
-	warn "Initial SELinux policy load failed."
-	if [ $ret -eq 3 -o $permissive -eq 0 ]; then
-	    warn "Machine in enforcing mode."
-	    warn "Not continuing"
-	    sleep 100d
-	    exit 1
-	fi
-	return 0
-    elif [ $permissive -eq 0 -a "$SELINUX" != "disabled" ]; then
-	warn "Machine in enforcing mode and cannot execute load_policy."
-	warn "To disable selinux, add selinux=0 to the kernel command line."
-	warn "Not continuing"
-	sleep 100d
-	exit 1
-    fi
-}
-
-rd_load_policy
+#!/bin/sh
+# FIXME: load selinux policy.  this should really be done after we switchroot
+
+rd_load_policy()
+{
+    # If SELinux is disabled exit now
+    getarg "selinux=0" > /dev/null && return 0
+    # if we cannot find load_policy, just return.
+    [ -x "$NEWROOT/usr/sbin/load_policy" ] || \
+	[ -x "$NEWROOT/sbin/load_policy" ] || \
+	return 0
+
+    SELINUX="enforcing"
+    [ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"
+
+    # Check whether SELinux is in permissive mode
+    permissive=0
+    getarg "enforcing=0" > /dev/null
+    if [ $? -eq 0 -o "$SELINUX" = "permissive" ]; then
+	permissive=1
+    fi
+
+    # Attempt to load SELinux Policy
+    ret=0
+    info "Loading SELinux policy"
+    {
+	    # load_policy does mount /proc and /selinux in
+	    # libselinux,selinux_init_load_policy()
+	if [ -x "$NEWROOT/sbin/load_policy" ]; then
+	    chroot "$NEWROOT" /sbin/load_policy -i
+	    ret=$?
+	else
+	    chroot "$NEWROOT" /usr/sbin/load_policy -i
+	    ret=$?
+	fi
+    } 2>&1 | vinfo
+
+    if [ "$SELINUX" = "disabled" ]; then
+	return 0;
+    fi
+
+    if [ $ret -eq 0 -o $ret -eq 2 ]; then
+	    # If machine requires a relabel, force to permissive mode
+	[ -e "$NEWROOT"/.autorelabel ] && ( echo 0 > "$NEWROOT"/selinux/enforce )
+	mount --bind /dev "$NEWROOT/dev"
+	chroot "$NEWROOT" /sbin/restorecon -R /dev
+	return 0
+    fi
+
+    warn "Initial SELinux policy load failed."
+    if [ $ret -eq 3 -o $permissive -eq 0 ]; then
+	warn "Machine in enforcing mode."
+	warn "Not continuing"
+	sleep 100d
+	exit 1
+    fi
+    return 0
+}
+
+rd_load_policy
-- 
1.7.1
