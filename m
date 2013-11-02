From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] dracut-functions.sh: Avoid loading unnecessary 32-bit libraries for 64-bit initrds
Date: Sat,  2 Nov 2013 11:26:30 +0000
Message-ID: <1383391590-437-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Due to the 'inst_libdir_file "libnss_files*"' in the udev-rules module
this caues the /usr/lib/libnss_files-2.18.so* to be included. This is a
32-bit library and pulls in a 32-bit version of glibc also even on a
64-bit system.

This is due to the fact that ldconfig -pN will print [/usr]/lib paths
from the cache as well as [/usr]/lib64. As we handle these paths
specifically we should ignore these results from the cache.

Also there was a missing space when appending the ldconfig paths
onto our list meaning the last builtin and first ldconfig path
were unusable.
---
 dracut-functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 2e6e845..1355aca 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -65,6 +65,7 @@ ldconfig_paths()
             printf "%s\n" ${d%/*};
         done
     ); do
+        [[ "$i" = "/lib" || "$i" = "/usr/lib" || "$i" = "/lib64" || "$i" = "/usr/lib64" ]] && continue
         a["$i"]=1;
     done;
     printf "%s\n" ${!a[@]}
@@ -81,7 +82,7 @@ if ! [[ $libdirs ]] ; then
         [[ -d /usr/lib ]] && libdirs+=" /usr/lib"
     fi
 
-    libdirs+="$(ldconfig_paths)"
+    libdirs+=" $(ldconfig_paths)"
 
     export libdirs
 fi
-- 
1.8.4
