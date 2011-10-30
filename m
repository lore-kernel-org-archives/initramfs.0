From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] init: /dev/.initramfs symlink fixup
Date: Mon, 31 Oct 2011 00:02:25 +0100
Message-ID: <1320015745-9557-1-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It's not related to $PREFIX being set or not (anymore).

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index c109ae4..0ce8ed8 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -380,7 +380,7 @@ if [ -d "$NEWROOT/run" ]; then
 else
     NEWRUN=/dev/.run
     mkdir -p -m 0755 "$NEWRUN"
-    [ -n "$PREFIX" ] && ln -sfn .run/initramfs /dev/.initramfs
+    ln -sfn .run/initramfs /dev/.initramfs
     # if initramfs's udev uses /run by default, but the host is
     # still /run-less, we should copy udev's data to legacy
     # /dev/.udev, so the necessary info is available for the host
-- 
1.7.7.1
