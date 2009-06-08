From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 04/11] NFS root: add missing DHCP root-path/nfsroot=[IP:]/path[,options] format
Date: Mon,  8 Jun 2009 00:40:17 -0400
Message-ID: <4107be9f9f1c2a635d3c504c4388601d3bb02e5f.1244435634.git.dave@thedillows.org>
References: <cover.1244435634.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

Reported-by: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
---
 modules.d/95nfs/nfs-netroot.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/modules.d/95nfs/nfs-netroot.sh b/modules.d/95nfs/nfs-netroot.sh
index 0591a31..8d552e9 100755
--- a/modules.d/95nfs/nfs-netroot.sh
+++ b/modules.d/95nfs/nfs-netroot.sh
@@ -14,6 +14,10 @@ if [ "$root" = "dhcp" -o "$root" = "nfs" -o "$root" = "nfs4" ]; then
 	if check_occurances "$new_root_path" ':' 2; then
 	    root="$nfsver:$new_root_path"
 	fi ;;
+    *:/*,*)
+	if check_occurances "$new_root_path" ':' 1; then
+	    root="$nfsver:$new_root_path"
+	fi ;;
     *:/*)
 	if check_occurances "$new_root_path" ':' 1; then
 	    root="$nfsver:$new_root_path:"
@@ -22,6 +26,10 @@ if [ "$root" = "dhcp" -o "$root" = "nfs" -o "$root" = "nfs4" ]; then
 	if check_occurances "$new_root_path" ':' 1; then
 	    root="$nfsver::$new_root_path"
 	fi ;;
+    /*,*)
+	if check_occurances "$new_root_path" ':' 0; then
+	    root="$nfsver::$new_root_path"
+	fi ;;
     /*)
 	if check_occurances "$new_root_path" ':' 0; then
 	    root="$nfsver::$new_root_path:"
@@ -40,6 +48,14 @@ if [ -z "${root%%nfs:*}" -o -z "${root%%nfs4:*}" ]; then
     if [ -z "$nfsserver" -o "$nfsserver" = "$nfspath" ]; then
 	nfsserver=$new_dhcp_server_identifier
     fi
+
+    # Handle alternate syntax of path,options
+    if [ "$nfsflags" = "$nfspath" -a "${root#*,}" != "$root" ]; then
+	nfspath=${root%%,*}
+	nfsflags=${root#*,}
+    fi
+
+    # Catch the case when no additional flags are set
     if [ "$nfspath" = "$nfsflags" ]; then
 	unset nfsflags
     fi
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
