From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 11/10] dracut: sewing fixup
Date: Fri, 21 Oct 2011 23:19:14 +0200
Message-ID: <1319231954-14286-1-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We accidentally tried to make upwards symlinks when directories existed.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 4cfcab8..72af2c0 100755
--- a/dracut
+++ b/dracut
@@ -543,7 +543,9 @@ else
 fi
 # initial sewing pass
 for d in "${initdir}${imgdir}"/*; do
-    ln -sfn "${imgdir#/}/${d##*/}" "${initdir}/${d##*/}"
+    if [[ ! -e "${initdir}/${d##*/}" ]]; then
+        ln -sfn "${imgdir#/}/${d##*/}" "${initdir}/${d##*/}"
+    fi
 done
 
 # check all our modules to see if they should be sourced.
@@ -684,7 +686,7 @@ for d in "${initdir}${imgdir}"/*; do
             dfatal "dracut: symlink mismatch ${d##*/} -/-> ${d#${initdir}/}"
             exit 1
         fi
-    else
+    elif [[ ! -e ${s} ]]; then
         ln -sfn "${d#${initdir}/}" "${s}"
     fi
 done
-- 
1.7.5.3
