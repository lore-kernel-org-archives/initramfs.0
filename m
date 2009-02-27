From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Fix find_binary always succeeding
Date: Fri, 27 Feb 2009 14:28:40 +0100
Message-ID: <49A7EA88.6090602@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

find_binary inside dracut-functions always succeeds. Independent of 
whether the file actually exists or not.

This patch fixes this.

And since we're using the function not only to find binaries at little 
enhancement there shouldn't be that bad either.

--
dracut-functions |   21 ++++++++++++++++-----
  1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 56b3757..d95d267 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -53,11 +53,21 @@ inst_library() {
      fi
  }
  	
-find_binary() {
+find_file() {
      local binpath="/bin /sbin /usr/bin /usr/sbin" p
-    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
+
+    #Full path or not?
+    if [[ ${1##*/} != $1 ]] ; then
+	if [[ -e $1 ]] ; then
+	    echo $1;
+	    return 0;
+	fi
+	return 1;
+    fi
+
+    #Search in path
      for p in $binpath; do
-	[[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
+	[[ -e $p/$1 ]] && { echo "$p/$1"; return 0; }
      done
      return 1
  }
@@ -96,7 +106,7 @@ inst_binary() {
  	    continue
  	}
          inst_library "$FILE"
-    done < <(ldd $bin 2>/dev/null)
+    done < <(ldd $bin)
      inst_simple "$bin" "$target"
  }

@@ -134,7 +144,8 @@ inst() {
          echo "usage: inst <file> <root> [<destination file>]"
          return 1
      fi
-    local src=$(find_binary "$1") || {
+    local src=$(find_file "$1")
+    [[ $src ]] || {
  	echo "Cannot find requested file $1. Exiting."
  	exit 1
      }
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
