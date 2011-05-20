From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 1/5] dracut-lib.sh: add vwarn() function
Date: Fri, 20 May 2011 17:09:23 +0200
Message-ID: <1305904167-14199-2-git-send-email-soltys@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305904167-14199-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Similary to vinfo()

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 4d03ed0..e376495 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -272,6 +272,12 @@ info() {
         echo "dracut: $@"
 }
 
+vwarn() {
+    while read line; do
+        warn $line;
+    done
+}
+
 vinfo() {
     while read line; do
         info $line;
-- 
1.7.2.1
