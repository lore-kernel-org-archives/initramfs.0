From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 2/2] ssh-client: add urandom seeding
Date: Thu, 11 Oct 2012 16:07:59 +0800
Message-ID: <20121011080918.972371593@redhat.com>
References: <20121011080757.285843621@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=feeding-dev-urandom.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

openssh usually depends on /dev/urandom to seeding PRNG (pseudo-random number
generator). To ensure there's sufficient entropy just feed /dev/urandom with
saved /var/lib/random-seed which is saved in installing phase.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95ssh-client/module-setup.sh   |    2 ++
 modules.d/95ssh-client/random-seeding.sh |    7 +++++++
 2 files changed, 9 insertions(+)

--- dracut.orig/modules.d/95ssh-client/module-setup.sh
+++ dracut/modules.d/95ssh-client/module-setup.sh
@@ -48,6 +48,8 @@ inst_sshenv()
 
 install() {
     dracut_install ssh scp
+    dracut_install /var/lib/random-seed
+    inst_hook cmdline 01 "$moddir/random-seeding.sh"
     inst_sshenv
 }
 
--- /dev/null
+++ dracut/modules.d/95ssh-client/random-seeding.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+if [ -f /var/lib/random-seed ]; then
+    cat /var/lib/random-seed > /dev/urandom 2>/dev/null
+fi
