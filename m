From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Make bash regexes behave
Date: Fri, 27 Feb 2009 15:16:36 +0100
Message-ID: <49A7F5C4.3090106@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On some systems with newer or unpatched bash versions the whole right 
portion of =~ is considered part of the regex. Means we need to get rid 
of enclosing ''.

This patch fixes this.

--
  dracut-functions |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index d95d267..2f63e31 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -82,17 +82,17 @@ inst_binary() {
      # I love bash!
      while read line; do
  	[[ $line = 'not a dynamic executable' ]] && return 1
-	[[ $line =~ 'not found' ]] &&{
+	[[ $line =~ not\ found ]] &&{
  	    echo "Missing a shared library required by $bin." >&2
  	    echo "Run \"ldd $bin\" to find out what it is." >&2
  	    echo "dracut cannot create an initrd." >&2
  	    exit 1
  	}
-	[[ $line =~ '([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)' ]] || continue
+	[[ $line =~ ([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*) ]] || continue
  	FILE=${BASH_REMATCH[1]}
  	[[ -f ${initdir}$FILE ]] && continue
  	# see if we are loading an optimized version of a shared lib.
-	[[ $FILE =~ '^(/lib[^/]*).*' ]] && {
+	[[ $FILE =~ ^(/lib[^/]*).* ]] && {
              TLIBDIR=${BASH_REMATCH[1]}
              BASE="${FILE##*/}"
  	    # prefer nosegneg libs, then unoptimized ones.
@@ -115,7 +115,7 @@ inst_binary() {
  inst_script() {
      local src=$1 target=${2:-$1} line
      read -r -n 80 line <"$src"
-    [[ $line =~ '(#! *)(/[^ ]+).*' ]] || return 1
+    [[ $line =~ (#! *)(/[^ ]+).* ]] || return 1
      inst "${BASH_REMATCH[2]}" && inst_simple "$src" "$target"
  }


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
