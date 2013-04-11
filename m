From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH 2/2] [40network] Provide a hostname fallback function, in case there is no executable of this name
Date: Thu, 11 Apr 2013 17:40:53 +0200
Message-ID: <1365694853-7881-2-git-send-email-devurandom@gmx.net>
References: <1365694853-7881-1-git-send-email-devurandom@gmx.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694853-7881-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>

---
 modules.d/40network/net-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index caa3b79..baeace4 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -422,3 +422,8 @@ net_add_parse_vars() {
 		[ -f /tmp/40network.parse.finished."${jobid}" ] && rm -f /tmp/40network.parse.finished."${jobid}"
 	EOF
 }
+
+type hostname >/dev/null 2>&1 || \
+hostname() {
+	cat /proc/sys/kernel/hostname
+}
-- 
1.8.1.5
