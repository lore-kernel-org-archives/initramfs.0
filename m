From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 1/2] ssh-client: remove ctty related check
Date: Thu, 11 Oct 2012 16:07:58 +0800
Message-ID: <20121011080918.807640177@redhat.com>
References: <20121011080757.285843621@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=ssh-remove-ctty-dependency.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

cttyhack was removed and ctty is supported by default, so no need to
check it in ssh-client module any more.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95ssh-client/module-setup.sh |    8 --------
 1 file changed, 8 deletions(-)

--- dracut.orig/modules.d/95ssh-client/module-setup.sh
+++ dracut/modules.d/95ssh-client/module-setup.sh
@@ -15,9 +15,6 @@ check() {
             derror "ssh key: $sshkey is not found!"
             return 1
         }
-        [[ ! $cttyhack = yes ]] && {
-            dinfo "--ctty is not used, you should make sure the machine is a knownhost and copy the sshkey to remote machine!"
-        }
     fi
 
     return 255
@@ -50,11 +47,6 @@ inst_sshenv()
 }
 
 install() {
-    [[ ! $cttyhack = yes && ! $sshkey ]] && {
-        derror "ssh-client needs option --ctty or --sshkey!"
-        return 1
-    }
-
     dracut_install ssh scp
     inst_sshenv
 }
