From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 28/33] 90lvm: Install dm-snapshot module
Date: Thu, 20 Nov 2014 15:57:03 +0100
Message-ID: <1416495428-36978-29-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

bnc#888530

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90lvm/module-setup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index 9ddc56e..5515ac0 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -42,6 +42,10 @@ cmdline() {
     done
 }
 
+installkernel() {
+    instmods dm-snapshot
+}
+
 # called by dracut
 install() {
     local _i
-- 
1.8.5.2
