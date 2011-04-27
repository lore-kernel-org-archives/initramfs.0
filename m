From: leho <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] install losetup
Date: Wed, 27 Apr 2011 11:30:11 +0300
Message-ID: <1303893012-10923-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: leho <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>

---
 modules.d/90crypt-loopkey/module-setup.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/90crypt-loopkey/module-setup.sh

diff --git a/modules.d/90crypt-loopkey/module-setup.sh b/modules.d/90crypt-loopkey/module-setup.sh
new file mode 100644
index 0000000..4c3b6d4
--- /dev/null
+++ b/modules.d/90crypt-loopkey/module-setup.sh
@@ -0,0 +1,11 @@
+check() {
+	[ -n $hostonly ] && return 0 || return 255
+}
+
+depends() {
+	echo "crypt"
+}
+
+install() {
+	inst losetup
+}
-- 
1.7.3.4
