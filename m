From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] modules.d/99base/init: missing slash in ismounted check
Date: Sun, 24 Apr 2011 00:22:51 +0200
Message-ID: <1303597371-6280-2-git-send-email-soltys@ziu.info>
References: <1303597371-6280-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303597371-6280-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

ismounted sys -> ismounted /sys

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index f07ad40..094dfc9 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -98,7 +98,7 @@ else
     unset _tmp
 fi
 
-ismounted sys || \
+ismounted /sys || \
     mount -t sysfs -o nosuid,noexec,nodev /sys /sys >/dev/null 2>&1
 
 if ! ismounted /dev; then
-- 
1.7.4.2
