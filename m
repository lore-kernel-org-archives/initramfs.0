From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] str_replace() fix
Date: Thu, 15 Sep 2011 08:45:57 +0200
Message-ID: <1316069157-3063-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Whitespace removal in:

	out="${out}${chop# }$r"

will damage certain strings, for example the following call:

	str_replace ' aax aaxaa' x y

would return 'aayaayaa' instead of ' aay aayaa'.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 50b1ed2..62c3bf5 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -24,7 +24,7 @@ str_replace() {
 
     while strstr "${in}" "$s"; do
         chop="${in%%$s*}"
-        out="${out}${chop# }$r"
+        out="${out}${chop}$r"
         in="${in#*$s}"
     done
     echo "${out}${in}"
-- 
1.7.5.3
