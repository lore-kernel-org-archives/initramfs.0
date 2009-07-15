From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 12/14] Makefile: add debug module to the testimage target
Date: Wed, 15 Jul 2009 18:50:44 +0200
Message-ID: <1247676646-3837-13-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a021617..9395eca 100644
--- a/Makefile
+++ b/Makefile
@@ -61,5 +61,5 @@ check: all
 	make -C test check
 
 testimage: all
-	./dracut -l -f test-$(shell uname -r).img $(shell uname -r)
+	./dracut -l -a debug -f test-$(shell uname -r).img $(shell uname -r)
 	@echo wrote  test-$(shell uname -r).img 
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
