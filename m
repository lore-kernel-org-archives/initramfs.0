From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] shutdown: fix PATH
Date: Wed, 21 Mar 2012 19:47:46 -0400
Message-ID: <1332373666-20104-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Some systems might not use /bin:/sbin in their paths anymore, but we're
still using it in initramfs, so make sure our PATH is correct.
---
 modules.d/99shutdown/shutdown.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/99shutdown/shutdown.sh b/modules.d/99shutdown/shutdown.sh
index c8ca664..8817a4c 100755
--- a/modules.d/99shutdown/shutdown.sh
+++ b/modules.d/99shutdown/shutdown.sh
@@ -10,6 +10,7 @@
 #!/bin/sh
 . /lib/dracut-lib.sh
 export TERM=linux
+PATH=/usr/sbin:/usr/bin:/sbin:/bin
 
 emergency_shell()
 {
-- 
1.7.7.6
