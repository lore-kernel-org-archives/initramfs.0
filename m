From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 2/6] syslog-genrules.sh: Shebang should be /bin/sh not /bin/dash
Date: Fri, 27 Nov 2009 11:57:12 +0100
Message-ID: <1259319436-14925-3-git-send-email-philippe.seewer@bfh.ch>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/98syslog/syslog-genrules.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/98syslog/syslog-genrules.sh b/modules.d/98syslog/syslog-genrules.sh
index 64aa08c..8d99fb8 100755
--- a/modules.d/98syslog/syslog-genrules.sh
+++ b/modules.d/98syslog/syslog-genrules.sh
@@ -1,4 +1,4 @@
-#!/bin/dash
+#!/bin/sh
 # Creates the syslog udev rules to be triggered when interface becomes online.
 . /lib/dracut-lib.sh
 
-- 
1.6.5.3
