From: Jan Synacek <jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] doc: fix typo
Date: Wed, 25 Feb 2015 13:16:44 +0100
Message-ID: <1424866606-12545-2-git-send-email-jsynacek@redhat.com>
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
 dracut.modules.7.asc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.modules.7.asc b/dracut.modules.7.asc
index e94670f..dbdf66e 100644
--- a/dracut.modules.7.asc
+++ b/dracut.modules.7.asc
@@ -19,7 +19,7 @@ you can replace init with your own version of _99base_, this is not encouraged.
 Instead you should use, if possible, the hooks of dracut. All hooks, and the
 point of time in which they are executed, are described in <<stages>>.
 
-The main script, which creates the initramfs is dracut itsself. It parses all
+The main script, which creates the initramfs is dracut itself. It parses all
 arguments and sets up the directory, in which everything is installed. It then
 executes all check, install, installkernel scripts found in the modules, which
 are to be processed. After everything is installed, the install directory is
-- 
2.1.0
