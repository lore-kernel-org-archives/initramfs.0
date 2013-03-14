From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fix typo in dracut.conf.5.asc
Date: Thu, 14 Mar 2013 13:48:06 -0400
Message-ID: <1363283286-29312-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It's /etc/dracut.conf.d, not /etc/dracut/conf.d
---
 dracut.conf.5.asc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index 1cc810f..dbaa2e5 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -140,7 +140,7 @@ Files
 -----
 _/etc/dracut.conf_::
     Old configuration file. You better use your own file in
-    _/etc/dracut/conf.d/_.
+    _/etc/dracut.conf.d/_.
 
 _/etc/dracut.conf.d/_::
     Any _/etc/dracut.conf.d/*.conf_ file can overwrite the values in
-- 
1.8.1.4
