From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: TODO: Legacy NFS should be root= only
Date: Fri, 26 Jun 2009 09:13:12 +0200
Message-ID: <4A447508.1050506@bfh.ch>
References: <4A444DED.7040601@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A444DED.7040601-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
> mkinitrd Legacy
>     root=IP:path
>     (IP:path is OK in DHCP root-path too.)
> nfsroot.tx Legacy
>     root=/dev/nfs [nfsroot=...]
> 
> netroot= equivalents of the two Legacy we shouldn't support.  They are 
> not from legacy precedents.
> 
> (I tried to get de-support netroot= by unconditionally netroot=$root, 
> but the argument parser can't recognize root=dhcp in that case.  Dillow 
> says he has an idea to split and clean up argument parsing.)

Mind giving the patch below a go? This should fix the issue.


diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index 96076fd..72f3c2e 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -72,6 +72,17 @@ netroot_to_var() {
 [ -z "$netroot" ] && netroot=$(getarg netroot=)
 [ -z "$nfsroot" ] && nfsroot=$(getarg nfsroot=)
 
+# Netroot cmdline argument must be ignored, but must be used if
+# we're inside netroot to parse dhcp root-path
+if [ -n "$netroot" ] ; then
+    if [ "$netroot" = "$(getarg netroot=)" ] ; then
+    warn "Ignoring netroot argument for NFS"
+    netroot=$root
+    fi
+else
+    netroot=$root;
+fi
+
 # Handle old style <server-ip>:/<path
 # FIXME: root= is not handled by this yet.
 case "$netroot" in
@@ -79,17 +90,6 @@ case "$netroot" in
        netroot=nfs:$netroot;;
 esac
 
-# Root takes precedence over netroot
-case "${root%%:*}" in
-    nfs|nfs4|/dev/nfs)
-    if [ -n "$netroot" ] ; then
-	warn "root takes precedence over netroot. Ignoring netroot"
-
-    fi
-    netroot=$root
-    ;;
-esac
-
 # Continue if nfs or blank prefix
 case "${netroot%%:*}" in
     ''|nfs|nfs4|/dev/nfs);;
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
