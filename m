From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] dracut: Add drivers/clk by default on arm
Date: Thu, 12 May 2016 17:28:21 +0200
Message-ID: <1463066902-11767-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9H/yR6/Q5ICgFxzYa6Ivv963SJpw7KJXG6FgXpxmPWc=;
        b=X86LEzUVmwP0MQLl0+Iz0XFGGRrle7oIyp8G7n7/V5+7/8w35l+Whky7Aj/K2Ud9m+
         WDSNOfqkhOu6bn5H3n2KnreutTuZrQeccPdO5OTlIPCmiRt0MvWUlkH9O+C5Ao3rJmab
         oTPQMJFR0QmKWlxGK9MMEMekfroN4AnzLIXp9bScPApKdaeHaaBDLkBm5LX5agxDUZ+N
         orfYeEI7NX1rza8n7kFpl41YF4MBnAOy63lINxlYocigbohxUHwqsLHCg5xB6lZgS96V
         ji9hBr2hZa6v/AOljL7mRmxvW5ORnyzbYpauUKQjVh8qcpRC6GLJgwZvEXKKqubMRTDk
         DE7A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This will bundle clock drivers into the initramfs on arm

Tested on ti dm8148-t410 where adpll is needed on 4.6+ kernel
This will avoid to rely on (maybe broken) bootloader clocks.

Theses modules are also usually loaded early. Having them bundled into
the initramfs will avoid lot of deferred probes and others delay.

Signed-off-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index c30715d..7904c02 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -26,6 +26,7 @@ installkernel() {
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
             instmods \
+                "=drivers/clk" \
                 "=drivers/i2c/busses" \
                 "=drivers/regulator" \
                 "=drivers/rtc" \
-- 
2.4.11
