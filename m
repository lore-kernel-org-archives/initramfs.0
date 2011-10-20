From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] remove the xen dracut module
Date: Thu, 20 Oct 2011 19:15:06 +0200
Message-ID: <1319130906-14267-1-git-send-email-pbonzini@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=TJXwFIPtIb7SqBL9ByZUQ8BLq3zF7UxhjpGeec8RiMQ=;
        b=atU54CZcDGOHK5+oJGg26rwzDDkIcPyMM9yNo6K7xR+mivO2sMs1/LepqaCtp5DfCj
         lKXbjZVZl47wqTMt4hZ3loWFRzyuf8iTrdNORDA9fixiYpgjhI3MUB/mXCeQRygUZSE3
         nVaMGjqYpCn0TLth6vuuO0g25Ux8H106ao+0Y=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org

The Xen module is unnecessary and it has been for a while.  
Most Xen systems will not be using the module, even now, because
xen-detect is not installed by default on most Xen systems, and
dracut uses xen-detect to decide whether to include the module.

It also has some problems:

1) it does not try loading xen_platform_pci;

2) it loads modules unnecessarily; modules.alias is where all Xen support
should reside.  Assuming xenbus_probe_frontend and xen_platform_pci
are loaded so that Xen devices are probed, other modules are picked up
automatically thanks to aliases such as

    alias xen:vbd xen_blkfront

3) Even not-so-recent kernels (say 2.6.32) require the xen_platform_pci
and xenbus_probe_frontend modules even for non-paravirtualized guests.
60xen/module-setup.sh picks the module only for PV guests.

So, just require xenbus_probe_frontend to be builtin, and also
xen_platform_pci for fully-virtualized guests, and remove the module.

Signed-off-by: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/60xen/module-setup.sh |   42 ---------------------------------------
 modules.d/60xen/xen-pre-udev.sh |   13 ------------
 2 files changed, 0 insertions(+), 55 deletions(-)
 delete mode 100755 modules.d/60xen/module-setup.sh
 delete mode 100755 modules.d/60xen/xen-pre-udev.sh

diff --git a/modules.d/60xen/module-setup.sh b/modules.d/60xen/module-setup.sh
deleted file mode 100755
index 75309be..0000000
--- a/modules.d/60xen/module-setup.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-check() {
-    # No Xen-detect? Boo!!
-    if ! hash xen-detect 2>/dev/null; then
-        [[ -d /usr/lib/xen-default ]] && \
-            hash -p /usr/lib/xen-default/bin/xen-detect xen-detect || return 1
-    fi
-
-    . $dracutfunctions
-    [[ $debug ]] && set -x
-
-    # Yes, we are under Xen PV env.
-    xen-detect | grep -q -v PV || return 0
-
-    return 1
-}
-
-depends() {
-    return 0
-}
-
-installkernel() {
-    local _i
-    for _i in \
-        xenbus_probe_frontend xen-pcifront \
-        xen-fbfront xen-kbdfront xen-blkfront xen-netfront \
-        ; do
-        modinfo -k $kernel $_i >/dev/null 2>&1 && instmods $_i
-    done
-
-}
-
-install() {
-    hash xen-detect 2>/dev/null || \
-        hash -p /usr/lib/xen-default/bin/xen-detect xen-detect
-    inst "$(hash -t xen-detect)" /sbin/xen-detect
-    inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
-}
-
diff --git a/modules.d/60xen/xen-pre-udev.sh b/modules.d/60xen/xen-pre-udev.sh
deleted file mode 100755
index f039aaa..0000000
--- a/modules.d/60xen/xen-pre-udev.sh
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-xen-detect
-RC=$?
-if [ "$RC" = "1" ] ; then
-    modprobe xenbus_probe_frontend
-    modprobe xen-kbdfront
-    modprobe xen-fbfront
-    modprobe xen-blkfront
-    modprobe xen-netfront
-    modprobe xen-pcifront
-fi
-- 
1.7.6
