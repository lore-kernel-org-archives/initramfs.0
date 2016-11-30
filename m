From: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] 98integrity: Use /etc/ima/ima-policy as file location for IMA policy
Date: Wed, 30 Nov 2016 09:05:41 -0500
Message-ID: <1480514741-30910-1-git-send-email-stefanb@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

To sync with systemd, use the filepath /etc/ima/ima-policy as
the file location for the IMA policy.

Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 modules.d/98integrity/ima-policy-load.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/modules.d/98integrity/ima-policy-load.sh b/modules.d/98integrity/ima-policy-load.sh
index 85cd3b9..35cfbcc 100755
--- a/modules.d/98integrity/ima-policy-load.sh
+++ b/modules.d/98integrity/ima-policy-load.sh
@@ -5,10 +5,15 @@
 # Copyright (C) 2011 Politecnico di Torino, Italy
 #                    TORSEC group -- http://security.polito.it
 # Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
+#
+# Copyright (C) 2016 IBM Corporation
+#
+# Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
+#
 
 IMASECDIR="${SECURITYFSDIR}/ima"
 IMACONFIG="${NEWROOT}/etc/sysconfig/ima"
-IMAPOLICY="/etc/sysconfig/ima-policy"
+IMAPOLICY="/etc/ima/ima-policy"
 
 load_ima_policy()
 {
-- 
2.8.3
