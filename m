From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [RFC 1/6] 90mdraid: adjust stock mdadm udev rules
Date: Tue,  6 Sep 2011 00:17:23 +0200
Message-ID: <1315261048-19544-2-git-send-email-soltys@ziu.info>
References: <1315261048-19544-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315261048-19544-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently shipped mdadm rules incrementally assemble all imsm and native
raids, and do so unconditionally. This causes few issues:

- fine-grained controls in 65-md* are shadowed - for example,
  mdadm.conf's presence tests or uuid checks
- 90dmraid might also conflict with 90mdraid, if user prefers the former
  to handle containers
- possibly other subtle issues

This patch adjusts the behaviour.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/90mdraid/module-setup.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index de7785d..91a0769 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -50,6 +50,11 @@ install() {
 
     if [ ! -x /lib/udev/vol_id ]; then
         inst_rules 64-md-raid.rules
+        # remove incremental assembly from stock rules, so they don't shadow
+        # 65-md-inc*.rules and its fine-grained controls, or cause other problems
+        # when we explicitly don't want certain components to be incrementally
+        # assembled
+        sed -i -e '/^ENV{ID_FS_TYPE}==.*ACTION=="add".*RUN+="\/sbin\/mdadm --incremental $env{DEVNAME}"$/d' "${initdir}/lib/udev/rules.d/64-md-raid.rules"
     fi
 
     inst_rules "$moddir/65-md-incremental-imsm.rules"
-- 
1.7.5.3
