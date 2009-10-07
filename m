From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] Do not worry at all about selinux stuff if we cannot find load_policy
Date: Wed,  7 Oct 2009 10:48:25 -0500 (CDT)
Message-ID: <76e534e17db7c50fe89c8878b4fccfce837380dd.1254930149.git.victor.lowther@gmail.com>
References: <a989fe01e19bd214cae75b705ac0c5e8aefb71d4.1254930149.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a989fe01e19bd214cae75b705ac0c5e8aefb71d4.1254930149.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dying horribly whenever load_policy is not found because we assume by default
that people want selinux loaded is very RHEL/fedora specifc. Instead, we 
should assume that we do not care at all about selinux if we cannot find
load_policy on the target filesystem.

Ideally, each distro would maintain their own module that uses pre-pivot
hooks to do whatever security policy magic they want -- 99base should not
know or care about any of that stuff.

---
 modules.d/99base/selinux-loadpolicy.sh |   45 ++++++++++++++-----------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/modules.d/99base/selinux-loadpolicy.sh b/modules.d/99base/selinux-loadpolicy.sh
index 9e95b8d..7599355 100755
--- a/modules.d/99base/selinux-loadpolicy.sh
+++ b/modules.d/99base/selinux-loadpolicy.sh
@@ -3,25 +3,24 @@
 
 rd_load_policy()
 {
-
-    SELINUX="enforcing"
-    [ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"
-
-    # If SELinux is disabled exit now 
-    getarg "selinux=0" > /dev/null
-    if [ $? -eq 0 -o "$SELINUX" = "disabled" ]; then
-	return 0
-    fi
-
-    # Check whether SELinux is in permissive mode
-    permissive=0
-    getarg "enforcing=0" > /dev/null
-    if [ $? -eq 0 -o "$SELINUX" = "permissive" ]; then
-	permissive=1
-    fi
-
+    
     # Attempt to load SELinux Policy
     if [ -x "$NEWROOT/usr/sbin/load_policy" -o -x "$NEWROOT/sbin/load_policy" ]; then
+	SELINUX="enforcing"
+	[ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"
+	
+        # If SELinux is disabled exit now 
+	getarg "selinux=0" > /dev/null
+	if [ $? -eq 0 -o "$SELINUX" = "disabled" ]; then
+	    return 0
+	fi
+
+        # Check whether SELinux is in permissive mode
+	permissive=0
+	getarg "enforcing=0" > /dev/null
+	if [ $? -eq 0 -o "$SELINUX" = "permissive" ]; then
+	    permissive=1
+	fi
 	ret=0
 	info "Loading SELinux policy"
 	{
@@ -35,11 +34,11 @@ rd_load_policy()
 		ret=$?
             fi
 	} 2>&1 | vinfo
-
+	
 	if [ $ret -eq 0 -o $ret -eq 2 ]; then
 	    return 0
 	fi
-
+	
 	warn "Initial SELinux policy load failed."
 	if [ $ret -eq 3 -o $permissive -eq 0 ]; then
 	    warn "Machine in enforcing mode."
@@ -48,12 +47,8 @@ rd_load_policy()
 	    exit 1
 	fi
 	return 0
-    elif [ $permissive -eq 0 ]; then
-	warn "Machine in enforcing mode and cannot execute load_policy."
-	warn "To disable selinux, add selinux=0 to the kernel command line."
-	warn "Not continuing"
-	sleep 100d
-	exit 1
+    else 
+	return 0
     fi
 }
 
-- 
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
