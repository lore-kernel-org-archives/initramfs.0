From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/18] The network check script must use /bin/bash
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <4e207ec86243a3ebbd660895e91074bc3cea99d8.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It sources dracut-functions.

---
 modules.d/40network/check |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/check b/modules.d/40network/check
index 95662f3..f2b137c 100755
--- a/modules.d/40network/check
+++ b/modules.d/40network/check
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 . $dracutfunctions
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
