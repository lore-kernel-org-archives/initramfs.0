From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/18] Get rid of redundant NONL stuff in dracut-gencmdline
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <ebdddd29d3b51f06f44b64bb12c19de149adcd20.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

bash's built-in echo already understands -n.

---
 dracut-gencmdline |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/dracut-gencmdline b/dracut-gencmdline
index 733f199..2901199 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -21,22 +21,11 @@
 
 
 function error() {
-    local NONL=""
-    if [ "$1" == "-n" ]; then
-        NONL="-n"
-        shift
-    fi
-    echo $NONL "$@" >&2
+    echo "$@" >&2
 }
 
 function vecho() {
-    return
-    local NONL=""
-    if [ "$1" == "-n" ]; then
-        NONL="-n"
-        shift
-    fi
-    is_verbose && echo $NONL "$@"
+    is_verbose && echo "$@"
 }
 
 # module dep finding and installation functions
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
