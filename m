From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2]02caps: do not create /bin/sh link
Date: Mon, 9 Jul 2012 14:57:11 +0800
Message-ID: <20120709065711.GA14096@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

02caps: do not create /bin/sh link

caps.sh use !/bin/bash explictly, so no need to ln -sf bash /bin/sh

OTOH, 00dash will create the symlink /bin/sh, 99base will create it if
there's no /bin/sh symlink. It looks bad to creat /bin/sh in other modules. 

If a script want to use bash as command interpreter it should use !/bin/bash
or !/bin/sh in case dash is not installed.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/02caps/module-setup.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- dracut.orig/modules.d/02caps/module-setup.sh
+++ dracut/modules.d/02caps/module-setup.sh
@@ -14,6 +14,6 @@ install() {
     inst_hook pre-pivot 00 "$moddir/caps.sh"
     inst $(type -P capsh 2>/dev/null) /usr/sbin/capsh
     # capsh wants bash and we need bash also
-    inst /bin/bash && ln -sf bash "${initdir}/bin/sh"
+    inst /bin/bash
 }
 
