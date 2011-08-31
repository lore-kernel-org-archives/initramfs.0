From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 5/8] instmods: sanity for _mpargs
Date: Tue, 30 Aug 2011 21:40:24 -0700
Message-ID: <4E5DBB38.5060004@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Documentation would save time!

---
 dracut-functions |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 5ff1d26..dc71f51 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -892,17 +892,20 @@ instmods() {
                 # This introduces 2 incompatible meanings for =* arguments
                 # to instmods.  We need to decide which one to keep.
                 if [[ $_mod = =ata && -f $srcmods/modules.block ]]; then
-                    ( echo -n "$_mpargs"; egrep 'ata|ahci' "${srcmods}/modules.block" ) \
+                    ( [[ "$_mpargs" ]] && echo $_mpargs
+                      egrep 'ata|ahci' "${srcmods}/modules.block" ) \
                     | instmods
                 elif [ -f $srcmods/modules.${_mod#=} ]; then
-                    ( echo -n "$_mpargs"; cat "${srcmods}/modules.${_mod#=}" ) \
+                    ( [[ "$_mpargs" ]] && echo $_mpargs
+                      cat "${srcmods}/modules.${_mod#=}" ) \
                     | instmods
                 else
-                    ( echo -n "$_mpargs"; find "$srcmods" -path "*/${_mod#=}/*" ) \
+                    ( [[ "$_mpargs" ]] && echo $_mpargs
+                      find "$srcmods" -path "*/${_mod#=}/*" ) \
                     | instmods
                 fi
                 ;;
-            --*) _mpargs+="${_mod##*/}"$'\n' ;;  # one _mod per line; lops '--'
+            --*) _mpargs+=" $_mod" ;;
             i2o_scsi) return ;; # Do not load this diagnostic-only module
             *)  _mod=${_mod##*/}
 -- 1.7.6


-- 
