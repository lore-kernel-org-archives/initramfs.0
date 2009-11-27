From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 5/6] loginit: Fix shebang
Date: Fri, 27 Nov 2009 11:57:15 +0100
Message-ID: <1259319436-14925-6-git-send-email-philippe.seewer@bfh.ch>
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
 modules.d/99base/loginit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/loginit b/modules.d/99base/loginit
index 8faa132..a777d6f 100755
--- a/modules.d/99base/loginit
+++ b/modules.d/99base/loginit
@@ -1,4 +1,4 @@
-#/bin/sh
+#!/bin/sh
 
 QUIET=$1
 
-- 
1.6.5.3
