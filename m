From: Jan Synacek <jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] fix syntax in .dir-locals.el
Date: Wed, 25 Feb 2015 13:16:45 +0100
Message-ID: <1424866606-12545-3-git-send-email-jsynacek@redhat.com>
References: <1424866606-12545-1-git-send-email-jsynacek@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424866606-12545-1-git-send-email-jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

---
 .dir-locals.el | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index c9ac3af..c0aff67 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,2 @@
-(setq sh-basic-offset: 4)
-(setq indent-tabs-mode nil)
+((nil . ((sh-basic-offset . 4)
+	 (indent-tabs-mode . nil))))
-- 
2.1.0
