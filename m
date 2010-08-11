From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] bootchart module cleanup
Date: Wed, 11 Aug 2010 21:46:56 +0400
Message-ID: <20100811174656.15568.98666.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- create /lib/bootchart in initramfs, not in live filesystem
- use proper dracut API to install files

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/00bootchart/install |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/00bootchart/install b/modules.d/00bootchart/install
index ff29de0..8738815 100644
--- a/modules.d/00bootchart/install
+++ b/modules.d/00bootchart/install
@@ -2,8 +2,8 @@
 
 inst /sbin/bootchartd 
 inst /bin/bash 
-ln -s /init "${initdir}/sbin/init"
-mkdir -p /lib/bootchart/
+inst_symlink /init /sbin/init
+inst_dir /lib/bootchart/
 inst /lib/bootchart/bootchart-collector 
 inst /etc/bootchartd.conf 
 inst /sbin/accton 
@@ -12,4 +12,5 @@ inst /bin/echo
 inst /bin/grep 
 inst /bin/usleep
 inst /usr/bin/[  /bin/[
+
 mknod -m 0666 "${initdir}/dev/null" c 1 3
